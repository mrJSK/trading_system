import 'package:freezed_annotation/freezed_annotation.dart';

part 'scraping_models.freezed.dart';
part 'scraping_models.g.dart';

@freezed
class QueueStatus with _$QueueStatus {
  const factory QueueStatus({
    @Default(0) int pending,
    @Default(0) int processing,
    @Default(0) int completed,
    @Default(0) int failed,
    @Default(0) int total,
    @Default(false) bool isActive,
    @Default(false) bool isCompleted,
    @Default(0.0) double progressPercentage,
    @Default('Ready') String statusText,
    required DateTime timestamp,
    @Default([]) List<RecentCompletedItem> recentCompleted,
    String? estimatedTimeRemaining,
    double? completionRate,
    @Default({}) Map<String, dynamic> queueStats,
  }) = _QueueStatus;

  factory QueueStatus.fromJson(Map<String, dynamic> json) =>
      _$QueueStatusFromJson(json);
}

@freezed
class RecentCompletedItem with _$RecentCompletedItem {
  const factory RecentCompletedItem({
    required String symbol,
    required String companyName,
    required String completedAt,
  }) = _RecentCompletedItem;

  factory RecentCompletedItem.fromJson(Map<String, dynamic> json) =>
      _$RecentCompletedItemFromJson(json);
}

@freezed
class ScrapingStatus with _$ScrapingStatus {
  const factory ScrapingStatus({
    @Default(0) int processedCount,
    @Default(0) int totalCount,
    @Default(0) int failedCount,
    @Default(0) int pendingCount,
    @Default(0) int processingCount,
    @Default(false) bool isActive,
    @Default(false) bool isCompleted,
    @Default(false) bool hasErrors,
    @Default('') String statusMessage,
    @Default(0) int estimatedTimeRemaining,
    @Default(0.0) double progress,
    DateTime? lastUpdated,
    QueueStatus? queueStatus,
  }) = _ScrapingStatus;

  factory ScrapingStatus.fromJson(Map<String, dynamic> json) =>
      _$ScrapingStatusFromJson(json);

  factory ScrapingStatus.fromQueueStatus(QueueStatus queueStatus) {
    return ScrapingStatus(
      processedCount: queueStatus.completed,
      totalCount: queueStatus.total,
      failedCount: queueStatus.failed,
      pendingCount: queueStatus.pending,
      processingCount: queueStatus.processing,
      isActive: queueStatus.isActive,
      isCompleted: queueStatus.isCompleted,
      hasErrors: queueStatus.failed > 0,
      statusMessage: queueStatus.statusText,
      progress: queueStatus.total > 0
          ? queueStatus.completed / queueStatus.total
          : 0.0,
      lastUpdated: queueStatus.timestamp,
      queueStatus: queueStatus,
    );
  }
}

@freezed
class ScrapingState with _$ScrapingState {
  const factory ScrapingState({
    ScrapingStatus? scrapingStatus,
    QueueStatus? queueStatus,
    @Default(false) bool isLoading,
    @Default(false) bool isTriggering,
    String? error,
    @Default(false) bool showDetails,
    DateTime? lastTriggered,
    @Default([]) List<ScrapingEvent> recentEvents,
  }) = _ScrapingState;

  factory ScrapingState.fromJson(Map<String, dynamic> json) =>
      _$ScrapingStateFromJson(json);
}

@freezed
class DetailedProgress with _$DetailedProgress {
  const factory DetailedProgress({
    required QueueStatus queueStatus,
    @Default([]) List<ProcessingItem> currentlyProcessing,
    @Default([]) List<FailedItem> recentFailures,
    DateTime? estimatedCompletion,
    String? estimatedRemainingTime,
    @Default({}) Map<String, dynamic> performanceMetrics,
    @Default(0.0) double successRate,
    @Default(0.0) double averageProcessingTime,
  }) = _DetailedProgress;

  factory DetailedProgress.fromJson(Map<String, dynamic> json) =>
      _$DetailedProgressFromJson(json);
}

