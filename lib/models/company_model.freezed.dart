// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) {
  return _CompanyModel.fromJson(json);
}

/// @nodoc
mixin _$CompanyModel {
  String get symbol => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get about => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  String? get bseCode => throw _privateConstructorUsedError;
  String? get nseCode => throw _privateConstructorUsedError;
  double? get marketCap => throw _privateConstructorUsedError;
  double? get currentPrice => throw _privateConstructorUsedError;
  String? get highLow => throw _privateConstructorUsedError;
  double? get stockPe => throw _privateConstructorUsedError;
  double? get bookValue => throw _privateConstructorUsedError;
  double? get dividendYield => throw _privateConstructorUsedError;
  double? get roce => throw _privateConstructorUsedError;
  double? get roe => throw _privateConstructorUsedError;
  double? get faceValue => throw _privateConstructorUsedError;
  List<String> get pros => throw _privateConstructorUsedError;
  List<String> get cons =>
      throw _privateConstructorUsedError; // Firebase document timestamps
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // API data timestamp
  String get lastUpdated => throw _privateConstructorUsedError;
  double get changePercent => throw _privateConstructorUsedError;
  double get changeAmount => throw _privateConstructorUsedError;
  double get previousClose =>
      throw _privateConstructorUsedError; // Financial statements from your cloud functions
  FinancialDataModel? get quarterlyResults =>
      throw _privateConstructorUsedError;
  FinancialDataModel? get profitLossStatement =>
      throw _privateConstructorUsedError;
  FinancialDataModel? get balanceSheet => throw _privateConstructorUsedError;
  FinancialDataModel? get cashFlowStatement =>
      throw _privateConstructorUsedError;
  FinancialDataModel? get ratios =>
      throw _privateConstructorUsedError; // Industry and shareholding data
  List<String> get industryClassification => throw _privateConstructorUsedError;
  ShareholdingPattern? get shareholdingPattern =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get ratiosData => throw _privateConstructorUsedError;
  Map<String, Map<String, String>> get growthTables =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyModelCopyWith<CompanyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyModelCopyWith<$Res> {
  factory $CompanyModelCopyWith(
          CompanyModel value, $Res Function(CompanyModel) then) =
      _$CompanyModelCopyWithImpl<$Res, CompanyModel>;
  @useResult
  $Res call(
      {String symbol,
      String name,
      String displayName,
      String? about,
      String? website,
      String? bseCode,
      String? nseCode,
      double? marketCap,
      double? currentPrice,
      String? highLow,
      double? stockPe,
      double? bookValue,
      double? dividendYield,
      double? roce,
      double? roe,
      double? faceValue,
      List<String> pros,
      List<String> cons,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      String lastUpdated,
      double changePercent,
      double changeAmount,
      double previousClose,
      FinancialDataModel? quarterlyResults,
      FinancialDataModel? profitLossStatement,
      FinancialDataModel? balanceSheet,
      FinancialDataModel? cashFlowStatement,
      FinancialDataModel? ratios,
      List<String> industryClassification,
      ShareholdingPattern? shareholdingPattern,
      Map<String, dynamic> ratiosData,
      Map<String, Map<String, String>> growthTables});

  $FinancialDataModelCopyWith<$Res>? get quarterlyResults;
  $FinancialDataModelCopyWith<$Res>? get profitLossStatement;
  $FinancialDataModelCopyWith<$Res>? get balanceSheet;
  $FinancialDataModelCopyWith<$Res>? get cashFlowStatement;
  $FinancialDataModelCopyWith<$Res>? get ratios;
  $ShareholdingPatternCopyWith<$Res>? get shareholdingPattern;
}

/// @nodoc
class _$CompanyModelCopyWithImpl<$Res, $Val extends CompanyModel>
    implements $CompanyModelCopyWith<$Res> {
  _$CompanyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? name = null,
    Object? displayName = null,
    Object? about = freezed,
    Object? website = freezed,
    Object? bseCode = freezed,
    Object? nseCode = freezed,
    Object? marketCap = freezed,
    Object? currentPrice = freezed,
    Object? highLow = freezed,
    Object? stockPe = freezed,
    Object? bookValue = freezed,
    Object? dividendYield = freezed,
    Object? roce = freezed,
    Object? roe = freezed,
    Object? faceValue = freezed,
    Object? pros = null,
    Object? cons = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastUpdated = null,
    Object? changePercent = null,
    Object? changeAmount = null,
    Object? previousClose = null,
    Object? quarterlyResults = freezed,
    Object? profitLossStatement = freezed,
    Object? balanceSheet = freezed,
    Object? cashFlowStatement = freezed,
    Object? ratios = freezed,
    Object? industryClassification = null,
    Object? shareholdingPattern = freezed,
    Object? ratiosData = null,
    Object? growthTables = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      bseCode: freezed == bseCode
          ? _value.bseCode
          : bseCode // ignore: cast_nullable_to_non_nullable
              as String?,
      nseCode: freezed == nseCode
          ? _value.nseCode
          : nseCode // ignore: cast_nullable_to_non_nullable
              as String?,
      marketCap: freezed == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double?,
      currentPrice: freezed == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      highLow: freezed == highLow
          ? _value.highLow
          : highLow // ignore: cast_nullable_to_non_nullable
              as String?,
      stockPe: freezed == stockPe
          ? _value.stockPe
          : stockPe // ignore: cast_nullable_to_non_nullable
              as double?,
      bookValue: freezed == bookValue
          ? _value.bookValue
          : bookValue // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendYield: freezed == dividendYield
          ? _value.dividendYield
          : dividendYield // ignore: cast_nullable_to_non_nullable
              as double?,
      roce: freezed == roce
          ? _value.roce
          : roce // ignore: cast_nullable_to_non_nullable
              as double?,
      roe: freezed == roe
          ? _value.roe
          : roe // ignore: cast_nullable_to_non_nullable
              as double?,
      faceValue: freezed == faceValue
          ? _value.faceValue
          : faceValue // ignore: cast_nullable_to_non_nullable
              as double?,
      pros: null == pros
          ? _value.pros
          : pros // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cons: null == cons
          ? _value.cons
          : cons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
      changePercent: null == changePercent
          ? _value.changePercent
          : changePercent // ignore: cast_nullable_to_non_nullable
              as double,
      changeAmount: null == changeAmount
          ? _value.changeAmount
          : changeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      previousClose: null == previousClose
          ? _value.previousClose
          : previousClose // ignore: cast_nullable_to_non_nullable
              as double,
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
      industryClassification: null == industryClassification
          ? _value.industryClassification
          : industryClassification // ignore: cast_nullable_to_non_nullable
              as List<String>,
      shareholdingPattern: freezed == shareholdingPattern
          ? _value.shareholdingPattern
          : shareholdingPattern // ignore: cast_nullable_to_non_nullable
              as ShareholdingPattern?,
      ratiosData: null == ratiosData
          ? _value.ratiosData
          : ratiosData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      growthTables: null == growthTables
          ? _value.growthTables
          : growthTables // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
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
abstract class _$$CompanyModelImplCopyWith<$Res>
    implements $CompanyModelCopyWith<$Res> {
  factory _$$CompanyModelImplCopyWith(
          _$CompanyModelImpl value, $Res Function(_$CompanyModelImpl) then) =
      __$$CompanyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      String name,
      String displayName,
      String? about,
      String? website,
      String? bseCode,
      String? nseCode,
      double? marketCap,
      double? currentPrice,
      String? highLow,
      double? stockPe,
      double? bookValue,
      double? dividendYield,
      double? roce,
      double? roe,
      double? faceValue,
      List<String> pros,
      List<String> cons,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      String lastUpdated,
      double changePercent,
      double changeAmount,
      double previousClose,
      FinancialDataModel? quarterlyResults,
      FinancialDataModel? profitLossStatement,
      FinancialDataModel? balanceSheet,
      FinancialDataModel? cashFlowStatement,
      FinancialDataModel? ratios,
      List<String> industryClassification,
      ShareholdingPattern? shareholdingPattern,
      Map<String, dynamic> ratiosData,
      Map<String, Map<String, String>> growthTables});

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
class __$$CompanyModelImplCopyWithImpl<$Res>
    extends _$CompanyModelCopyWithImpl<$Res, _$CompanyModelImpl>
    implements _$$CompanyModelImplCopyWith<$Res> {
  __$$CompanyModelImplCopyWithImpl(
      _$CompanyModelImpl _value, $Res Function(_$CompanyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? name = null,
    Object? displayName = null,
    Object? about = freezed,
    Object? website = freezed,
    Object? bseCode = freezed,
    Object? nseCode = freezed,
    Object? marketCap = freezed,
    Object? currentPrice = freezed,
    Object? highLow = freezed,
    Object? stockPe = freezed,
    Object? bookValue = freezed,
    Object? dividendYield = freezed,
    Object? roce = freezed,
    Object? roe = freezed,
    Object? faceValue = freezed,
    Object? pros = null,
    Object? cons = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastUpdated = null,
    Object? changePercent = null,
    Object? changeAmount = null,
    Object? previousClose = null,
    Object? quarterlyResults = freezed,
    Object? profitLossStatement = freezed,
    Object? balanceSheet = freezed,
    Object? cashFlowStatement = freezed,
    Object? ratios = freezed,
    Object? industryClassification = null,
    Object? shareholdingPattern = freezed,
    Object? ratiosData = null,
    Object? growthTables = null,
  }) {
    return _then(_$CompanyModelImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      bseCode: freezed == bseCode
          ? _value.bseCode
          : bseCode // ignore: cast_nullable_to_non_nullable
              as String?,
      nseCode: freezed == nseCode
          ? _value.nseCode
          : nseCode // ignore: cast_nullable_to_non_nullable
              as String?,
      marketCap: freezed == marketCap
          ? _value.marketCap
          : marketCap // ignore: cast_nullable_to_non_nullable
              as double?,
      currentPrice: freezed == currentPrice
          ? _value.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      highLow: freezed == highLow
          ? _value.highLow
          : highLow // ignore: cast_nullable_to_non_nullable
              as String?,
      stockPe: freezed == stockPe
          ? _value.stockPe
          : stockPe // ignore: cast_nullable_to_non_nullable
              as double?,
      bookValue: freezed == bookValue
          ? _value.bookValue
          : bookValue // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendYield: freezed == dividendYield
          ? _value.dividendYield
          : dividendYield // ignore: cast_nullable_to_non_nullable
              as double?,
      roce: freezed == roce
          ? _value.roce
          : roce // ignore: cast_nullable_to_non_nullable
              as double?,
      roe: freezed == roe
          ? _value.roe
          : roe // ignore: cast_nullable_to_non_nullable
              as double?,
      faceValue: freezed == faceValue
          ? _value.faceValue
          : faceValue // ignore: cast_nullable_to_non_nullable
              as double?,
      pros: null == pros
          ? _value._pros
          : pros // ignore: cast_nullable_to_non_nullable
              as List<String>,
      cons: null == cons
          ? _value._cons
          : cons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as String,
      changePercent: null == changePercent
          ? _value.changePercent
          : changePercent // ignore: cast_nullable_to_non_nullable
              as double,
      changeAmount: null == changeAmount
          ? _value.changeAmount
          : changeAmount // ignore: cast_nullable_to_non_nullable
              as double,
      previousClose: null == previousClose
          ? _value.previousClose
          : previousClose // ignore: cast_nullable_to_non_nullable
              as double,
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
      industryClassification: null == industryClassification
          ? _value._industryClassification
          : industryClassification // ignore: cast_nullable_to_non_nullable
              as List<String>,
      shareholdingPattern: freezed == shareholdingPattern
          ? _value.shareholdingPattern
          : shareholdingPattern // ignore: cast_nullable_to_non_nullable
              as ShareholdingPattern?,
      ratiosData: null == ratiosData
          ? _value._ratiosData
          : ratiosData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      growthTables: null == growthTables
          ? _value._growthTables
          : growthTables // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyModelImpl extends _CompanyModel {
  const _$CompanyModelImpl(
      {required this.symbol,
      required this.name,
      required this.displayName,
      this.about,
      this.website,
      this.bseCode,
      this.nseCode,
      this.marketCap,
      this.currentPrice,
      this.highLow,
      this.stockPe,
      this.bookValue,
      this.dividendYield,
      this.roce,
      this.roe,
      this.faceValue,
      final List<String> pros = const [],
      final List<String> cons = const [],
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt,
      required this.lastUpdated,
      this.changePercent = 0.0,
      this.changeAmount = 0.0,
      this.previousClose = 0.0,
      this.quarterlyResults,
      this.profitLossStatement,
      this.balanceSheet,
      this.cashFlowStatement,
      this.ratios,
      final List<String> industryClassification = const [],
      this.shareholdingPattern,
      final Map<String, dynamic> ratiosData = const {},
      final Map<String, Map<String, String>> growthTables = const {}})
      : _pros = pros,
        _cons = cons,
        _industryClassification = industryClassification,
        _ratiosData = ratiosData,
        _growthTables = growthTables,
        super._();

  factory _$CompanyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyModelImplFromJson(json);

  @override
  final String symbol;
  @override
  final String name;
  @override
  final String displayName;
  @override
  final String? about;
  @override
  final String? website;
  @override
  final String? bseCode;
  @override
  final String? nseCode;
  @override
  final double? marketCap;
  @override
  final double? currentPrice;
  @override
  final String? highLow;
  @override
  final double? stockPe;
  @override
  final double? bookValue;
  @override
  final double? dividendYield;
  @override
  final double? roce;
  @override
  final double? roe;
  @override
  final double? faceValue;
  final List<String> _pros;
  @override
  @JsonKey()
  List<String> get pros {
    if (_pros is EqualUnmodifiableListView) return _pros;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pros);
  }

  final List<String> _cons;
  @override
  @JsonKey()
  List<String> get cons {
    if (_cons is EqualUnmodifiableListView) return _cons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cons);
  }

// Firebase document timestamps
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
// API data timestamp
  @override
  final String lastUpdated;
  @override
  @JsonKey()
  final double changePercent;
  @override
  @JsonKey()
  final double changeAmount;
  @override
  @JsonKey()
  final double previousClose;
// Financial statements from your cloud functions
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
// Industry and shareholding data
  final List<String> _industryClassification;
// Industry and shareholding data
  @override
  @JsonKey()
  List<String> get industryClassification {
    if (_industryClassification is EqualUnmodifiableListView)
      return _industryClassification;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_industryClassification);
  }

  @override
  final ShareholdingPattern? shareholdingPattern;
  final Map<String, dynamic> _ratiosData;
  @override
  @JsonKey()
  Map<String, dynamic> get ratiosData {
    if (_ratiosData is EqualUnmodifiableMapView) return _ratiosData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ratiosData);
  }

  final Map<String, Map<String, String>> _growthTables;
  @override
  @JsonKey()
  Map<String, Map<String, String>> get growthTables {
    if (_growthTables is EqualUnmodifiableMapView) return _growthTables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_growthTables);
  }

  @override
  String toString() {
    return 'CompanyModel(symbol: $symbol, name: $name, displayName: $displayName, about: $about, website: $website, bseCode: $bseCode, nseCode: $nseCode, marketCap: $marketCap, currentPrice: $currentPrice, highLow: $highLow, stockPe: $stockPe, bookValue: $bookValue, dividendYield: $dividendYield, roce: $roce, roe: $roe, faceValue: $faceValue, pros: $pros, cons: $cons, createdAt: $createdAt, updatedAt: $updatedAt, lastUpdated: $lastUpdated, changePercent: $changePercent, changeAmount: $changeAmount, previousClose: $previousClose, quarterlyResults: $quarterlyResults, profitLossStatement: $profitLossStatement, balanceSheet: $balanceSheet, cashFlowStatement: $cashFlowStatement, ratios: $ratios, industryClassification: $industryClassification, shareholdingPattern: $shareholdingPattern, ratiosData: $ratiosData, growthTables: $growthTables)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyModelImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.bseCode, bseCode) || other.bseCode == bseCode) &&
            (identical(other.nseCode, nseCode) || other.nseCode == nseCode) &&
            (identical(other.marketCap, marketCap) ||
                other.marketCap == marketCap) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.highLow, highLow) || other.highLow == highLow) &&
            (identical(other.stockPe, stockPe) || other.stockPe == stockPe) &&
            (identical(other.bookValue, bookValue) ||
                other.bookValue == bookValue) &&
            (identical(other.dividendYield, dividendYield) ||
                other.dividendYield == dividendYield) &&
            (identical(other.roce, roce) || other.roce == roce) &&
            (identical(other.roe, roe) || other.roe == roe) &&
            (identical(other.faceValue, faceValue) ||
                other.faceValue == faceValue) &&
            const DeepCollectionEquality().equals(other._pros, _pros) &&
            const DeepCollectionEquality().equals(other._cons, _cons) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.changePercent, changePercent) ||
                other.changePercent == changePercent) &&
            (identical(other.changeAmount, changeAmount) ||
                other.changeAmount == changeAmount) &&
            (identical(other.previousClose, previousClose) ||
                other.previousClose == previousClose) &&
            (identical(other.quarterlyResults, quarterlyResults) ||
                other.quarterlyResults == quarterlyResults) &&
            (identical(other.profitLossStatement, profitLossStatement) ||
                other.profitLossStatement == profitLossStatement) &&
            (identical(other.balanceSheet, balanceSheet) ||
                other.balanceSheet == balanceSheet) &&
            (identical(other.cashFlowStatement, cashFlowStatement) ||
                other.cashFlowStatement == cashFlowStatement) &&
            (identical(other.ratios, ratios) || other.ratios == ratios) &&
            const DeepCollectionEquality().equals(
                other._industryClassification, _industryClassification) &&
            (identical(other.shareholdingPattern, shareholdingPattern) ||
                other.shareholdingPattern == shareholdingPattern) &&
            const DeepCollectionEquality()
                .equals(other._ratiosData, _ratiosData) &&
            const DeepCollectionEquality()
                .equals(other._growthTables, _growthTables));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        symbol,
        name,
        displayName,
        about,
        website,
        bseCode,
        nseCode,
        marketCap,
        currentPrice,
        highLow,
        stockPe,
        bookValue,
        dividendYield,
        roce,
        roe,
        faceValue,
        const DeepCollectionEquality().hash(_pros),
        const DeepCollectionEquality().hash(_cons),
        createdAt,
        updatedAt,
        lastUpdated,
        changePercent,
        changeAmount,
        previousClose,
        quarterlyResults,
        profitLossStatement,
        balanceSheet,
        cashFlowStatement,
        ratios,
        const DeepCollectionEquality().hash(_industryClassification),
        shareholdingPattern,
        const DeepCollectionEquality().hash(_ratiosData),
        const DeepCollectionEquality().hash(_growthTables)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyModelImplCopyWith<_$CompanyModelImpl> get copyWith =>
      __$$CompanyModelImplCopyWithImpl<_$CompanyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyModelImplToJson(
      this,
    );
  }
}

