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
  List<RecentCompany> get recentCompleted => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
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
      List<RecentCompany> recentCompleted,
      DateTime timestamp,
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
    Object? recentCompleted = null,
    Object? timestamp = null,
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
      recentCompleted: null == recentCompleted
          ? _value.recentCompleted
          : recentCompleted // ignore: cast_nullable_to_non_nullable
              as List<RecentCompany>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      List<RecentCompany> recentCompleted,
      DateTime timestamp,
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
    Object? recentCompleted = null,
    Object? timestamp = null,
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
      recentCompleted: null == recentCompleted
          ? _value._recentCompleted
          : recentCompleted // ignore: cast_nullable_to_non_nullable
              as List<RecentCompany>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      final List<RecentCompany> recentCompleted = const [],
      required this.timestamp,
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
  final List<RecentCompany> _recentCompleted;
  @override
  @JsonKey()
  List<RecentCompany> get recentCompleted {
    if (_recentCompleted is EqualUnmodifiableListView) return _recentCompleted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentCompleted);
  }

  @override
  final DateTime timestamp;
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
    return 'QueueStatus(pending: $pending, processing: $processing, completed: $completed, failed: $failed, total: $total, recentCompleted: $recentCompleted, timestamp: $timestamp, estimatedTimeRemaining: $estimatedTimeRemaining, completionRate: $completionRate, queueStats: $queueStats)';
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
            const DeepCollectionEquality()
                .equals(other._recentCompleted, _recentCompleted) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
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
      const DeepCollectionEquality().hash(_recentCompleted),
      timestamp,
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
      final List<RecentCompany> recentCompleted,
      required final DateTime timestamp,
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
  List<RecentCompany> get recentCompleted;
  @override
  DateTime get timestamp;
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

RecentCompany _$RecentCompanyFromJson(Map<String, dynamic> json) {
  return _RecentCompany.fromJson(json);
}

/// @nodoc
mixin _$RecentCompany {
  String get symbol => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  DateTime get completedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecentCompanyCopyWith<RecentCompany> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecentCompanyCopyWith<$Res> {
  factory $RecentCompanyCopyWith(
          RecentCompany value, $Res Function(RecentCompany) then) =
      _$RecentCompanyCopyWithImpl<$Res, RecentCompany>;
  @useResult
  $Res call({String symbol, String companyName, DateTime completedAt});
}

/// @nodoc
class _$RecentCompanyCopyWithImpl<$Res, $Val extends RecentCompany>
    implements $RecentCompanyCopyWith<$Res> {
  _$RecentCompanyCopyWithImpl(this._value, this._then);

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
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecentCompanyImplCopyWith<$Res>
    implements $RecentCompanyCopyWith<$Res> {
  factory _$$RecentCompanyImplCopyWith(
          _$RecentCompanyImpl value, $Res Function(_$RecentCompanyImpl) then) =
      __$$RecentCompanyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String symbol, String companyName, DateTime completedAt});
}

