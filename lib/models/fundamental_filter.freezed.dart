// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fundamental_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FundamentalFilter _$FundamentalFilterFromJson(Map<String, dynamic> json) {
  return _FundamentalFilter.fromJson(json);
}

/// @nodoc
mixin _$FundamentalFilter {
  FundamentalType get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  FilterCategory get category => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  bool get isPremium => throw _privateConstructorUsedError;
  int get minimumQualityScore => throw _privateConstructorUsedError;
  Map<String, dynamic> get criteria => throw _privateConstructorUsedError;
  int get difficulty =>
      throw _privateConstructorUsedError; // 0=Beginner, 1=Intermediate, 2=Advanced
  String get explanation => throw _privateConstructorUsedError;
  List<String> get relatedFilters => throw _privateConstructorUsedError;
  double get successRate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FundamentalFilterCopyWith<FundamentalFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FundamentalFilterCopyWith<$Res> {
  factory $FundamentalFilterCopyWith(
          FundamentalFilter value, $Res Function(FundamentalFilter) then) =
      _$FundamentalFilterCopyWithImpl<$Res, FundamentalFilter>;
  @useResult
  $Res call(
      {FundamentalType type,
      String name,
      String description,
      FilterCategory category,
      List<String> tags,
      String icon,
      bool isPremium,
      int minimumQualityScore,
      Map<String, dynamic> criteria,
      int difficulty,
      String explanation,
      List<String> relatedFilters,
      double successRate});
}

/// @nodoc
class _$FundamentalFilterCopyWithImpl<$Res, $Val extends FundamentalFilter>
    implements $FundamentalFilterCopyWith<$Res> {
  _$FundamentalFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? tags = null,
    Object? icon = null,
    Object? isPremium = null,
    Object? minimumQualityScore = null,
    Object? criteria = null,
    Object? difficulty = null,
    Object? explanation = null,
    Object? relatedFilters = null,
    Object? successRate = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FundamentalType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as FilterCategory,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      minimumQualityScore: null == minimumQualityScore
          ? _value.minimumQualityScore
          : minimumQualityScore // ignore: cast_nullable_to_non_nullable
              as int,
      criteria: null == criteria
          ? _value.criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      relatedFilters: null == relatedFilters
          ? _value.relatedFilters
          : relatedFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FundamentalFilterImplCopyWith<$Res>
    implements $FundamentalFilterCopyWith<$Res> {
  factory _$$FundamentalFilterImplCopyWith(_$FundamentalFilterImpl value,
          $Res Function(_$FundamentalFilterImpl) then) =
      __$$FundamentalFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FundamentalType type,
      String name,
      String description,
      FilterCategory category,
      List<String> tags,
      String icon,
      bool isPremium,
      int minimumQualityScore,
      Map<String, dynamic> criteria,
      int difficulty,
      String explanation,
      List<String> relatedFilters,
      double successRate});
}

