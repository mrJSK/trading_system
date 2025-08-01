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
  $Res call({List<String> headers, List<FinancialDataRow> body});
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
  $Res call({List<String> headers, List<FinancialDataRow> body});
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
      final List<FinancialDataRow> body = const []})
      : _headers = headers,
        _body = body;

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FinancialDataModel(headers: $headers, body: $body)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FinancialDataModel'))
      ..add(DiagnosticsProperty('headers', headers))
      ..add(DiagnosticsProperty('body', body));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialDataModelImpl &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            const DeepCollectionEquality().equals(other._body, _body));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_headers),
      const DeepCollectionEquality().hash(_body));

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
      final List<FinancialDataRow> body}) = _$FinancialDataModelImpl;

  factory _FinancialDataModel.fromJson(Map<String, dynamic> json) =
      _$FinancialDataModelImpl.fromJson;

  @override
  List<String> get headers;
  @override
  List<FinancialDataRow> get body;
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
  String get description =>
      throw _privateConstructorUsedError; // 🔥 FIXED: Uses default instead of required
  List<String> get values => throw _privateConstructorUsedError;

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
  $Res call({String description, List<String> values});
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
  $Res call({String description, List<String> values});
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FinancialDataRowImpl
    with DiagnosticableTreeMixin
    implements _FinancialDataRow {
  const _$FinancialDataRowImpl(
      {this.description = '', final List<String> values = const []})
      : _values = values;

  factory _$FinancialDataRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$FinancialDataRowImplFromJson(json);

  @override
  @JsonKey()
  final String description;
// 🔥 FIXED: Uses default instead of required
  final List<String> _values;
// 🔥 FIXED: Uses default instead of required
  @override
  @JsonKey()
  List<String> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FinancialDataRow(description: $description, values: $values)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FinancialDataRow'))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('values', values));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinancialDataRowImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, description, const DeepCollectionEquality().hash(_values));

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
      {final String description,
      final List<String> values}) = _$FinancialDataRowImpl;

  factory _FinancialDataRow.fromJson(Map<String, dynamic> json) =
      _$FinancialDataRowImpl.fromJson;

  @override
  String get description;
  @override // 🔥 FIXED: Uses default instead of required
  List<String> get values;
  @override
  @JsonKey(ignore: true)
  _$$FinancialDataRowImplCopyWith<_$FinancialDataRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
