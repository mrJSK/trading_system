// providers/scraping_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import '../models/scraping_models.dart';
import '../services/scraping_service.dart';

// Main Scraping Status Provider (using HTTP service)
final scrapingStatusProvider = StreamProvider<ScrapingStatus>((ref) async* {
  final scrapingService = ScrapingService();

  // Initial load
  try {
    final queueStatus = await scrapingService.getQueueStatus();
    yield ScrapingStatus.fromQueueStatus(queueStatus);
  } catch (e) {
    yield ScrapingStatus(
      statusMessage: 'Failed to load status: ${e.toString()}',
      hasErrors: true,
    );
  }

  // Set up periodic polling for real-time updates
  yield* Stream.periodic(const Duration(seconds: 15), (count) => count)
      .asyncMap((_) async {
    try {
      final queueStatus = await scrapingService.getQueueStatus();
      return ScrapingStatus.fromQueueStatus(queueStatus);
    } catch (e) {
      return ScrapingStatus(
        statusMessage: 'Connection error: ${e.toString()}',
        hasErrors: true,
      );
    }
  });
});

// Queue Status Provider (using HTTP service)
final queueStatusProvider = StreamProvider<QueueStatus>((ref) async* {
  final scrapingService = ScrapingService();

  // Initial load
  try {
    yield await scrapingService.getQueueStatus();
  } catch (e) {
    yield QueueStatus(
      timestamp: DateTime.now(),
      statusText: 'Failed to load queue status',
    );
  }

  // Periodic updates
  yield* Stream.periodic(const Duration(seconds: 30), (count) => count)
      .asyncMap((_) async {
    try {
      return await scrapingService.getQueueStatus();
    } catch (e) {
      return QueueStatus(
        timestamp: DateTime.now(),
        statusText: 'Connection error',
      );
    }
  });
});

// Scraping Stats Provider
final scrapingStatsProvider = StreamProvider<ScrapingStats>((ref) async* {
  final scrapingService = ScrapingService();

  // Initial load
  try {
    final statsData = await scrapingService.getScrapingStats();
    yield ScrapingStats.fromJson(statsData);
  } catch (e) {
    yield ScrapingStats(
      queueStatus: QueueStatus(timestamp: DateTime.now()),
      lastUpdated: DateTime.now(),
    );
  }

  // Periodic updates (less frequent for stats)
  yield* Stream.periodic(const Duration(minutes: 2), (count) => count)
      .asyncMap((_) async {
    try {
      final statsData = await scrapingService.getScrapingStats();
      return ScrapingStats.fromJson(statsData);
    } catch (e) {
      return ScrapingStats(
        queueStatus: QueueStatus(timestamp: DateTime.now()),
        lastUpdated: DateTime.now(),
      );
    }
  });
});

// Recent Completed Items Provider
final recentCompletedProvider =
    StreamProvider<List<RecentCompletedItem>>((ref) async* {
  final scrapingService = ScrapingService();

  // Initial load
  try {
    yield await scrapingService.getRecentCompleted();
  } catch (e) {
    yield <RecentCompletedItem>[];
  }

  // Periodic updates
  yield* Stream.periodic(const Duration(seconds: 45), (count) => count)
      .asyncMap((_) async {
    try {
      return await scrapingService.getRecentCompleted();
    } catch (e) {
      return <RecentCompletedItem>[];
    }
  });
});

// Scraping State Provider (combines multiple states)
final scrapingStateProvider =
    StateNotifierProvider<ScrapingStateNotifier, ScrapingState>((ref) {
  return ScrapingStateNotifier(ref);
});

class ScrapingStateNotifier extends StateNotifier<ScrapingState> {
  final Ref _ref;
  StreamSubscription? _statusSubscription;
  StreamSubscription? _queueSubscription;

  ScrapingStateNotifier(this._ref) : super(const ScrapingState()) {
    _init();
  }

  void _init() {
    // Listen to scraping status changes
    _statusSubscription = _ref.listen<AsyncValue<ScrapingStatus>>(
      scrapingStatusProvider,
      (previous, next) {
        next.when(
          data: (status) {
            state = state.copyWith(
              scrapingStatus: status,
              isLoading: false,
              error: null,
            );
          },
          loading: () {
            state = state.copyWith(isLoading: true);
          },
          error: (error, stack) {
            state = state.copyWith(
              error: error.toString(),
              isLoading: false,
            );
          },
        );
      },
    ) as StreamSubscription?;

    // Listen to queue status changes
    _queueSubscription = _ref.listen<AsyncValue<QueueStatus>>(
      queueStatusProvider,
      (previous, next) {
        next.when(
          data: (queueStatus) {
            state = state.copyWith(queueStatus: queueStatus);
          },
          loading: () {},
          error: (error, stack) {},
        );
      },
    ) as StreamSubscription?;
  }

