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
  String? get tableTitle => throw _privateConstructorUsedError;
  String? get dataSource => throw _privateConstructorUsedError;
  Map<String, dynamic> get metadata => throw _privateConstructorUsedError;
  String get tableType =>
      throw _privateConstructorUsedError; // 'quarterly', 'annual', 'ratios', etc.
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  bool get isProcessed => throw _privateConstructorUsedError;

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
      String? tableTitle,
      String? dataSource,
      Map<String, dynamic> metadata,
      String tableType,
      DateTime? lastUpdated,
      bool isProcessed});
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
    Object? tableTitle = freezed,
    Object? dataSource = freezed,
    Object? metadata = null,
    Object? tableType = null,
    Object? lastUpdated = freezed,
    Object? isProcessed = null,
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
      tableTitle: freezed == tableTitle
          ? _value.tableTitle
          : tableTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      dataSource: freezed == dataSource
          ? _value.dataSource
          : dataSource // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      tableType: null == tableType
          ? _value.tableType
          : tableType // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isProcessed: null == isProcessed
          ? _value.isProcessed
          : isProcessed // ignore: cast_nullable_to_non_nullable
              as bool,
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
      String? tableTitle,
      String? dataSource,
      Map<String, dynamic> metadata,
      String tableType,
      DateTime? lastUpdated,
      bool isProcessed});
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
    Object? tableTitle = freezed,
    Object? dataSource = freezed,
    Object? metadata = null,
    Object? tableType = null,
    Object? lastUpdated = freezed,
    Object? isProcessed = null,
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
      tableTitle: freezed == tableTitle
          ? _value.tableTitle
          : tableTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      dataSource: freezed == dataSource
          ? _value.dataSource
          : dataSource // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: null == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      tableType: null == tableType
          ? _value.tableType
          : tableType // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isProcessed: null == isProcessed
          ? _value.isProcessed
          : isProcessed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialDataModelImpl
    with DiagnosticableTreeMixin
    implements _FinancialDataModel {
  const _$FinancialDataModelImpl(
      {final List<String> headers = const [],
      final List<FinancialDataRow> body = const [],
      this.tableTitle,
      this.dataSource,
      final Map<String, dynamic> metadata = const {},
      this.tableType = '',
      this.lastUpdated,
      this.isProcessed = false})
      : _headers = headers,
        _body = body,
        _metadata = metadata;

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
  final String? tableTitle;
  @override
  final String? dataSource;
  final Map<String, dynamic> _metadata;
  @override
  @JsonKey()
  Map<String, dynamic> get metadata {
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_metadata);
  }

  @override
  @JsonKey()
  final String tableType;
// 'quarterly', 'annual', 'ratios', etc.
  @override
  final DateTime? lastUpdated;
  @override
  @JsonKey()
  final bool isProcessed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FinancialDataModel(headers: $headers, body: $body, tableTitle: $tableTitle, dataSource: $dataSource, metadata: $metadata, tableType: $tableType, lastUpdated: $lastUpdated, isProcessed: $isProcessed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FinancialDataModel'))
      ..add(DiagnosticsProperty('headers', headers))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('tableTitle', tableTitle))
      ..add(DiagnosticsProperty('dataSource', dataSource))
      ..add(DiagnosticsProperty('metadata', metadata))
      ..add(DiagnosticsProperty('tableType', tableType))
      ..add(DiagnosticsProperty('lastUpdated', lastUpdated))
      ..add(DiagnosticsProperty('isProcessed', isProcessed));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialDataModelImpl &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            const DeepCollectionEquality().equals(other._body, _body) &&
            (identical(other.tableTitle, tableTitle) ||
                other.tableTitle == tableTitle) &&
            (identical(other.dataSource, dataSource) ||
                other.dataSource == dataSource) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.tableType, tableType) ||
                other.tableType == tableType) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.isProcessed, isProcessed) ||
                other.isProcessed == isProcessed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_headers),
      const DeepCollectionEquality().hash(_body),
      tableTitle,
      dataSource,
      const DeepCollectionEquality().hash(_metadata),
      tableType,
      lastUpdated,
      isProcessed);

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

abstract class _FinancialDataModel implements FinancialDataModel {
  const factory _FinancialDataModel(
      {final List<String> headers,
      final List<FinancialDataRow> body,
      final String? tableTitle,
      final String? dataSource,
      final Map<String, dynamic> metadata,
      final String tableType,
      final DateTime? lastUpdated,
      final bool isProcessed}) = _$FinancialDataModelImpl;

  factory _FinancialDataModel.fromJson(Map<String, dynamic> json) =
      _$FinancialDataModelImpl.fromJson;