/// @nodoc
class __$$RecentCompanyImplCopyWithImpl<$Res>
    extends _$RecentCompanyCopyWithImpl<$Res, _$RecentCompanyImpl>
    implements _$$RecentCompanyImplCopyWith<$Res> {
  __$$RecentCompanyImplCopyWithImpl(
      _$RecentCompanyImpl _value, $Res Function(_$RecentCompanyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? companyName = null,
    Object? completedAt = null,
  }) {
    return _then(_$RecentCompanyImpl(
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
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecentCompanyImpl implements _RecentCompany {
  const _$RecentCompanyImpl(
      {required this.symbol,
      required this.companyName,
      required this.completedAt});

  factory _$RecentCompanyImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecentCompanyImplFromJson(json);

  @override
  final String symbol;
  @override
  final String companyName;
  @override
  final DateTime completedAt;

  @override
  String toString() {
    return 'RecentCompany(symbol: $symbol, companyName: $companyName, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecentCompanyImpl &&
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
  _$$RecentCompanyImplCopyWith<_$RecentCompanyImpl> get copyWith =>
      __$$RecentCompanyImplCopyWithImpl<_$RecentCompanyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecentCompanyImplToJson(
      this,
    );
  }
}

abstract class _RecentCompany implements RecentCompany {
  const factory _RecentCompany(
      {required final String symbol,
      required final String companyName,
      required final DateTime completedAt}) = _$RecentCompanyImpl;

  factory _RecentCompany.fromJson(Map<String, dynamic> json) =
      _$RecentCompanyImpl.fromJson;

  @override
  String get symbol;
  @override
  String get companyName;
  @override
  DateTime get completedAt;
  @override
  @JsonKey(ignore: true)
  _$$RecentCompanyImplCopyWith<_$RecentCompanyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScrapingState _$ScrapingStateFromJson(Map<String, dynamic> json) {
  return _ScrapingState.fromJson(json);
}

/// @nodoc
mixin _$ScrapingState {
  QueueStatus? get queueStatus => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get showDetails => throw _privateConstructorUsedError;

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
      {QueueStatus? queueStatus,
      bool isLoading,
      String? error,
      bool showDetails});

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
    Object? queueStatus = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? showDetails = null,
  }) {
    return _then(_value.copyWith(
      queueStatus: freezed == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as QueueStatus?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      showDetails: null == showDetails
          ? _value.showDetails
          : showDetails // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$ScrapingStateImplCopyWith<$Res>
    implements $ScrapingStateCopyWith<$Res> {
  factory _$$ScrapingStateImplCopyWith(
          _$ScrapingStateImpl value, $Res Function(_$ScrapingStateImpl) then) =
      __$$ScrapingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {QueueStatus? queueStatus,
      bool isLoading,
      String? error,
      bool showDetails});

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
    Object? queueStatus = freezed,
    Object? isLoading = null,
    Object? error = freezed,
    Object? showDetails = null,
  }) {
    return _then(_$ScrapingStateImpl(
      queueStatus: freezed == queueStatus
          ? _value.queueStatus
          : queueStatus // ignore: cast_nullable_to_non_nullable
              as QueueStatus?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      showDetails: null == showDetails
          ? _value.showDetails
          : showDetails // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScrapingStateImpl implements _ScrapingState {
  const _$ScrapingStateImpl(
      {this.queueStatus,
      this.isLoading = false,
      this.error,
      this.showDetails = false});

  factory _$ScrapingStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScrapingStateImplFromJson(json);

  @override
  final QueueStatus? queueStatus;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool showDetails;

  @override
  String toString() {
    return 'ScrapingState(queueStatus: $queueStatus, isLoading: $isLoading, error: $error, showDetails: $showDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrapingStateImpl &&
            (identical(other.queueStatus, queueStatus) ||
                other.queueStatus == queueStatus) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.showDetails, showDetails) ||
                other.showDetails == showDetails));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, queueStatus, isLoading, error, showDetails);

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
      {final QueueStatus? queueStatus,
      final bool isLoading,
      final String? error,
      final bool showDetails}) = _$ScrapingStateImpl;

  factory _ScrapingState.fromJson(Map<String, dynamic> json) =
      _$ScrapingStateImpl.fromJson;

  @override
  QueueStatus? get queueStatus;
  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  bool get showDetails;
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
      Map<String, dynamic> performanceMetrics});

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
      Map<String, dynamic> performanceMetrics});

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
      final Map<String, dynamic> performanceMetrics = const {}})
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
  String toString() {
    return 'DetailedProgress(queueStatus: $queueStatus, currentlyProcessing: $currentlyProcessing, recentFailures: $recentFailures, estimatedCompletion: $estimatedCompletion, estimatedRemainingTime: $estimatedRemainingTime, performanceMetrics: $performanceMetrics)';
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
                .equals(other._performanceMetrics, _performanceMetrics));
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
      const DeepCollectionEquality().hash(_performanceMetrics));

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
      final Map<String, dynamic> performanceMetrics}) = _$DetailedProgressImpl;

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
      double processingDuration});
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
      double processingDuration});
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
      this.processingDuration = 0.0});

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
  String toString() {
    return 'ProcessingItem(url: $url, symbol: $symbol, startedAt: $startedAt, processingDuration: $processingDuration)';
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
                other.processingDuration == processingDuration));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, url, symbol, startedAt, processingDuration);

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
      final double processingDuration}) = _$ProcessingItemImpl;

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
  $Res call({String url, String error, DateTime failedAt, int retryCount});
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
  $Res call({String url, String error, DateTime failedAt, int retryCount});
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
      this.retryCount = 0});

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
  String toString() {
    return 'FailedItem(url: $url, error: $error, failedAt: $failedAt, retryCount: $retryCount)';
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
                other.retryCount == retryCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, url, error, failedAt, retryCount);

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
      final int retryCount}) = _$FailedItemImpl;

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
  $Res call({String message, ScrapingEventType type, DateTime timestamp});
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
  $Res call({String message, ScrapingEventType type, DateTime timestamp});
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScrapingEventImpl implements _ScrapingEvent {
  const _$ScrapingEventImpl(
      {required this.message, required this.type, required this.timestamp});

  factory _$ScrapingEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScrapingEventImplFromJson(json);

  @override
  final String message;
  @override
  final ScrapingEventType type;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'ScrapingEvent(message: $message, type: $type, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScrapingEventImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, message, type, timestamp);

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
      required final DateTime timestamp}) = _$ScrapingEventImpl;

  factory _ScrapingEvent.fromJson(Map<String, dynamic> json) =
      _$ScrapingEventImpl.fromJson;

  @override
  String get message;
  @override
  ScrapingEventType get type;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$ScrapingEventImplCopyWith<_$ScrapingEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
