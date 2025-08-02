// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scraping_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QueueStatus _$QueueStatusFromJson(Map<String, dynamic> json) {
  return _QueueStatus.fromJson(json);
}

/// @nodoc
mixin _$QueueStatus {
  int get pending => throw _privateConstructorUsedError;
  int get processing => throw _privateConstructorUsedError;
  int get completed => throw _privateConstructorUsedError;
  int get failed => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  double get progressPercentage => throw _privateConstructorUsedError;
  String get statusText => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<RecentCompletedItem> get recentCompleted =>
      throw _privateConstructorUsedError;
  String? get estimatedTimeRemaining => throw _privateConstructorUsedError;
  double? get completionRate => throw _privateConstructorUsedError;
  Map<String, dynamic> get queueStats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QueueStatusCopyWith<QueueStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueStatusCopyWith<$Res> {
  factory $QueueStatusCopyWith(
          QueueStatus value, $Res Function(QueueStatus) then) =
      _$QueueStatusCopyWithImpl<$Res, QueueStatus>;
  @useResult
  $Res call(
      {int pending,
      int processing,
      int completed,
      int failed,
      int total,
      bool isActive,
      bool isCompleted,
      double progressPercentage,
      String statusText,
      DateTime timestamp,
      List<RecentCompletedItem> recentCompleted,
      String? estimatedTimeRemaining,
      double? completionRate,
      Map<String, dynamic> queueStats});
}

/// @nodoc
class _$QueueStatusCopyWithImpl<$Res, $Val extends QueueStatus>
    implements $QueueStatusCopyWith<$Res> {
  _$QueueStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pending = null,
    Object? processing = null,
    Object? completed = null,
    Object? failed = null,
    Object? total = null,
    Object? isActive = null,
    Object? isCompleted = null,
    Object? progressPercentage = null,
    Object? statusText = null,
    Object? timestamp = null,
    Object? recentCompleted = null,
    Object? estimatedTimeRemaining = freezed,
    Object? completionRate = freezed,
    Object? queueStats = null,
  }) {
    return _then(_value.copyWith(
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as int,
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _value.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      statusText: null == statusText
          ? _value.statusText
          : statusText // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recentCompleted: null == recentCompleted
          ? _value.recentCompleted
          : recentCompleted // ignore: cast_nullable_to_non_nullable
              as List<RecentCompletedItem>,
      estimatedTimeRemaining: freezed == estimatedTimeRemaining
          ? _value.estimatedTimeRemaining
          : estimatedTimeRemaining // ignore: cast_nullable_to_non_nullable
              as String?,
      completionRate: freezed == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double?,
      queueStats: null == queueStats
          ? _value.queueStats
          : queueStats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QueueStatusImplCopyWith<$Res>
    implements $QueueStatusCopyWith<$Res> {
  factory _$$QueueStatusImplCopyWith(
          _$QueueStatusImpl value, $Res Function(_$QueueStatusImpl) then) =
      __$$QueueStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int pending,
      int processing,
      int completed,
      int failed,
      int total,
      bool isActive,
      bool isCompleted,
      double progressPercentage,
      String statusText,
      DateTime timestamp,
      List<RecentCompletedItem> recentCompleted,
      String? estimatedTimeRemaining,
      double? completionRate,
      Map<String, dynamic> queueStats});
}

/// @nodoc
class __$$QueueStatusImplCopyWithImpl<$Res>
    extends _$QueueStatusCopyWithImpl<$Res, _$QueueStatusImpl>
    implements _$$QueueStatusImplCopyWith<$Res> {
  __$$QueueStatusImplCopyWithImpl(
      _$QueueStatusImpl _value, $Res Function(_$QueueStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pending = null,
    Object? processing = null,
    Object? completed = null,
    Object? failed = null,
    Object? total = null,
    Object? isActive = null,
    Object? isCompleted = null,
    Object? progressPercentage = null,
    Object? statusText = null,
    Object? timestamp = null,
    Object? recentCompleted = null,
    Object? estimatedTimeRemaining = freezed,
    Object? completionRate = freezed,
    Object? queueStats = null,
  }) {
    return _then(_$QueueStatusImpl(
      pending: null == pending
          ? _value.pending
          : pending // ignore: cast_nullable_to_non_nullable
              as int,
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as int,
      failed: null == failed
          ? _value.failed
          : failed // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      statusText: null == statusText
          ? _value.statusText
          : statusText // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recentCompleted: null == recentCompleted
          ? _value._recentCompleted
          : recentCompleted // ignore: cast_nullable_to_non_nullable
              as List<RecentCompletedItem>,
      estimatedTimeRemaining: freezed == estimatedTimeRemaining
          ? _value.estimatedTimeRemaining
          : estimatedTimeRemaining // ignore: cast_nullable_to_non_nullable
              as String?,
      completionRate: freezed == completionRate
          ? _value.completionRate
          : completionRate // ignore: cast_nullable_to_non_nullable
              as double?,
      queueStats: null == queueStats
          ? _value._queueStats
          : queueStats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueStatusImpl implements _QueueStatus {
  const _$QueueStatusImpl(
      {this.pending = 0,
      this.processing = 0,
      this.completed = 0,
      this.failed = 0,
      this.total = 0,
      this.isActive = false,
      this.isCompleted = false,
      this.progressPercentage = 0.0,
      this.statusText = 'Ready',
      required this.timestamp,
      final List<RecentCompletedItem> recentCompleted = const [],
      this.estimatedTimeRemaining,
      this.completionRate,
      final Map<String, dynamic> queueStats = const {}})
      : _recentCompleted = recentCompleted,
        _queueStats = queueStats;

  factory _$QueueStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueStatusImplFromJson(json);

  @override
  @JsonKey()
  final int pending;
  @override
  @JsonKey()
  final int processing;
  @override
  @JsonKey()
  final int completed;
  @override
  @JsonKey()
  final int failed;
  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final double progressPercentage;
  @override
  @JsonKey()
  final String statusText;
  @override
  final DateTime timestamp;
  final List<RecentCompletedItem> _recentCompleted;
  @override
  @JsonKey()
  List<RecentCompletedItem> get recentCompleted {
    if (_recentCompleted is EqualUnmodifiableListView) return _recentCompleted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentCompleted);
  }

  @override
  final String? estimatedTimeRemaining;
  @override
  final double? completionRate;
  final Map<String, dynamic> _queueStats;
  @override
  @JsonKey()
  Map<String, dynamic> get queueStats {
    if (_queueStats is EqualUnmodifiableMapView) return _queueStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_queueStats);
  }

  @override
  String toString() {
    return 'QueueStatus(pending: $pending, processing: $processing, completed: $completed, failed: $failed, total: $total, isActive: $isActive, isCompleted: $isCompleted, progressPercentage: $progressPercentage, statusText: $statusText, timestamp: $timestamp, recentCompleted: $recentCompleted, estimatedTimeRemaining: $estimatedTimeRemaining, completionRate: $completionRate, queueStats: $queueStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueStatusImpl &&
            (identical(other.pending, pending) || other.pending == pending) &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.failed, failed) || other.failed == failed) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage) &&
            (identical(other.statusText, statusText) ||
                other.statusText == statusText) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._recentCompleted, _recentCompleted) &&
            (identical(other.estimatedTimeRemaining, estimatedTimeRemaining) ||
                other.estimatedTimeRemaining == estimatedTimeRemaining) &&
            (identical(other.completionRate, completionRate) ||
                other.completionRate == completionRate) &&
            const DeepCollectionEquality()
                .equals(other._queueStats, _queueStats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      pending,
      processing,
      completed,
      failed,
      total,
      isActive,
      isCompleted,
      progressPercentage,
      statusText,
      timestamp,
      const DeepCollectionEquality().hash(_recentCompleted),
      estimatedTimeRemaining,
      completionRate,
      const DeepCollectionEquality().hash(_queueStats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueStatusImplCopyWith<_$QueueStatusImpl> get copyWith =>
      __$$QueueStatusImplCopyWithImpl<_$QueueStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueStatusImplToJson(
      this,
    );
  }
}

abstract class _QueueStatus implements QueueStatus {
  const factory _QueueStatus(
      {final int pending,
      final int processing,
      final int completed,
      final int failed,
      final int total,
      final bool isActive,
      final bool isCompleted,
      final double progressPercentage,
      final String statusText,
      required final DateTime timestamp,
      final List<RecentCompletedItem> recentCompleted,
      final String? estimatedTimeRemaining,
      final double? completionRate,
      final Map<String, dynamic> queueStats}) = _$QueueStatusImpl;

  factory _QueueStatus.fromJson(Map<String, dynamic> json) =
      _$QueueStatusImpl.fromJson;

  @override
  int get pending;
  @override
  int get processing;
  @override
  int get completed;
  @override
  int get failed;
  @override
  int get total;
  @override
  bool get isActive;
  @override
  bool get isCompleted;
  @override
  double get progressPercentage;
  @override
  String get statusText;
  @override
  DateTime get timestamp;
  @override
  List<RecentCompletedItem> get recentCompleted;
  @override
  String? get estimatedTimeRemaining;
  @override
  double? get completionRate;
  @override
  Map<String, dynamic> get queueStats;
  @override
  @JsonKey(ignore: true)
  _$$QueueStatusImplCopyWith<_$QueueStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecentCompletedItem _$RecentCompletedItemFromJson(Map<String, dynamic> json) {
  return _RecentCompletedItem.fromJson(json);
}

/// @nodoc
mixin _$RecentCompletedItem {
  String get symbol => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  String get completedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecentCompletedItemCopyWith<RecentCompletedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentCompletedItemCopyWith<$Res> {
  factory $RecentCompletedItemCopyWith(
          RecentCompletedItem value, $Res Function(RecentCompletedItem) then) =
      _$RecentCompletedItemCopyWithImpl<$Res, RecentCompletedItem>;
  @useResult
  $Res call({String symbol, String companyName, String completedAt});
}

/// @nodoc
class _$RecentCompletedItemCopyWithImpl<$Res, $Val extends RecentCompletedItem>
    implements $RecentCompletedItemCopyWith<$Res> {
  _$RecentCompletedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? completedAt = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecentCompletedItemImplCopyWith<$Res>
    implements $RecentCompletedItemCopyWith<$Res> {
  factory _$$RecentCompletedItemImplCopyWith(_$RecentCompletedItemImpl value,
          $Res Function(_$RecentCompletedItemImpl) then) =
      __$$RecentCompletedItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String symbol, String companyName, String completedAt});
}

/// @nodoc
class __$$RecentCompletedItemImplCopyWithImpl<$Res>
    extends _$RecentCompletedItemCopyWithImpl<$Res, _$RecentCompletedItemImpl>
    implements _$$RecentCompletedItemImplCopyWith<$Res> {
  __$$RecentCompletedItemImplCopyWithImpl(_$RecentCompletedItemImpl _value,
      $Res Function(_$RecentCompletedItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? completedAt = null,
  }) {
    return _then(_$RecentCompletedItemImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecentCompletedItemImpl implements _RecentCompletedItem {
  const _$RecentCompletedItemImpl(
      {required this.symbol,
      required this.companyName,
      required this.completedAt});

  factory _$RecentCompletedItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecentCompletedItemImplFromJson(json);

  @override
  final String symbol;
  @override
  final String companyName;
  @override
  final String completedAt;

  @override
  String toString() {
    return 'RecentCompletedItem(symbol: $symbol, companyName: $companyName, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentCompletedItemImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, symbol, companyName, completedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecentCompletedItemImplCopyWith<_$RecentCompletedItemImpl> get copyWith =>
      __$$RecentCompletedItemImplCopyWithImpl<_$RecentCompletedItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentCompletedItemImplToJson(
      this,
    );
  }
}

abstract class _RecentCompletedItem implements RecentCompletedItem {
  const factory _RecentCompletedItem(
      {required final String symbol,
      required final String companyName,
      required final String completedAt}) = _$RecentCompletedItemImpl;

  factory _RecentCompletedItem.fromJson(Map<String, dynamic> json) =
      _$RecentCompletedItemImpl.fromJson;

  @override
  String get symbol;
  @override
  String get companyName;
  @override
  String get completedAt;
  @override
  @JsonKey(ignore: true)
  _$$RecentCompletedItemImplCopyWith<_$RecentCompletedItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScrapingStatus _$ScrapingStatusFromJson(Map<String, dynamic> json) {
  return _ScrapingStatus.fromJson(json);
}

/// @nodoc
mixin _$ScrapingStatus {
  int get processedCount => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int get failedCount => throw _privateConstructorUsedError;
  int get pendingCount => throw _privateConstructorUsedError;
  int get processingCount => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get hasErrors => throw _privateConstructorUsedError;
  String get statusMessage => throw _privateConstructorUsedError;
  int get estimatedTimeRemaining => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  QueueStatus? get queueStatus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScrapingStatusCopyWith<ScrapingStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScrapingStatusCopyWith<$Res> {
  factory $ScrapingStatusCopyWith(
          ScrapingStatus value, $Res Function(ScrapingStatus) then) =
      _$ScrapingStatusCopyWithImpl<$Res, ScrapingStatus>;
  @useResult
  $Res call(
      {int processedCount,
      int totalCount,
      int failedCount,
      int pendingCount,
      int processingCount,
      bool isActive,
      bool isCompleted,
      bool hasErrors,
      String statusMessage,
      int estimatedTimeRemaining,
      double progress,
      DateTime? lastUpdated,
      QueueStatus? queueStatus});

  $QueueStatusCopyWith<$Res>? get queueStatus;
}

/// @nodoc
class _$ScrapingStatusCopyWithImpl<$Res, $Val extends ScrapingStatus>
    implements $ScrapingStatusCopyWith<$Res> {
  _$ScrapingStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processedCount = null,
    Object? totalCount = null,
    Object? failedCount = null,
    Object? pendingCount = null,
    Object? processingCount = null,
    Object? isActive = null,
    Object? isCompleted = null,
    Object? hasErrors = null,
    Object? statusMessage = null,
    Object? estimatedTimeRemaining = null,
    Object? progress = null,
    Object? lastUpdated = freezed,
    Object? queueStatus = freezed,
  }) {
    return _then(_value.copyWith(
      processedCount: null == processedCount
          ? _value.processedCount
          : processedCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      failedCount: null == failedCount
          ? _value.failedCount
          : failedCount // ignore: cast_nullable_to_non_nullable
              as int,
      pendingCount: null == pendingCount
          ? _value.pendingCount
          : pendingCount // ignore: cast_nullable_to_non_nullable
              as int,
      processingCount: null == processingCount
          ? _value.processingCount
          : processingCount // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      hasErrors: null == hasErrors
          ? _value.hasErrors
          : hasErrors // ignore: cast_nullable_to_non_nullable
              as bool,
      statusMessage: null == statusMessage
          ? _value.statusMessage
          : statusMessage // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedTimeRemaining: null == estimatedTimeRemaining
          ? _value.estimatedTimeRemaining
          : estimatedTimeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      queueStatus: freezed == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as QueueStatus?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QueueStatusCopyWith<$Res>? get queueStatus {
    if (_value.queueStatus == null) {
      return null;
    }

    return $QueueStatusCopyWith<$Res>(_value.queueStatus!, (value) {
      return _then(_value.copyWith(queueStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScrapingStatusImplCopyWith<$Res>
    implements $ScrapingStatusCopyWith<$Res> {
  factory _$$ScrapingStatusImplCopyWith(_$ScrapingStatusImpl value,
          $Res Function(_$ScrapingStatusImpl) then) =
      __$$ScrapingStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int processedCount,
      int totalCount,
      int failedCount,
      int pendingCount,
      int processingCount,
      bool isActive,
      bool isCompleted,
      bool hasErrors,
      String statusMessage,
      int estimatedTimeRemaining,
      double progress,
      DateTime? lastUpdated,
      QueueStatus? queueStatus});

  @override
  $QueueStatusCopyWith<$Res>? get queueStatus;
}

/// @nodoc
class __$$ScrapingStatusImplCopyWithImpl<$Res>
    extends _$ScrapingStatusCopyWithImpl<$Res, _$ScrapingStatusImpl>
    implements _$$ScrapingStatusImplCopyWith<$Res> {
  __$$ScrapingStatusImplCopyWithImpl(
      _$ScrapingStatusImpl _value, $Res Function(_$ScrapingStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processedCount = null,
    Object? totalCount = null,
    Object? failedCount = null,
    Object? pendingCount = null,
    Object? processingCount = null,
    Object? isActive = null,
    Object? isCompleted = null,
    Object? hasErrors = null,
    Object? statusMessage = null,
    Object? estimatedTimeRemaining = null,
    Object? progress = null,
    Object? lastUpdated = freezed,
    Object? queueStatus = freezed,
  }) {
    return _then(_$ScrapingStatusImpl(
      processedCount: null == processedCount
          ? _value.processedCount
          : processedCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      failedCount: null == failedCount
          ? _value.failedCount
          : failedCount // ignore: cast_nullable_to_non_nullable
              as int,
      pendingCount: null == pendingCount
          ? _value.pendingCount
          : pendingCount // ignore: cast_nullable_to_non_nullable
              as int,
      processingCount: null == processingCount
          ? _value.processingCount
          : processingCount // ignore: cast_nullable_to_non_nullable
              as int,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      hasErrors: null == hasErrors
          ? _value.hasErrors
          : hasErrors // ignore: cast_nullable_to_non_nullable
              as bool,
      statusMessage: null == statusMessage
          ? _value.statusMessage
          : statusMessage // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedTimeRemaining: null == estimatedTimeRemaining
          ? _value.estimatedTimeRemaining
          : estimatedTimeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      queueStatus: freezed == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as QueueStatus?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScrapingStatusImpl implements _ScrapingStatus {
  const _$ScrapingStatusImpl(
      {this.processedCount = 0,
      this.totalCount = 0,
      this.failedCount = 0,
      this.pendingCount = 0,
      this.processingCount = 0,
      this.isActive = false,
      this.isCompleted = false,
      this.hasErrors = false,
      this.statusMessage = '',
      this.estimatedTimeRemaining = 0,
      this.progress = 0.0,
      this.lastUpdated,
      this.queueStatus});

  factory _$ScrapingStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScrapingStatusImplFromJson(json);

  @override
  @JsonKey()
  final int processedCount;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final int failedCount;
  @override
  @JsonKey()
  final int pendingCount;
  @override
  @JsonKey()
  final int processingCount;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isCompleted;
  @override
  @JsonKey()
  final bool hasErrors;
  @override
  @JsonKey()
  final String statusMessage;
  @override
  @JsonKey()
  final int estimatedTimeRemaining;
  @override
  @JsonKey()
  final double progress;
  @override
  final DateTime? lastUpdated;
  @override
  final QueueStatus? queueStatus;

  @override
  String toString() {
    return 'ScrapingStatus(processedCount: $processedCount, totalCount: $totalCount, failedCount: $failedCount, pendingCount: $pendingCount, processingCount: $processingCount, isActive: $isActive, isCompleted: $isCompleted, hasErrors: $hasErrors, statusMessage: $statusMessage, estimatedTimeRemaining: $estimatedTimeRemaining, progress: $progress, lastUpdated: $lastUpdated, queueStatus: $queueStatus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrapingStatusImpl &&
            (identical(other.processedCount, processedCount) ||
                other.processedCount == processedCount) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.failedCount, failedCount) ||
                other.failedCount == failedCount) &&
            (identical(other.pendingCount, pendingCount) ||
                other.pendingCount == pendingCount) &&
            (identical(other.processingCount, processingCount) ||
                other.processingCount == processingCount) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.hasErrors, hasErrors) ||
                other.hasErrors == hasErrors) &&
            (identical(other.statusMessage, statusMessage) ||
                other.statusMessage == statusMessage) &&
            (identical(other.estimatedTimeRemaining, estimatedTimeRemaining) ||
                other.estimatedTimeRemaining == estimatedTimeRemaining) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.queueStatus, queueStatus) ||
                other.queueStatus == queueStatus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      processedCount,
      totalCount,
      failedCount,
      pendingCount,
      processingCount,
      isActive,
      isCompleted,
      hasErrors,
      statusMessage,
      estimatedTimeRemaining,
      progress,
      lastUpdated,
      queueStatus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScrapingStatusImplCopyWith<_$ScrapingStatusImpl> get copyWith =>
      __$$ScrapingStatusImplCopyWithImpl<_$ScrapingStatusImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScrapingStatusImplToJson(
      this,
    );
  }
}

abstract class _ScrapingStatus implements ScrapingStatus {
  const factory _ScrapingStatus(
      {final int processedCount,
      final int totalCount,
      final int failedCount,
      final int pendingCount,
      final int processingCount,
      final bool isActive,
      final bool isCompleted,
      final bool hasErrors,
      final String statusMessage,
      final int estimatedTimeRemaining,
      final double progress,
      final DateTime? lastUpdated,
      final QueueStatus? queueStatus}) = _$ScrapingStatusImpl;

  factory _ScrapingStatus.fromJson(Map<String, dynamic> json) =
      _$ScrapingStatusImpl.fromJson;

  @override
  int get processedCount;
  @override
  int get totalCount;
  @override
  int get failedCount;
  @override
  int get pendingCount;
  @override
  int get processingCount;
  @override
  bool get isActive;
  @override
  bool get isCompleted;
  @override
  bool get hasErrors;
  @override
  String get statusMessage;
  @override
  int get estimatedTimeRemaining;
  @override
  double get progress;
  @override
  DateTime? get lastUpdated;
  @override
  QueueStatus? get queueStatus;
  @override
  @JsonKey(ignore: true)
  _$$ScrapingStatusImplCopyWith<_$ScrapingStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScrapingState _$ScrapingStateFromJson(Map<String, dynamic> json) {
  return _ScrapingState.fromJson(json);
}

/// @nodoc
mixin _$ScrapingState {
  ScrapingStatus? get scrapingStatus => throw _privateConstructorUsedError;
  QueueStatus? get queueStatus => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isTriggering => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get showDetails => throw _privateConstructorUsedError;
  DateTime? get lastTriggered => throw _privateConstructorUsedError;
  List<ScrapingEvent> get recentEvents => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScrapingStateCopyWith<ScrapingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScrapingStateCopyWith<$Res> {
  factory $ScrapingStateCopyWith(
          ScrapingState value, $Res Function(ScrapingState) then) =
      _$ScrapingStateCopyWithImpl<$Res, ScrapingState>;
  @useResult
  $Res call(
      {ScrapingStatus? scrapingStatus,
      QueueStatus? queueStatus,
      bool isLoading,
      bool isTriggering,
      String? error,
      bool showDetails,
      DateTime? lastTriggered,
      List<ScrapingEvent> recentEvents});

  $ScrapingStatusCopyWith<$Res>? get scrapingStatus;
  $QueueStatusCopyWith<$Res>? get queueStatus;
}

/// @nodoc
class _$ScrapingStateCopyWithImpl<$Res, $Val extends ScrapingState>
    implements $ScrapingStateCopyWith<$Res> {
  _$ScrapingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scrapingStatus = freezed,
    Object? queueStatus = freezed,
    Object? isLoading = null,
    Object? isTriggering = null,
    Object? error = freezed,
    Object? showDetails = null,
    Object? lastTriggered = freezed,
    Object? recentEvents = null,
  }) {
    return _then(_value.copyWith(
      scrapingStatus: freezed == scrapingStatus
          ? _value.scrapingStatus
          : scrapingStatus // ignore: cast_nullable_to_non_nullable
              as ScrapingStatus?,
      queueStatus: freezed == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as QueueStatus?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isTriggering: null == isTriggering
          ? _value.isTriggering
          : isTriggering // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      showDetails: null == showDetails
          ? _value.showDetails
          : showDetails // ignore: cast_nullable_to_non_nullable
              as bool,
      lastTriggered: freezed == lastTriggered
          ? _value.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recentEvents: null == recentEvents
          ? _value.recentEvents
          : recentEvents // ignore: cast_nullable_to_non_nullable
              as List<ScrapingEvent>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ScrapingStatusCopyWith<$Res>? get scrapingStatus {
    if (_value.scrapingStatus == null) {
      return null;
    }

    return $ScrapingStatusCopyWith<$Res>(_value.scrapingStatus!, (value) {
      return _then(_value.copyWith(scrapingStatus: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $QueueStatusCopyWith<$Res>? get queueStatus {
    if (_value.queueStatus == null) {
      return null;
    }

    return $QueueStatusCopyWith<$Res>(_value.queueStatus!, (value) {
      return _then(_value.copyWith(queueStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScrapingStateImplCopyWith<$Res>
    implements $ScrapingStateCopyWith<$Res> {
  factory _$$ScrapingStateImplCopyWith(
          _$ScrapingStateImpl value, $Res Function(_$ScrapingStateImpl) then) =
      __$$ScrapingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ScrapingStatus? scrapingStatus,
      QueueStatus? queueStatus,
      bool isLoading,
      bool isTriggering,
      String? error,
      bool showDetails,
      DateTime? lastTriggered,
      List<ScrapingEvent> recentEvents});

  @override
  $ScrapingStatusCopyWith<$Res>? get scrapingStatus;
  @override
  $QueueStatusCopyWith<$Res>? get queueStatus;
}

/// @nodoc
class __$$ScrapingStateImplCopyWithImpl<$Res>
    extends _$ScrapingStateCopyWithImpl<$Res, _$ScrapingStateImpl>
    implements _$$ScrapingStateImplCopyWith<$Res> {
  __$$ScrapingStateImplCopyWithImpl(
      _$ScrapingStateImpl _value, $Res Function(_$ScrapingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scrapingStatus = freezed,
    Object? queueStatus = freezed,
    Object? isLoading = null,
    Object? isTriggering = null,
    Object? error = freezed,
    Object? showDetails = null,
    Object? lastTriggered = freezed,
    Object? recentEvents = null,
  }) {
    return _then(_$ScrapingStateImpl(
      scrapingStatus: freezed == scrapingStatus
          ? _value.scrapingStatus
          : scrapingStatus // ignore: cast_nullable_to_non_nullable
              as ScrapingStatus?,
      queueStatus: freezed == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as QueueStatus?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isTriggering: null == isTriggering
          ? _value.isTriggering
          : isTriggering // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      showDetails: null == showDetails
          ? _value.showDetails
          : showDetails // ignore: cast_nullable_to_non_nullable
              as bool,
      lastTriggered: freezed == lastTriggered
          ? _value.lastTriggered
          : lastTriggered // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recentEvents: null == recentEvents
          ? _value._recentEvents
          : recentEvents // ignore: cast_nullable_to_non_nullable
              as List<ScrapingEvent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScrapingStateImpl implements _ScrapingState {
  const _$ScrapingStateImpl(
      {this.scrapingStatus,
      this.queueStatus,
      this.isLoading = false,
      this.isTriggering = false,
      this.error,
      this.showDetails = false,
      this.lastTriggered,
      final List<ScrapingEvent> recentEvents = const []})
      : _recentEvents = recentEvents;

  factory _$ScrapingStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScrapingStateImplFromJson(json);

  @override
  final ScrapingStatus? scrapingStatus;
  @override
  final QueueStatus? queueStatus;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isTriggering;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool showDetails;
  @override
  final DateTime? lastTriggered;
  final List<ScrapingEvent> _recentEvents;
  @override
  @JsonKey()
  List<ScrapingEvent> get recentEvents {
    if (_recentEvents is EqualUnmodifiableListView) return _recentEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentEvents);
  }

  @override
  String toString() {
    return 'ScrapingState(scrapingStatus: $scrapingStatus, queueStatus: $queueStatus, isLoading: $isLoading, isTriggering: $isTriggering, error: $error, showDetails: $showDetails, lastTriggered: $lastTriggered, recentEvents: $recentEvents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrapingStateImpl &&
            (identical(other.scrapingStatus, scrapingStatus) ||
                other.scrapingStatus == scrapingStatus) &&
            (identical(other.queueStatus, queueStatus) ||
                other.queueStatus == queueStatus) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isTriggering, isTriggering) ||
                other.isTriggering == isTriggering) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.showDetails, showDetails) ||
                other.showDetails == showDetails) &&
            (identical(other.lastTriggered, lastTriggered) ||
                other.lastTriggered == lastTriggered) &&
            const DeepCollectionEquality()
                .equals(other._recentEvents, _recentEvents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      scrapingStatus,
      queueStatus,
      isLoading,
      isTriggering,
      error,
      showDetails,
      lastTriggered,
      const DeepCollectionEquality().hash(_recentEvents));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScrapingStateImplCopyWith<_$ScrapingStateImpl> get copyWith =>
      __$$ScrapingStateImplCopyWithImpl<_$ScrapingStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScrapingStateImplToJson(
      this,
    );
  }
}

abstract class _ScrapingState implements ScrapingState {
  const factory _ScrapingState(
      {final ScrapingStatus? scrapingStatus,
      final QueueStatus? queueStatus,
      final bool isLoading,
      final bool isTriggering,
      final String? error,
      final bool showDetails,
      final DateTime? lastTriggered,
      final List<ScrapingEvent> recentEvents}) = _$ScrapingStateImpl;

  factory _ScrapingState.fromJson(Map<String, dynamic> json) =
      _$ScrapingStateImpl.fromJson;

  @override
  ScrapingStatus? get scrapingStatus;
  @override
  QueueStatus? get queueStatus;
  @override
  bool get isLoading;
  @override
  bool get isTriggering;
  @override
  String? get error;
  @override
  bool get showDetails;
  @override
  DateTime? get lastTriggered;
  @override
  List<ScrapingEvent> get recentEvents;
  @override
  @JsonKey(ignore: true)
  _$$ScrapingStateImplCopyWith<_$ScrapingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DetailedProgress _$DetailedProgressFromJson(Map<String, dynamic> json) {
  return _DetailedProgress.fromJson(json);
}

/// @nodoc
mixin _$DetailedProgress {
  QueueStatus get queueStatus => throw _privateConstructorUsedError;
  List<ProcessingItem> get currentlyProcessing =>
      throw _privateConstructorUsedError;
  List<FailedItem> get recentFailures => throw _privateConstructorUsedError;
  DateTime? get estimatedCompletion => throw _privateConstructorUsedError;
  String? get estimatedRemainingTime => throw _privateConstructorUsedError;
  Map<String, dynamic> get performanceMetrics =>
      throw _privateConstructorUsedError;
  double get successRate => throw _privateConstructorUsedError;
  double get averageProcessingTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DetailedProgressCopyWith<DetailedProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailedProgressCopyWith<$Res> {
  factory $DetailedProgressCopyWith(
          DetailedProgress value, $Res Function(DetailedProgress) then) =
      _$DetailedProgressCopyWithImpl<$Res, DetailedProgress>;
  @useResult
  $Res call(
      {QueueStatus queueStatus,
      List<ProcessingItem> currentlyProcessing,
      List<FailedItem> recentFailures,
      DateTime? estimatedCompletion,
      String? estimatedRemainingTime,
      Map<String, dynamic> performanceMetrics,
      double successRate,
      double averageProcessingTime});

  $QueueStatusCopyWith<$Res> get queueStatus;
}

/// @nodoc
class _$DetailedProgressCopyWithImpl<$Res, $Val extends DetailedProgress>
    implements $DetailedProgressCopyWith<$Res> {
  _$DetailedProgressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueStatus = null,
    Object? currentlyProcessing = null,
    Object? recentFailures = null,
    Object? estimatedCompletion = freezed,
    Object? estimatedRemainingTime = freezed,
    Object? performanceMetrics = null,
    Object? successRate = null,
    Object? averageProcessingTime = null,
  }) {
    return _then(_value.copyWith(
      queueStatus: null == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as QueueStatus,
      currentlyProcessing: null == currentlyProcessing
          ? _value.currentlyProcessing
          : currentlyProcessing // ignore: cast_nullable_to_non_nullable
              as List<ProcessingItem>,
      recentFailures: null == recentFailures
          ? _value.recentFailures
          : recentFailures // ignore: cast_nullable_to_non_nullable
              as List<FailedItem>,
      estimatedCompletion: freezed == estimatedCompletion
          ? _value.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedRemainingTime: freezed == estimatedRemainingTime
          ? _value.estimatedRemainingTime
          : estimatedRemainingTime // ignore: cast_nullable_to_non_nullable
              as String?,
      performanceMetrics: null == performanceMetrics
          ? _value.performanceMetrics
          : performanceMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageProcessingTime: null == averageProcessingTime
          ? _value.averageProcessingTime
          : averageProcessingTime // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QueueStatusCopyWith<$Res> get queueStatus {
    return $QueueStatusCopyWith<$Res>(_value.queueStatus, (value) {
      return _then(_value.copyWith(queueStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DetailedProgressImplCopyWith<$Res>
    implements $DetailedProgressCopyWith<$Res> {
  factory _$$DetailedProgressImplCopyWith(_$DetailedProgressImpl value,
          $Res Function(_$DetailedProgressImpl) then) =
      __$$DetailedProgressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {QueueStatus queueStatus,
      List<ProcessingItem> currentlyProcessing,
      List<FailedItem> recentFailures,
      DateTime? estimatedCompletion,
      String? estimatedRemainingTime,
      Map<String, dynamic> performanceMetrics,
      double successRate,
      double averageProcessingTime});

  @override
  $QueueStatusCopyWith<$Res> get queueStatus;
}

/// @nodoc
class __$$DetailedProgressImplCopyWithImpl<$Res>
    extends _$DetailedProgressCopyWithImpl<$Res, _$DetailedProgressImpl>
    implements _$$DetailedProgressImplCopyWith<$Res> {
  __$$DetailedProgressImplCopyWithImpl(_$DetailedProgressImpl _value,
      $Res Function(_$DetailedProgressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueStatus = null,
    Object? currentlyProcessing = null,
    Object? recentFailures = null,
    Object? estimatedCompletion = freezed,
    Object? estimatedRemainingTime = freezed,
    Object? performanceMetrics = null,
    Object? successRate = null,
    Object? averageProcessingTime = null,
  }) {
    return _then(_$DetailedProgressImpl(
      queueStatus: null == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as QueueStatus,
      currentlyProcessing: null == currentlyProcessing
          ? _value._currentlyProcessing
          : currentlyProcessing // ignore: cast_nullable_to_non_nullable
              as List<ProcessingItem>,
      recentFailures: null == recentFailures
          ? _value._recentFailures
          : recentFailures // ignore: cast_nullable_to_non_nullable
              as List<FailedItem>,
      estimatedCompletion: freezed == estimatedCompletion
          ? _value.estimatedCompletion
          : estimatedCompletion // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      estimatedRemainingTime: freezed == estimatedRemainingTime
          ? _value.estimatedRemainingTime
          : estimatedRemainingTime // ignore: cast_nullable_to_non_nullable
              as String?,
      performanceMetrics: null == performanceMetrics
          ? _value._performanceMetrics
          : performanceMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as double,
      averageProcessingTime: null == averageProcessingTime
          ? _value.averageProcessingTime
          : averageProcessingTime // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailedProgressImpl implements _DetailedProgress {
  const _$DetailedProgressImpl(
      {required this.queueStatus,
      final List<ProcessingItem> currentlyProcessing = const [],
      final List<FailedItem> recentFailures = const [],
      this.estimatedCompletion,
      this.estimatedRemainingTime,
      final Map<String, dynamic> performanceMetrics = const {},
      this.successRate = 0.0,
      this.averageProcessingTime = 0.0})
      : _currentlyProcessing = currentlyProcessing,
        _recentFailures = recentFailures,
        _performanceMetrics = performanceMetrics;

  factory _$DetailedProgressImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailedProgressImplFromJson(json);

  @override
  final QueueStatus queueStatus;
  final List<ProcessingItem> _currentlyProcessing;
  @override
  @JsonKey()
  List<ProcessingItem> get currentlyProcessing {
    if (_currentlyProcessing is EqualUnmodifiableListView)
      return _currentlyProcessing;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentlyProcessing);
  }

  final List<FailedItem> _recentFailures;
  @override
  @JsonKey()
  List<FailedItem> get recentFailures {
    if (_recentFailures is EqualUnmodifiableListView) return _recentFailures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentFailures);
  }

  @override
  final DateTime? estimatedCompletion;
  @override
  final String? estimatedRemainingTime;
  final Map<String, dynamic> _performanceMetrics;
  @override
  @JsonKey()
  Map<String, dynamic> get performanceMetrics {
    if (_performanceMetrics is EqualUnmodifiableMapView)
      return _performanceMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_performanceMetrics);
  }

  @override
  @JsonKey()
  final double successRate;
  @override
  @JsonKey()
  final double averageProcessingTime;

  @override
  String toString() {
    return 'DetailedProgress(queueStatus: $queueStatus, currentlyProcessing: $currentlyProcessing, recentFailures: $recentFailures, estimatedCompletion: $estimatedCompletion, estimatedRemainingTime: $estimatedRemainingTime, performanceMetrics: $performanceMetrics, successRate: $successRate, averageProcessingTime: $averageProcessingTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailedProgressImpl &&
            (identical(other.queueStatus, queueStatus) ||
                other.queueStatus == queueStatus) &&
            const DeepCollectionEquality()
                .equals(other._currentlyProcessing, _currentlyProcessing) &&
            const DeepCollectionEquality()
                .equals(other._recentFailures, _recentFailures) &&
            (identical(other.estimatedCompletion, estimatedCompletion) ||
                other.estimatedCompletion == estimatedCompletion) &&
            (identical(other.estimatedRemainingTime, estimatedRemainingTime) ||
                other.estimatedRemainingTime == estimatedRemainingTime) &&
            const DeepCollectionEquality()
                .equals(other._performanceMetrics, _performanceMetrics) &&
            (identical(other.successRate, successRate) ||
                other.successRate == successRate) &&
            (identical(other.averageProcessingTime, averageProcessingTime) ||
                other.averageProcessingTime == averageProcessingTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      queueStatus,
      const DeepCollectionEquality().hash(_currentlyProcessing),
      const DeepCollectionEquality().hash(_recentFailures),
      estimatedCompletion,
      estimatedRemainingTime,
      const DeepCollectionEquality().hash(_performanceMetrics),
      successRate,
      averageProcessingTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailedProgressImplCopyWith<_$DetailedProgressImpl> get copyWith =>
      __$$DetailedProgressImplCopyWithImpl<_$DetailedProgressImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailedProgressImplToJson(
      this,
    );
  }
}

abstract class _DetailedProgress implements DetailedProgress {
  const factory _DetailedProgress(
      {required final QueueStatus queueStatus,
      final List<ProcessingItem> currentlyProcessing,
      final List<FailedItem> recentFailures,
      final DateTime? estimatedCompletion,
      final String? estimatedRemainingTime,
      final Map<String, dynamic> performanceMetrics,
      final double successRate,
      final double averageProcessingTime}) = _$DetailedProgressImpl;

  factory _DetailedProgress.fromJson(Map<String, dynamic> json) =
      _$DetailedProgressImpl.fromJson;

  @override
  QueueStatus get queueStatus;
  @override
  List<ProcessingItem> get currentlyProcessing;
  @override
  List<FailedItem> get recentFailures;
  @override
  DateTime? get estimatedCompletion;
  @override
  String? get estimatedRemainingTime;
  @override
  Map<String, dynamic> get performanceMetrics;
  @override
  double get successRate;
  @override
  double get averageProcessingTime;
  @override
  @JsonKey(ignore: true)
  _$$DetailedProgressImplCopyWith<_$DetailedProgressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProcessingItem _$ProcessingItemFromJson(Map<String, dynamic> json) {
  return _ProcessingItem.fromJson(json);
}

/// @nodoc
mixin _$ProcessingItem {
  String get url => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  double get processingDuration => throw _privateConstructorUsedError;
  String? get processorId => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProcessingItemCopyWith<ProcessingItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProcessingItemCopyWith<$Res> {
  factory $ProcessingItemCopyWith(
          ProcessingItem value, $Res Function(ProcessingItem) then) =
      _$ProcessingItemCopyWithImpl<$Res, ProcessingItem>;
  @useResult
  $Res call(
      {String url,
      String symbol,
      DateTime startedAt,
      double processingDuration,
      String? processorId,
      String? status});
}

/// @nodoc
class _$ProcessingItemCopyWithImpl<$Res, $Val extends ProcessingItem>
    implements $ProcessingItemCopyWith<$Res> {
  _$ProcessingItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? symbol = null,
    Object? startedAt = null,
    Object? processingDuration = null,
    Object? processorId = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      processingDuration: null == processingDuration
          ? _value.processingDuration
          : processingDuration // ignore: cast_nullable_to_non_nullable
              as double,
      processorId: freezed == processorId
          ? _value.processorId
          : processorId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProcessingItemImplCopyWith<$Res>
    implements $ProcessingItemCopyWith<$Res> {
  factory _$$ProcessingItemImplCopyWith(_$ProcessingItemImpl value,
          $Res Function(_$ProcessingItemImpl) then) =
      __$$ProcessingItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String symbol,
      DateTime startedAt,
      double processingDuration,
      String? processorId,
      String? status});
}

/// @nodoc
class __$$ProcessingItemImplCopyWithImpl<$Res>
    extends _$ProcessingItemCopyWithImpl<$Res, _$ProcessingItemImpl>
    implements _$$ProcessingItemImplCopyWith<$Res> {
  __$$ProcessingItemImplCopyWithImpl(
      _$ProcessingItemImpl _value, $Res Function(_$ProcessingItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? symbol = null,
    Object? startedAt = null,
    Object? processingDuration = null,
    Object? processorId = freezed,
    Object? status = freezed,
  }) {
    return _then(_$ProcessingItemImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      startedAt: null == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      processingDuration: null == processingDuration
          ? _value.processingDuration
          : processingDuration // ignore: cast_nullable_to_non_nullable
              as double,
      processorId: freezed == processorId
          ? _value.processorId
          : processorId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProcessingItemImpl implements _ProcessingItem {
  const _$ProcessingItemImpl(
      {required this.url,
      required this.symbol,
      required this.startedAt,
      this.processingDuration = 0.0,
      this.processorId,
      this.status});

  factory _$ProcessingItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcessingItemImplFromJson(json);

  @override
  final String url;
  @override
  final String symbol;
  @override
  final DateTime startedAt;
  @override
  @JsonKey()
  final double processingDuration;
  @override
  final String? processorId;
  @override
  final String? status;

  @override
  String toString() {
    return 'ProcessingItem(url: $url, symbol: $symbol, startedAt: $startedAt, processingDuration: $processingDuration, processorId: $processorId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessingItemImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.processingDuration, processingDuration) ||
                other.processingDuration == processingDuration) &&
            (identical(other.processorId, processorId) ||
                other.processorId == processorId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, symbol, startedAt,
      processingDuration, processorId, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessingItemImplCopyWith<_$ProcessingItemImpl> get copyWith =>
      __$$ProcessingItemImplCopyWithImpl<_$ProcessingItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcessingItemImplToJson(
      this,
    );
  }
}

abstract class _ProcessingItem implements ProcessingItem {
  const factory _ProcessingItem(
      {required final String url,
      required final String symbol,
      required final DateTime startedAt,
      final double processingDuration,
      final String? processorId,
      final String? status}) = _$ProcessingItemImpl;

  factory _ProcessingItem.fromJson(Map<String, dynamic> json) =
      _$ProcessingItemImpl.fromJson;

  @override
  String get url;
  @override
  String get symbol;
  @override
  DateTime get startedAt;
  @override
  double get processingDuration;
  @override
  String? get processorId;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$ProcessingItemImplCopyWith<_$ProcessingItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FailedItem _$FailedItemFromJson(Map<String, dynamic> json) {
  return _FailedItem.fromJson(json);
}

/// @nodoc
mixin _$FailedItem {
  String get url => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  DateTime get failedAt => throw _privateConstructorUsedError;
  int get retryCount => throw _privateConstructorUsedError;
  int get maxRetries => throw _privateConstructorUsedError;
  String? get symbol => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FailedItemCopyWith<FailedItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailedItemCopyWith<$Res> {
  factory $FailedItemCopyWith(
          FailedItem value, $Res Function(FailedItem) then) =
      _$FailedItemCopyWithImpl<$Res, FailedItem>;
  @useResult
  $Res call(
      {String url,
      String error,
      DateTime failedAt,
      int retryCount,
      int maxRetries,
      String? symbol});
}

/// @nodoc
class _$FailedItemCopyWithImpl<$Res, $Val extends FailedItem>
    implements $FailedItemCopyWith<$Res> {
  _$FailedItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? error = null,
    Object? failedAt = null,
    Object? retryCount = null,
    Object? maxRetries = null,
    Object? symbol = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      failedAt: null == failedAt
          ? _value.failedAt
          : failedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FailedItemImplCopyWith<$Res>
    implements $FailedItemCopyWith<$Res> {
  factory _$$FailedItemImplCopyWith(
          _$FailedItemImpl value, $Res Function(_$FailedItemImpl) then) =
      __$$FailedItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String error,
      DateTime failedAt,
      int retryCount,
      int maxRetries,
      String? symbol});
}

/// @nodoc
class __$$FailedItemImplCopyWithImpl<$Res>
    extends _$FailedItemCopyWithImpl<$Res, _$FailedItemImpl>
    implements _$$FailedItemImplCopyWith<$Res> {
  __$$FailedItemImplCopyWithImpl(
      _$FailedItemImpl _value, $Res Function(_$FailedItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? error = null,
    Object? failedAt = null,
    Object? retryCount = null,
    Object? maxRetries = null,
    Object? symbol = freezed,
  }) {
    return _then(_$FailedItemImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      failedAt: null == failedAt
          ? _value.failedAt
          : failedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      retryCount: null == retryCount
          ? _value.retryCount
          : retryCount // ignore: cast_nullable_to_non_nullable
              as int,
      maxRetries: null == maxRetries
          ? _value.maxRetries
          : maxRetries // ignore: cast_nullable_to_non_nullable
              as int,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FailedItemImpl implements _FailedItem {
  const _$FailedItemImpl(
      {required this.url,
      required this.error,
      required this.failedAt,
      this.retryCount = 0,
      this.maxRetries = 3,
      this.symbol});

  factory _$FailedItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FailedItemImplFromJson(json);

  @override
  final String url;
  @override
  final String error;
  @override
  final DateTime failedAt;
  @override
  @JsonKey()
  final int retryCount;
  @override
  @JsonKey()
  final int maxRetries;
  @override
  final String? symbol;

  @override
  String toString() {
    return 'FailedItem(url: $url, error: $error, failedAt: $failedAt, retryCount: $retryCount, maxRetries: $maxRetries, symbol: $symbol)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailedItemImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.failedAt, failedAt) ||
                other.failedAt == failedAt) &&
            (identical(other.retryCount, retryCount) ||
                other.retryCount == retryCount) &&
            (identical(other.maxRetries, maxRetries) ||
                other.maxRetries == maxRetries) &&
            (identical(other.symbol, symbol) || other.symbol == symbol));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, error, failedAt, retryCount, maxRetries, symbol);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FailedItemImplCopyWith<_$FailedItemImpl> get copyWith =>
      __$$FailedItemImplCopyWithImpl<_$FailedItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FailedItemImplToJson(
      this,
    );
  }
}

abstract class _FailedItem implements FailedItem {
  const factory _FailedItem(
      {required final String url,
      required final String error,
      required final DateTime failedAt,
      final int retryCount,
      final int maxRetries,
      final String? symbol}) = _$FailedItemImpl;

  factory _FailedItem.fromJson(Map<String, dynamic> json) =
      _$FailedItemImpl.fromJson;

  @override
  String get url;
  @override
  String get error;
  @override
  DateTime get failedAt;
  @override
  int get retryCount;
  @override
  int get maxRetries;
  @override
  String? get symbol;
  @override
  @JsonKey(ignore: true)
  _$$FailedItemImplCopyWith<_$FailedItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScrapingEvent _$ScrapingEventFromJson(Map<String, dynamic> json) {
  return _ScrapingEvent.fromJson(json);
}

/// @nodoc
mixin _$ScrapingEvent {
  String get message => throw _privateConstructorUsedError;
  ScrapingEventType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScrapingEventCopyWith<ScrapingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScrapingEventCopyWith<$Res> {
  factory $ScrapingEventCopyWith(
          ScrapingEvent value, $Res Function(ScrapingEvent) then) =
      _$ScrapingEventCopyWithImpl<$Res, ScrapingEvent>;
  @useResult
  $Res call(
      {String message,
      ScrapingEventType type,
      DateTime timestamp,
      String? details,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$ScrapingEventCopyWithImpl<$Res, $Val extends ScrapingEvent>
    implements $ScrapingEventCopyWith<$Res> {
  _$ScrapingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
    Object? timestamp = null,
    Object? details = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ScrapingEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScrapingEventImplCopyWith<$Res>
    implements $ScrapingEventCopyWith<$Res> {
  factory _$$ScrapingEventImplCopyWith(
          _$ScrapingEventImpl value, $Res Function(_$ScrapingEventImpl) then) =
      __$$ScrapingEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message,
      ScrapingEventType type,
      DateTime timestamp,
      String? details,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$ScrapingEventImplCopyWithImpl<$Res>
    extends _$ScrapingEventCopyWithImpl<$Res, _$ScrapingEventImpl>
    implements _$$ScrapingEventImplCopyWith<$Res> {
  __$$ScrapingEventImplCopyWithImpl(
      _$ScrapingEventImpl _value, $Res Function(_$ScrapingEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? type = null,
    Object? timestamp = null,
    Object? details = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$ScrapingEventImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ScrapingEventType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScrapingEventImpl implements _ScrapingEvent {
  const _$ScrapingEventImpl(
      {required this.message,
      required this.type,
      required this.timestamp,
      this.details,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$ScrapingEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScrapingEventImplFromJson(json);

  @override
  final String message;
  @override
  final ScrapingEventType type;
  @override
  final DateTime timestamp;
  @override
  final String? details;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ScrapingEvent(message: $message, type: $type, timestamp: $timestamp, details: $details, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrapingEventImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.details, details) || other.details == details) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, type, timestamp,
      details, const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScrapingEventImplCopyWith<_$ScrapingEventImpl> get copyWith =>
      __$$ScrapingEventImplCopyWithImpl<_$ScrapingEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScrapingEventImplToJson(
      this,
    );
  }
}

abstract class _ScrapingEvent implements ScrapingEvent {
  const factory _ScrapingEvent(
      {required final String message,
      required final ScrapingEventType type,
      required final DateTime timestamp,
      final String? details,
      final Map<String, dynamic>? metadata}) = _$ScrapingEventImpl;

  factory _ScrapingEvent.fromJson(Map<String, dynamic> json) =
      _$ScrapingEventImpl.fromJson;

  @override
  String get message;
  @override
  ScrapingEventType get type;
  @override
  DateTime get timestamp;
  @override
  String? get details;
  @override
  Map<String, dynamic>? get metadata;
  @override
  @JsonKey(ignore: true)
  _$$ScrapingEventImplCopyWith<_$ScrapingEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScrapingStats _$ScrapingStatsFromJson(Map<String, dynamic> json) {
  return _ScrapingStats.fromJson(json);
}

/// @nodoc
mixin _$ScrapingStats {
  QueueStatus get queueStatus => throw _privateConstructorUsedError;
  List<RecentCompletedItem> get recentCompleted =>
      throw _privateConstructorUsedError;
  int get totalCompaniesProcessed => throw _privateConstructorUsedError;
  int get successRate => throw _privateConstructorUsedError;
  bool get isHealthy => throw _privateConstructorUsedError;
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalMetrics =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScrapingStatsCopyWith<ScrapingStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScrapingStatsCopyWith<$Res> {
  factory $ScrapingStatsCopyWith(
          ScrapingStats value, $Res Function(ScrapingStats) then) =
      _$ScrapingStatsCopyWithImpl<$Res, ScrapingStats>;
  @useResult
  $Res call(
      {QueueStatus queueStatus,
      List<RecentCompletedItem> recentCompleted,
      int totalCompaniesProcessed,
      int successRate,
      bool isHealthy,
      DateTime lastUpdated,
      Map<String, dynamic> additionalMetrics});

  $QueueStatusCopyWith<$Res> get queueStatus;
}

/// @nodoc
class _$ScrapingStatsCopyWithImpl<$Res, $Val extends ScrapingStats>
    implements $ScrapingStatsCopyWith<$Res> {
  _$ScrapingStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueStatus = null,
    Object? recentCompleted = null,
    Object? totalCompaniesProcessed = null,
    Object? successRate = null,
    Object? isHealthy = null,
    Object? lastUpdated = null,
    Object? additionalMetrics = null,
  }) {
    return _then(_value.copyWith(
      queueStatus: null == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as QueueStatus,
      recentCompleted: null == recentCompleted
          ? _value.recentCompleted
          : recentCompleted // ignore: cast_nullable_to_non_nullable
              as List<RecentCompletedItem>,
      totalCompaniesProcessed: null == totalCompaniesProcessed
          ? _value.totalCompaniesProcessed
          : totalCompaniesProcessed // ignore: cast_nullable_to_non_nullable
              as int,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as int,
      isHealthy: null == isHealthy
          ? _value.isHealthy
          : isHealthy // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      additionalMetrics: null == additionalMetrics
          ? _value.additionalMetrics
          : additionalMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $QueueStatusCopyWith<$Res> get queueStatus {
    return $QueueStatusCopyWith<$Res>(_value.queueStatus, (value) {
      return _then(_value.copyWith(queueStatus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScrapingStatsImplCopyWith<$Res>
    implements $ScrapingStatsCopyWith<$Res> {
  factory _$$ScrapingStatsImplCopyWith(
          _$ScrapingStatsImpl value, $Res Function(_$ScrapingStatsImpl) then) =
      __$$ScrapingStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {QueueStatus queueStatus,
      List<RecentCompletedItem> recentCompleted,
      int totalCompaniesProcessed,
      int successRate,
      bool isHealthy,
      DateTime lastUpdated,
      Map<String, dynamic> additionalMetrics});

  @override
  $QueueStatusCopyWith<$Res> get queueStatus;
}

/// @nodoc
class __$$ScrapingStatsImplCopyWithImpl<$Res>
    extends _$ScrapingStatsCopyWithImpl<$Res, _$ScrapingStatsImpl>
    implements _$$ScrapingStatsImplCopyWith<$Res> {
  __$$ScrapingStatsImplCopyWithImpl(
      _$ScrapingStatsImpl _value, $Res Function(_$ScrapingStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queueStatus = null,
    Object? recentCompleted = null,
    Object? totalCompaniesProcessed = null,
    Object? successRate = null,
    Object? isHealthy = null,
    Object? lastUpdated = null,
    Object? additionalMetrics = null,
  }) {
    return _then(_$ScrapingStatsImpl(
      queueStatus: null == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as QueueStatus,
      recentCompleted: null == recentCompleted
          ? _value._recentCompleted
          : recentCompleted // ignore: cast_nullable_to_non_nullable
              as List<RecentCompletedItem>,
      totalCompaniesProcessed: null == totalCompaniesProcessed
          ? _value.totalCompaniesProcessed
          : totalCompaniesProcessed // ignore: cast_nullable_to_non_nullable
              as int,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as int,
      isHealthy: null == isHealthy
          ? _value.isHealthy
          : isHealthy // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      additionalMetrics: null == additionalMetrics
          ? _value._additionalMetrics
          : additionalMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScrapingStatsImpl implements _ScrapingStats {
  const _$ScrapingStatsImpl(
      {required this.queueStatus,
      final List<RecentCompletedItem> recentCompleted = const [],
      this.totalCompaniesProcessed = 0,
      this.successRate = 0,
      this.isHealthy = true,
      required this.lastUpdated,
      final Map<String, dynamic> additionalMetrics = const {}})
      : _recentCompleted = recentCompleted,
        _additionalMetrics = additionalMetrics;

  factory _$ScrapingStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScrapingStatsImplFromJson(json);

  @override
  final QueueStatus queueStatus;
  final List<RecentCompletedItem> _recentCompleted;
  @override
  @JsonKey()
  List<RecentCompletedItem> get recentCompleted {
    if (_recentCompleted is EqualUnmodifiableListView) return _recentCompleted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentCompleted);
  }

  @override
  @JsonKey()
  final int totalCompaniesProcessed;
  @override
  @JsonKey()
  final int successRate;
  @override
  @JsonKey()
  final bool isHealthy;
  @override
  final DateTime lastUpdated;
  final Map<String, dynamic> _additionalMetrics;
  @override
  @JsonKey()
  Map<String, dynamic> get additionalMetrics {
    if (_additionalMetrics is EqualUnmodifiableMapView)
      return _additionalMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_additionalMetrics);
  }

  @override
  String toString() {
    return 'ScrapingStats(queueStatus: $queueStatus, recentCompleted: $recentCompleted, totalCompaniesProcessed: $totalCompaniesProcessed, successRate: $successRate, isHealthy: $isHealthy, lastUpdated: $lastUpdated, additionalMetrics: $additionalMetrics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrapingStatsImpl &&
            (identical(other.queueStatus, queueStatus) ||
                other.queueStatus == queueStatus) &&
            const DeepCollectionEquality()
                .equals(other._recentCompleted, _recentCompleted) &&
            (identical(
                    other.totalCompaniesProcessed, totalCompaniesProcessed) ||
                other.totalCompaniesProcessed == totalCompaniesProcessed) &&
            (identical(other.successRate, successRate) ||
                other.successRate == successRate) &&
            (identical(other.isHealthy, isHealthy) ||
                other.isHealthy == isHealthy) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality()
                .equals(other._additionalMetrics, _additionalMetrics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      queueStatus,
      const DeepCollectionEquality().hash(_recentCompleted),
      totalCompaniesProcessed,
      successRate,
      isHealthy,
      lastUpdated,
      const DeepCollectionEquality().hash(_additionalMetrics));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScrapingStatsImplCopyWith<_$ScrapingStatsImpl> get copyWith =>
      __$$ScrapingStatsImplCopyWithImpl<_$ScrapingStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScrapingStatsImplToJson(
      this,
    );
  }
}

abstract class _ScrapingStats implements ScrapingStats {
  const factory _ScrapingStats(
      {required final QueueStatus queueStatus,
      final List<RecentCompletedItem> recentCompleted,
      final int totalCompaniesProcessed,
      final int successRate,
      final bool isHealthy,
      required final DateTime lastUpdated,
      final Map<String, dynamic> additionalMetrics}) = _$ScrapingStatsImpl;

  factory _ScrapingStats.fromJson(Map<String, dynamic> json) =
      _$ScrapingStatsImpl.fromJson;

  @override
  QueueStatus get queueStatus;
  @override
  List<RecentCompletedItem> get recentCompleted;
  @override
  int get totalCompaniesProcessed;
  @override
  int get successRate;
  @override
  bool get isHealthy;
  @override
  DateTime get lastUpdated;
  @override
  Map<String, dynamic> get additionalMetrics;
  @override
  @JsonKey(ignore: true)
  _$$ScrapingStatsImplCopyWith<_$ScrapingStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