@freezed
class ProcessingItem with _$ProcessingItem {
  const factory ProcessingItem({
    required String url,
    required String symbol,
    required DateTime startedAt,
    @Default(0.0) double processingDuration,
    String? processorId,
    String? status,
  }) = _ProcessingItem;

  factory ProcessingItem.fromJson(Map<String, dynamic> json) =>
      _$ProcessingItemFromJson(json);
}

@freezed
class FailedItem with _$FailedItem {
  const factory FailedItem({
    required String url,
    required String error,
    required DateTime failedAt,
    @Default(0) int retryCount,
    @Default(3) int maxRetries,
    String? symbol,
  }) = _FailedItem;

  factory FailedItem.fromJson(Map<String, dynamic> json) =>
      _$FailedItemFromJson(json);
}

@freezed
class ScrapingEvent with _$ScrapingEvent {
  const factory ScrapingEvent({
    required String message,
    required ScrapingEventType type,
    required DateTime timestamp,
    String? details,
    Map<String, dynamic>? metadata,
  }) = _ScrapingEvent;

  factory ScrapingEvent.fromJson(Map<String, dynamic> json) =>
      _$ScrapingEventFromJson(json);
}

@freezed
class ScrapingStats with _$ScrapingStats {
  const factory ScrapingStats({
    required QueueStatus queueStatus,
    @Default([]) List<RecentCompletedItem> recentCompleted,
    @Default(0) int totalCompaniesProcessed,
    @Default(0) int successRate,
    @Default(true) bool isHealthy,
    required DateTime lastUpdated,
    @Default({}) Map<String, dynamic> additionalMetrics,
  }) = _ScrapingStats;

  factory ScrapingStats.fromJson(Map<String, dynamic> json) =>
      _$ScrapingStatsFromJson(json);
}

enum ScrapingEventType {
  info,
  success,
  error,
  warning,
  action,
  started,
  completed,
  paused,
  stopped,
}

// Extensions
extension QueueStatusExtension on QueueStatus {
  double get progressPercentageCalculated {
    if (total == 0) return 0.0;
    return ((completed + failed) / total) * 100;
  }

  bool get isActiveCalculated => pending > 0 || processing > 0;
  bool get isCompletedCalculated =>
      pending == 0 && processing == 0 && total > 0;
  bool get hasErrors => failed > 0;
  bool get isStalled =>
      processing > 0 && completionRate != null && completionRate! < 0.1;
  bool get isHealthy => total > 0 ? failed < (total * 0.1) : true;

  String get statusTextCalculated {
    if (isStalled) return 'Scraping stalled - may need intervention';
    if (isActiveCalculated) return 'Scraping in progress...';
    if (isCompletedCalculated) return 'Scraping completed successfully';
    if (hasErrors && total > 0) return 'Scraping completed with errors';
    return 'No active scraping';
  }

  String get detailedStatusText {
    if (total == 0) return 'No scraping jobs queued';
    final progress =
        '${completed}/${total} completed (${progressPercentageCalculated.toStringAsFixed(1)}%)';
    if (isActiveCalculated) {
      String eta = estimatedTimeRemaining ?? 'calculating...';
      return 'In progress: $progress, ETA: $eta';
    }
    if (hasErrors) {
      return 'Completed: $progress, $failed failed';
    }
    return 'Completed: $progress';
  }

  Duration? get estimatedTimeRemainingDuration {
    if (estimatedTimeRemaining == null ||
        completionRate == null ||
        completionRate! <= 0) {
      return null;
    }
    final remainingItems = pending + processing;
    final minutesRemaining = (remainingItems / completionRate!).round();
    return Duration(minutes: minutesRemaining);
  }
}

extension RecentCompletedItemExtension on RecentCompletedItem {
  String get timeAgo {
    try {
      final completedDateTime = DateTime.parse(completedAt);
      final diff = DateTime.now().difference(completedDateTime);
      if (diff.inSeconds < 60) return 'Just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      return '${diff.inDays}d ago';
    } catch (e) {
      return 'Unknown';
    }
  }

