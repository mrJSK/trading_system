// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FilterSettings _$FilterSettingsFromJson(Map<String, dynamic> json) {
  return _FilterSettings.fromJson(json);
}

/// @nodoc
mixin _$FilterSettings {
  RangeFilter get marketCap => throw _privateConstructorUsedError;
  RangeFilter get pe => throw _privateConstructorUsedError;
  RangeFilter get priceRange => throw _privateConstructorUsedError;
  RangeFilter get dividend => throw _privateConstructorUsedError;
  RangeFilter get roce => throw _privateConstructorUsedError;
  RangeFilter get roe => throw _privateConstructorUsedError;
  List<String> get sectors => throw _privateConstructorUsedError;
  String get sortBy => throw _privateConstructorUsedError;
  bool get sortDescending => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterSettingsCopyWith<FilterSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterSettingsCopyWith<$Res> {
  factory $FilterSettingsCopyWith(
          FilterSettings value, $Res Function(FilterSettings) then) =
      _$FilterSettingsCopyWithImpl<$Res, FilterSettings>;
  @useResult
  $Res call(
      {RangeFilter marketCap,
      RangeFilter pe,
      RangeFilter priceRange,
      RangeFilter dividend,
      RangeFilter roce,
      RangeFilter roe,
      List<String> sectors,
      String sortBy,
      bool sortDescending,
      int pageSize});

  $RangeFilterCopyWith<$Res> get marketCap;
  $RangeFilterCopyWith<$Res> get pe;
  $RangeFilterCopyWith<$Res> get priceRange;
  $RangeFilterCopyWith<$Res> get dividend;
  $RangeFilterCopyWith<$Res> get roce;
  $RangeFilterCopyWith<$Res> get roe;
}

/// @nodoc
class _$FilterSettingsCopyWithImpl<$Res, $Val extends FilterSettings>
    implements $FilterSettingsCopyWith<$Res> {
  _$FilterSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? marketCap = null,
    Object? pe = null,
    Object? priceRange = null,
    Object? dividend = null,
    Object? roce = null,
    Object? roe = null,
    Object? sectors = null,
    Object? sortBy = null,
    Object? sortDescending = null,
    Object? pageSize = null,
  }) {
    return _then(_value.copyWith(
      marketCap: null == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      pe: null == pe
          ? _value.pe
          : pe // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      priceRange: null == priceRange
          ? _value.priceRange
          : priceRange // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      dividend: null == dividend
          ? _value.dividend
          : dividend // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      roce: null == roce
          ? _value.roce
          : roce // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      roe: null == roe
          ? _value.roe
          : roe // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      sectors: null == sectors
          ? _value.sectors
          : sectors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      sortDescending: null == sortDescending
          ? _value.sortDescending
          : sortDescending // ignore: cast_nullable_to_non_nullable
              as bool,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RangeFilterCopyWith<$Res> get marketCap {
    return $RangeFilterCopyWith<$Res>(_value.marketCap, (value) {
      return _then(_value.copyWith(marketCap: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RangeFilterCopyWith<$Res> get pe {
    return $RangeFilterCopyWith<$Res>(_value.pe, (value) {
      return _then(_value.copyWith(pe: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RangeFilterCopyWith<$Res> get priceRange {
    return $RangeFilterCopyWith<$Res>(_value.priceRange, (value) {
      return _then(_value.copyWith(priceRange: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RangeFilterCopyWith<$Res> get dividend {
    return $RangeFilterCopyWith<$Res>(_value.dividend, (value) {
      return _then(_value.copyWith(dividend: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RangeFilterCopyWith<$Res> get roce {
    return $RangeFilterCopyWith<$Res>(_value.roce, (value) {
      return _then(_value.copyWith(roce: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $RangeFilterCopyWith<$Res> get roe {
    return $RangeFilterCopyWith<$Res>(_value.roe, (value) {
      return _then(_value.copyWith(roe: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FilterSettingsImplCopyWith<$Res>
    implements $FilterSettingsCopyWith<$Res> {
  factory _$$FilterSettingsImplCopyWith(_$FilterSettingsImpl value,
          $Res Function(_$FilterSettingsImpl) then) =
      __$$FilterSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RangeFilter marketCap,
      RangeFilter pe,
      RangeFilter priceRange,
      RangeFilter dividend,
      RangeFilter roce,
      RangeFilter roe,
      List<String> sectors,
      String sortBy,
      bool sortDescending,
      int pageSize});

  @override
  $RangeFilterCopyWith<$Res> get marketCap;
  @override
  $RangeFilterCopyWith<$Res> get pe;
  @override
  $RangeFilterCopyWith<$Res> get priceRange;
  @override
  $RangeFilterCopyWith<$Res> get dividend;
  @override
  $RangeFilterCopyWith<$Res> get roce;
  @override
  $RangeFilterCopyWith<$Res> get roe;
}

/// @nodoc
class __$$FilterSettingsImplCopyWithImpl<$Res>
    extends _$FilterSettingsCopyWithImpl<$Res, _$FilterSettingsImpl>
    implements _$$FilterSettingsImplCopyWith<$Res> {
  __$$FilterSettingsImplCopyWithImpl(
      _$FilterSettingsImpl _value, $Res Function(_$FilterSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? marketCap = null,
    Object? pe = null,
    Object? priceRange = null,
    Object? dividend = null,
    Object? roce = null,
    Object? roe = null,
    Object? sectors = null,
    Object? sortBy = null,
    Object? sortDescending = null,
    Object? pageSize = null,
  }) {
    return _then(_$FilterSettingsImpl(
      marketCap: null == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      pe: null == pe
          ? _value.pe
          : pe // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      priceRange: null == priceRange
          ? _value.priceRange
          : priceRange // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      dividend: null == dividend
          ? _value.dividend
          : dividend // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      roce: null == roce
          ? _value.roce
          : roce // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      roe: null == roe
          ? _value.roe
          : roe // ignore: cast_nullable_to_non_nullable
              as RangeFilter,
      sectors: null == sectors
          ? _value._sectors
          : sectors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      sortDescending: null == sortDescending
          ? _value.sortDescending
          : sortDescending // ignore: cast_nullable_to_non_nullable
              as bool,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FilterSettingsImpl implements _FilterSettings {
  const _$FilterSettingsImpl(
      {this.marketCap = const RangeFilter(),
      this.pe = const RangeFilter(),
      this.priceRange = const RangeFilter(),
      this.dividend = const RangeFilter(),
      this.roce = const RangeFilter(),
      this.roe = const RangeFilter(),
      final List<String> sectors = const [],
      this.sortBy = 'market_cap',
      this.sortDescending = true,
      this.pageSize = 10})
      : _sectors = sectors;

  factory _$FilterSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FilterSettingsImplFromJson(json);

  @override
  @JsonKey()
  final RangeFilter marketCap;
  @override
  @JsonKey()
  final RangeFilter pe;
  @override
  @JsonKey()
  final RangeFilter priceRange;
  @override
  @JsonKey()
  final RangeFilter dividend;
  @override
  @JsonKey()
  final RangeFilter roce;
  @override
  @JsonKey()
  final RangeFilter roe;
  final List<String> _sectors;
  @override
  @JsonKey()
  List<String> get sectors {
    if (_sectors is EqualUnmodifiableListView) return _sectors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sectors);
  }

  @override
  @JsonKey()
  final String sortBy;
  @override
  @JsonKey()
  final bool sortDescending;
  @override
  @JsonKey()
  final int pageSize;

  @override
  String toString() {
    return 'FilterSettings(marketCap: $marketCap, pe: $pe, priceRange: $priceRange, dividend: $dividend, roce: $roce, roe: $roe, sectors: $sectors, sortBy: $sortBy, sortDescending: $sortDescending, pageSize: $pageSize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterSettingsImpl &&
            (identical(other.marketCap, marketCap) ||
                other.marketCap == marketCap) &&
            (identical(other.pe, pe) || other.pe == pe) &&
            (identical(other.priceRange, priceRange) ||
                other.priceRange == priceRange) &&
            (identical(other.dividend, dividend) ||
                other.dividend == dividend) &&
            (identical(other.roce, roce) || other.roce == roce) &&
            (identical(other.roe, roe) || other.roe == roe) &&
            const DeepCollectionEquality().equals(other._sectors, _sectors) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortDescending, sortDescending) ||
                other.sortDescending == sortDescending) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      marketCap,
      pe,
      priceRange,
      dividend,
      roce,
      roe,
      const DeepCollectionEquality().hash(_sectors),
      sortBy,
      sortDescending,
      pageSize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterSettingsImplCopyWith<_$FilterSettingsImpl> get copyWith =>
      __$$FilterSettingsImplCopyWithImpl<_$FilterSettingsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterSettingsImplToJson(
      this,
    );
  }
}

abstract class _FilterSettings implements FilterSettings {
  const factory _FilterSettings(
      {final RangeFilter marketCap,
      final RangeFilter pe,
      final RangeFilter priceRange,
      final RangeFilter dividend,
      final RangeFilter roce,
      final RangeFilter roe,
      final List<String> sectors,
      final String sortBy,
      final bool sortDescending,
      final int pageSize}) = _$FilterSettingsImpl;

  factory _FilterSettings.fromJson(Map<String, dynamic> json) =
      _$FilterSettingsImpl.fromJson;

  @override
  RangeFilter get marketCap;
  @override
  RangeFilter get pe;
  @override
  RangeFilter get priceRange;
  @override
  RangeFilter get dividend;
  @override
  RangeFilter get roce;
  @override
  RangeFilter get roe;
  @override
  List<String> get sectors;
  @override
  String get sortBy;
  @override
  bool get sortDescending;
  @override
  int get pageSize;
  @override
  @JsonKey(ignore: true)
  _$$FilterSettingsImplCopyWith<_$FilterSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RangeFilter _$RangeFilterFromJson(Map<String, dynamic> json) {
  return _RangeFilter.fromJson(json);
}

/// @nodoc
mixin _$RangeFilter {
  double? get min => throw _privateConstructorUsedError;
  double? get max => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RangeFilterCopyWith<RangeFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RangeFilterCopyWith<$Res> {
  factory $RangeFilterCopyWith(
          RangeFilter value, $Res Function(RangeFilter) then) =
      _$RangeFilterCopyWithImpl<$Res, RangeFilter>;
  @useResult
  $Res call({double? min, double? max, bool isActive});
}

/// @nodoc
class _$RangeFilterCopyWithImpl<$Res, $Val extends RangeFilter>
    implements $RangeFilterCopyWith<$Res> {
  _$RangeFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = freezed,
    Object? max = freezed,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      min: freezed == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double?,
      max: freezed == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RangeFilterImplCopyWith<$Res>
    implements $RangeFilterCopyWith<$Res> {
  factory _$$RangeFilterImplCopyWith(
          _$RangeFilterImpl value, $Res Function(_$RangeFilterImpl) then) =
      __$$RangeFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? min, double? max, bool isActive});
}

/// @nodoc
class __$$RangeFilterImplCopyWithImpl<$Res>
    extends _$RangeFilterCopyWithImpl<$Res, _$RangeFilterImpl>
    implements _$$RangeFilterImplCopyWith<$Res> {
  __$$RangeFilterImplCopyWithImpl(
      _$RangeFilterImpl _value, $Res Function(_$RangeFilterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = freezed,
    Object? max = freezed,
    Object? isActive = null,
  }) {
    return _then(_$RangeFilterImpl(
      min: freezed == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double?,
      max: freezed == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RangeFilterImpl implements _RangeFilter {
  const _$RangeFilterImpl(
      {this.min = null, this.max = null, this.isActive = false});

  factory _$RangeFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$RangeFilterImplFromJson(json);

  @override
  @JsonKey()
  final double? min;
  @override
  @JsonKey()
  final double? max;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'RangeFilter(min: $min, max: $max, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RangeFilterImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, min, max, isActive);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RangeFilterImplCopyWith<_$RangeFilterImpl> get copyWith =>
      __$$RangeFilterImplCopyWithImpl<_$RangeFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RangeFilterImplToJson(
      this,
    );
  }
}

abstract class _RangeFilter implements RangeFilter {
  const factory _RangeFilter(
      {final double? min,
      final double? max,
      final bool isActive}) = _$RangeFilterImpl;

  factory _RangeFilter.fromJson(Map<String, dynamic> json) =
      _$RangeFilterImpl.fromJson;

  @override
  double? get min;
  @override
  double? get max;
  @override
  bool get isActive;
  @override
  @JsonKey(ignore: true)
  _$$RangeFilterImplCopyWith<_$RangeFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
