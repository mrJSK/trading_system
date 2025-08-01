// lib/features/home/presentation/providers/scraping_providers.dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/scraping_service.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../models/scraping/scraping_models.dart';

// Service provider
final scrapingServiceProvider = Provider<ScrapingService>((ref) {
  return ScrapingService();
});

// State notifier class with proper error handling and nullable queueStatus
class ScrapingNotifier extends StateNotifier<ScrapingState> {
  final Ref ref;
  Timer? _refreshTimer;

  ScrapingNotifier(this.ref) : super(const ScrapingState()) {
    LoggerService.info('ScrapingNotifier initialized');
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    LoggerService.debug('Starting auto-refresh timer');
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      LoggerService.debug('Auto-refresh triggered');
      refreshStatus();
    });

    // Initial load
    refreshStatus();
  }

  Future<void> refreshStatus() async {
    if (state.isLoading) {
      LoggerService.debug('Refresh skipped - already loading');
      return;
    }

    LoggerService.debug('Refreshing scraping status');
    try {
      final service = ref.read(scrapingServiceProvider);
      final queueStatus = await service.getQueueStatus(); // Can return null

      state = state.copyWith(
        queueStatus: queueStatus, // Handle nullable QueueStatus
        error: null,
        isLoading: false,
      );

      if (queueStatus != null) {
        LoggerService.info(
            'Scraping status refreshed successfully: ${queueStatus.statusText}');
        LoggerService.debug(
            'Queue stats - Pending: ${queueStatus.pending}, Processing: ${queueStatus.processing}, Completed: ${queueStatus.completed}, Failed: ${queueStatus.failed}');
      } else {
        LoggerService.warning('Queue status is null after refresh');
      }
    } catch (e) {
      LoggerService.error('Failed to refresh scraping status', e);
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
        queueStatus: null, // Clear status on error
      );
    }
  }

  Future<String> startScraping({
    int maxPages = 50,
    bool clearExisting = true,
    Map<String, dynamic>? customConfig,
  }) async {
    LoggerService.info(
        'Starting scraping from UI - maxPages: $maxPages, clearExisting: $clearExisting');

    // Log custom config if provided
    if (customConfig != null) {
      LoggerService.debug('Custom config: $customConfig');
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final service = ref.read(scrapingServiceProvider);
      final message = await service.startScraping(maxPages: maxPages);

      // Refresh status immediately after starting
      await refreshStatus();

      // Update loading state after refresh
      state = state.copyWith(isLoading: false);

      LoggerService.info('Scraping started successfully from UI: $message');
      return message;
    } catch (e) {
      LoggerService.error('Failed to start scraping from UI', e);
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<String> retryFailed() async {
    LoggerService.info('Retrying failed items from UI');

    try {
      final service = ref.read(scrapingServiceProvider);
      final message = await service.retryFailed();

      // Refresh status to get updated queue information
      await refreshStatus();

      LoggerService.info('Failed items retry completed: $message');
      return message;
    } catch (e) {
      LoggerService.error('Failed to retry failed items from UI', e);
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<String> clearFailed() async {
    LoggerService.info('Clearing failed items from UI');

    try {
      final service = ref.read(scrapingServiceProvider);
      final message = await service.manageQueue('clear_failed');

      // Refresh status to reflect cleared failed items
      await refreshStatus();

      LoggerService.info('Failed items cleared: $message');
      return message;
    } catch (e) {
      LoggerService.error('Failed to clear failed items from UI', e);
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<String> resetStalled() async {
    LoggerService.info('Resetting stalled items from UI');

    try {
      final service = ref.read(scrapingServiceProvider);
      final message = await service.manageQueue('reset_stalled');

      // Refresh status to reflect reset stalled items
      await refreshStatus();

      LoggerService.info('Stalled items reset: $message');
      return message;
    } catch (e) {
      LoggerService.error('Failed to reset stalled items from UI', e);
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<String> pauseScraping() async {
    LoggerService.info('Pausing scraping from UI');

    try {
      final service = ref.read(scrapingServiceProvider);
      final message = await service.manageQueue('pause');

      // Refresh status to show paused state
      await refreshStatus();

      LoggerService.info('Scraping paused: $message');
      return message;
    } catch (e) {
      LoggerService.error('Failed to pause scraping from UI', e);
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<String> resumeScraping() async {
    LoggerService.info('Resuming scraping from UI');

    try {
      final service = ref.read(scrapingServiceProvider);
      final message = await service.manageQueue('resume');

      // Refresh status to show resumed state
      await refreshStatus();

      LoggerService.info('Scraping resumed: $message');
      return message;
    } catch (e) {
      LoggerService.error('Failed to resume scraping from UI', e);
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  void toggleDetails() {
    LoggerService.debug('Toggling details view');
    state = state.copyWith(showDetails: !state.showDetails);
  }

  void clearError() {
    LoggerService.debug('Clearing error state');
    state = state.copyWith(error: null);
  }

  // Manual refresh for pull-to-refresh functionality
  Future<void> forceRefresh() async {
    LoggerService.info('Force refresh triggered');
    await refreshStatus();
  }

  // Get detailed progress if available
  Future<DetailedProgress?> getDetailedProgress() async {
    LoggerService.debug('Getting detailed progress');
    try {
      final service = ref.read(scrapingServiceProvider);
      final progress = await service.getDetailedProgress();
      LoggerService.debug('Detailed progress retrieved successfully');
      return progress;
    } catch (e) {
      LoggerService.error('Failed to get detailed progress', e);
      return null;
    }
  }

  @override
  void dispose() {
    LoggerService.info('ScrapingNotifier disposing');
    _refreshTimer?.cancel();
    super.dispose();
  }
}

// Main state notifier provider
final scrapingNotifierProvider =
    StateNotifierProvider<ScrapingNotifier, ScrapingState>((ref) {
  return ScrapingNotifier(ref);
});

// Helper providers for computed values with proper null handling
final isScrapingActiveProvider = Provider<bool>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.queueStatus?.isActive ?? false;
});

final scrapingStatusMessageProvider = Provider<String>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  final status = scrapingState.queueStatus;

  // Handle loading state
  if (scrapingState.isLoading && status == null) {
    return 'Loading status...';
  }

  // Handle error state
  if (scrapingState.error != null && status == null) {
    return 'Error loading status';
  }

  // Handle null status
  if (status == null) return 'No status available';

  // Handle different status states
  if (status.isActive) {
    return 'Scraping: ${status.progressPercentage.toStringAsFixed(1)}% (${status.completed}/${status.total})';
  } else if (status.isCompleted) {
    return 'Last scraping: ${status.completed} companies updated';
  } else if (status.total > 0) {
    return 'Scraping paused or stopped';
  } else {
    return 'No active scraping';
  }
});

final isSystemHealthyProvider = Provider<bool>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  final hasError = scrapingState.error != null;
  final queueHealthy = scrapingState.queueStatus?.isHealthy ?? true;

  return !hasError && queueHealthy;
});

// Additional helper providers for better UI state management
final scrapingProgressProvider = Provider<double?>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.queueStatus?.progressPercentage;
});

final hasScrapingErrorProvider = Provider<bool>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.error != null;
});

final scrapingErrorMessageProvider = Provider<String?>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.error;
});