  DateTime? get completedDateTime {
    try {
      return DateTime.parse(completedAt);
    } catch (e) {
      return null;
    }
  }
}

extension ScrapingStatusExtension on ScrapingStatus {
  bool get shouldShowProgress => isActive || isCompleted;

  String get progressText {
    if (totalCount == 0) return 'No items to process';
    return '$processedCount/$totalCount';
  }

  String get detailedStatusText {
    if (totalCount == 0) return 'Ready to start scraping';
    if (isActive) {
      final remaining = totalCount - processedCount;
      String eta = estimatedTimeRemaining > 0
          ? _formatDuration(Duration(seconds: estimatedTimeRemaining))
          : 'calculating...';
      return 'Processing $remaining items, ETA: $eta';
    }
    if (isCompleted) {
      if (failedCount > 0) {
        return 'Completed with $failedCount failures';
      }
      return 'All items processed successfully';
    }
    return statusMessage;
  }

  String _formatDuration(Duration duration) {
    if (duration.inMinutes < 1) {
      return '${duration.inSeconds}s';
    } else if (duration.inHours < 1) {
      return '${duration.inMinutes}m';
    } else {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    }
  }
}

extension ScrapingStateExtension on ScrapingState {
  bool get hasActiveQueue =>
      scrapingStatus?.isActive ?? queueStatus?.isActive ?? false;
  bool get shouldShowProgress =>
      hasActiveQueue ||
      (scrapingStatus?.isCompleted ?? queueStatus?.isCompleted ?? false);
  String get primaryStatus =>
      scrapingStatus?.statusMessage ?? queueStatus?.statusText ?? 'Ready';

  bool get hasRecentEvents => recentEvents.isNotEmpty;

  List<ScrapingEvent> get importantEvents =>
      recentEvents.where((event) => event.isImportant).toList();
}

extension DetailedProgressExtension on DetailedProgress {
  bool get hasCurrentActivity => currentlyProcessing.isNotEmpty;
  bool get hasRecentFailures => recentFailures.isNotEmpty;

  String get currentActivitySummary {
    if (!hasCurrentActivity) return 'No current activity';
    return 'Processing ${currentlyProcessing.length} items';
  }

  String get failureSummary {
    if (!hasRecentFailures) return 'No recent failures';
    return '${recentFailures.length} recent failures';
  }

  String get performanceSummary {
    return 'Success rate: ${successRate.toStringAsFixed(1)}%, '
        'Avg time: ${averageProcessingTime.toStringAsFixed(1)}s';
  }
}

extension ProcessingItemExtension on ProcessingItem {
  Duration get processingTime => DateTime.now().difference(startedAt);

  String get processingTimeText {
    final duration = processingTime;
    if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
    }
    return '${duration.inSeconds}s';
  }

  bool get isStalled =>
      processingTime.inMinutes > 5; // Consider stalled after 5 minutes
}

extension FailedItemExtension on FailedItem {
  String get timeAgo {
    final diff = DateTime.now().difference(failedAt);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  bool get shouldRetry => retryCount < maxRetries;
  String get retryStatus => shouldRetry ? 'Can retry' : 'Max retries reached';

  bool get isRecent => DateTime.now().difference(failedAt).inHours < 24;
}

extension ScrapingEventExtension on ScrapingEvent {
  String get timeAgo {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  bool get isImportant =>
      type == ScrapingEventType.error ||
      type == ScrapingEventType.warning ||
      type == ScrapingEventType.completed ||
      type == ScrapingEventType.stopped;

  bool get isRecent => DateTime.now().difference(timestamp).inHours < 1;
}

extension ScrapingStatsExtension on ScrapingStats {
  String get healthStatus {
    if (!isHealthy) return 'Unhealthy';
    if (successRate >= 95) return 'Excellent';
    if (successRate >= 85) return 'Good';
    if (successRate >= 70) return 'Fair';
    return 'Poor';
  }

  bool get needsAttention => !isHealthy || successRate < 80;
}
