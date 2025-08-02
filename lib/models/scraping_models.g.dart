// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scraping_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QueueStatusImpl _$$QueueStatusImplFromJson(Map<String, dynamic> json) =>
    _$QueueStatusImpl(
      pending: (json['pending'] as num?)?.toInt() ?? 0,
      processing: (json['processing'] as num?)?.toInt() ?? 0,
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      failed: (json['failed'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      progressPercentage:
          (json['progressPercentage'] as num?)?.toDouble() ?? 0.0,
      statusText: json['statusText'] as String? ?? 'Ready',
      timestamp: DateTime.parse(json['timestamp'] as String),
      recentCompleted: (json['recentCompleted'] as List<dynamic>?)
              ?.map((e) =>
                  RecentCompletedItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      estimatedTimeRemaining: json['estimatedTimeRemaining'] as String?,
      completionRate: (json['completionRate'] as num?)?.toDouble(),
      queueStats: json['queueStats'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$QueueStatusImplToJson(_$QueueStatusImpl instance) =>
    <String, dynamic>{
      'pending': instance.pending,
      'processing': instance.processing,
      'completed': instance.completed,
      'failed': instance.failed,
      'total': instance.total,
      'isActive': instance.isActive,
      'isCompleted': instance.isCompleted,
      'progressPercentage': instance.progressPercentage,
      'statusText': instance.statusText,
      'timestamp': instance.timestamp.toIso8601String(),
      'recentCompleted': instance.recentCompleted,
      'estimatedTimeRemaining': instance.estimatedTimeRemaining,
      'completionRate': instance.completionRate,
      'queueStats': instance.queueStats,
    };

_$RecentCompletedItemImpl _$$RecentCompletedItemImplFromJson(
        Map<String, dynamic> json) =>
    _$RecentCompletedItemImpl(
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String,
      completedAt: json['completedAt'] as String,
    );

Map<String, dynamic> _$$RecentCompletedItemImplToJson(
        _$RecentCompletedItemImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'completedAt': instance.completedAt,
    };

_$ScrapingStatusImpl _$$ScrapingStatusImplFromJson(Map<String, dynamic> json) =>
    _$ScrapingStatusImpl(
      processedCount: (json['processedCount'] as num?)?.toInt() ?? 0,
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
      failedCount: (json['failedCount'] as num?)?.toInt() ?? 0,
      pendingCount: (json['pendingCount'] as num?)?.toInt() ?? 0,
      processingCount: (json['processingCount'] as num?)?.toInt() ?? 0,
      isActive: json['isActive'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
      hasErrors: json['hasErrors'] as bool? ?? false,
      statusMessage: json['statusMessage'] as String? ?? '',
      estimatedTimeRemaining:
          (json['estimatedTimeRemaining'] as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      queueStatus: json['queueStatus'] == null
          ? null
          : QueueStatus.fromJson(json['queueStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ScrapingStatusImplToJson(
        _$ScrapingStatusImpl instance) =>
    <String, dynamic>{
      'processedCount': instance.processedCount,
      'totalCount': instance.totalCount,
      'failedCount': instance.failedCount,
      'pendingCount': instance.pendingCount,
      'processingCount': instance.processingCount,
      'isActive': instance.isActive,
      'isCompleted': instance.isCompleted,
      'hasErrors': instance.hasErrors,
      'statusMessage': instance.statusMessage,
      'estimatedTimeRemaining': instance.estimatedTimeRemaining,
      'progress': instance.progress,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'queueStatus': instance.queueStatus,
    };

_$ScrapingStateImpl _$$ScrapingStateImplFromJson(Map<String, dynamic> json) =>
    _$ScrapingStateImpl(
      scrapingStatus: json['scrapingStatus'] == null
          ? null
          : ScrapingStatus.fromJson(
              json['scrapingStatus'] as Map<String, dynamic>),
      queueStatus: json['queueStatus'] == null
          ? null
          : QueueStatus.fromJson(json['queueStatus'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
      isTriggering: json['isTriggering'] as bool? ?? false,
      error: json['error'] as String?,
      showDetails: json['showDetails'] as bool? ?? false,
      lastTriggered: json['lastTriggered'] == null
          ? null
          : DateTime.parse(json['lastTriggered'] as String),
      recentEvents: (json['recentEvents'] as List<dynamic>?)
              ?.map((e) => ScrapingEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ScrapingStateImplToJson(_$ScrapingStateImpl instance) =>
    <String, dynamic>{
      'scrapingStatus': instance.scrapingStatus,
      'queueStatus': instance.queueStatus,
      'isLoading': instance.isLoading,
      'isTriggering': instance.isTriggering,
      'error': instance.error,
      'showDetails': instance.showDetails,
      'lastTriggered': instance.lastTriggered?.toIso8601String(),
      'recentEvents': instance.recentEvents,
    };

_$DetailedProgressImpl _$$DetailedProgressImplFromJson(
        Map<String, dynamic> json) =>
    _$DetailedProgressImpl(
      queueStatus:
          QueueStatus.fromJson(json['queueStatus'] as Map<String, dynamic>),
      currentlyProcessing: (json['currentlyProcessing'] as List<dynamic>?)
              ?.map((e) => ProcessingItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      recentFailures: (json['recentFailures'] as List<dynamic>?)
              ?.map((e) => FailedItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      estimatedCompletion: json['estimatedCompletion'] == null
          ? null
          : DateTime.parse(json['estimatedCompletion'] as String),
      estimatedRemainingTime: json['estimatedRemainingTime'] as String?,
      performanceMetrics:
          json['performanceMetrics'] as Map<String, dynamic>? ?? const {},
      successRate: (json['successRate'] as num?)?.toDouble() ?? 0.0,
      averageProcessingTime:
          (json['averageProcessingTime'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$DetailedProgressImplToJson(
        _$DetailedProgressImpl instance) =>
    <String, dynamic>{
      'queueStatus': instance.queueStatus,
      'currentlyProcessing': instance.currentlyProcessing,
      'recentFailures': instance.recentFailures,
      'estimatedCompletion': instance.estimatedCompletion?.toIso8601String(),
      'estimatedRemainingTime': instance.estimatedRemainingTime,
      'performanceMetrics': instance.performanceMetrics,
      'successRate': instance.successRate,
      'averageProcessingTime': instance.averageProcessingTime,
    };

_$ProcessingItemImpl _$$ProcessingItemImplFromJson(Map<String, dynamic> json) =>
    _$ProcessingItemImpl(
      url: json['url'] as String,
      symbol: json['symbol'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      processingDuration:
          (json['processingDuration'] as num?)?.toDouble() ?? 0.0,
      processorId: json['processorId'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$ProcessingItemImplToJson(
        _$ProcessingItemImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'symbol': instance.symbol,
      'startedAt': instance.startedAt.toIso8601String(),
      'processingDuration': instance.processingDuration,
      'processorId': instance.processorId,
      'status': instance.status,
    };

_$FailedItemImpl _$$FailedItemImplFromJson(Map<String, dynamic> json) =>
    _$FailedItemImpl(
      url: json['url'] as String,
      error: json['error'] as String,
      failedAt: DateTime.parse(json['failedAt'] as String),
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
      maxRetries: (json['maxRetries'] as num?)?.toInt() ?? 3,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$$FailedItemImplToJson(_$FailedItemImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'error': instance.error,
      'failedAt': instance.failedAt.toIso8601String(),
      'retryCount': instance.retryCount,
      'maxRetries': instance.maxRetries,
      'symbol': instance.symbol,
    };

_$ScrapingEventImpl _$$ScrapingEventImplFromJson(Map<String, dynamic> json) =>
    _$ScrapingEventImpl(
      message: json['message'] as String,
      type: $enumDecode(_$ScrapingEventTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      details: json['details'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ScrapingEventImplToJson(_$ScrapingEventImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': _$ScrapingEventTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'details': instance.details,
      'metadata': instance.metadata,
    };

const _$ScrapingEventTypeEnumMap = {
  ScrapingEventType.info: 'info',
  ScrapingEventType.success: 'success',
  ScrapingEventType.error: 'error',
  ScrapingEventType.warning: 'warning',
  ScrapingEventType.action: 'action',
  ScrapingEventType.started: 'started',
  ScrapingEventType.completed: 'completed',
  ScrapingEventType.paused: 'paused',
  ScrapingEventType.stopped: 'stopped',
};

_$ScrapingStatsImpl _$$ScrapingStatsImplFromJson(Map<String, dynamic> json) =>
    _$ScrapingStatsImpl(
      queueStatus:
          QueueStatus.fromJson(json['queueStatus'] as Map<String, dynamic>),
      recentCompleted: (json['recentCompleted'] as List<dynamic>?)
              ?.map((e) =>
                  RecentCompletedItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalCompaniesProcessed:
          (json['totalCompaniesProcessed'] as num?)?.toInt() ?? 0,
      successRate: (json['successRate'] as num?)?.toInt() ?? 0,
      isHealthy: json['isHealthy'] as bool? ?? true,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      additionalMetrics:
          json['additionalMetrics'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ScrapingStatsImplToJson(_$ScrapingStatsImpl instance) =>
    <String, dynamic>{
      'queueStatus': instance.queueStatus,
      'recentCompleted': instance.recentCompleted,
      'totalCompaniesProcessed': instance.totalCompaniesProcessed,
      'successRate': instance.successRate,
      'isHealthy': instance.isHealthy,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'additionalMetrics': instance.additionalMetrics,
    };
