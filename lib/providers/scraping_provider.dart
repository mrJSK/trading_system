// providers/scraping_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Scraping Status Model
class ScrapingStatus {
  final bool isActive;
  final int processedCount;
  final int totalCount;
  final String currentSymbol;
  final DateTime? startTime;
  final DateTime? lastUpdated;
  final List<String> errors;
  final String phase; // 'initializing', 'scraping', 'processing', 'completed'

  const ScrapingStatus({
    required this.isActive,
    required this.processedCount,
    required this.totalCount,
    this.currentSymbol = '',
    this.startTime,
    this.lastUpdated,
    this.errors = const [],
    this.phase = 'initializing',
  });

  ScrapingStatus copyWith({
    bool? isActive,
    int? processedCount,
    int? totalCount,
    String? currentSymbol,
    DateTime? startTime,
    DateTime? lastUpdated,
    List<String>? errors,
    String? phase,
  }) {
    return ScrapingStatus(
      isActive: isActive ?? this.isActive,
      processedCount: processedCount ?? this.processedCount,
      totalCount: totalCount ?? this.totalCount,
      currentSymbol: currentSymbol ?? this.currentSymbol,
      startTime: startTime ?? this.startTime,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      errors: errors ?? this.errors,
      phase: phase ?? this.phase,
    );
  }

  factory ScrapingStatus.fromFirestore(Map<String, dynamic> data) {
    return ScrapingStatus(
      isActive: data['isActive'] ?? false,
      processedCount: data['processedCount'] ?? 0,
      totalCount: data['totalCount'] ?? 0,
      currentSymbol: data['currentSymbol'] ?? '',
      startTime: data['startTime']?.toDate(),
      lastUpdated: data['lastUpdated']?.toDate(),
      errors: List<String>.from(data['errors'] ?? []),
      phase: data['phase'] ?? 'initializing',
    );
  }

  double get progress {
    if (totalCount == 0) return 0.0;
    return processedCount / totalCount;
  }

  String get progressText {
    return '${(progress * 100).toStringAsFixed(1)}%';
  }

  bool get hasErrors => errors.isNotEmpty;

  Duration? get elapsedTime {
    if (startTime == null) return null;
    final endTime = lastUpdated ?? DateTime.now();
    return endTime.difference(startTime!);
  }

  String get statusMessage {
    switch (phase) {
      case 'initializing':
        return 'Initializing scraping process...';
      case 'scraping':
        return 'Scraping data from Screener.in...';
      case 'processing':
        return 'Processing and updating database...';
      case 'completed':
        return 'Data update completed successfully';
      default:
        return 'Updating financial data...';
    }
  }
}

// Job Queue Item Model
class QueueItem {
  final String id;
  final String symbol;
  final String status; // 'pending', 'processing', 'completed', 'failed'
  final DateTime createdAt;
  final DateTime? processedAt;
  final String? error;
  final int retryCount;

  const QueueItem({
    required this.id,
    required this.symbol,
    required this.status,
    required this.createdAt,
    this.processedAt,
    this.error,
    this.retryCount = 0,
  });

  factory QueueItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return QueueItem(
      id: doc.id,
      symbol: data['symbol'] ?? '',
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      processedAt: data['processedAt']?.toDate(),
      error: data['error'],
      retryCount: data['retryCount'] ?? 0,
    );
  }
}

// Main Scraping Status Provider
final scrapingStatusProvider = StreamProvider<ScrapingStatus>((ref) {
  return FirebaseFirestore.instance
      .collection('system')
      .doc('scraping_status')
      .snapshots()
      .map((snapshot) {
    if (!snapshot.exists) {
      return const ScrapingStatus(
        isActive: false,
        processedCount: 0,
        totalCount: 0,
      );
    }

    final data = snapshot.data() as Map<String, dynamic>;
    return ScrapingStatus.fromFirestore(data);
  });
});

// Queue Status Provider
final queueStatusProvider = StreamProvider<List<QueueItem>>((ref) {
  return FirebaseFirestore.instance
      .collection('scraping_queue')
      .orderBy('createdAt', descending: true)
      .limit(100)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => QueueItem.fromFirestore(doc)).toList());
});

// Recent Scraping Stats Provider
final scrapingStatsProvider = StreamProvider<ScrapingStats>((ref) {
  return FirebaseFirestore.instance
      .collection('system')
      .doc('scraping_stats')
      .snapshots()
      .map((snapshot) {
    if (!snapshot.exists) {
      return ScrapingStats.empty();
    }

    final data = snapshot.data() as Map<String, dynamic>;
    return ScrapingStats.fromFirestore(data);
  });
});

