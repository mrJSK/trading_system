// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FinancialDataModel _$FinancialDataModelFromJson(Map<String, dynamic> json) {
  return _FinancialDataModel.fromJson(json);
}

/// @nodoc
mixin _$FinancialDataModel {
  List<String> get headers => throw _privateConstructorUsedError;
  List<FinancialDataRow> get body => throw _privateConstructorUsedError;
  String get dataType => throw _privateConstructorUsedError;
  String get sourceUrl => throw _privateConstructorUsedError;
  String get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FinancialDataModelCopyWith<FinancialDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialDataModelCopyWith<$Res> {
  factory $FinancialDataModelCopyWith(
          FinancialDataModel value, $Res Function(FinancialDataModel) then) =
      _$FinancialDataModelCopyWithImpl<$Res, FinancialDataModel>;
  @useResult
  $Res call(
      {List<String> headers,
      List<FinancialDataRow> body,
      String dataType,
      String sourceUrl,
      String lastUpdated});
}

/// @nodoc
class _$FinancialDataModelCopyWithImpl<$Res, $Val extends FinancialDataModel>
    implements $FinancialDataModelCopyWith<$Res> {
  _$FinancialDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? headers = null,
    Object? body = null,
    Object? dataType = null,
    Object? sourceUrl = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      headers: null == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as List<FinancialDataRow>,
      dataType: null == dataType
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String,
      sourceUrl: null == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialDataModelImplCopyWith<$Res>
    implements $FinancialDataModelCopyWith<$Res> {
  factory _$$FinancialDataModelImplCopyWith(_$FinancialDataModelImpl value,
          $Res Function(_$FinancialDataModelImpl) then) =
      __$$FinancialDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> headers,
      List<FinancialDataRow> body,
      String dataType,
      String sourceUrl,
      String lastUpdated});
}

/// @nodoc
class __$$FinancialDataModelImplCopyWithImpl<$Res>
    extends _$FinancialDataModelCopyWithImpl<$Res, _$FinancialDataModelImpl>
    implements _$$FinancialDataModelImplCopyWith<$Res> {
  __$$FinancialDataModelImplCopyWithImpl(_$FinancialDataModelImpl _value,
      $Res Function(_$FinancialDataModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? headers = null,
    Object? body = null,
    Object? dataType = null,
    Object? sourceUrl = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$FinancialDataModelImpl(
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      body: null == body
          ? _value._body
          : body // ignore: cast_nullable_to_non_nullable
              as List<FinancialDataRow>,
      dataType: null == dataType
          ? _value.dataType
          : dataType // ignore: cast_nullable_to_non_nullable
              as String,
      sourceUrl: null == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialDataModelImpl extends _FinancialDataModel
    with DiagnosticableTreeMixin {
  const _$FinancialDataModelImpl(
      {final List<String> headers = const [],
      final List<FinancialDataRow> body = const [],
      this.dataType = '',
      this.sourceUrl = '',
      this.lastUpdated = ''})
      : _headers = headers,
        _body = body,
        super._();

  factory _$FinancialDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialDataModelImplFromJson(json);

  final List<String> _headers;
  @override
  @JsonKey()
  List<String> get headers {
    if (_headers is EqualUnmodifiableListView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_headers);
  }

  final List<FinancialDataRow> _body;
  @override
  @JsonKey()
  List<FinancialDataRow> get body {
    if (_body is EqualUnmodifiableListView) return _body;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_body);
  }

  @override
  @JsonKey()
  final String dataType;
  @override
  @JsonKey()
  final String sourceUrl;
  @override
  @JsonKey()
  final String lastUpdated;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FinancialDataModel(headers: $headers, body: $body, dataType: $dataType, sourceUrl: $sourceUrl, lastUpdated: $lastUpdated)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FinancialDataModel'))
      ..add(DiagnosticsProperty('headers', headers))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('dataType', dataType))
      ..add(DiagnosticsProperty('sourceUrl', sourceUrl))
      ..add(DiagnosticsProperty('lastUpdated', lastUpdated));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialDataModelImpl &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            const DeepCollectionEquality().equals(other._body, _body) &&
            (identical(other.dataType, dataType) ||
                other.dataType == dataType) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_headers),
      const DeepCollectionEquality().hash(_body),
      dataType,
      sourceUrl,
      lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialDataModelImplCopyWith<_$FinancialDataModelImpl> get copyWith =>
      __$$FinancialDataModelImplCopyWithImpl<_$FinancialDataModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FinancialDataModelImplToJson(
      this,
    );
  }
}

abstract class _FinancialDataModel extends FinancialDataModel {
  const factory _FinancialDataModel(
      {final List<String> headers,
      final List<FinancialDataRow> body,
      final String dataType,
      final String sourceUrl,
      final String lastUpdated}) = _$FinancialDataModelImpl;
  const _FinancialDataModel._() : super._();

  factory _FinancialDataModel.fromJson(Map<String, dynamic> json) =
      _$FinancialDataModelImpl.fromJson;