  Future<void> triggerScraping({
    int maxPages = 10,
    bool clearExisting = true,
  }) async {
    state = state.copyWith(isTriggering: true, error: null);

    try {
      final scrapingService = ScrapingService();
      await scrapingService.startScraping(
        maxPages: maxPages,
        clearExisting: clearExisting,
      );

      state = state.copyWith(
        isTriggering: false,
        lastTriggered: DateTime.now(),
      );

      // Add event
      _addEvent(
        'Scraping started',
        ScrapingEventType.started,
        'Initiated scraping for $maxPages pages',
      );

      // Refresh providers
      _ref.invalidate(scrapingStatusProvider);
      _ref.invalidate(queueStatusProvider);
    } catch (e) {
      state = state.copyWith(
        isTriggering: false,
        error: e.toString(),
      );

      _addEvent(
        'Scraping failed to start',
        ScrapingEventType.error,
        e.toString(),
      );
    }
  }

  Future<void> stopScraping() async {
    try {
      final scrapingService = ScrapingService();
      await scrapingService.stopScraping();

      _addEvent(
        'Scraping stopped',
        ScrapingEventType.stopped,
        'Scraping process has been stopped',
      );

      _ref.invalidate(scrapingStatusProvider);
      _ref.invalidate(queueStatusProvider);
    } catch (e) {
      state = state.copyWith(error: e.toString());

      _addEvent(
        'Failed to stop scraping',
        ScrapingEventType.error,
        e.toString(),
      );
    }
  }

  Future<void> retryFailed() async {
    try {
      final scrapingService = ScrapingService();
      final message = await scrapingService.retryFailed();

      _addEvent(
        'Retrying failed items',
        ScrapingEventType.action,
        message,
      );

      _ref.invalidate(scrapingStatusProvider);
      _ref.invalidate(queueStatusProvider);
    } catch (e) {
      state = state.copyWith(error: e.toString());

      _addEvent(
        'Failed to retry items',
        ScrapingEventType.error,
        e.toString(),
      );
    }
  }

  Future<void> clearFailed() async {
    try {
      final scrapingService = ScrapingService();
      final message = await scrapingService.clearFailed();

      _addEvent(
        'Cleared failed items',
        ScrapingEventType.action,
        message,
      );

      _ref.invalidate(scrapingStatusProvider);
      _ref.invalidate(queueStatusProvider);
    } catch (e) {
      state = state.copyWith(error: e.toString());

      _addEvent(
        'Failed to clear items',
        ScrapingEventType.error,
        e.toString(),
      );
    }
  }

  Future<void> testConnection() async {
    try {
      final scrapingService = ScrapingService();
      final message = await scrapingService.testConnection();

      _addEvent(
        'Connection test',
        ScrapingEventType.success,
        message,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());

      _addEvent(
        'Connection test failed',
        ScrapingEventType.error,
        e.toString(),
      );
    }
  }

  void toggleDetails() {
    state = state.copyWith(showDetails: !state.showDetails);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void _addEvent(String message, ScrapingEventType type, [String? details]) {
    final event = ScrapingEvent(
      message: message,
      type: type,
      timestamp: DateTime.now(),
      details: details,
    );

    final updatedEvents = [event, ...state.recentEvents].take(20).toList();
    state = state.copyWith(recentEvents: updatedEvents);
  }

  @override
  void dispose() {
    _statusSubscription?.cancel();
    _queueSubscription?.cancel();
    super.dispose();
  }
}

// Enhanced Scraping Control Provider
final scrapingControlProvider = Provider<EnhancedScrapingControl>((ref) {
  return EnhancedScrapingControl(ref);
});

class EnhancedScrapingControl {
  final Ref _ref;
  late final ScrapingService _scrapingService;

  EnhancedScrapingControl(this._ref) {
    _scrapingService = ScrapingService();
  }

  Future<String> startScraping({
    int maxPages = 100,
    bool clearExisting = true,
  }) async {
    try {
      final message = await _scrapingService.startScraping(
        maxPages: maxPages,
        clearExisting: clearExisting,
      );

      // Refresh all providers
      _ref.invalidate(scrapingStatusProvider);
      _ref.invalidate(queueStatusProvider);
      _ref.invalidate(scrapingStatsProvider);

      return message;
    } catch (e) {
      throw Exception('Failed to start scraping: $e');
    }
  }

  Future<String> stopScraping() async {
    try {
      final message = await _scrapingService.stopScraping();

      _ref.invalidate(scrapingStatusProvider);
      _ref.invalidate(queueStatusProvider);

      return message;
    } catch (e) {
      throw Exception('Failed to stop scraping: $e');
    }
  }