class ScrapingStats {
  final int totalCompanies;
  final int successfulScrapes;
  final int failedScrapes;
  final DateTime? lastSuccessfulRun;
  final DateTime? lastFailedRun;
  final double averageProcessingTime;
  final Map<String, int> errorCounts;

  const ScrapingStats({
    required this.totalCompanies,
    required this.successfulScrapes,
    required this.failedScrapes,
    this.lastSuccessfulRun,
    this.lastFailedRun,
    this.averageProcessingTime = 0.0,
    this.errorCounts = const {},
  });

  factory ScrapingStats.empty() {
    return const ScrapingStats(
      totalCompanies: 0,
      successfulScrapes: 0,
      failedScrapes: 0,
    );
  }

  factory ScrapingStats.fromFirestore(Map<String, dynamic> data) {
    return ScrapingStats(
      totalCompanies: data['totalCompanies'] ?? 0,
      successfulScrapes: data['successfulScrapes'] ?? 0,
      failedScrapes: data['failedScrapes'] ?? 0,
      lastSuccessfulRun: data['lastSuccessfulRun']?.toDate(),
      lastFailedRun: data['lastFailedRun']?.toDate(),
      averageProcessingTime: (data['averageProcessingTime'] ?? 0.0).toDouble(),
      errorCounts: Map<String, int>.from(data['errorCounts'] ?? {}),
    );
  }

  double get successRate {
    final total = successfulScrapes + failedScrapes;
    if (total == 0) return 0.0;
    return successfulScrapes / total;
  }

  String get formattedLastRun {
    if (lastSuccessfulRun == null) return 'Never';

    final now = DateTime.now();
    final difference = now.difference(lastSuccessfulRun!);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }
}

// Scraping Control Provider
final scrapingControlProvider = Provider<ScrapingControl>((ref) {
  return ScrapingControl();
});

class ScrapingControl {
  // Trigger manual scraping
  Future<void> startScraping({List<String>? symbols}) async {
    try {
      await FirebaseFirestore.instance
          .collection('system')
          .doc('scraping_control')
          .set({
        'action': 'start',
        'symbols': symbols,
        'requestedAt': FieldValue.serverTimestamp(),
        'requestedBy': 'mobile_app',
      });
    } catch (e) {
      throw Exception('Failed to start scraping: $e');
    }
  }

  // Stop scraping
  Future<void> stopScraping() async {
    try {
      await FirebaseFirestore.instance
          .collection('system')
          .doc('scraping_control')
          .set({
        'action': 'stop',
        'requestedAt': FieldValue.serverTimestamp(),
        'requestedBy': 'mobile_app',
      });
    } catch (e) {
      throw Exception('Failed to stop scraping: $e');
    }
  }

  // Clear failed items from queue
  Future<void> clearFailedItems() async {
    try {
      final failedItems = await FirebaseFirestore.instance
          .collection('scraping_queue')
          .where('status', isEqualTo: 'failed')
          .get();

      final batch = FirebaseFirestore.instance.batch();
      for (final doc in failedItems.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to clear failed items: $e');
    }
  }

  // Retry failed items
  Future<void> retryFailedItems() async {
    try {
      final failedItems = await FirebaseFirestore.instance
          .collection('scraping_queue')
          .where('status', isEqualTo: 'failed')
          .get();

      final batch = FirebaseFirestore.instance.batch();
      for (final doc in failedItems.docs) {
        batch.update(doc.reference, {
          'status': 'pending',
          'error': null,
          'retryCount': FieldValue.increment(1),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to retry failed items: $e');
    }
  }

  // Get queue statistics
  Future<Map<String, int>> getQueueStats() async {
    try {
      final queueSnapshot =
          await FirebaseFirestore.instance.collection('scraping_queue').get();

      final stats = <String, int>{
        'total': 0,
        'pending': 0,
        'processing': 0,
        'completed': 0,
        'failed': 0,
      };

      for (final doc in queueSnapshot.docs) {
        final data = doc.data();
        final status = data['status'] ?? 'unknown';
        stats['total'] = (stats['total'] ?? 0) + 1;
        stats[status] = (stats[status] ?? 0) + 1;
      }

      return stats;
    } catch (e) {
      throw Exception('Failed to get queue stats: $e');
    }
  }
}