  @override
  List<String> get headers;
  @override
  List<FinancialDataRow> get body;
  @override
  String get dataType;
  @override
  String get sourceUrl;
  @override
  String get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$FinancialDataModelImplCopyWith<_$FinancialDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FinancialDataRow _$FinancialDataRowFromJson(Map<String, dynamic> json) {
  return _FinancialDataRow.fromJson(json);
}

/// @nodoc
mixin _$FinancialDataRow {
  String get description => throw _privateConstructorUsedError;
  List<String?> get values => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  bool get isCalculated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FinancialDataRowCopyWith<FinancialDataRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinancialDataRowCopyWith<$Res> {
  factory $FinancialDataRowCopyWith(
          FinancialDataRow value, $Res Function(FinancialDataRow) then) =
      _$FinancialDataRowCopyWithImpl<$Res, FinancialDataRow>;
  @useResult
  $Res call(
      {String description,
      List<String?> values,
      String category,
      bool isCalculated});
}

/// @nodoc
class _$FinancialDataRowCopyWithImpl<$Res, $Val extends FinancialDataRow>
    implements $FinancialDataRowCopyWith<$Res> {
  _$FinancialDataRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? values = null,
    Object? category = null,
    Object? isCalculated = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isCalculated: null == isCalculated
          ? _value.isCalculated
          : isCalculated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FinancialDataRowImplCopyWith<$Res>
    implements $FinancialDataRowCopyWith<$Res> {
  factory _$$FinancialDataRowImplCopyWith(_$FinancialDataRowImpl value,
          $Res Function(_$FinancialDataRowImpl) then) =
      __$$FinancialDataRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      List<String?> values,
      String category,
      bool isCalculated});
}

/// @nodoc
class __$$FinancialDataRowImplCopyWithImpl<$Res>
    extends _$FinancialDataRowCopyWithImpl<$Res, _$FinancialDataRowImpl>
    implements _$$FinancialDataRowImplCopyWith<$Res> {
  __$$FinancialDataRowImplCopyWithImpl(_$FinancialDataRowImpl _value,
      $Res Function(_$FinancialDataRowImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? values = null,
    Object? category = null,
    Object? isCalculated = null,
  }) {
    return _then(_$FinancialDataRowImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isCalculated: null == isCalculated
          ? _value.isCalculated
          : isCalculated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialDataRowImpl extends _FinancialDataRow
    with DiagnosticableTreeMixin {
  const _$FinancialDataRowImpl(
      {this.description = '',
      final List<String?> values = const [],
      this.category = '',
      this.isCalculated = false})
      : _values = values,
        super._();

  factory _$FinancialDataRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialDataRowImplFromJson(json);

  @override
  @JsonKey()
  final String description;
  final List<String?> _values;
  @override
  @JsonKey()
  List<String?> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final bool isCalculated;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FinancialDataRow(description: $description, values: $values, category: $category, isCalculated: $isCalculated)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FinancialDataRow'))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('values', values))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('isCalculated', isCalculated));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialDataRowImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isCalculated, isCalculated) ||
                other.isCalculated == isCalculated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, description,
      const DeepCollectionEquality().hash(_values), category, isCalculated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FinancialDataRowImplCopyWith<_$FinancialDataRowImpl> get copyWith =>
      __$$FinancialDataRowImplCopyWithImpl<_$FinancialDataRowImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FinancialDataRowImplToJson(
      this,
    );
  }
}

abstract class _FinancialDataRow extends FinancialDataRow {
  const factory _FinancialDataRow(
      {final String description,
      final List<String?> values,
      final String category,
      final bool isCalculated}) = _$FinancialDataRowImpl;
  const _FinancialDataRow._() : super._();

  factory _FinancialDataRow.fromJson(Map<String, dynamic> json) =
      _$FinancialDataRowImpl.fromJson;

  @override
  String get description;
  @override
  List<String?> get values;
  @override
  String get category;
  @override
  bool get isCalculated;
  @override
  @JsonKey(ignore: true)
  _$$FinancialDataRowImplCopyWith<_$FinancialDataRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuarterlyData _$QuarterlyDataFromJson(Map<String, dynamic> json) {
  return _QuarterlyData.fromJson(json);
}

/// @nodoc
mixin _$QuarterlyData {
  String get quarter => throw _privateConstructorUsedError;
  String get year => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  double? get sales => throw _privateConstructorUsedError;
  double? get netProfit => throw _privateConstructorUsedError;
  double? get eps => throw _privateConstructorUsedError;
  double? get ebitda => throw _privateConstructorUsedError;
  double? get operatingProfit => throw _privateConstructorUsedError;
  double? get operatingMargin => throw _privateConstructorUsedError;
  double? get netMargin => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalMetrics =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuarterlyDataCopyWith<QuarterlyData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuarterlyDataCopyWith<$Res> {
  factory $QuarterlyDataCopyWith(
          QuarterlyData value, $Res Function(QuarterlyData) then) =
      _$QuarterlyDataCopyWithImpl<$Res, QuarterlyData>;
  @useResult
  $Res call(
      {String quarter,
      String year,
      String period,
      double? sales,
      double? netProfit,
      double? eps,
      double? ebitda,
      double? operatingProfit,
      double? operatingMargin,
      double? netMargin,
      Map<String, dynamic> additionalMetrics});
}

/// @nodoc
class _$QuarterlyDataCopyWithImpl<$Res, $Val extends QuarterlyData>
    implements $QuarterlyDataCopyWith<$Res> {
  _$QuarterlyDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quarter = null,
    Object? year = null,
    Object? period = null,
    Object? sales = freezed,
    Object? netProfit = freezed,
    Object? eps = freezed,
    Object? ebitda = freezed,
    Object? operatingProfit = freezed,
    Object? operatingMargin = freezed,
    Object? netMargin = freezed,
    Object? additionalMetrics = null,
  }) {
    return _then(_value.copyWith(
      quarter: null == quarter
          ? _value.quarter
          : quarter // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      sales: freezed == sales
          ? _value.sales
          : sales // ignore: cast_nullable_to_non_nullable
              as double?,
      netProfit: freezed == netProfit
          ? _value.netProfit
          : netProfit // ignore: cast_nullable_to_non_nullable
              as double?,
      eps: freezed == eps
          ? _value.eps
          : eps // ignore: cast_nullable_to_non_nullable
              as double?,
      ebitda: freezed == ebitda
          ? _value.ebitda
          : ebitda // ignore: cast_nullable_to_non_nullable
              as double?,
      operatingProfit: freezed == operatingProfit
          ? _value.operatingProfit
          : operatingProfit // ignore: cast_nullable_to_non_nullable
              as double?,
      operatingMargin: freezed == operatingMargin
          ? _value.operatingMargin
          : operatingMargin // ignore: cast_nullable_to_non_nullable
              as double?,
      netMargin: freezed == netMargin
          ? _value.netMargin
          : netMargin // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalMetrics: null == additionalMetrics
          ? _value.additionalMetrics
          : additionalMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuarterlyDataImplCopyWith<$Res>
    implements $QuarterlyDataCopyWith<$Res> {
  factory _$$QuarterlyDataImplCopyWith(
          _$QuarterlyDataImpl value, $Res Function(_$QuarterlyDataImpl) then) =
      __$$QuarterlyDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String quarter,
      String year,
      String period,
      double? sales,
      double? netProfit,
      double? eps,
      double? ebitda,
      double? operatingProfit,
      double? operatingMargin,
      double? netMargin,
      Map<String, dynamic> additionalMetrics});
}

/// @nodoc
class __$$QuarterlyDataImplCopyWithImpl<$Res>
    extends _$QuarterlyDataCopyWithImpl<$Res, _$QuarterlyDataImpl>
    implements _$$QuarterlyDataImplCopyWith<$Res> {
  __$$QuarterlyDataImplCopyWithImpl(
      _$QuarterlyDataImpl _value, $Res Function(_$QuarterlyDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quarter = null,
    Object? year = null,
    Object? period = null,
    Object? sales = freezed,
    Object? netProfit = freezed,
    Object? eps = freezed,
    Object? ebitda = freezed,
    Object? operatingProfit = freezed,
    Object? operatingMargin = freezed,
    Object? netMargin = freezed,
    Object? additionalMetrics = null,
  }) {
    return _then(_$QuarterlyDataImpl(
      quarter: null == quarter
          ? _value.quarter
          : quarter // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      sales: freezed == sales
          ? _value.sales
          : sales // ignore: cast_nullable_to_non_nullable
              as double?,
      netProfit: freezed == netProfit
          ? _value.netProfit
          : netProfit // ignore: cast_nullable_to_non_nullable
              as double?,
      eps: freezed == eps
          ? _value.eps
          : eps // ignore: cast_nullable_to_non_nullable
              as double?,
      ebitda: freezed == ebitda
          ? _value.ebitda
          : ebitda // ignore: cast_nullable_to_non_nullable
              as double?,
      operatingProfit: freezed == operatingProfit
          ? _value.operatingProfit
          : operatingProfit // ignore: cast_nullable_to_non_nullable
              as double?,
      operatingMargin: freezed == operatingMargin
          ? _value.operatingMargin
          : operatingMargin // ignore: cast_nullable_to_non_nullable
              as double?,
      netMargin: freezed == netMargin
          ? _value.netMargin
          : netMargin // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalMetrics: null == additionalMetrics
          ? _value._additionalMetrics
          : additionalMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuarterlyDataImpl extends _QuarterlyData with DiagnosticableTreeMixin {
  const _$QuarterlyDataImpl(
      {this.quarter = '',
      this.year = '',
      this.period = '',
      this.sales,
      this.netProfit,
      this.eps,
      this.ebitda,
      this.operatingProfit,
      this.operatingMargin,
      this.netMargin,
      final Map<String, dynamic> additionalMetrics = const {}})
      : _additionalMetrics = additionalMetrics,
        super._();

  factory _$QuarterlyDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuarterlyDataImplFromJson(json);

  @override
  @JsonKey()
  final String quarter;
  @override
  @JsonKey()
  final String year;
  @override
  @JsonKey()
  final String period;
  @override
  final double? sales;
  @override
  final double? netProfit;
  @override
  final double? eps;
  @override
  final double? ebitda;
  @override
  final double? operatingProfit;
  @override
  final double? operatingMargin;
  @override
  final double? netMargin;
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'QuarterlyData(quarter: $quarter, year: $year, period: $period, sales: $sales, netProfit: $netProfit, eps: $eps, ebitda: $ebitda, operatingProfit: $operatingProfit, operatingMargin: $operatingMargin, netMargin: $netMargin, additionalMetrics: $additionalMetrics)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'QuarterlyData'))
      ..add(DiagnosticsProperty('quarter', quarter))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('period', period))
      ..add(DiagnosticsProperty('sales', sales))
      ..add(DiagnosticsProperty('netProfit', netProfit))
      ..add(DiagnosticsProperty('eps', eps))
      ..add(DiagnosticsProperty('ebitda', ebitda))
      ..add(DiagnosticsProperty('operatingProfit', operatingProfit))
      ..add(DiagnosticsProperty('operatingMargin', operatingMargin))
      ..add(DiagnosticsProperty('netMargin', netMargin))
      ..add(DiagnosticsProperty('additionalMetrics', additionalMetrics));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuarterlyDataImpl &&
            (identical(other.quarter, quarter) || other.quarter == quarter) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.sales, sales) || other.sales == sales) &&
            (identical(other.netProfit, netProfit) ||
                other.netProfit == netProfit) &&
            (identical(other.eps, eps) || other.eps == eps) &&
            (identical(other.ebitda, ebitda) || other.ebitda == ebitda) &&
            (identical(other.operatingProfit, operatingProfit) ||
                other.operatingProfit == operatingProfit) &&
            (identical(other.operatingMargin, operatingMargin) ||
                other.operatingMargin == operatingMargin) &&
            (identical(other.netMargin, netMargin) ||
                other.netMargin == netMargin) &&
            const DeepCollectionEquality()
                .equals(other._additionalMetrics, _additionalMetrics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      quarter,
      year,
      period,
      sales,
      netProfit,
      eps,
      ebitda,
      operatingProfit,
      operatingMargin,
      netMargin,
      const DeepCollectionEquality().hash(_additionalMetrics));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuarterlyDataImplCopyWith<_$QuarterlyDataImpl> get copyWith =>
      __$$QuarterlyDataImplCopyWithImpl<_$QuarterlyDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuarterlyDataImplToJson(
      this,
    );
  }
}

abstract class _QuarterlyData extends QuarterlyData {
  const factory _QuarterlyData(
      {final String quarter,
      final String year,
      final String period,
      final double? sales,
      final double? netProfit,
      final double? eps,
      final double? ebitda,
      final double? operatingProfit,
      final double? operatingMargin,
      final double? netMargin,
      final Map<String, dynamic> additionalMetrics}) = _$QuarterlyDataImpl;
  const _QuarterlyData._() : super._();

  factory _QuarterlyData.fromJson(Map<String, dynamic> json) =
      _$QuarterlyDataImpl.fromJson;

  @override
  String get quarter;
  @override
  String get year;
  @override
  String get period;
  @override
  double? get sales;
  @override
  double? get netProfit;
  @override
  double? get eps;
  @override
  double? get ebitda;
  @override
  double? get operatingProfit;
  @override
  double? get operatingMargin;
  @override
  double? get netMargin;
  @override
  Map<String, dynamic> get additionalMetrics;
  @override
  @JsonKey(ignore: true)
  _$$QuarterlyDataImplCopyWith<_$QuarterlyDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnnualData _$AnnualDataFromJson(Map<String, dynamic> json) {
  return _AnnualData.fromJson(json);
}

/// @nodoc
mixin _$AnnualData {
  String get year => throw _privateConstructorUsedError;
  double? get sales => throw _privateConstructorUsedError;
  double? get netProfit => throw _privateConstructorUsedError;
  double? get eps => throw _privateConstructorUsedError;
  double? get bookValue => throw _privateConstructorUsedError;
  double? get dividendYield => throw _privateConstructorUsedError;
  double? get roe => throw _privateConstructorUsedError;
  double? get roce => throw _privateConstructorUsedError;
  double? get peRatio => throw _privateConstructorUsedError;
  double? get pbRatio => throw _privateConstructorUsedError;
  double? get debtToEquity => throw _privateConstructorUsedError;
  double? get currentRatio => throw _privateConstructorUsedError;
  double? get interestCoverage => throw _privateConstructorUsedError;
  double? get totalAssets => throw _privateConstructorUsedError;
  double? get shareholdersEquity => throw _privateConstructorUsedError;
  double? get totalDebt => throw _privateConstructorUsedError;
  double? get workingCapital => throw _privateConstructorUsedError;
  double? get operatingCashFlow => throw _privateConstructorUsedError;
  double? get investingCashFlow => throw _privateConstructorUsedError;
  double? get financingCashFlow => throw _privateConstructorUsedError;
  double? get freeCashFlow => throw _privateConstructorUsedError;
  double? get ebitda => throw _privateConstructorUsedError;
  double? get operatingProfit => throw _privateConstructorUsedError;
  Map<String, dynamic> get additionalMetrics =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnnualDataCopyWith<AnnualData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnualDataCopyWith<$Res> {
  factory $AnnualDataCopyWith(
          AnnualData value, $Res Function(AnnualData) then) =
      _$AnnualDataCopyWithImpl<$Res, AnnualData>;
  @useResult
  $Res call(
      {String year,
      double? sales,
      double? netProfit,
      double? eps,
      double? bookValue,
      double? dividendYield,
      double? roe,
      double? roce,
      double? peRatio,
      double? pbRatio,
      double? debtToEquity,
      double? currentRatio,
      double? interestCoverage,
      double? totalAssets,
      double? shareholdersEquity,
      double? totalDebt,
      double? workingCapital,
      double? operatingCashFlow,
      double? investingCashFlow,
      double? financingCashFlow,
      double? freeCashFlow,
      double? ebitda,
      double? operatingProfit,
      Map<String, dynamic> additionalMetrics});
}

/// @nodoc
class _$AnnualDataCopyWithImpl<$Res, $Val extends AnnualData>
    implements $AnnualDataCopyWith<$Res> {
  _$AnnualDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? sales = freezed,
    Object? netProfit = freezed,
    Object? eps = freezed,
    Object? bookValue = freezed,
    Object? dividendYield = freezed,
    Object? roe = freezed,
    Object? roce = freezed,
    Object? peRatio = freezed,
    Object? pbRatio = freezed,
    Object? debtToEquity = freezed,
    Object? currentRatio = freezed,
    Object? interestCoverage = freezed,
    Object? totalAssets = freezed,
    Object? shareholdersEquity = freezed,
    Object? totalDebt = freezed,
    Object? workingCapital = freezed,
    Object? operatingCashFlow = freezed,
    Object? investingCashFlow = freezed,
    Object? financingCashFlow = freezed,
    Object? freeCashFlow = freezed,
    Object? ebitda = freezed,
    Object? operatingProfit = freezed,
    Object? additionalMetrics = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      sales: freezed == sales
          ? _value.sales
          : sales // ignore: cast_nullable_to_non_nullable
              as double?,
      netProfit: freezed == netProfit
          ? _value.netProfit
          : netProfit // ignore: cast_nullable_to_non_nullable
              as double?,
      eps: freezed == eps
          ? _value.eps
          : eps // ignore: cast_nullable_to_non_nullable
              as double?,
      bookValue: freezed == bookValue
          ? _value.bookValue
          : bookValue // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendYield: freezed == dividendYield
          ? _value.dividendYield
          : dividendYield // ignore: cast_nullable_to_non_nullable
              as double?,
      roe: freezed == roe
          ? _value.roe
          : roe // ignore: cast_nullable_to_non_nullable
              as double?,
      roce: freezed == roce
          ? _value.roce
          : roce // ignore: cast_nullable_to_non_nullable
              as double?,
      peRatio: freezed == peRatio
          ? _value.peRatio
          : peRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      pbRatio: freezed == pbRatio
          ? _value.pbRatio
          : pbRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      debtToEquity: freezed == debtToEquity
          ? _value.debtToEquity
          : debtToEquity // ignore: cast_nullable_to_non_nullable
              as double?,
      currentRatio: freezed == currentRatio
          ? _value.currentRatio
          : currentRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      interestCoverage: freezed == interestCoverage
          ? _value.interestCoverage
          : interestCoverage // ignore: cast_nullable_to_non_nullable
              as double?,
      totalAssets: freezed == totalAssets
          ? _value.totalAssets
          : totalAssets // ignore: cast_nullable_to_non_nullable
              as double?,
      shareholdersEquity: freezed == shareholdersEquity
          ? _value.shareholdersEquity
          : shareholdersEquity // ignore: cast_nullable_to_non_nullable
              as double?,
      totalDebt: freezed == totalDebt
          ? _value.totalDebt
          : totalDebt // ignore: cast_nullable_to_non_nullable
              as double?,
      workingCapital: freezed == workingCapital
          ? _value.workingCapital
          : workingCapital // ignore: cast_nullable_to_non_nullable
              as double?,
      operatingCashFlow: freezed == operatingCashFlow
          ? _value.operatingCashFlow
          : operatingCashFlow // ignore: cast_nullable_to_non_nullable
              as double?,
      investingCashFlow: freezed == investingCashFlow
          ? _value.investingCashFlow
          : investingCashFlow // ignore: cast_nullable_to_non_nullable
              as double?,
      financingCashFlow: freezed == financingCashFlow
          ? _value.financingCashFlow
          : financingCashFlow // ignore: cast_nullable_to_non_nullable
              as double?,
      freeCashFlow: freezed == freeCashFlow
          ? _value.freeCashFlow
          : freeCashFlow // ignore: cast_nullable_to_non_nullable
              as double?,
      ebitda: freezed == ebitda
          ? _value.ebitda
          : ebitda // ignore: cast_nullable_to_non_nullable
              as double?,
      operatingProfit: freezed == operatingProfit
          ? _value.operatingProfit
          : operatingProfit // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalMetrics: null == additionalMetrics
          ? _value.additionalMetrics
          : additionalMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnnualDataImplCopyWith<$Res>
    implements $AnnualDataCopyWith<$Res> {
  factory _$$AnnualDataImplCopyWith(
          _$AnnualDataImpl value, $Res Function(_$AnnualDataImpl) then) =
      __$$AnnualDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String year,
      double? sales,
      double? netProfit,
      double? eps,
      double? bookValue,
      double? dividendYield,
      double? roe,
      double? roce,
      double? peRatio,
      double? pbRatio,
      double? debtToEquity,
      double? currentRatio,
      double? interestCoverage,
      double? totalAssets,
      double? shareholdersEquity,
      double? totalDebt,
      double? workingCapital,
      double? operatingCashFlow,
      double? investingCashFlow,
      double? financingCashFlow,
      double? freeCashFlow,
      double? ebitda,
      double? operatingProfit,
      Map<String, dynamic> additionalMetrics});
}

/// @nodoc
class __$$AnnualDataImplCopyWithImpl<$Res>
    extends _$AnnualDataCopyWithImpl<$Res, _$AnnualDataImpl>
    implements _$$AnnualDataImplCopyWith<$Res> {
  __$$AnnualDataImplCopyWithImpl(
      _$AnnualDataImpl _value, $Res Function(_$AnnualDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? sales = freezed,
    Object? netProfit = freezed,
    Object? eps = freezed,
    Object? bookValue = freezed,
    Object? dividendYield = freezed,
    Object? roe = freezed,
    Object? roce = freezed,
    Object? peRatio = freezed,
    Object? pbRatio = freezed,
    Object? debtToEquity = freezed,
    Object? currentRatio = freezed,
    Object? interestCoverage = freezed,
    Object? totalAssets = freezed,
    Object? shareholdersEquity = freezed,
    Object? totalDebt = freezed,
    Object? workingCapital = freezed,
    Object? operatingCashFlow = freezed,
    Object? investingCashFlow = freezed,
    Object? financingCashFlow = freezed,
    Object? freeCashFlow = freezed,
    Object? ebitda = freezed,
    Object? operatingProfit = freezed,
    Object? additionalMetrics = null,
  }) {
    return _then(_$AnnualDataImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      sales: freezed == sales
          ? _value.sales
          : sales // ignore: cast_nullable_to_non_nullable
              as double?,
      netProfit: freezed == netProfit
          ? _value.netProfit
          : netProfit // ignore: cast_nullable_to_non_nullable
              as double?,
      eps: freezed == eps
          ? _value.eps
          : eps // ignore: cast_nullable_to_non_nullable
              as double?,
      bookValue: freezed == bookValue
          ? _value.bookValue
          : bookValue // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendYield: freezed == dividendYield
          ? _value.dividendYield
          : dividendYield // ignore: cast_nullable_to_non_nullable
              as double?,
      roe: freezed == roe
          ? _value.roe
          : roe // ignore: cast_nullable_to_non_nullable
              as double?,
      roce: freezed == roce
          ? _value.roce
          : roce // ignore: cast_nullable_to_non_nullable
              as double?,
      peRatio: freezed == peRatio
          ? _value.peRatio
          : peRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      pbRatio: freezed == pbRatio
          ? _value.pbRatio
          : pbRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      debtToEquity: freezed == debtToEquity
          ? _value.debtToEquity
          : debtToEquity // ignore: cast_nullable_to_non_nullable
              as double?,
      currentRatio: freezed == currentRatio
          ? _value.currentRatio
          : currentRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      interestCoverage: freezed == interestCoverage
          ? _value.interestCoverage
          : interestCoverage // ignore: cast_nullable_to_non_nullable
              as double?,
      totalAssets: freezed == totalAssets
          ? _value.totalAssets
          : totalAssets // ignore: cast_nullable_to_non_nullable
              as double?,
      shareholdersEquity: freezed == shareholdersEquity
          ? _value.shareholdersEquity
          : shareholdersEquity // ignore: cast_nullable_to_non_nullable
              as double?,
      totalDebt: freezed == totalDebt
          ? _value.totalDebt
          : totalDebt // ignore: cast_nullable_to_non_nullable
              as double?,
      workingCapital: freezed == workingCapital
          ? _value.workingCapital
          : workingCapital // ignore: cast_nullable_to_non_nullable
              as double?,
      operatingCashFlow: freezed == operatingCashFlow
          ? _value.operatingCashFlow
          : operatingCashFlow // ignore: cast_nullable_to_non_nullable
              as double?,
      investingCashFlow: freezed == investingCashFlow
          ? _value.investingCashFlow
          : investingCashFlow // ignore: cast_nullable_to_non_nullable
              as double?,
      financingCashFlow: freezed == financingCashFlow
          ? _value.financingCashFlow
          : financingCashFlow // ignore: cast_nullable_to_non_nullable
              as double?,
      freeCashFlow: freezed == freeCashFlow
          ? _value.freeCashFlow
          : freeCashFlow // ignore: cast_nullable_to_non_nullable
              as double?,
      ebitda: freezed == ebitda
          ? _value.ebitda
          : ebitda // ignore: cast_nullable_to_non_nullable
              as double?,
      operatingProfit: freezed == operatingProfit
          ? _value.operatingProfit
          : operatingProfit // ignore: cast_nullable_to_non_nullable
              as double?,
      additionalMetrics: null == additionalMetrics
          ? _value._additionalMetrics
          : additionalMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnnualDataImpl extends _AnnualData with DiagnosticableTreeMixin {
  const _$AnnualDataImpl(
      {this.year = '',
      this.sales,
      this.netProfit,
      this.eps,
      this.bookValue,
      this.dividendYield,
      this.roe,
      this.roce,
      this.peRatio,
      this.pbRatio,
      this.debtToEquity,
      this.currentRatio,
      this.interestCoverage,
      this.totalAssets,
      this.shareholdersEquity,
      this.totalDebt,
      this.workingCapital,
      this.operatingCashFlow,
      this.investingCashFlow,
      this.financingCashFlow,
      this.freeCashFlow,
      this.ebitda,
      this.operatingProfit,
      final Map<String, dynamic> additionalMetrics = const {}})
      : _additionalMetrics = additionalMetrics,
        super._();

  factory _$AnnualDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnnualDataImplFromJson(json);

  @override
  @JsonKey()
  final String year;
  @override
  final double? sales;
  @override
  final double? netProfit;
  @override
  final double? eps;
  @override
  final double? bookValue;
  @override
  final double? dividendYield;
  @override
  final double? roe;
  @override
  final double? roce;
  @override
  final double? peRatio;
  @override
  final double? pbRatio;
  @override
  final double? debtToEquity;
  @override
  final double? currentRatio;
  @override
  final double? interestCoverage;
  @override
  final double? totalAssets;
  @override
  final double? shareholdersEquity;
  @override
  final double? totalDebt;
  @override
  final double? workingCapital;
  @override
  final double? operatingCashFlow;
  @override
  final double? investingCashFlow;
  @override
  final double? financingCashFlow;
  @override
  final double? freeCashFlow;
  @override
  final double? ebitda;
  @override
  final double? operatingProfit;
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AnnualData(year: $year, sales: $sales, netProfit: $netProfit, eps: $eps, bookValue: $bookValue, dividendYield: $dividendYield, roe: $roe, roce: $roce, peRatio: $peRatio, pbRatio: $pbRatio, debtToEquity: $debtToEquity, currentRatio: $currentRatio, interestCoverage: $interestCoverage, totalAssets: $totalAssets, shareholdersEquity: $shareholdersEquity, totalDebt: $totalDebt, workingCapital: $workingCapital, operatingCashFlow: $operatingCashFlow, investingCashFlow: $investingCashFlow, financingCashFlow: $financingCashFlow, freeCashFlow: $freeCashFlow, ebitda: $ebitda, operatingProfit: $operatingProfit, additionalMetrics: $additionalMetrics)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AnnualData'))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('sales', sales))
      ..add(DiagnosticsProperty('netProfit', netProfit))
      ..add(DiagnosticsProperty('eps', eps))
      ..add(DiagnosticsProperty('bookValue', bookValue))
      ..add(DiagnosticsProperty('dividendYield', dividendYield))
      ..add(DiagnosticsProperty('roe', roe))
      ..add(DiagnosticsProperty('roce', roce))
      ..add(DiagnosticsProperty('peRatio', peRatio))
      ..add(DiagnosticsProperty('pbRatio', pbRatio))
      ..add(DiagnosticsProperty('debtToEquity', debtToEquity))
      ..add(DiagnosticsProperty('currentRatio', currentRatio))
      ..add(DiagnosticsProperty('interestCoverage', interestCoverage))
      ..add(DiagnosticsProperty('totalAssets', totalAssets))
      ..add(DiagnosticsProperty('shareholdersEquity', shareholdersEquity))
      ..add(DiagnosticsProperty('totalDebt', totalDebt))
      ..add(DiagnosticsProperty('workingCapital', workingCapital))
      ..add(DiagnosticsProperty('operatingCashFlow', operatingCashFlow))
      ..add(DiagnosticsProperty('investingCashFlow', investingCashFlow))
      ..add(DiagnosticsProperty('financingCashFlow', financingCashFlow))
      ..add(DiagnosticsProperty('freeCashFlow', freeCashFlow))
      ..add(DiagnosticsProperty('ebitda', ebitda))
      ..add(DiagnosticsProperty('operatingProfit', operatingProfit))
      ..add(DiagnosticsProperty('additionalMetrics', additionalMetrics));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnnualDataImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.sales, sales) || other.sales == sales) &&
            (identical(other.netProfit, netProfit) ||
                other.netProfit == netProfit) &&
            (identical(other.eps, eps) || other.eps == eps) &&
            (identical(other.bookValue, bookValue) ||
                other.bookValue == bookValue) &&
            (identical(other.dividendYield, dividendYield) ||
                other.dividendYield == dividendYield) &&
            (identical(other.roe, roe) || other.roe == roe) &&
            (identical(other.roce, roce) || other.roce == roce) &&
            (identical(other.peRatio, peRatio) || other.peRatio == peRatio) &&
            (identical(other.pbRatio, pbRatio) || other.pbRatio == pbRatio) &&
            (identical(other.debtToEquity, debtToEquity) ||
                other.debtToEquity == debtToEquity) &&
            (identical(other.currentRatio, currentRatio) ||
                other.currentRatio == currentRatio) &&
            (identical(other.interestCoverage, interestCoverage) ||
                other.interestCoverage == interestCoverage) &&
            (identical(other.totalAssets, totalAssets) ||
                other.totalAssets == totalAssets) &&
            (identical(other.shareholdersEquity, shareholdersEquity) ||
                other.shareholdersEquity == shareholdersEquity) &&
            (identical(other.totalDebt, totalDebt) ||
                other.totalDebt == totalDebt) &&
            (identical(other.workingCapital, workingCapital) ||
                other.workingCapital == workingCapital) &&
            (identical(other.operatingCashFlow, operatingCashFlow) ||
                other.operatingCashFlow == operatingCashFlow) &&
            (identical(other.investingCashFlow, investingCashFlow) ||
                other.investingCashFlow == investingCashFlow) &&
            (identical(other.financingCashFlow, financingCashFlow) ||
                other.financingCashFlow == financingCashFlow) &&
            (identical(other.freeCashFlow, freeCashFlow) ||
                other.freeCashFlow == freeCashFlow) &&
            (identical(other.ebitda, ebitda) || other.ebitda == ebitda) &&
            (identical(other.operatingProfit, operatingProfit) ||
                other.operatingProfit == operatingProfit) &&
            const DeepCollectionEquality()
                .equals(other._additionalMetrics, _additionalMetrics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        year,
        sales,
        netProfit,
        eps,
        bookValue,
        dividendYield,
        roe,
        roce,
        peRatio,
        pbRatio,
        debtToEquity,
        currentRatio,
        interestCoverage,
        totalAssets,
        shareholdersEquity,
        totalDebt,
        workingCapital,
        operatingCashFlow,
        investingCashFlow,
        financingCashFlow,
        freeCashFlow,
        ebitda,
        operatingProfit,
        const DeepCollectionEquality().hash(_additionalMetrics)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnnualDataImplCopyWith<_$AnnualDataImpl> get copyWith =>
      __$$AnnualDataImplCopyWithImpl<_$AnnualDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnnualDataImplToJson(
      this,
    );
  }
}

abstract class _AnnualData extends AnnualData {
  const factory _AnnualData(
      {final String year,
      final double? sales,
      final double? netProfit,
      final double? eps,
      final double? bookValue,
      final double? dividendYield,
      final double? roe,
      final double? roce,
      final double? peRatio,
      final double? pbRatio,
      final double? debtToEquity,
      final double? currentRatio,
      final double? interestCoverage,
      final double? totalAssets,
      final double? shareholdersEquity,
      final double? totalDebt,
      final double? workingCapital,
      final double? operatingCashFlow,
      final double? investingCashFlow,
      final double? financingCashFlow,
      final double? freeCashFlow,
      final double? ebitda,
      final double? operatingProfit,
      final Map<String, dynamic> additionalMetrics}) = _$AnnualDataImpl;
  const _AnnualData._() : super._();

  factory _AnnualData.fromJson(Map<String, dynamic> json) =
      _$AnnualDataImpl.fromJson;

  @override
  String get year;
  @override
  double? get sales;
  @override
  double? get netProfit;
  @override
  double? get eps;
  @override
  double? get bookValue;
  @override
  double? get dividendYield;
  @override
  double? get roe;
  @override
  double? get roce;
  @override
  double? get peRatio;
  @override
  double? get pbRatio;
  @override
  double? get debtToEquity;
  @override
  double? get currentRatio;
  @override
  double? get interestCoverage;
  @override
  double? get totalAssets;
  @override
  double? get shareholdersEquity;
  @override
  double? get totalDebt;
  @override
  double? get workingCapital;
  @override
  double? get operatingCashFlow;
  @override
  double? get investingCashFlow;
  @override
  double? get financingCashFlow;
  @override
  double? get freeCashFlow;
  @override
  double? get ebitda;
  @override
  double? get operatingProfit;
  @override
  Map<String, dynamic> get additionalMetrics;
  @override
  @JsonKey(ignore: true)
  _$$AnnualDataImplCopyWith<_$AnnualDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShareholdingPattern _$ShareholdingPatternFromJson(Map<String, dynamic> json) {
  return _ShareholdingPattern.fromJson(json);
}

/// @nodoc
mixin _$ShareholdingPattern {
  double? get promoterHolding => throw _privateConstructorUsedError;
  double? get publicHolding => throw _privateConstructorUsedError;
  double? get institutionalHolding => throw _privateConstructorUsedError;
  double? get foreignInstitutional => throw _privateConstructorUsedError;
  List<MajorShareholder> get majorShareholders =>
      throw _privateConstructorUsedError;
  Map<String, Map<String, String>> get quarterly =>
      throw _privateConstructorUsedError;
  String get lastUpdated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShareholdingPatternCopyWith<ShareholdingPattern> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShareholdingPatternCopyWith<$Res> {
  factory $ShareholdingPatternCopyWith(
          ShareholdingPattern value, $Res Function(ShareholdingPattern) then) =
      _$ShareholdingPatternCopyWithImpl<$Res, ShareholdingPattern>;
  @useResult
  $Res call(
      {double? promoterHolding,
      double? publicHolding,
      double? institutionalHolding,
      double? foreignInstitutional,
      List<MajorShareholder> majorShareholders,
      Map<String, Map<String, String>> quarterly,
      String lastUpdated});
}

/// @nodoc
class _$ShareholdingPatternCopyWithImpl<$Res, $Val extends ShareholdingPattern>
    implements $ShareholdingPatternCopyWith<$Res> {
  _$ShareholdingPatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promoterHolding = freezed,
    Object? publicHolding = freezed,
    Object? institutionalHolding = freezed,
    Object? foreignInstitutional = freezed,
    Object? majorShareholders = null,
    Object? quarterly = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      promoterHolding: freezed == promoterHolding
          ? _value.promoterHolding
          : promoterHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      publicHolding: freezed == publicHolding
          ? _value.publicHolding
          : publicHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      institutionalHolding: freezed == institutionalHolding
          ? _value.institutionalHolding
          : institutionalHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      foreignInstitutional: freezed == foreignInstitutional
          ? _value.foreignInstitutional
          : foreignInstitutional // ignore: cast_nullable_to_non_nullable
              as double?,
      majorShareholders: null == majorShareholders
          ? _value.majorShareholders
          : majorShareholders // ignore: cast_nullable_to_non_nullable
              as List<MajorShareholder>,
      quarterly: null == quarterly
          ? _value.quarterly
          : quarterly // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShareholdingPatternImplCopyWith<$Res>
    implements $ShareholdingPatternCopyWith<$Res> {
  factory _$$ShareholdingPatternImplCopyWith(_$ShareholdingPatternImpl value,
          $Res Function(_$ShareholdingPatternImpl) then) =
      __$$ShareholdingPatternImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? promoterHolding,
      double? publicHolding,
      double? institutionalHolding,
      double? foreignInstitutional,
      List<MajorShareholder> majorShareholders,
      Map<String, Map<String, String>> quarterly,
      String lastUpdated});
}

/// @nodoc
class __$$ShareholdingPatternImplCopyWithImpl<$Res>
    extends _$ShareholdingPatternCopyWithImpl<$Res, _$ShareholdingPatternImpl>
    implements _$$ShareholdingPatternImplCopyWith<$Res> {
  __$$ShareholdingPatternImplCopyWithImpl(_$ShareholdingPatternImpl _value,
      $Res Function(_$ShareholdingPatternImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? promoterHolding = freezed,
    Object? publicHolding = freezed,
    Object? institutionalHolding = freezed,
    Object? foreignInstitutional = freezed,
    Object? majorShareholders = null,
    Object? quarterly = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$ShareholdingPatternImpl(
      promoterHolding: freezed == promoterHolding
          ? _value.promoterHolding
          : promoterHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      publicHolding: freezed == publicHolding
          ? _value.publicHolding
          : publicHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      institutionalHolding: freezed == institutionalHolding
          ? _value.institutionalHolding
          : institutionalHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      foreignInstitutional: freezed == foreignInstitutional
          ? _value.foreignInstitutional
          : foreignInstitutional // ignore: cast_nullable_to_non_nullable
              as double?,
      majorShareholders: null == majorShareholders
          ? _value._majorShareholders
          : majorShareholders // ignore: cast_nullable_to_non_nullable
              as List<MajorShareholder>,
      quarterly: null == quarterly
          ? _value._quarterly
          : quarterly // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShareholdingPatternImpl extends _ShareholdingPattern
    with DiagnosticableTreeMixin {
  const _$ShareholdingPatternImpl(
      {this.promoterHolding,
      this.publicHolding,
      this.institutionalHolding,
      this.foreignInstitutional,
      final List<MajorShareholder> majorShareholders = const [],
      final Map<String, Map<String, String>> quarterly = const {},
      this.lastUpdated = ''})
      : _majorShareholders = majorShareholders,
        _quarterly = quarterly,
        super._();

  factory _$ShareholdingPatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShareholdingPatternImplFromJson(json);

  @override
  final double? promoterHolding;
  @override
  final double? publicHolding;
  @override
  final double? institutionalHolding;
  @override
  final double? foreignInstitutional;
  final List<MajorShareholder> _majorShareholders;
  @override
  @JsonKey()
  List<MajorShareholder> get majorShareholders {
    if (_majorShareholders is EqualUnmodifiableListView)
      return _majorShareholders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_majorShareholders);
  }

  final Map<String, Map<String, String>> _quarterly;
  @override
  @JsonKey()
  Map<String, Map<String, String>> get quarterly {
    if (_quarterly is EqualUnmodifiableMapView) return _quarterly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_quarterly);
  }

  @override
  @JsonKey()
  final String lastUpdated;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ShareholdingPattern(promoterHolding: $promoterHolding, publicHolding: $publicHolding, institutionalHolding: $institutionalHolding, foreignInstitutional: $foreignInstitutional, majorShareholders: $majorShareholders, quarterly: $quarterly, lastUpdated: $lastUpdated)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ShareholdingPattern'))
      ..add(DiagnosticsProperty('promoterHolding', promoterHolding))
      ..add(DiagnosticsProperty('publicHolding', publicHolding))
      ..add(DiagnosticsProperty('institutionalHolding', institutionalHolding))
      ..add(DiagnosticsProperty('foreignInstitutional', foreignInstitutional))
      ..add(DiagnosticsProperty('majorShareholders', majorShareholders))
      ..add(DiagnosticsProperty('quarterly', quarterly))
      ..add(DiagnosticsProperty('lastUpdated', lastUpdated));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareholdingPatternImpl &&
            (identical(other.promoterHolding, promoterHolding) ||
                other.promoterHolding == promoterHolding) &&
            (identical(other.publicHolding, publicHolding) ||
                other.publicHolding == publicHolding) &&
            (identical(other.institutionalHolding, institutionalHolding) ||
                other.institutionalHolding == institutionalHolding) &&
            (identical(other.foreignInstitutional, foreignInstitutional) ||
                other.foreignInstitutional == foreignInstitutional) &&
            const DeepCollectionEquality()
                .equals(other._majorShareholders, _majorShareholders) &&
            const DeepCollectionEquality()
                .equals(other._quarterly, _quarterly) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      promoterHolding,
      publicHolding,
      institutionalHolding,
      foreignInstitutional,
      const DeepCollectionEquality().hash(_majorShareholders),
      const DeepCollectionEquality().hash(_quarterly),
      lastUpdated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShareholdingPatternImplCopyWith<_$ShareholdingPatternImpl> get copyWith =>
      __$$ShareholdingPatternImplCopyWithImpl<_$ShareholdingPatternImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShareholdingPatternImplToJson(
      this,
    );
  }
}

abstract class _ShareholdingPattern extends ShareholdingPattern {
  const factory _ShareholdingPattern(
      {final double? promoterHolding,
      final double? publicHolding,
      final double? institutionalHolding,
      final double? foreignInstitutional,
      final List<MajorShareholder> majorShareholders,
      final Map<String, Map<String, String>> quarterly,
      final String lastUpdated}) = _$ShareholdingPatternImpl;
  const _ShareholdingPattern._() : super._();

  factory _ShareholdingPattern.fromJson(Map<String, dynamic> json) =
      _$ShareholdingPatternImpl.fromJson;

  @override
  double? get promoterHolding;
  @override
  double? get publicHolding;
  @override
  double? get institutionalHolding;
  @override
  double? get foreignInstitutional;
  @override
  List<MajorShareholder> get majorShareholders;
  @override
  Map<String, Map<String, String>> get quarterly;
  @override
  String get lastUpdated;
  @override
  @JsonKey(ignore: true)
  _$$ShareholdingPatternImplCopyWith<_$ShareholdingPatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MajorShareholder _$MajorShareholderFromJson(Map<String, dynamic> json) {
  return _MajorShareholder.fromJson(json);
}

/// @nodoc
mixin _$MajorShareholder {
  String get name => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MajorShareholderCopyWith<MajorShareholder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MajorShareholderCopyWith<$Res> {
  factory $MajorShareholderCopyWith(
          MajorShareholder value, $Res Function(MajorShareholder) then) =
      _$MajorShareholderCopyWithImpl<$Res, MajorShareholder>;
  @useResult
  $Res call({String name, double percentage, String category});
}

/// @nodoc
class _$MajorShareholderCopyWithImpl<$Res, $Val extends MajorShareholder>
    implements $MajorShareholderCopyWith<$Res> {
  _$MajorShareholderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? percentage = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MajorShareholderImplCopyWith<$Res>
    implements $MajorShareholderCopyWith<$Res> {
  factory _$$MajorShareholderImplCopyWith(_$MajorShareholderImpl value,
          $Res Function(_$MajorShareholderImpl) then) =
      __$$MajorShareholderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double percentage, String category});
}

/// @nodoc
class __$$MajorShareholderImplCopyWithImpl<$Res>
    extends _$MajorShareholderCopyWithImpl<$Res, _$MajorShareholderImpl>
    implements _$$MajorShareholderImplCopyWith<$Res> {
  __$$MajorShareholderImplCopyWithImpl(_$MajorShareholderImpl _value,
      $Res Function(_$MajorShareholderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? percentage = null,
    Object? category = null,
  }) {
    return _then(_$MajorShareholderImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MajorShareholderImpl
    with DiagnosticableTreeMixin
    implements _MajorShareholder {
  const _$MajorShareholderImpl(
      {this.name = '', this.percentage = 0.0, this.category = ''});

  factory _$MajorShareholderImpl.fromJson(Map<String, dynamic> json) =>
      _$$MajorShareholderImplFromJson(json);

  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double percentage;
  @override
  @JsonKey()
  final String category;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MajorShareholder(name: $name, percentage: $percentage, category: $category)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MajorShareholder'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('percentage', percentage))
      ..add(DiagnosticsProperty('category', category));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MajorShareholderImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, percentage, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MajorShareholderImplCopyWith<_$MajorShareholderImpl> get copyWith =>
      __$$MajorShareholderImplCopyWithImpl<_$MajorShareholderImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MajorShareholderImplToJson(
      this,
    );
  }
}

abstract class _MajorShareholder implements MajorShareholder {
  const factory _MajorShareholder(
      {final String name,
      final double percentage,
      final String category}) = _$MajorShareholderImpl;

  factory _MajorShareholder.fromJson(Map<String, dynamic> json) =
      _$MajorShareholderImpl.fromJson;

  @override
  String get name;
  @override
  double get percentage;
  @override
  String get category;
  @override
  @JsonKey(ignore: true)
  _$$MajorShareholderImplCopyWith<_$MajorShareholderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

KeyMilestone _$KeyMilestoneFromJson(Map<String, dynamic> json) {
  return _KeyMilestone.fromJson(json);
}

/// @nodoc
mixin _$KeyMilestone {
  String get year => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get impact => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KeyMilestoneCopyWith<KeyMilestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyMilestoneCopyWith<$Res> {
  factory $KeyMilestoneCopyWith(
          KeyMilestone value, $Res Function(KeyMilestone) then) =
      _$KeyMilestoneCopyWithImpl<$Res, KeyMilestone>;
  @useResult
  $Res call({String year, String description, String category, String impact});
}

/// @nodoc
class _$KeyMilestoneCopyWithImpl<$Res, $Val extends KeyMilestone>
    implements $KeyMilestoneCopyWith<$Res> {
  _$KeyMilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? description = null,
    Object? category = null,
    Object? impact = null,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KeyMilestoneImplCopyWith<$Res>
    implements $KeyMilestoneCopyWith<$Res> {
  factory _$$KeyMilestoneImplCopyWith(
          _$KeyMilestoneImpl value, $Res Function(_$KeyMilestoneImpl) then) =
      __$$KeyMilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String year, String description, String category, String impact});
}

/// @nodoc
class __$$KeyMilestoneImplCopyWithImpl<$Res>
    extends _$KeyMilestoneCopyWithImpl<$Res, _$KeyMilestoneImpl>
    implements _$$KeyMilestoneImplCopyWith<$Res> {
  __$$KeyMilestoneImplCopyWithImpl(
      _$KeyMilestoneImpl _value, $Res Function(_$KeyMilestoneImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? description = null,
    Object? category = null,
    Object? impact = null,
  }) {
    return _then(_$KeyMilestoneImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KeyMilestoneImpl with DiagnosticableTreeMixin implements _KeyMilestone {
  const _$KeyMilestoneImpl(
      {this.year = '',
      this.description = '',
      this.category = '',
      this.impact = ''});

  factory _$KeyMilestoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyMilestoneImplFromJson(json);

  @override
  @JsonKey()
  final String year;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String category;
  @override
  @JsonKey()
  final String impact;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'KeyMilestone(year: $year, description: $description, category: $category, impact: $impact)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'KeyMilestone'))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('impact', impact));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyMilestoneImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.impact, impact) || other.impact == impact));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, year, description, category, impact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyMilestoneImplCopyWith<_$KeyMilestoneImpl> get copyWith =>
      __$$KeyMilestoneImplCopyWithImpl<_$KeyMilestoneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyMilestoneImplToJson(
      this,
    );
  }
}

abstract class _KeyMilestone implements KeyMilestone {
  const factory _KeyMilestone(
      {final String year,
      final String description,
      final String category,
      final String impact}) = _$KeyMilestoneImpl;

  factory _KeyMilestone.fromJson(Map<String, dynamic> json) =
      _$KeyMilestoneImpl.fromJson;

  @override
  String get year;
  @override
  String get description;
  @override
  String get category;
  @override
  String get impact;
  @override
  @JsonKey(ignore: true)
  _$$KeyMilestoneImplCopyWith<_$KeyMilestoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InvestmentHighlight _$InvestmentHighlightFromJson(Map<String, dynamic> json) {
  return _InvestmentHighlight.fromJson(json);
}

/// @nodoc
mixin _$InvestmentHighlight {
  String get type => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get impact => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InvestmentHighlightCopyWith<InvestmentHighlight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvestmentHighlightCopyWith<$Res> {
  factory $InvestmentHighlightCopyWith(
          InvestmentHighlight value, $Res Function(InvestmentHighlight) then) =
      _$InvestmentHighlightCopyWithImpl<$Res, InvestmentHighlight>;
  @useResult
  $Res call({String type, String description, String impact, String category});
}

/// @nodoc
class _$InvestmentHighlightCopyWithImpl<$Res, $Val extends InvestmentHighlight>
    implements $InvestmentHighlightCopyWith<$Res> {
  _$InvestmentHighlightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? description = null,
    Object? impact = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InvestmentHighlightImplCopyWith<$Res>
    implements $InvestmentHighlightCopyWith<$Res> {
  factory _$$InvestmentHighlightImplCopyWith(_$InvestmentHighlightImpl value,
          $Res Function(_$InvestmentHighlightImpl) then) =
      __$$InvestmentHighlightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String description, String impact, String category});
}

/// @nodoc
class __$$InvestmentHighlightImplCopyWithImpl<$Res>
    extends _$InvestmentHighlightCopyWithImpl<$Res, _$InvestmentHighlightImpl>
    implements _$$InvestmentHighlightImplCopyWith<$Res> {
  __$$InvestmentHighlightImplCopyWithImpl(_$InvestmentHighlightImpl _value,
      $Res Function(_$InvestmentHighlightImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? description = null,
    Object? impact = null,
    Object? category = null,
  }) {
    return _then(_$InvestmentHighlightImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      impact: null == impact
          ? _value.impact
          : impact // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InvestmentHighlightImpl
    with DiagnosticableTreeMixin
    implements _InvestmentHighlight {
  const _$InvestmentHighlightImpl(
      {this.type = '',
      this.description = '',
      this.impact = '',
      this.category = ''});

  factory _$InvestmentHighlightImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvestmentHighlightImplFromJson(json);

  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String impact;
  @override
  @JsonKey()
  final String category;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'InvestmentHighlight(type: $type, description: $description, impact: $impact, category: $category)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'InvestmentHighlight'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('impact', impact))
      ..add(DiagnosticsProperty('category', category));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvestmentHighlightImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.impact, impact) || other.impact == impact) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, description, impact, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InvestmentHighlightImplCopyWith<_$InvestmentHighlightImpl> get copyWith =>
      __$$InvestmentHighlightImplCopyWithImpl<_$InvestmentHighlightImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InvestmentHighlightImplToJson(
      this,
    );
  }
}

abstract class _InvestmentHighlight implements InvestmentHighlight {
  const factory _InvestmentHighlight(
      {final String type,
      final String description,
      final String impact,
      final String category}) = _$InvestmentHighlightImpl;

  factory _InvestmentHighlight.fromJson(Map<String, dynamic> json) =
      _$InvestmentHighlightImpl.fromJson;

  @override
  String get type;
  @override
  String get description;
  @override
  String get impact;
  @override
  String get category;
  @override
  @JsonKey(ignore: true)
  _$$InvestmentHighlightImplCopyWith<_$InvestmentHighlightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