  @override
  List<String> get headers;
  @override
  List<FinancialDataRow> get body;
  @override
  String? get tableTitle;
  @override
  String? get dataSource;
  @override
  Map<String, dynamic> get metadata;
  @override
  String get tableType;
  @override // 'quarterly', 'annual', 'ratios', etc.
  DateTime? get lastUpdated;
  @override
  bool get isProcessed;
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
  List<String> get values => throw _privateConstructorUsedError;
  Map<String, String> get additionalData => throw _privateConstructorUsedError;
  Map<String, double> get calculatedMetrics =>
      throw _privateConstructorUsedError;
  String? get category =>
      throw _privateConstructorUsedError; // 'revenue', 'expense', 'asset', 'liability', etc.
  bool get isKeyMetric => throw _privateConstructorUsedError;

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
      List<String> values,
      Map<String, String> additionalData,
      Map<String, double> calculatedMetrics,
      String? category,
      bool isKeyMetric});
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
    Object? additionalData = null,
    Object? calculatedMetrics = null,
    Object? category = freezed,
    Object? isKeyMetric = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
      additionalData: null == additionalData
          ? _value.additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      calculatedMetrics: null == calculatedMetrics
          ? _value.calculatedMetrics
          : calculatedMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isKeyMetric: null == isKeyMetric
          ? _value.isKeyMetric
          : isKeyMetric // ignore: cast_nullable_to_non_nullable
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
      List<String> values,
      Map<String, String> additionalData,
      Map<String, double> calculatedMetrics,
      String? category,
      bool isKeyMetric});
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
    Object? additionalData = null,
    Object? calculatedMetrics = null,
    Object? category = freezed,
    Object? isKeyMetric = null,
  }) {
    return _then(_$FinancialDataRowImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
      additionalData: null == additionalData
          ? _value._additionalData
          : additionalData // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      calculatedMetrics: null == calculatedMetrics
          ? _value._calculatedMetrics
          : calculatedMetrics // ignore: cast_nullable_to_non_nullable
              as Map<String, double>,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      isKeyMetric: null == isKeyMetric
          ? _value.isKeyMetric
          : isKeyMetric // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialDataRowImpl
    with DiagnosticableTreeMixin
    implements _FinancialDataRow {
  const _$FinancialDataRowImpl(
      {required this.description,
      final List<String> values = const [],
      final Map<String, String> additionalData = const {},
      final Map<String, double> calculatedMetrics = const {},
      this.category,
      this.isKeyMetric = false})
      : _values = values,
        _additionalData = additionalData,
        _calculatedMetrics = calculatedMetrics;

  factory _$FinancialDataRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialDataRowImplFromJson(json);

  @override
  final String description;
  final List<String> _values;
  @override
  @JsonKey()
  List<String> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  final Map<String, String> _additionalData;
  @override
  @JsonKey()
  Map<String, String> get additionalData {
    if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_additionalData);
  }

  final Map<String, double> _calculatedMetrics;
  @override
  @JsonKey()
  Map<String, double> get calculatedMetrics {
    if (_calculatedMetrics is EqualUnmodifiableMapView)
      return _calculatedMetrics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_calculatedMetrics);
  }

  @override
  final String? category;
// 'revenue', 'expense', 'asset', 'liability', etc.
  @override
  @JsonKey()
  final bool isKeyMetric;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FinancialDataRow(description: $description, values: $values, additionalData: $additionalData, calculatedMetrics: $calculatedMetrics, category: $category, isKeyMetric: $isKeyMetric)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FinancialDataRow'))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('values', values))
      ..add(DiagnosticsProperty('additionalData', additionalData))
      ..add(DiagnosticsProperty('calculatedMetrics', calculatedMetrics))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('isKeyMetric', isKeyMetric));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialDataRowImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._values, _values) &&
            const DeepCollectionEquality()
                .equals(other._additionalData, _additionalData) &&
            const DeepCollectionEquality()
                .equals(other._calculatedMetrics, _calculatedMetrics) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isKeyMetric, isKeyMetric) ||
                other.isKeyMetric == isKeyMetric));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      description,
      const DeepCollectionEquality().hash(_values),
      const DeepCollectionEquality().hash(_additionalData),
      const DeepCollectionEquality().hash(_calculatedMetrics),
      category,
      isKeyMetric);

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

abstract class _FinancialDataRow implements FinancialDataRow {
  const factory _FinancialDataRow(
      {required final String description,
      final List<String> values,
      final Map<String, String> additionalData,
      final Map<String, double> calculatedMetrics,
      final String? category,
      final bool isKeyMetric}) = _$FinancialDataRowImpl;

  factory _FinancialDataRow.fromJson(Map<String, dynamic> json) =
      _$FinancialDataRowImpl.fromJson;

  @override
  String get description;
  @override
  List<String> get values;
  @override
  Map<String, String> get additionalData;
  @override
  Map<String, double> get calculatedMetrics;
  @override
  String? get category;
  @override // 'revenue', 'expense', 'asset', 'liability', etc.
  bool get isKeyMetric;
  @override
  @JsonKey(ignore: true)
  _$$FinancialDataRowImplCopyWith<_$FinancialDataRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
