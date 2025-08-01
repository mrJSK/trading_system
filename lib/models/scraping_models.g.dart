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
      recentCompleted: (json['recentCompleted'] as List<dynamic>?)
              ?.map((e) => RecentCompany.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      timestamp: DateTime.parse(json['timestamp'] as String),
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
      'recentCompleted': instance.recentCompleted,
      'timestamp': instance.timestamp.toIso8601String(),
      'estimatedTimeRemaining': instance.estimatedTimeRemaining,
      'completionRate': instance.completionRate,
      'queueStats': instance.queueStats,
    };

_$RecentCompanyImpl _$$RecentCompanyImplFromJson(Map<String, dynamic> json) =>
    _$RecentCompanyImpl(
      symbol: json['symbol'] as String,
      companyName: json['companyName'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$RecentCompanyImplToJson(_$RecentCompanyImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'companyName': instance.companyName,
      'completedAt': instance.completedAt.toIso8601String(),
    };

_$ScrapingStateImpl _$$ScrapingStateImplFromJson(Map<String, dynamic> json) =>
    _$ScrapingStateImpl(
      queueStatus: json['queueStatus'] == null
          ? null
          : QueueStatus.fromJson(json['queueStatus'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String?,
      showDetails: json['showDetails'] as bool? ?? false,
    );

Map<String, dynamic> _$$ScrapingStateImplToJson(_$ScrapingStateImpl instance) =>
    <String, dynamic>{
      'queueStatus': instance.queueStatus,
      'isLoading': instance.isLoading,
      'error': instance.error,
      'showDetails': instance.showDetails,
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
    };

_$ProcessingItemImpl _$$ProcessingItemImplFromJson(Map<String, dynamic> json) =>
    _$ProcessingItemImpl(
      url: json['url'] as String,
      symbol: json['symbol'] as String,
      startedAt: DateTime.parse(json['startedAt'] as String),
      processingDuration:
          (json['processingDuration'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$ProcessingItemImplToJson(
        _$ProcessingItemImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'symbol': instance.symbol,
      'startedAt': instance.startedAt.toIso8601String(),
      'processingDuration': instance.processingDuration,
    };

_$FailedItemImpl _$$FailedItemImplFromJson(Map<String, dynamic> json) =>
    _$FailedItemImpl(
      url: json['url'] as String,
      error: json['error'] as String,
      failedAt: DateTime.parse(json['failedAt'] as String),
      retryCount: (json['retryCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$FailedItemImplToJson(_$FailedItemImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'error': instance.error,
      'failedAt': instance.failedAt.toIso8601String(),
      'retryCount': instance.retryCount,
    };

_$ScrapingEventImpl _$$ScrapingEventImplFromJson(Map<String, dynamic> json) =>
    _$ScrapingEventImpl(
      message: json['message'] as String,
      type: $enumDecode(_$ScrapingEventTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$ScrapingEventImplToJson(_$ScrapingEventImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'type': _$ScrapingEventTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$ScrapingEventTypeEnumMap = {
  ScrapingEventType.info: 'info',
  ScrapingEventType.success: 'success',
  ScrapingEventType.error: 'error',
  ScrapingEventType.warning: 'warning',
  ScrapingEventType.action: 'action',
};
