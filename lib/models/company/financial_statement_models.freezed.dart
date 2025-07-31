// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'financial_statement_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompanyFinancials _$CompanyFinancialsFromJson(Map<String, dynamic> json) {
  return _CompanyFinancials.fromJson(json);
}

/// @nodoc
mixin _$CompanyFinancials {
  FinancialDataModel? get quarterlyResults =>
      throw _privateConstructorUsedError;
  FinancialDataModel? get profitLossStatement =>
      throw _privateConstructorUsedError;
  FinancialDataModel? get balanceSheet => throw _privateConstructorUsedError;
  FinancialDataModel? get cashFlowStatement =>
      throw _privateConstructorUsedError;
  FinancialDataModel? get ratios => throw _privateConstructorUsedError;
  ShareholdingPattern? get shareholdingPattern =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get growthTables => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyFinancialsCopyWith<CompanyFinancials> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyFinancialsCopyWith<$Res> {
  factory $CompanyFinancialsCopyWith(
          CompanyFinancials value, $Res Function(CompanyFinancials) then) =
      _$CompanyFinancialsCopyWithImpl<$Res, CompanyFinancials>;
  @useResult
  $Res call(
      {FinancialDataModel? quarterlyResults,
      FinancialDataModel? profitLossStatement,
      FinancialDataModel? balanceSheet,
      FinancialDataModel? cashFlowStatement,
      FinancialDataModel? ratios,
      ShareholdingPattern? shareholdingPattern,
      Map<String, dynamic> growthTables});

  $FinancialDataModelCopyWith<$Res>? get quarterlyResults;
  $FinancialDataModelCopyWith<$Res>? get profitLossStatement;
  $FinancialDataModelCopyWith<$Res>? get balanceSheet;
  $FinancialDataModelCopyWith<$Res>? get cashFlowStatement;
  $FinancialDataModelCopyWith<$Res>? get ratios;
  $ShareholdingPatternCopyWith<$Res>? get shareholdingPattern;
}

/// @nodoc
class _$CompanyFinancialsCopyWithImpl<$Res, $Val extends CompanyFinancials>
    implements $CompanyFinancialsCopyWith<$Res> {
  _$CompanyFinancialsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quarterlyResults = freezed,
    Object? profitLossStatement = freezed,
    Object? balanceSheet = freezed,
    Object? cashFlowStatement = freezed,
    Object? ratios = freezed,
    Object? shareholdingPattern = freezed,
    Object? growthTables = null,
  }) {
    return _then(_value.copyWith(
      quarterlyResults: freezed == quarterlyResults
          ? _value.quarterlyResults
          : quarterlyResults // ignore: cast_nullable_to_non_nullable
              as FinancialDataModel?,
      profitLossStatement: freezed == profitLossStatement
          ? _value.profitLossStatement
          : profitLossStatement // ignore: cast_nullable_to_non_nullable
              as FinancialDataModel?,
      balanceSheet: freezed == balanceSheet
          ? _value.balanceSheet
          : balanceSheet // ignore: cast_nullable_to_non_nullable
              as FinancialDataModel?,
      cashFlowStatement: freezed == cashFlowStatement
          ? _value.cashFlowStatement
          : cashFlowStatement // ignore: cast_nullable_to_non_nullable
              as FinancialDataModel?,
      ratios: freezed == ratios
          ? _value.ratios
          : ratios // ignore: cast_nullable_to_non_nullable
              as FinancialDataModel?,
      shareholdingPattern: freezed == shareholdingPattern
          ? _value.shareholdingPattern
          : shareholdingPattern // ignore: cast_nullable_to_non_nullable
              as ShareholdingPattern?,
      growthTables: null == growthTables
          ? _value.growthTables
          : growthTables // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FinancialDataModelCopyWith<$Res>? get quarterlyResults {
    if (_value.quarterlyResults == null) {
      return null;
    }

    return $FinancialDataModelCopyWith<$Res>(_value.quarterlyResults!, (value) {
      return _then(_value.copyWith(quarterlyResults: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FinancialDataModelCopyWith<$Res>? get profitLossStatement {
    if (_value.profitLossStatement == null) {
      return null;
    }

    return $FinancialDataModelCopyWith<$Res>(_value.profitLossStatement!,
        (value) {
      return _then(_value.copyWith(profitLossStatement: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FinancialDataModelCopyWith<$Res>? get balanceSheet {
    if (_value.balanceSheet == null) {
      return null;
    }

    return $FinancialDataModelCopyWith<$Res>(_value.balanceSheet!, (value) {
      return _then(_value.copyWith(balanceSheet: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FinancialDataModelCopyWith<$Res>? get cashFlowStatement {
    if (_value.cashFlowStatement == null) {
      return null;
    }

    return $FinancialDataModelCopyWith<$Res>(_value.cashFlowStatement!,
        (value) {
      return _then(_value.copyWith(cashFlowStatement: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FinancialDataModelCopyWith<$Res>? get ratios {
    if (_value.ratios == null) {
      return null;
    }

    return $FinancialDataModelCopyWith<$Res>(_value.ratios!, (value) {
      return _then(_value.copyWith(ratios: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShareholdingPatternCopyWith<$Res>? get shareholdingPattern {
    if (_value.shareholdingPattern == null) {
      return null;
    }

    return $ShareholdingPatternCopyWith<$Res>(_value.shareholdingPattern!,
        (value) {
      return _then(_value.copyWith(shareholdingPattern: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CompanyFinancialsImplCopyWith<$Res>
    implements $CompanyFinancialsCopyWith<$Res> {
  factory _$$CompanyFinancialsImplCopyWith(_$CompanyFinancialsImpl value,
          $Res Function(_$CompanyFinancialsImpl) then) =
      __$$CompanyFinancialsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FinancialDataModel? quarterlyResults,
      FinancialDataModel? profitLossStatement,
      FinancialDataModel? balanceSheet,
      FinancialDataModel? cashFlowStatement,
      FinancialDataModel? ratios,
      ShareholdingPattern? shareholdingPattern,
      Map<String, dynamic> growthTables});

  @override
  $FinancialDataModelCopyWith<$Res>? get quarterlyResults;
  @override
  $FinancialDataModelCopyWith<$Res>? get profitLossStatement;
  @override
  $FinancialDataModelCopyWith<$Res>? get balanceSheet;
  @override
  $FinancialDataModelCopyWith<$Res>? get cashFlowStatement;
  @override
  $FinancialDataModelCopyWith<$Res>? get ratios;
  @override
  $ShareholdingPatternCopyWith<$Res>? get shareholdingPattern;
}

/// @nodoc
class __$$CompanyFinancialsImplCopyWithImpl<$Res>
    extends _$CompanyFinancialsCopyWithImpl<$Res, _$CompanyFinancialsImpl>
    implements _$$CompanyFinancialsImplCopyWith<$Res> {
  __$$CompanyFinancialsImplCopyWithImpl(_$CompanyFinancialsImpl _value,
      $Res Function(_$CompanyFinancialsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quarterlyResults = freezed,
    Object? profitLossStatement = freezed,
    Object? balanceSheet = freezed,
    Object? cashFlowStatement = freezed,
    Object? ratios = freezed,
    Object? shareholdingPattern = freezed,
    Object? growthTables = null,
  }) {
    return _then(_$CompanyFinancialsImpl(
      quarterlyResults: freezed == quarterlyResults
          ? _value.quarterlyResults
          : quarterlyResults // ignore: cast_nullable_to_non_nullable
              as FinancialDataModel?,
      profitLossStatement: freezed == profitLossStatement
          ? _value.profitLossStatement
          : profitLossStatement // ignore: cast_nullable_to_non_nullable
              as FinancialDataModel?,
      balanceSheet: freezed == balanceSheet
          ? _value.balanceSheet
          : balanceSheet // ignore: cast_nullable_to_non_nullable
              as FinancialDataModel?,
      cashFlowStatement: freezed == cashFlowStatement
          ? _value.cashFlowStatement
          : cashFlowStatement // ignore: cast_nullable_to_non_nullable
              as FinancialDataModel?,
      ratios: freezed == ratios
          ? _value.ratios
          : ratios // ignore: cast_nullable_to_non_nullable
              as FinancialDataModel?,
      shareholdingPattern: freezed == shareholdingPattern
          ? _value.shareholdingPattern
          : shareholdingPattern // ignore: cast_nullable_to_non_nullable
              as ShareholdingPattern?,
      growthTables: null == growthTables
          ? _value._growthTables
          : growthTables // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyFinancialsImpl implements _CompanyFinancials {
  const _$CompanyFinancialsImpl(
      {this.quarterlyResults,
      this.profitLossStatement,
      this.balanceSheet,
      this.cashFlowStatement,
      this.ratios,
      this.shareholdingPattern,
      final Map<String, dynamic> growthTables = const {}})
      : _growthTables = growthTables;

  factory _$CompanyFinancialsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyFinancialsImplFromJson(json);

  @override
  final FinancialDataModel? quarterlyResults;
  @override
  final FinancialDataModel? profitLossStatement;
  @override
  final FinancialDataModel? balanceSheet;
  @override
  final FinancialDataModel? cashFlowStatement;
  @override
  final FinancialDataModel? ratios;
  @override
  final ShareholdingPattern? shareholdingPattern;
  final Map<String, dynamic> _growthTables;
  @override
  @JsonKey()
  Map<String, dynamic> get growthTables {
    if (_growthTables is EqualUnmodifiableMapView) return _growthTables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_growthTables);
  }

  @override
  String toString() {
    return 'CompanyFinancials(quarterlyResults: $quarterlyResults, profitLossStatement: $profitLossStatement, balanceSheet: $balanceSheet, cashFlowStatement: $cashFlowStatement, ratios: $ratios, shareholdingPattern: $shareholdingPattern, growthTables: $growthTables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyFinancialsImpl &&
            (identical(other.quarterlyResults, quarterlyResults) ||
                other.quarterlyResults == quarterlyResults) &&
            (identical(other.profitLossStatement, profitLossStatement) ||
                other.profitLossStatement == profitLossStatement) &&
            (identical(other.balanceSheet, balanceSheet) ||
                other.balanceSheet == balanceSheet) &&
            (identical(other.cashFlowStatement, cashFlowStatement) ||
                other.cashFlowStatement == cashFlowStatement) &&
            (identical(other.ratios, ratios) || other.ratios == ratios) &&
            (identical(other.shareholdingPattern, shareholdingPattern) ||
                other.shareholdingPattern == shareholdingPattern) &&
            const DeepCollectionEquality()
                .equals(other._growthTables, _growthTables));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      quarterlyResults,
      profitLossStatement,
      balanceSheet,
      cashFlowStatement,
      ratios,
      shareholdingPattern,
      const DeepCollectionEquality().hash(_growthTables));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyFinancialsImplCopyWith<_$CompanyFinancialsImpl> get copyWith =>
      __$$CompanyFinancialsImplCopyWithImpl<_$CompanyFinancialsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyFinancialsImplToJson(
      this,
    );
  }
}

abstract class _CompanyFinancials implements CompanyFinancials {
  const factory _CompanyFinancials(
      {final FinancialDataModel? quarterlyResults,
      final FinancialDataModel? profitLossStatement,
      final FinancialDataModel? balanceSheet,
      final FinancialDataModel? cashFlowStatement,
      final FinancialDataModel? ratios,
      final ShareholdingPattern? shareholdingPattern,
      final Map<String, dynamic> growthTables}) = _$CompanyFinancialsImpl;

  factory _CompanyFinancials.fromJson(Map<String, dynamic> json) =
      _$CompanyFinancialsImpl.fromJson;

  @override
  FinancialDataModel? get quarterlyResults;
  @override
  FinancialDataModel? get profitLossStatement;
  @override
  FinancialDataModel? get balanceSheet;
  @override
  FinancialDataModel? get cashFlowStatement;
  @override
  FinancialDataModel? get ratios;
  @override
  ShareholdingPattern? get shareholdingPattern;
  @override
  Map<String, dynamic> get growthTables;
  @override
  @JsonKey(ignore: true)
  _$$CompanyFinancialsImplCopyWith<_$CompanyFinancialsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShareholdingPattern _$ShareholdingPatternFromJson(Map<String, dynamic> json) {
  return _ShareholdingPattern.fromJson(json);
}

/// @nodoc
mixin _$ShareholdingPattern {
  Map<String, Map<String, String>> get quarterly =>
      throw _privateConstructorUsedError;

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
  $Res call({Map<String, Map<String, String>> quarterly});
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
    Object? quarterly = null,
  }) {
    return _then(_value.copyWith(
      quarterly: null == quarterly
          ? _value.quarterly
          : quarterly // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
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
  $Res call({Map<String, Map<String, String>> quarterly});
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
    Object? quarterly = null,
  }) {
    return _then(_$ShareholdingPatternImpl(
      quarterly: null == quarterly
          ? _value._quarterly
          : quarterly // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShareholdingPatternImpl implements _ShareholdingPattern {
  const _$ShareholdingPatternImpl(
      {final Map<String, Map<String, String>> quarterly = const {}})
      : _quarterly = quarterly;

  factory _$ShareholdingPatternImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShareholdingPatternImplFromJson(json);

  final Map<String, Map<String, String>> _quarterly;
  @override
  @JsonKey()
  Map<String, Map<String, String>> get quarterly {
    if (_quarterly is EqualUnmodifiableMapView) return _quarterly;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_quarterly);
  }

  @override
  String toString() {
    return 'ShareholdingPattern(quarterly: $quarterly)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareholdingPatternImpl &&
            const DeepCollectionEquality()
                .equals(other._quarterly, _quarterly));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_quarterly));

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

abstract class _ShareholdingPattern implements ShareholdingPattern {
  const factory _ShareholdingPattern(
          {final Map<String, Map<String, String>> quarterly}) =
      _$ShareholdingPatternImpl;

  factory _ShareholdingPattern.fromJson(Map<String, dynamic> json) =
      _$ShareholdingPatternImpl.fromJson;

  @override
  Map<String, Map<String, String>> get quarterly;
  @override
  @JsonKey(ignore: true)
  _$$ShareholdingPatternImplCopyWith<_$ShareholdingPatternImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