/// @nodoc
class __$$FundamentalFilterImplCopyWithImpl<$Res>
    extends _$FundamentalFilterCopyWithImpl<$Res, _$FundamentalFilterImpl>
    implements _$$FundamentalFilterImplCopyWith<$Res> {
  __$$FundamentalFilterImplCopyWithImpl(_$FundamentalFilterImpl _value,
      $Res Function(_$FundamentalFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? name = null,
    Object? description = null,
    Object? category = null,
    Object? tags = null,
    Object? icon = null,
    Object? isPremium = null,
    Object? minimumQualityScore = null,
    Object? criteria = null,
    Object? difficulty = null,
    Object? explanation = null,
    Object? relatedFilters = null,
    Object? successRate = null,
  }) {
    return _then(_$FundamentalFilterImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FundamentalType,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as FilterCategory,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      isPremium: null == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool,
      minimumQualityScore: null == minimumQualityScore
          ? _value.minimumQualityScore
          : minimumQualityScore // ignore: cast_nullable_to_non_nullable
              as int,
      criteria: null == criteria
          ? _value._criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      relatedFilters: null == relatedFilters
          ? _value._relatedFilters
          : relatedFilters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      successRate: null == successRate
          ? _value.successRate
          : successRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FundamentalFilterImpl implements _FundamentalFilter {
  const _$FundamentalFilterImpl(
      {required this.type,
      required this.name,
      required this.description,
      required this.category,
      final List<String> tags = const [],
      this.icon = '',
      this.isPremium = false,
      this.minimumQualityScore = 0,
      final Map<String, dynamic> criteria = const {},
      this.difficulty = 0,
      this.explanation = '',
      final List<String> relatedFilters = const [],
      this.successRate = 0.0})
      : _tags = tags,
        _criteria = criteria,
        _relatedFilters = relatedFilters;

  factory _$FundamentalFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$FundamentalFilterImplFromJson(json);

  @override
  final FundamentalType type;
  @override
  final String name;
  @override
  final String description;
  @override
  final FilterCategory category;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final String icon;
  @override
  @JsonKey()
  final bool isPremium;
  @override
  @JsonKey()
  final int minimumQualityScore;
  final Map<String, dynamic> _criteria;
  @override
  @JsonKey()
  Map<String, dynamic> get criteria {
    if (_criteria is EqualUnmodifiableMapView) return _criteria;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_criteria);
  }

  @override
  @JsonKey()
  final int difficulty;
// 0=Beginner, 1=Intermediate, 2=Advanced
  @override
  @JsonKey()
  final String explanation;
  final List<String> _relatedFilters;
  @override
  @JsonKey()
  List<String> get relatedFilters {
    if (_relatedFilters is EqualUnmodifiableListView) return _relatedFilters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relatedFilters);
  }

  @override
  @JsonKey()
  final double successRate;

  @override
  String toString() {
    return 'FundamentalFilter(type: $type, name: $name, description: $description, category: $category, tags: $tags, icon: $icon, isPremium: $isPremium, minimumQualityScore: $minimumQualityScore, criteria: $criteria, difficulty: $difficulty, explanation: $explanation, relatedFilters: $relatedFilters, successRate: $successRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FundamentalFilterImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.minimumQualityScore, minimumQualityScore) ||
                other.minimumQualityScore == minimumQualityScore) &&
            const DeepCollectionEquality().equals(other._criteria, _criteria) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            const DeepCollectionEquality()
                .equals(other._relatedFilters, _relatedFilters) &&
            (identical(other.successRate, successRate) ||
                other.successRate == successRate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      name,
      description,
      category,
      const DeepCollectionEquality().hash(_tags),
      icon,
      isPremium,
      minimumQualityScore,
      const DeepCollectionEquality().hash(_criteria),
      difficulty,
      explanation,
      const DeepCollectionEquality().hash(_relatedFilters),
      successRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FundamentalFilterImplCopyWith<_$FundamentalFilterImpl> get copyWith =>
      __$$FundamentalFilterImplCopyWithImpl<_$FundamentalFilterImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FundamentalFilterImplToJson(
      this,
    );
  }
}

abstract class _FundamentalFilter implements FundamentalFilter {
  const factory _FundamentalFilter(
      {required final FundamentalType type,
      required final String name,
      required final String description,
      required final FilterCategory category,
      final List<String> tags,
      final String icon,
      final bool isPremium,
      final int minimumQualityScore,
      final Map<String, dynamic> criteria,
      final int difficulty,
      final String explanation,
      final List<String> relatedFilters,
      final double successRate}) = _$FundamentalFilterImpl;

  factory _FundamentalFilter.fromJson(Map<String, dynamic> json) =
      _$FundamentalFilterImpl.fromJson;

  @override
  FundamentalType get type;
  @override
  String get name;
  @override
  String get description;
  @override
  FilterCategory get category;
  @override
  List<String> get tags;
  @override
  String get icon;
  @override
  bool get isPremium;
  @override
  int get minimumQualityScore;
  @override
  Map<String, dynamic> get criteria;
  @override
  int get difficulty;
  @override // 0=Beginner, 1=Intermediate, 2=Advanced
  String get explanation;
  @override
  List<String> get relatedFilters;
  @override
  double get successRate;
  @override
  @JsonKey(ignore: true)
  _$$FundamentalFilterImplCopyWith<_$FundamentalFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