abstract class _CompanyModel extends CompanyModel {
  const factory _CompanyModel(
          {required final String symbol,
          required final String name,
          required final String displayName,
          final String? about,
          final String? website,
          final String? bseCode,
          final String? nseCode,
          final double? marketCap,
          final double? currentPrice,
          final String? highLow,
          final double? stockPe,
          final double? bookValue,
          final double? dividendYield,
          final double? roce,
          final double? roe,
          final double? faceValue,
          final List<String> pros,
          final List<String> cons,
          @TimestampConverter() final DateTime? createdAt,
          @TimestampConverter() final DateTime? updatedAt,
          required final String lastUpdated,
          final double changePercent,
          final double changeAmount,
          final double previousClose,
          final FinancialDataModel? quarterlyResults,
          final FinancialDataModel? profitLossStatement,
          final FinancialDataModel? balanceSheet,
          final FinancialDataModel? cashFlowStatement,
          final FinancialDataModel? ratios,
          final List<String> industryClassification,
          final ShareholdingPattern? shareholdingPattern,
          final Map<String, dynamic> ratiosData,
          final Map<String, Map<String, String>> growthTables}) =
      _$CompanyModelImpl;
  const _CompanyModel._() : super._();

  factory _CompanyModel.fromJson(Map<String, dynamic> json) =
      _$CompanyModelImpl.fromJson;

