// lib/models/scraping/scraping_models.dart
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
    @Default([]) List<RecentCompany> recentCompleted,
    required DateTime timestamp,
    String? estimatedTimeRemaining,
    double? completionRate,
    Map<String, dynamic>? queueStats,
  }) = _QueueStatus;

  factory QueueStatus.fromJson(Map<String, Object?> json) =>
      _$QueueStatusFromJson(json);
}

@freezed
class RecentCompany with _$RecentCompany {
  const factory RecentCompany({
    required String symbol,
    required String companyName,
    required DateTime completedAt,
  }) = _RecentCompany;

  factory RecentCompany.fromJson(Map<String, Object?> json) =>
      _$RecentCompanyFromJson(json);
}

@freezed
class ScrapingState with _$ScrapingState {
  const factory ScrapingState({
    QueueStatus? queueStatus,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool showDetails,
  }) = _ScrapingState;

  // Add fromJson if you plan to serialize ScrapingState
  // factory ScrapingState.fromJson(Map<String, Object?> json) =>
  //     _$ScrapingStateFromJson(json);
}

@freezed
class DetailedProgress with _$DetailedProgress {
  const factory DetailedProgress({
    required QueueStatus queueStatus,
    @Default([]) List<ProcessingItem> currentlyProcessing,
    @Default([]) List<FailedItem> recentFailures,
    DateTime? estimatedCompletion,
    String? estimatedRemainingTime,
    Map<String, dynamic>? performanceMetrics,
  }) = _DetailedProgress;

  factory DetailedProgress.fromJson(Map<String, Object?> json) =>
      _$DetailedProgressFromJson(json);
}

@freezed
class ProcessingItem with _$ProcessingItem {
  const factory ProcessingItem({
    required String url,
    required String symbol,
    required DateTime startedAt,
    @Default(0.0) double processingDuration,
  }) = _ProcessingItem;

  factory ProcessingItem.fromJson(Map<String, Object?> json) =>
      _$ProcessingItemFromJson(json);
}

@freezed
class FailedItem with _$FailedItem {
  const factory FailedItem({
    required String url,
    required String error,
    required DateTime failedAt,
    @Default(0) int retryCount,
  }) = _FailedItem;

  factory FailedItem.fromJson(Map<String, Object?> json) =>
      _$FailedItemFromJson(json);
}

@freezed
class ScrapingEvent with _$ScrapingEvent {
  const factory ScrapingEvent({
    required String message,
    required ScrapingEventType type,
    required DateTime timestamp,
  }) = _ScrapingEvent;

  // Add fromJson if you plan to serialize ScrapingEvent
  // factory ScrapingEvent.fromJson(Map<String, Object?> json) =>
  //     _$ScrapingEventFromJson(json);
}

enum ScrapingEventType { info, success, error, warning, action }

// Extensions for computed properties
extension QueueStatusExtension on QueueStatus {
  double get progressPercentage {
    if (total == 0) return 0.0;
    return (completed / total) * 100;
  }

  bool get isActive => pending > 0 || processing > 0;
  bool get isCompleted => pending == 0 && processing == 0 && total > 0;
  bool get hasErrors => failed > 0;
  bool get isStalled =>
      processing > 0 && completionRate != null && completionRate! < 0.1;
  bool get isHealthy =>
      total > 0 ? failed < (total * 0.1) : true; // Fixed division by zero

  String get statusText {
    if (isStalled) return 'Scraping stalled - may need intervention';
    if (isActive) return 'Scraping in progress...';
    if (isCompleted) return 'Scraping completed successfully';
    if (hasErrors && total > 0) return 'Scraping completed with errors';
    return 'No active scraping';
  }

  String get detailedStatusText {
    if (total == 0) return 'No scraping jobs queued';

    final progress =
        '${completed}/${total} completed (${progressPercentage.toStringAsFixed(1)}%)';

    if (isActive) {
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

extension RecentCompanyExtension on RecentCompany {
  String get timeAgo {
    final diff = DateTime.now().difference(completedAt);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}

extension ProcessingItemExtension on ProcessingItem {
  bool get isStuck => processingDuration > 300; // 5 minutes
  String get durationText => '${processingDuration.toInt()}s';

  String get statusText {
    if (isStuck) return 'Stuck ($durationText)';
    return 'Processing ($durationText)';
  }

  String get timeAgo {
    final diff = DateTime.now().difference(startedAt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }
}

extension FailedItemExtension on FailedItem {
  bool get canRetry => retryCount < 3;

  String get timeAgo {
    final diff = DateTime.now().difference(failedAt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    return '${diff.inHours}h ago';
  }

  String get shortError {
    if (error.length <= 50) return error;
    return '${error.substring(0, 47)}...';
  }
}

extension DetailedProgressExtension on DetailedProgress {
  int get stuckItemsCount =>
      currentlyProcessing.where((item) => item.isStuck).length;
  int get retryableFailuresCount =>
      recentFailures.where((item) => item.canRetry).length;

  bool get hasStuckItems => stuckItemsCount > 0;
  bool get hasRetryableFailures => retryableFailuresCount > 0;
}

extension ScrapingEventExtension on ScrapingEvent {
  String get timeAgo {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