final canRetryFailedProvider = Provider<bool>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  final failedCount = scrapingState.queueStatus?.failed ?? 0;
  return failedCount > 0;
});

final scrapingStatsProvider = Provider<Map<String, int>>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  final status = scrapingState.queueStatus;

  if (status == null) {
    return {
      'pending': 0,
      'processing': 0,
      'completed': 0,
      'failed': 0,
      'total': 0,
    };
  }

  return {
    'pending': status.pending,
    'processing': status.processing,
    'completed': status.completed,
    'failed': status.failed,
    'total': status.total,
  };
});

final recentCompletedProvider = Provider<List<RecentCompany>>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.queueStatus?.recentCompleted ?? [];
});

// Advanced providers for enhanced functionality
final estimatedTimeRemainingProvider = Provider<Duration?>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.queueStatus?.estimatedTimeRemainingDuration;
});

final completionRateProvider = Provider<double?>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.queueStatus?.completionRate;
});

final isScrapingStalledProvider = Provider<bool>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.queueStatus?.isStalled ?? false;
});

final scrapingHealthScoreProvider = Provider<double>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  final status = scrapingState.queueStatus;

  if (status == null || status.total == 0) return 1.0;

  final successRate = status.completed / status.total;
  final errorRate = status.failed / status.total;

  // Health score calculation: success rate - error penalty
  double healthScore = successRate - (errorRate * 2);

  // Penalize if stalled
  if (status.isStalled) {
    healthScore -= 0.3;
  }

  return (healthScore.clamp(0.0, 1.0));
});

final lastUpdateTimeProvider = Provider<DateTime?>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.queueStatus?.timestamp;
});

final scrapingDetailedStatusProvider = Provider<String>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  final status = scrapingState.queueStatus;

  if (status == null) return 'No status information available';

  return status.detailedStatusText;
});

// Provider to check if manual intervention is needed
final needsInterventionProvider = Provider<bool>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  final status = scrapingState.queueStatus;

  if (status == null) return false;

  // Intervention needed if:
  // 1. High failure rate (>20%)
  // 2. Processing is stalled
  // 3. No progress for extended period
  final highFailureRate =
      status.total > 0 && (status.failed / status.total) > 0.2;
  final isStalled = status.isStalled;

  return highFailureRate || isStalled;
});

// Provider for auto-retry configuration
final shouldAutoRetryProvider = Provider<bool>((ref) {
  final canRetry = ref.watch(canRetryFailedProvider);
  final needsIntervention = ref.watch(needsInterventionProvider);

  // Auto-retry if there are failed items but no intervention needed
  return canRetry && !needsIntervention;
});

// Provider for queue performance metrics
final queuePerformanceProvider = Provider<Map<String, dynamic>>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  final status = scrapingState.queueStatus;

  if (status == null) {
    return {
      'throughput': 0.0,
      'success_rate': 0.0,
      'error_rate': 0.0,
      'efficiency': 0.0,
    };
  }

  final throughput = status.completionRate ?? 0.0;
  final successRate =
      status.total > 0 ? (status.completed / status.total) : 0.0;
  final errorRate = status.total > 0 ? (status.failed / status.total) : 0.0;
  final efficiency = successRate * (throughput / 10.0).clamp(0.0, 1.0);

  return {
    'throughput': throughput,
    'success_rate': successRate,
    'error_rate': errorRate,
    'efficiency': efficiency,
  };
});