  @override
  String get symbol;
  @override
  String get name;
  @override
  String get displayName;
  @override
  String? get about;
  @override
  String? get website;
  @override
  String? get bseCode;
  @override
  String? get nseCode;
  @override
  double? get marketCap;
  @override
  double? get currentPrice;
  @override
  String? get highLow;
  @override
  double? get stockPe;
  @override
  double? get bookValue;
  @override
  double? get dividendYield;
  @override
  double? get roce;
  @override
  double? get roe;
  @override
  double? get faceValue;
  @override
  List<String> get pros;
  @override
  List<String> get cons;
  @override // Firebase document timestamps
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override // API data timestamp
  String get lastUpdated;
  @override
  double get changePercent;
  @override
  double get changeAmount;
  @override
  double get previousClose;
  @override // Financial statements from your cloud functions
  FinancialDataModel? get quarterlyResults;
  @override
  FinancialDataModel? get profitLossStatement;
  @override
  FinancialDataModel? get balanceSheet;
  @override
  FinancialDataModel? get cashFlowStatement;
  @override
  FinancialDataModel? get ratios;
  @override // Industry and shareholding data
  List<String> get industryClassification;
  @override
  ShareholdingPattern? get shareholdingPattern;
  @override
  Map<String, dynamic> get ratiosData;
  @override
  Map<String, Map<String, String>> get growthTables;
  @override
  @JsonKey(ignore: true)
  _$$CompanyModelImplCopyWith<_$CompanyModelImpl> get copyWith =>
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