  Future<String> retryFailedItems() async {
    try {
      final message = await _scrapingService.retryFailed();

      _ref.invalidate(scrapingStatusProvider);
      _ref.invalidate(queueStatusProvider);

      return message;
    } catch (e) {
      throw Exception('Failed to retry failed items: $e');
    }
  }

  Future<String> clearFailedItems() async {
    try {
      final message = await _scrapingService.clearFailed();

      _ref.invalidate(scrapingStatusProvider);
      _ref.invalidate(queueStatusProvider);

      return message;
    } catch (e) {
      throw Exception('Failed to clear failed items: $e');
    }
  }

  Future<QueueStatus> getQueueStatus() async {
    try {
      return await _scrapingService.getQueueStatus();
    } catch (e) {
      throw Exception('Failed to get queue status: $e');
    }
  }

  Future<ScrapingStats> getScrapingStats() async {
    try {
      final statsData = await _scrapingService.getScrapingStats();
      return ScrapingStats.fromJson(statsData);
    } catch (e) {
      throw Exception('Failed to get scraping stats: $e');
    }
  }

  Future<bool> isScrapingActive() async {
    try {
      return await _scrapingService.isScrapingActive();
    } catch (e) {
      return false;
    }
  }

  Future<double> getProgressPercentage() async {
    try {
      return await _scrapingService.getProgressPercentage();
    } catch (e) {
      return 0.0;
    }
  }

  Future<int> getEstimatedTimeRemaining() async {
    try {
      return await _scrapingService.getEstimatedTimeRemaining();
    } catch (e) {
      return 0;
    }
  }

  Future<String> testConnection() async {
    try {
      return await _scrapingService.testConnection();
    } catch (e) {
      throw Exception('Connection test failed: $e');
    }
  }

  Future<String> triggerManualScrape({
    int maxPages = 5,
    bool testMode = false,
  }) async {
    try {
      final message = await _scrapingService.triggerManualScrape(
        maxPages: maxPages,
        testMode: testMode,
      );

      _ref.invalidate(scrapingStatusProvider);
      _ref.invalidate(queueStatusProvider);

      return message;
    } catch (e) {
      throw Exception('Failed to trigger manual scrape: $e');
    }
  }

  void refreshAllProviders() {
    _ref.invalidate(scrapingStatusProvider);
    _ref.invalidate(queueStatusProvider);
    _ref.invalidate(scrapingStatsProvider);
    _ref.invalidate(recentCompletedProvider);
  }
}

// Helper providers for specific UI needs
final isScrapingActiveProvider = Provider<bool>((ref) {
  final scrapingStatus = ref.watch(scrapingStatusProvider);
  return scrapingStatus.when(
    data: (status) => status.isActive,
    loading: () => false,
    error: (_, __) => false,
  );
});

final scrapingProgressProvider = Provider<double>((ref) {
  final scrapingStatus = ref.watch(scrapingStatusProvider);
  return scrapingStatus.when(
    data: (status) => status.progress,
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
});

final scrapingHealthProvider = Provider<bool>((ref) {
  final stats = ref.watch(scrapingStatsProvider);
  return stats.when(
    data: (stats) => stats.isHealthy,
    loading: () => true,
    error: (_, __) => false,
  );
});

// Combined provider for dashboard summary
final scrapingSummaryProvider = Provider<ScrapingSummary>((ref) {
  final scrapingStatus = ref.watch(scrapingStatusProvider);
  final queueStatus = ref.watch(queueStatusProvider);
  final stats = ref.watch(scrapingStatsProvider);

  return ScrapingSummary(
    isActive: scrapingStatus.when(
      data: (status) => status.isActive,
      loading: () => false,
      error: (_, __) => false,
    ),
    progress: scrapingStatus.when(
      data: (status) => status.progress,
      loading: () => 0.0,
      error: (_, __) => 0.0,
    ),
    statusMessage: scrapingStatus.when(
      data: (status) => status.statusMessage,
      loading: () => 'Loading...',
      error: (error, __) => 'Error: ${error.toString()}',
    ),
    totalItems: queueStatus.when(
      data: (queue) => queue.total,
      loading: () => 0,
      error: (_, __) => 0,
    ),
    isHealthy: stats.when(
      data: (stats) => stats.isHealthy,
      loading: () => true,
      error: (_, __) => false,
    ),
  );
});

class ScrapingSummary {
  final bool isActive;
  final double progress;
  final String statusMessage;
  final int totalItems;
  final bool isHealthy;

  ScrapingSummary({
    required this.isActive,
    required this.progress,
    required this.statusMessage,
    required this.totalItems,
    required this.isHealthy,
  });
}
