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
      throw _privateConstructorUsedError; // 🔥 CRITICAL FIX: Enhanced Financial statements with JsonConverter annotations
  @FinancialDataModelConverter()
  FinancialDataModel? get quarterlyResults =>
      throw _privateConstructorUsedError;
  @FinancialDataModelConverter()
  FinancialDataModel? get profitLossStatement =>
      throw _privateConstructorUsedError;
  @FinancialDataModelConverter()
  FinancialDataModel? get balanceSheet => throw _privateConstructorUsedError;
  @FinancialDataModelConverter()
  FinancialDataModel? get cashFlowStatement =>
      throw _privateConstructorUsedError;
  @FinancialDataModelConverter()
  FinancialDataModel? get ratios =>
      throw _privateConstructorUsedError; // Additional financial metrics
  double? get debtToEquity => throw _privateConstructorUsedError;
  double? get currentRatio => throw _privateConstructorUsedError;
  double? get quickRatio => throw _privateConstructorUsedError;
  double? get interestCoverage => throw _privateConstructorUsedError;
  double? get assetTurnover => throw _privateConstructorUsedError;
  double? get inventoryTurnover => throw _privateConstructorUsedError;
  double? get receivablesTurnover => throw _privateConstructorUsedError;
  double? get payablesTurnover => throw _privateConstructorUsedError;
  double? get workingCapital => throw _privateConstructorUsedError;
  double? get enterpriseValue => throw _privateConstructorUsedError;
  double? get evEbitda => throw _privateConstructorUsedError;
  double? get priceToBook => throw _privateConstructorUsedError;
  double? get priceToSales => throw _privateConstructorUsedError;
  double? get pegRatio => throw _privateConstructorUsedError;
  double? get betaValue => throw _privateConstructorUsedError; // Growth metrics
  double? get salesGrowth1Y => throw _privateConstructorUsedError;
  double? get salesGrowth3Y => throw _privateConstructorUsedError;
  double? get salesGrowth5Y => throw _privateConstructorUsedError;
  double? get profitGrowth1Y => throw _privateConstructorUsedError;
  double? get profitGrowth3Y => throw _privateConstructorUsedError;
  double? get profitGrowth5Y => throw _privateConstructorUsedError;
  double? get salesCAGR3Y => throw _privateConstructorUsedError;
  double? get salesCAGR5Y => throw _privateConstructorUsedError;
  double? get profitCAGR3Y => throw _privateConstructorUsedError;
  double? get profitCAGR5Y =>
      throw _privateConstructorUsedError; // Valuation and quality scores
  double? get piotroskiScore => throw _privateConstructorUsedError;
  double? get altmanZScore => throw _privateConstructorUsedError;
  String? get creditRating =>
      throw _privateConstructorUsedError; // Industry and shareholding data
  String? get sector => throw _privateConstructorUsedError;
  String? get industry => throw _privateConstructorUsedError;
  List<String> get industryClassification => throw _privateConstructorUsedError;
  @ShareholdingPatternConverter()
  ShareholdingPattern? get shareholdingPattern =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get ratiosData => throw _privateConstructorUsedError;
  Map<String, Map<String, String>> get growthTables =>
      throw _privateConstructorUsedError; // Historical data
  List<QuarterlyData> get quarterlyDataHistory =>
      throw _privateConstructorUsedError;
  List<AnnualData> get annualDataHistory =>
      throw _privateConstructorUsedError; // Peer comparison
  List<String> get peerCompanies => throw _privateConstructorUsedError;
  double? get sectorPE => throw _privateConstructorUsedError;
  double? get sectorROE => throw _privateConstructorUsedError;
  double? get sectorDebtToEquity =>
      throw _privateConstructorUsedError; // Dividend information
  double? get dividendPerShare => throw _privateConstructorUsedError;
  String? get dividendFrequency => throw _privateConstructorUsedError;
  List<DividendHistory> get dividendHistory =>
      throw _privateConstructorUsedError; // Management and governance
  List<String> get keyManagement => throw _privateConstructorUsedError;
  double? get promoterHolding => throw _privateConstructorUsedError;
  double? get institutionalHolding => throw _privateConstructorUsedError;
  double? get publicHolding =>
      throw _privateConstructorUsedError; // Risk metrics
  double? get volatility30D => throw _privateConstructorUsedError;
  double? get volatility1Y => throw _privateConstructorUsedError;
  double? get maxDrawdown => throw _privateConstructorUsedError;
  double? get sharpeRatio => throw _privateConstructorUsedError; // Market data
  double? get marketCapCategory => throw _privateConstructorUsedError;
  bool? get isIndexConstituent => throw _privateConstructorUsedError;
  List<String> get indices =>
      throw _privateConstructorUsedError; // Technical indicators
  double? get rsi => throw _privateConstructorUsedError;
  double? get sma50 => throw _privateConstructorUsedError;
  double? get sma200 => throw _privateConstructorUsedError;
  double? get ema12 => throw _privateConstructorUsedError;
  double? get ema26 => throw _privateConstructorUsedError; // Fundamental flags
  bool get isDebtFree => throw _privateConstructorUsedError;
  bool get isProfitable => throw _privateConstructorUsedError;
  bool get hasConsistentProfits => throw _privateConstructorUsedError;
  bool get paysDividends => throw _privateConstructorUsedError;
  bool get isGrowthStock => throw _privateConstructorUsedError;
  bool get isValueStock => throw _privateConstructorUsedError;
  bool get isQualityStock => throw _privateConstructorUsedError;

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
      @FinancialDataModelConverter() FinancialDataModel? quarterlyResults,
      @FinancialDataModelConverter() FinancialDataModel? profitLossStatement,
      @FinancialDataModelConverter() FinancialDataModel? balanceSheet,
      @FinancialDataModelConverter() FinancialDataModel? cashFlowStatement,
      @FinancialDataModelConverter() FinancialDataModel? ratios,
      double? debtToEquity,
      double? currentRatio,
      double? quickRatio,
      double? interestCoverage,
      double? assetTurnover,
      double? inventoryTurnover,
      double? receivablesTurnover,
      double? payablesTurnover,
      double? workingCapital,
      double? enterpriseValue,
      double? evEbitda,
      double? priceToBook,
      double? priceToSales,
      double? pegRatio,
      double? betaValue,
      double? salesGrowth1Y,
      double? salesGrowth3Y,
      double? salesGrowth5Y,
      double? profitGrowth1Y,
      double? profitGrowth3Y,
      double? profitGrowth5Y,
      double? salesCAGR3Y,
      double? salesCAGR5Y,
      double? profitCAGR3Y,
      double? profitCAGR5Y,
      double? piotroskiScore,
      double? altmanZScore,
      String? creditRating,
      String? sector,
      String? industry,
      List<String> industryClassification,
      @ShareholdingPatternConverter() ShareholdingPattern? shareholdingPattern,
      Map<String, dynamic> ratiosData,
      Map<String, Map<String, String>> growthTables,
      List<QuarterlyData> quarterlyDataHistory,
      List<AnnualData> annualDataHistory,
      List<String> peerCompanies,
      double? sectorPE,
      double? sectorROE,
      double? sectorDebtToEquity,
      double? dividendPerShare,
      String? dividendFrequency,
      List<DividendHistory> dividendHistory,
      List<String> keyManagement,
      double? promoterHolding,
      double? institutionalHolding,
      double? publicHolding,
      double? volatility30D,
      double? volatility1Y,
      double? maxDrawdown,
      double? sharpeRatio,
      double? marketCapCategory,
      bool? isIndexConstituent,
      List<String> indices,
      double? rsi,
      double? sma50,
      double? sma200,
      double? ema12,
      double? ema26,
      bool isDebtFree,
      bool isProfitable,
      bool hasConsistentProfits,
      bool paysDividends,
      bool isGrowthStock,
      bool isValueStock,
      bool isQualityStock});

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
    Object? debtToEquity = freezed,
    Object? currentRatio = freezed,
    Object? quickRatio = freezed,
    Object? interestCoverage = freezed,
    Object? assetTurnover = freezed,
    Object? inventoryTurnover = freezed,
    Object? receivablesTurnover = freezed,
    Object? payablesTurnover = freezed,
    Object? workingCapital = freezed,
    Object? enterpriseValue = freezed,
    Object? evEbitda = freezed,
    Object? priceToBook = freezed,
    Object? priceToSales = freezed,
    Object? pegRatio = freezed,
    Object? betaValue = freezed,
    Object? salesGrowth1Y = freezed,
    Object? salesGrowth3Y = freezed,
    Object? salesGrowth5Y = freezed,
    Object? profitGrowth1Y = freezed,
    Object? profitGrowth3Y = freezed,
    Object? profitGrowth5Y = freezed,
    Object? salesCAGR3Y = freezed,
    Object? salesCAGR5Y = freezed,
    Object? profitCAGR3Y = freezed,
    Object? profitCAGR5Y = freezed,
    Object? piotroskiScore = freezed,
    Object? altmanZScore = freezed,
    Object? creditRating = freezed,
    Object? sector = freezed,
    Object? industry = freezed,
    Object? industryClassification = null,
    Object? shareholdingPattern = freezed,
    Object? ratiosData = null,
    Object? growthTables = null,
    Object? quarterlyDataHistory = null,
    Object? annualDataHistory = null,
    Object? peerCompanies = null,
    Object? sectorPE = freezed,
    Object? sectorROE = freezed,
    Object? sectorDebtToEquity = freezed,
    Object? dividendPerShare = freezed,
    Object? dividendFrequency = freezed,
    Object? dividendHistory = null,
    Object? keyManagement = null,
    Object? promoterHolding = freezed,
    Object? institutionalHolding = freezed,
    Object? publicHolding = freezed,
    Object? volatility30D = freezed,
    Object? volatility1Y = freezed,
    Object? maxDrawdown = freezed,
    Object? sharpeRatio = freezed,
    Object? marketCapCategory = freezed,
    Object? isIndexConstituent = freezed,
    Object? indices = null,
    Object? rsi = freezed,
    Object? sma50 = freezed,
    Object? sma200 = freezed,
    Object? ema12 = freezed,
    Object? ema26 = freezed,
    Object? isDebtFree = null,
    Object? isProfitable = null,
    Object? hasConsistentProfits = null,
    Object? paysDividends = null,
    Object? isGrowthStock = null,
    Object? isValueStock = null,
    Object? isQualityStock = null,
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
      debtToEquity: freezed == debtToEquity
          ? _value.debtToEquity
          : debtToEquity // ignore: cast_nullable_to_non_nullable
              as double?,
      currentRatio: freezed == currentRatio
          ? _value.currentRatio
          : currentRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      quickRatio: freezed == quickRatio
          ? _value.quickRatio
          : quickRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      interestCoverage: freezed == interestCoverage
          ? _value.interestCoverage
          : interestCoverage // ignore: cast_nullable_to_non_nullable
              as double?,
      assetTurnover: freezed == assetTurnover
          ? _value.assetTurnover
          : assetTurnover // ignore: cast_nullable_to_non_nullable
              as double?,
      inventoryTurnover: freezed == inventoryTurnover
          ? _value.inventoryTurnover
          : inventoryTurnover // ignore: cast_nullable_to_non_nullable
              as double?,
      receivablesTurnover: freezed == receivablesTurnover
          ? _value.receivablesTurnover
          : receivablesTurnover // ignore: cast_nullable_to_non_nullable
              as double?,
      payablesTurnover: freezed == payablesTurnover
          ? _value.payablesTurnover
          : payablesTurnover // ignore: cast_nullable_to_non_nullable
              as double?,
      workingCapital: freezed == workingCapital
          ? _value.workingCapital
          : workingCapital // ignore: cast_nullable_to_non_nullable
              as double?,
      enterpriseValue: freezed == enterpriseValue
          ? _value.enterpriseValue
          : enterpriseValue // ignore: cast_nullable_to_non_nullable
              as double?,
      evEbitda: freezed == evEbitda
          ? _value.evEbitda
          : evEbitda // ignore: cast_nullable_to_non_nullable
              as double?,
      priceToBook: freezed == priceToBook
          ? _value.priceToBook
          : priceToBook // ignore: cast_nullable_to_non_nullable
              as double?,
      priceToSales: freezed == priceToSales
          ? _value.priceToSales
          : priceToSales // ignore: cast_nullable_to_non_nullable
              as double?,
      pegRatio: freezed == pegRatio
          ? _value.pegRatio
          : pegRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      betaValue: freezed == betaValue
          ? _value.betaValue
          : betaValue // ignore: cast_nullable_to_non_nullable
              as double?,
      salesGrowth1Y: freezed == salesGrowth1Y
          ? _value.salesGrowth1Y
          : salesGrowth1Y // ignore: cast_nullable_to_non_nullable
              as double?,
      salesGrowth3Y: freezed == salesGrowth3Y
          ? _value.salesGrowth3Y
          : salesGrowth3Y // ignore: cast_nullable_to_non_nullable
              as double?,
      salesGrowth5Y: freezed == salesGrowth5Y
          ? _value.salesGrowth5Y
          : salesGrowth5Y // ignore: cast_nullable_to_non_nullable
              as double?,
      profitGrowth1Y: freezed == profitGrowth1Y
          ? _value.profitGrowth1Y
          : profitGrowth1Y // ignore: cast_nullable_to_non_nullable
              as double?,
      profitGrowth3Y: freezed == profitGrowth3Y
          ? _value.profitGrowth3Y
          : profitGrowth3Y // ignore: cast_nullable_to_non_nullable
              as double?,
      profitGrowth5Y: freezed == profitGrowth5Y
          ? _value.profitGrowth5Y
          : profitGrowth5Y // ignore: cast_nullable_to_non_nullable
              as double?,
      salesCAGR3Y: freezed == salesCAGR3Y
          ? _value.salesCAGR3Y
          : salesCAGR3Y // ignore: cast_nullable_to_non_nullable
              as double?,
      salesCAGR5Y: freezed == salesCAGR5Y
          ? _value.salesCAGR5Y
          : salesCAGR5Y // ignore: cast_nullable_to_non_nullable
              as double?,
      profitCAGR3Y: freezed == profitCAGR3Y
          ? _value.profitCAGR3Y
          : profitCAGR3Y // ignore: cast_nullable_to_non_nullable
              as double?,
      profitCAGR5Y: freezed == profitCAGR5Y
          ? _value.profitCAGR5Y
          : profitCAGR5Y // ignore: cast_nullable_to_non_nullable
              as double?,
      piotroskiScore: freezed == piotroskiScore
          ? _value.piotroskiScore
          : piotroskiScore // ignore: cast_nullable_to_non_nullable
              as double?,
      altmanZScore: freezed == altmanZScore
          ? _value.altmanZScore
          : altmanZScore // ignore: cast_nullable_to_non_nullable
              as double?,
      creditRating: freezed == creditRating
          ? _value.creditRating
          : creditRating // ignore: cast_nullable_to_non_nullable
              as String?,
      sector: freezed == sector
          ? _value.sector
          : sector // ignore: cast_nullable_to_non_nullable
              as String?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String?,
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
      quarterlyDataHistory: null == quarterlyDataHistory
          ? _value.quarterlyDataHistory
          : quarterlyDataHistory // ignore: cast_nullable_to_non_nullable
              as List<QuarterlyData>,
      annualDataHistory: null == annualDataHistory
          ? _value.annualDataHistory
          : annualDataHistory // ignore: cast_nullable_to_non_nullable
              as List<AnnualData>,
      peerCompanies: null == peerCompanies
          ? _value.peerCompanies
          : peerCompanies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sectorPE: freezed == sectorPE
          ? _value.sectorPE
          : sectorPE // ignore: cast_nullable_to_non_nullable
              as double?,
      sectorROE: freezed == sectorROE
          ? _value.sectorROE
          : sectorROE // ignore: cast_nullable_to_non_nullable
              as double?,
      sectorDebtToEquity: freezed == sectorDebtToEquity
          ? _value.sectorDebtToEquity
          : sectorDebtToEquity // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendPerShare: freezed == dividendPerShare
          ? _value.dividendPerShare
          : dividendPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendFrequency: freezed == dividendFrequency
          ? _value.dividendFrequency
          : dividendFrequency // ignore: cast_nullable_to_non_nullable
              as String?,
      dividendHistory: null == dividendHistory
          ? _value.dividendHistory
          : dividendHistory // ignore: cast_nullable_to_non_nullable
              as List<DividendHistory>,
      keyManagement: null == keyManagement
          ? _value.keyManagement
          : keyManagement // ignore: cast_nullable_to_non_nullable
              as List<String>,
      promoterHolding: freezed == promoterHolding
          ? _value.promoterHolding
          : promoterHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      institutionalHolding: freezed == institutionalHolding
          ? _value.institutionalHolding
          : institutionalHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      publicHolding: freezed == publicHolding
          ? _value.publicHolding
          : publicHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      volatility30D: freezed == volatility30D
          ? _value.volatility30D
          : volatility30D // ignore: cast_nullable_to_non_nullable
              as double?,
      volatility1Y: freezed == volatility1Y
          ? _value.volatility1Y
          : volatility1Y // ignore: cast_nullable_to_non_nullable
              as double?,
      maxDrawdown: freezed == maxDrawdown
          ? _value.maxDrawdown
          : maxDrawdown // ignore: cast_nullable_to_non_nullable
              as double?,
      sharpeRatio: freezed == sharpeRatio
          ? _value.sharpeRatio
          : sharpeRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      marketCapCategory: freezed == marketCapCategory
          ? _value.marketCapCategory
          : marketCapCategory // ignore: cast_nullable_to_non_nullable
              as double?,
      isIndexConstituent: freezed == isIndexConstituent
          ? _value.isIndexConstituent
          : isIndexConstituent // ignore: cast_nullable_to_non_nullable
              as bool?,
      indices: null == indices
          ? _value.indices
          : indices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rsi: freezed == rsi
          ? _value.rsi
          : rsi // ignore: cast_nullable_to_non_nullable
              as double?,
      sma50: freezed == sma50
          ? _value.sma50
          : sma50 // ignore: cast_nullable_to_non_nullable
              as double?,
      sma200: freezed == sma200
          ? _value.sma200
          : sma200 // ignore: cast_nullable_to_non_nullable
              as double?,
      ema12: freezed == ema12
          ? _value.ema12
          : ema12 // ignore: cast_nullable_to_non_nullable
              as double?,
      ema26: freezed == ema26
          ? _value.ema26
          : ema26 // ignore: cast_nullable_to_non_nullable
              as double?,
      isDebtFree: null == isDebtFree
          ? _value.isDebtFree
          : isDebtFree // ignore: cast_nullable_to_non_nullable
              as bool,
      isProfitable: null == isProfitable
          ? _value.isProfitable
          : isProfitable // ignore: cast_nullable_to_non_nullable
              as bool,
      hasConsistentProfits: null == hasConsistentProfits
          ? _value.hasConsistentProfits
          : hasConsistentProfits // ignore: cast_nullable_to_non_nullable
              as bool,
      paysDividends: null == paysDividends
          ? _value.paysDividends
          : paysDividends // ignore: cast_nullable_to_non_nullable
              as bool,
      isGrowthStock: null == isGrowthStock
          ? _value.isGrowthStock
          : isGrowthStock // ignore: cast_nullable_to_non_nullable
              as bool,
      isValueStock: null == isValueStock
          ? _value.isValueStock
          : isValueStock // ignore: cast_nullable_to_non_nullable
              as bool,
      isQualityStock: null == isQualityStock
          ? _value.isQualityStock
          : isQualityStock // ignore: cast_nullable_to_non_nullable
              as bool,
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
      @FinancialDataModelConverter() FinancialDataModel? quarterlyResults,
      @FinancialDataModelConverter() FinancialDataModel? profitLossStatement,
      @FinancialDataModelConverter() FinancialDataModel? balanceSheet,
      @FinancialDataModelConverter() FinancialDataModel? cashFlowStatement,
      @FinancialDataModelConverter() FinancialDataModel? ratios,
      double? debtToEquity,
      double? currentRatio,
      double? quickRatio,
      double? interestCoverage,
      double? assetTurnover,
      double? inventoryTurnover,
      double? receivablesTurnover,
      double? payablesTurnover,
      double? workingCapital,
      double? enterpriseValue,
      double? evEbitda,
      double? priceToBook,
      double? priceToSales,
      double? pegRatio,
      double? betaValue,
      double? salesGrowth1Y,
      double? salesGrowth3Y,
      double? salesGrowth5Y,
      double? profitGrowth1Y,
      double? profitGrowth3Y,
      double? profitGrowth5Y,
      double? salesCAGR3Y,
      double? salesCAGR5Y,
      double? profitCAGR3Y,
      double? profitCAGR5Y,
      double? piotroskiScore,
      double? altmanZScore,
      String? creditRating,
      String? sector,
      String? industry,
      List<String> industryClassification,
      @ShareholdingPatternConverter() ShareholdingPattern? shareholdingPattern,
      Map<String, dynamic> ratiosData,
      Map<String, Map<String, String>> growthTables,
      List<QuarterlyData> quarterlyDataHistory,
      List<AnnualData> annualDataHistory,
      List<String> peerCompanies,
      double? sectorPE,
      double? sectorROE,
      double? sectorDebtToEquity,
      double? dividendPerShare,
      String? dividendFrequency,
      List<DividendHistory> dividendHistory,
      List<String> keyManagement,
      double? promoterHolding,
      double? institutionalHolding,
      double? publicHolding,
      double? volatility30D,
      double? volatility1Y,
      double? maxDrawdown,
      double? sharpeRatio,
      double? marketCapCategory,
      bool? isIndexConstituent,
      List<String> indices,
      double? rsi,
      double? sma50,
      double? sma200,
      double? ema12,
      double? ema26,
      bool isDebtFree,
      bool isProfitable,
      bool hasConsistentProfits,
      bool paysDividends,
      bool isGrowthStock,
      bool isValueStock,
      bool isQualityStock});

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
    Object? debtToEquity = freezed,
    Object? currentRatio = freezed,
    Object? quickRatio = freezed,
    Object? interestCoverage = freezed,
    Object? assetTurnover = freezed,
    Object? inventoryTurnover = freezed,
    Object? receivablesTurnover = freezed,
    Object? payablesTurnover = freezed,
    Object? workingCapital = freezed,
    Object? enterpriseValue = freezed,
    Object? evEbitda = freezed,
    Object? priceToBook = freezed,
    Object? priceToSales = freezed,
    Object? pegRatio = freezed,
    Object? betaValue = freezed,
    Object? salesGrowth1Y = freezed,
    Object? salesGrowth3Y = freezed,
    Object? salesGrowth5Y = freezed,
    Object? profitGrowth1Y = freezed,
    Object? profitGrowth3Y = freezed,
    Object? profitGrowth5Y = freezed,
    Object? salesCAGR3Y = freezed,
    Object? salesCAGR5Y = freezed,
    Object? profitCAGR3Y = freezed,
    Object? profitCAGR5Y = freezed,
    Object? piotroskiScore = freezed,
    Object? altmanZScore = freezed,
    Object? creditRating = freezed,
    Object? sector = freezed,
    Object? industry = freezed,
    Object? industryClassification = null,
    Object? shareholdingPattern = freezed,
    Object? ratiosData = null,
    Object? growthTables = null,
    Object? quarterlyDataHistory = null,
    Object? annualDataHistory = null,
    Object? peerCompanies = null,
    Object? sectorPE = freezed,
    Object? sectorROE = freezed,
    Object? sectorDebtToEquity = freezed,
    Object? dividendPerShare = freezed,
    Object? dividendFrequency = freezed,
    Object? dividendHistory = null,
    Object? keyManagement = null,
    Object? promoterHolding = freezed,
    Object? institutionalHolding = freezed,
    Object? publicHolding = freezed,
    Object? volatility30D = freezed,
    Object? volatility1Y = freezed,
    Object? maxDrawdown = freezed,
    Object? sharpeRatio = freezed,
    Object? marketCapCategory = freezed,
    Object? isIndexConstituent = freezed,
    Object? indices = null,
    Object? rsi = freezed,
    Object? sma50 = freezed,
    Object? sma200 = freezed,
    Object? ema12 = freezed,
    Object? ema26 = freezed,
    Object? isDebtFree = null,
    Object? isProfitable = null,
    Object? hasConsistentProfits = null,
    Object? paysDividends = null,
    Object? isGrowthStock = null,
    Object? isValueStock = null,
    Object? isQualityStock = null,
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
      debtToEquity: freezed == debtToEquity
          ? _value.debtToEquity
          : debtToEquity // ignore: cast_nullable_to_non_nullable
              as double?,
      currentRatio: freezed == currentRatio
          ? _value.currentRatio
          : currentRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      quickRatio: freezed == quickRatio
          ? _value.quickRatio
          : quickRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      interestCoverage: freezed == interestCoverage
          ? _value.interestCoverage
          : interestCoverage // ignore: cast_nullable_to_non_nullable
              as double?,
      assetTurnover: freezed == assetTurnover
          ? _value.assetTurnover
          : assetTurnover // ignore: cast_nullable_to_non_nullable
              as double?,
      inventoryTurnover: freezed == inventoryTurnover
          ? _value.inventoryTurnover
          : inventoryTurnover // ignore: cast_nullable_to_non_nullable
              as double?,
      receivablesTurnover: freezed == receivablesTurnover
          ? _value.receivablesTurnover
          : receivablesTurnover // ignore: cast_nullable_to_non_nullable
              as double?,
      payablesTurnover: freezed == payablesTurnover
          ? _value.payablesTurnover
          : payablesTurnover // ignore: cast_nullable_to_non_nullable
              as double?,
      workingCapital: freezed == workingCapital
          ? _value.workingCapital
          : workingCapital // ignore: cast_nullable_to_non_nullable
              as double?,
      enterpriseValue: freezed == enterpriseValue
          ? _value.enterpriseValue
          : enterpriseValue // ignore: cast_nullable_to_non_nullable
              as double?,
      evEbitda: freezed == evEbitda
          ? _value.evEbitda
          : evEbitda // ignore: cast_nullable_to_non_nullable
              as double?,
      priceToBook: freezed == priceToBook
          ? _value.priceToBook
          : priceToBook // ignore: cast_nullable_to_non_nullable
              as double?,
      priceToSales: freezed == priceToSales
          ? _value.priceToSales
          : priceToSales // ignore: cast_nullable_to_non_nullable
              as double?,
      pegRatio: freezed == pegRatio
          ? _value.pegRatio
          : pegRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      betaValue: freezed == betaValue
          ? _value.betaValue
          : betaValue // ignore: cast_nullable_to_non_nullable
              as double?,
      salesGrowth1Y: freezed == salesGrowth1Y
          ? _value.salesGrowth1Y
          : salesGrowth1Y // ignore: cast_nullable_to_non_nullable
              as double?,
      salesGrowth3Y: freezed == salesGrowth3Y
          ? _value.salesGrowth3Y
          : salesGrowth3Y // ignore: cast_nullable_to_non_nullable
              as double?,
      salesGrowth5Y: freezed == salesGrowth5Y
          ? _value.salesGrowth5Y
          : salesGrowth5Y // ignore: cast_nullable_to_non_nullable
              as double?,
      profitGrowth1Y: freezed == profitGrowth1Y
          ? _value.profitGrowth1Y
          : profitGrowth1Y // ignore: cast_nullable_to_non_nullable
              as double?,
      profitGrowth3Y: freezed == profitGrowth3Y
          ? _value.profitGrowth3Y
          : profitGrowth3Y // ignore: cast_nullable_to_non_nullable
              as double?,
      profitGrowth5Y: freezed == profitGrowth5Y
          ? _value.profitGrowth5Y
          : profitGrowth5Y // ignore: cast_nullable_to_non_nullable
              as double?,
      salesCAGR3Y: freezed == salesCAGR3Y
          ? _value.salesCAGR3Y
          : salesCAGR3Y // ignore: cast_nullable_to_non_nullable
              as double?,
      salesCAGR5Y: freezed == salesCAGR5Y
          ? _value.salesCAGR5Y
          : salesCAGR5Y // ignore: cast_nullable_to_non_nullable
              as double?,
      profitCAGR3Y: freezed == profitCAGR3Y
          ? _value.profitCAGR3Y
          : profitCAGR3Y // ignore: cast_nullable_to_non_nullable
              as double?,
      profitCAGR5Y: freezed == profitCAGR5Y
          ? _value.profitCAGR5Y
          : profitCAGR5Y // ignore: cast_nullable_to_non_nullable
              as double?,
      piotroskiScore: freezed == piotroskiScore
          ? _value.piotroskiScore
          : piotroskiScore // ignore: cast_nullable_to_non_nullable
              as double?,
      altmanZScore: freezed == altmanZScore
          ? _value.altmanZScore
          : altmanZScore // ignore: cast_nullable_to_non_nullable
              as double?,
      creditRating: freezed == creditRating
          ? _value.creditRating
          : creditRating // ignore: cast_nullable_to_non_nullable
              as String?,
      sector: freezed == sector
          ? _value.sector
          : sector // ignore: cast_nullable_to_non_nullable
              as String?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String?,
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
      quarterlyDataHistory: null == quarterlyDataHistory
          ? _value._quarterlyDataHistory
          : quarterlyDataHistory // ignore: cast_nullable_to_non_nullable
              as List<QuarterlyData>,
      annualDataHistory: null == annualDataHistory
          ? _value._annualDataHistory
          : annualDataHistory // ignore: cast_nullable_to_non_nullable
              as List<AnnualData>,
      peerCompanies: null == peerCompanies
          ? _value._peerCompanies
          : peerCompanies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      sectorPE: freezed == sectorPE
          ? _value.sectorPE
          : sectorPE // ignore: cast_nullable_to_non_nullable
              as double?,
      sectorROE: freezed == sectorROE
          ? _value.sectorROE
          : sectorROE // ignore: cast_nullable_to_non_nullable
              as double?,
      sectorDebtToEquity: freezed == sectorDebtToEquity
          ? _value.sectorDebtToEquity
          : sectorDebtToEquity // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendPerShare: freezed == dividendPerShare
          ? _value.dividendPerShare
          : dividendPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendFrequency: freezed == dividendFrequency
          ? _value.dividendFrequency
          : dividendFrequency // ignore: cast_nullable_to_non_nullable
              as String?,
      dividendHistory: null == dividendHistory
          ? _value._dividendHistory
          : dividendHistory // ignore: cast_nullable_to_non_nullable
              as List<DividendHistory>,
      keyManagement: null == keyManagement
          ? _value._keyManagement
          : keyManagement // ignore: cast_nullable_to_non_nullable
              as List<String>,
      promoterHolding: freezed == promoterHolding
          ? _value.promoterHolding
          : promoterHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      institutionalHolding: freezed == institutionalHolding
          ? _value.institutionalHolding
          : institutionalHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      publicHolding: freezed == publicHolding
          ? _value.publicHolding
          : publicHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      volatility30D: freezed == volatility30D
          ? _value.volatility30D
          : volatility30D // ignore: cast_nullable_to_non_nullable
              as double?,
      volatility1Y: freezed == volatility1Y
          ? _value.volatility1Y
          : volatility1Y // ignore: cast_nullable_to_non_nullable
              as double?,
      maxDrawdown: freezed == maxDrawdown
          ? _value.maxDrawdown
          : maxDrawdown // ignore: cast_nullable_to_non_nullable
              as double?,
      sharpeRatio: freezed == sharpeRatio
          ? _value.sharpeRatio
          : sharpeRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      marketCapCategory: freezed == marketCapCategory
          ? _value.marketCapCategory
          : marketCapCategory // ignore: cast_nullable_to_non_nullable
              as double?,
      isIndexConstituent: freezed == isIndexConstituent
          ? _value.isIndexConstituent
          : isIndexConstituent // ignore: cast_nullable_to_non_nullable
              as bool?,
      indices: null == indices
          ? _value._indices
          : indices // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rsi: freezed == rsi
          ? _value.rsi
          : rsi // ignore: cast_nullable_to_non_nullable
              as double?,
      sma50: freezed == sma50
          ? _value.sma50
          : sma50 // ignore: cast_nullable_to_non_nullable
              as double?,
      sma200: freezed == sma200
          ? _value.sma200
          : sma200 // ignore: cast_nullable_to_non_nullable
              as double?,
      ema12: freezed == ema12
          ? _value.ema12
          : ema12 // ignore: cast_nullable_to_non_nullable
              as double?,
      ema26: freezed == ema26
          ? _value.ema26
          : ema26 // ignore: cast_nullable_to_non_nullable
              as double?,
      isDebtFree: null == isDebtFree
          ? _value.isDebtFree
          : isDebtFree // ignore: cast_nullable_to_non_nullable
              as bool,
      isProfitable: null == isProfitable
          ? _value.isProfitable
          : isProfitable // ignore: cast_nullable_to_non_nullable
              as bool,
      hasConsistentProfits: null == hasConsistentProfits
          ? _value.hasConsistentProfits
          : hasConsistentProfits // ignore: cast_nullable_to_non_nullable
              as bool,
      paysDividends: null == paysDividends
          ? _value.paysDividends
          : paysDividends // ignore: cast_nullable_to_non_nullable
              as bool,
      isGrowthStock: null == isGrowthStock
          ? _value.isGrowthStock
          : isGrowthStock // ignore: cast_nullable_to_non_nullable
              as bool,
      isValueStock: null == isValueStock
          ? _value.isValueStock
          : isValueStock // ignore: cast_nullable_to_non_nullable
              as bool,
      isQualityStock: null == isQualityStock
          ? _value.isQualityStock
          : isQualityStock // ignore: cast_nullable_to_non_nullable
              as bool,
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
      @FinancialDataModelConverter() this.quarterlyResults,
      @FinancialDataModelConverter() this.profitLossStatement,
      @FinancialDataModelConverter() this.balanceSheet,
      @FinancialDataModelConverter() this.cashFlowStatement,
      @FinancialDataModelConverter() this.ratios,
      this.debtToEquity,
      this.currentRatio,
      this.quickRatio,
      this.interestCoverage,
      this.assetTurnover,
      this.inventoryTurnover,
      this.receivablesTurnover,
      this.payablesTurnover,
      this.workingCapital,
      this.enterpriseValue,
      this.evEbitda,
      this.priceToBook,
      this.priceToSales,
      this.pegRatio,
      this.betaValue,
      this.salesGrowth1Y,
      this.salesGrowth3Y,
      this.salesGrowth5Y,
      this.profitGrowth1Y,
      this.profitGrowth3Y,
      this.profitGrowth5Y,
      this.salesCAGR3Y,
      this.salesCAGR5Y,
      this.profitCAGR3Y,
      this.profitCAGR5Y,
      this.piotroskiScore,
      this.altmanZScore,
      this.creditRating,
      this.sector,
      this.industry,
      final List<String> industryClassification = const [],
      @ShareholdingPatternConverter() this.shareholdingPattern,
      final Map<String, dynamic> ratiosData = const {},
      final Map<String, Map<String, String>> growthTables = const {},
      final List<QuarterlyData> quarterlyDataHistory = const [],
      final List<AnnualData> annualDataHistory = const [],
      final List<String> peerCompanies = const [],
      this.sectorPE,
      this.sectorROE,
      this.sectorDebtToEquity,
      this.dividendPerShare,
      this.dividendFrequency,
      final List<DividendHistory> dividendHistory = const [],
      final List<String> keyManagement = const [],
      this.promoterHolding,
      this.institutionalHolding,
      this.publicHolding,
      this.volatility30D,
      this.volatility1Y,
      this.maxDrawdown,
      this.sharpeRatio,
      this.marketCapCategory,
      this.isIndexConstituent,
      final List<String> indices = const [],
      this.rsi,
      this.sma50,
      this.sma200,
      this.ema12,
      this.ema26,
      this.isDebtFree = false,
      this.isProfitable = false,
      this.hasConsistentProfits = false,
      this.paysDividends = false,
      this.isGrowthStock = false,
      this.isValueStock = false,
      this.isQualityStock = false})
      : _pros = pros,
        _cons = cons,
        _industryClassification = industryClassification,
        _ratiosData = ratiosData,
        _growthTables = growthTables,
        _quarterlyDataHistory = quarterlyDataHistory,
        _annualDataHistory = annualDataHistory,
        _peerCompanies = peerCompanies,
        _dividendHistory = dividendHistory,
        _keyManagement = keyManagement,
        _indices = indices,
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
// 🔥 CRITICAL FIX: Enhanced Financial statements with JsonConverter annotations
  @override
  @FinancialDataModelConverter()
  final FinancialDataModel? quarterlyResults;
  @override
  @FinancialDataModelConverter()
  final FinancialDataModel? profitLossStatement;
  @override
  @FinancialDataModelConverter()
  final FinancialDataModel? balanceSheet;
  @override
  @FinancialDataModelConverter()
  final FinancialDataModel? cashFlowStatement;
  @override
  @FinancialDataModelConverter()
  final FinancialDataModel? ratios;
// Additional financial metrics
  @override
  final double? debtToEquity;
  @override
  final double? currentRatio;
  @override
  final double? quickRatio;
  @override
  final double? interestCoverage;
  @override
  final double? assetTurnover;
  @override
  final double? inventoryTurnover;
  @override
  final double? receivablesTurnover;
  @override
  final double? payablesTurnover;
  @override
  final double? workingCapital;
  @override
  final double? enterpriseValue;
  @override
  final double? evEbitda;
  @override
  final double? priceToBook;
  @override
  final double? priceToSales;
  @override
  final double? pegRatio;
  @override
  final double? betaValue;
// Growth metrics
  @override
  final double? salesGrowth1Y;
  @override
  final double? salesGrowth3Y;
  @override
  final double? salesGrowth5Y;
  @override
  final double? profitGrowth1Y;
  @override
  final double? profitGrowth3Y;
  @override
  final double? profitGrowth5Y;
  @override
  final double? salesCAGR3Y;
  @override
  final double? salesCAGR5Y;
  @override
  final double? profitCAGR3Y;
  @override
  final double? profitCAGR5Y;
// Valuation and quality scores
  @override
  final double? piotroskiScore;
  @override
  final double? altmanZScore;
  @override
  final String? creditRating;
// Industry and shareholding data
  @override
  final String? sector;
  @override
  final String? industry;
  final List<String> _industryClassification;
  @override
  @JsonKey()
  List<String> get industryClassification {
    if (_industryClassification is EqualUnmodifiableListView)
      return _industryClassification;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_industryClassification);
  }

  @override
  @ShareholdingPatternConverter()
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

// Historical data
  final List<QuarterlyData> _quarterlyDataHistory;
// Historical data
  @override
  @JsonKey()
  List<QuarterlyData> get quarterlyDataHistory {
    if (_quarterlyDataHistory is EqualUnmodifiableListView)
      return _quarterlyDataHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_quarterlyDataHistory);
  }

  final List<AnnualData> _annualDataHistory;
  @override
  @JsonKey()
  List<AnnualData> get annualDataHistory {
    if (_annualDataHistory is EqualUnmodifiableListView)
      return _annualDataHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_annualDataHistory);
  }

// Peer comparison
  final List<String> _peerCompanies;
// Peer comparison
  @override
  @JsonKey()
  List<String> get peerCompanies {
    if (_peerCompanies is EqualUnmodifiableListView) return _peerCompanies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_peerCompanies);
  }

  @override
  final double? sectorPE;
  @override
  final double? sectorROE;
  @override
  final double? sectorDebtToEquity;
// Dividend information
  @override
  final double? dividendPerShare;
  @override
  final String? dividendFrequency;
  final List<DividendHistory> _dividendHistory;
  @override
  @JsonKey()
  List<DividendHistory> get dividendHistory {
    if (_dividendHistory is EqualUnmodifiableListView) return _dividendHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dividendHistory);
  }

// Management and governance
  final List<String> _keyManagement;
// Management and governance
  @override
  @JsonKey()
  List<String> get keyManagement {
    if (_keyManagement is EqualUnmodifiableListView) return _keyManagement;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keyManagement);
  }

  @override
  final double? promoterHolding;
  @override
  final double? institutionalHolding;
  @override
  final double? publicHolding;
// Risk metrics
  @override
  final double? volatility30D;
  @override
  final double? volatility1Y;
  @override
  final double? maxDrawdown;
  @override
  final double? sharpeRatio;
// Market data
  @override
  final double? marketCapCategory;
  @override
  final bool? isIndexConstituent;
  final List<String> _indices;
  @override
  @JsonKey()
  List<String> get indices {
    if (_indices is EqualUnmodifiableListView) return _indices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_indices);
  }

// Technical indicators
  @override
  final double? rsi;
  @override
  final double? sma50;
  @override
  final double? sma200;
  @override
  final double? ema12;
  @override
  final double? ema26;
// Fundamental flags
  @override
  @JsonKey()
  final bool isDebtFree;
  @override
  @JsonKey()
  final bool isProfitable;
  @override
  @JsonKey()
  final bool hasConsistentProfits;
  @override
  @JsonKey()
  final bool paysDividends;
  @override
  @JsonKey()
  final bool isGrowthStock;
  @override
  @JsonKey()
  final bool isValueStock;
  @override
  @JsonKey()
  final bool isQualityStock;

  @override
  String toString() {
    return 'CompanyModel(symbol: $symbol, name: $name, displayName: $displayName, about: $about, website: $website, bseCode: $bseCode, nseCode: $nseCode, marketCap: $marketCap, currentPrice: $currentPrice, highLow: $highLow, stockPe: $stockPe, bookValue: $bookValue, dividendYield: $dividendYield, roce: $roce, roe: $roe, faceValue: $faceValue, pros: $pros, cons: $cons, createdAt: $createdAt, updatedAt: $updatedAt, lastUpdated: $lastUpdated, changePercent: $changePercent, changeAmount: $changeAmount, previousClose: $previousClose, quarterlyResults: $quarterlyResults, profitLossStatement: $profitLossStatement, balanceSheet: $balanceSheet, cashFlowStatement: $cashFlowStatement, ratios: $ratios, debtToEquity: $debtToEquity, currentRatio: $currentRatio, quickRatio: $quickRatio, interestCoverage: $interestCoverage, assetTurnover: $assetTurnover, inventoryTurnover: $inventoryTurnover, receivablesTurnover: $receivablesTurnover, payablesTurnover: $payablesTurnover, workingCapital: $workingCapital, enterpriseValue: $enterpriseValue, evEbitda: $evEbitda, priceToBook: $priceToBook, priceToSales: $priceToSales, pegRatio: $pegRatio, betaValue: $betaValue, salesGrowth1Y: $salesGrowth1Y, salesGrowth3Y: $salesGrowth3Y, salesGrowth5Y: $salesGrowth5Y, profitGrowth1Y: $profitGrowth1Y, profitGrowth3Y: $profitGrowth3Y, profitGrowth5Y: $profitGrowth5Y, salesCAGR3Y: $salesCAGR3Y, salesCAGR5Y: $salesCAGR5Y, profitCAGR3Y: $profitCAGR3Y, profitCAGR5Y: $profitCAGR5Y, piotroskiScore: $piotroskiScore, altmanZScore: $altmanZScore, creditRating: $creditRating, sector: $sector, industry: $industry, industryClassification: $industryClassification, shareholdingPattern: $shareholdingPattern, ratiosData: $ratiosData, growthTables: $growthTables, quarterlyDataHistory: $quarterlyDataHistory, annualDataHistory: $annualDataHistory, peerCompanies: $peerCompanies, sectorPE: $sectorPE, sectorROE: $sectorROE, sectorDebtToEquity: $sectorDebtToEquity, dividendPerShare: $dividendPerShare, dividendFrequency: $dividendFrequency, dividendHistory: $dividendHistory, keyManagement: $keyManagement, promoterHolding: $promoterHolding, institutionalHolding: $institutionalHolding, publicHolding: $publicHolding, volatility30D: $volatility30D, volatility1Y: $volatility1Y, maxDrawdown: $maxDrawdown, sharpeRatio: $sharpeRatio, marketCapCategory: $marketCapCategory, isIndexConstituent: $isIndexConstituent, indices: $indices, rsi: $rsi, sma50: $sma50, sma200: $sma200, ema12: $ema12, ema26: $ema26, isDebtFree: $isDebtFree, isProfitable: $isProfitable, hasConsistentProfits: $hasConsistentProfits, paysDividends: $paysDividends, isGrowthStock: $isGrowthStock, isValueStock: $isValueStock, isQualityStock: $isQualityStock)';
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
            (identical(other.debtToEquity, debtToEquity) ||
                other.debtToEquity == debtToEquity) &&
            (identical(other.currentRatio, currentRatio) ||
                other.currentRatio == currentRatio) &&
            (identical(other.quickRatio, quickRatio) ||
                other.quickRatio == quickRatio) &&
            (identical(other.interestCoverage, interestCoverage) ||
                other.interestCoverage == interestCoverage) &&
            (identical(other.assetTurnover, assetTurnover) ||
                other.assetTurnover == assetTurnover) &&
            (identical(other.inventoryTurnover, inventoryTurnover) ||
                other.inventoryTurnover == inventoryTurnover) &&
            (identical(other.receivablesTurnover, receivablesTurnover) ||
                other.receivablesTurnover == receivablesTurnover) &&
            (identical(other.payablesTurnover, payablesTurnover) ||
                other.payablesTurnover == payablesTurnover) &&
            (identical(other.workingCapital, workingCapital) ||
                other.workingCapital == workingCapital) &&
            (identical(other.enterpriseValue, enterpriseValue) ||
                other.enterpriseValue == enterpriseValue) &&
            (identical(other.evEbitda, evEbitda) ||
                other.evEbitda == evEbitda) &&
            (identical(other.priceToBook, priceToBook) ||
                other.priceToBook == priceToBook) &&
            (identical(other.priceToSales, priceToSales) ||
                other.priceToSales == priceToSales) &&
            (identical(other.pegRatio, pegRatio) ||
                other.pegRatio == pegRatio) &&
            (identical(other.betaValue, betaValue) ||
                other.betaValue == betaValue) &&
            (identical(other.salesGrowth1Y, salesGrowth1Y) ||
                other.salesGrowth1Y == salesGrowth1Y) &&
            (identical(other.salesGrowth3Y, salesGrowth3Y) ||
                other.salesGrowth3Y == salesGrowth3Y) &&
            (identical(other.salesGrowth5Y, salesGrowth5Y) ||
                other.salesGrowth5Y == salesGrowth5Y) &&
            (identical(other.profitGrowth1Y, profitGrowth1Y) ||
                other.profitGrowth1Y == profitGrowth1Y) &&
            (identical(other.profitGrowth3Y, profitGrowth3Y) ||
                other.profitGrowth3Y == profitGrowth3Y) &&
            (identical(other.profitGrowth5Y, profitGrowth5Y) ||
                other.profitGrowth5Y == profitGrowth5Y) &&
            (identical(other.salesCAGR3Y, salesCAGR3Y) ||
                other.salesCAGR3Y == salesCAGR3Y) &&
            (identical(other.salesCAGR5Y, salesCAGR5Y) ||
                other.salesCAGR5Y == salesCAGR5Y) &&
            (identical(other.profitCAGR3Y, profitCAGR3Y) ||
                other.profitCAGR3Y == profitCAGR3Y) &&
            (identical(other.profitCAGR5Y, profitCAGR5Y) ||
                other.profitCAGR5Y == profitCAGR5Y) &&
            (identical(other.piotroskiScore, piotroskiScore) ||
                other.piotroskiScore == piotroskiScore) &&
            (identical(other.altmanZScore, altmanZScore) ||
                other.altmanZScore == altmanZScore) &&
            (identical(other.creditRating, creditRating) || other.creditRating == creditRating) &&
            (identical(other.sector, sector) || other.sector == sector) &&
            (identical(other.industry, industry) || other.industry == industry) &&
            const DeepCollectionEquality().equals(other._industryClassification, _industryClassification) &&
            (identical(other.shareholdingPattern, shareholdingPattern) || other.shareholdingPattern == shareholdingPattern) &&
            const DeepCollectionEquality().equals(other._ratiosData, _ratiosData) &&
            const DeepCollectionEquality().equals(other._growthTables, _growthTables) &&
            const DeepCollectionEquality().equals(other._quarterlyDataHistory, _quarterlyDataHistory) &&
            const DeepCollectionEquality().equals(other._annualDataHistory, _annualDataHistory) &&
            const DeepCollectionEquality().equals(other._peerCompanies, _peerCompanies) &&
            (identical(other.sectorPE, sectorPE) || other.sectorPE == sectorPE) &&
            (identical(other.sectorROE, sectorROE) || other.sectorROE == sectorROE) &&
            (identical(other.sectorDebtToEquity, sectorDebtToEquity) || other.sectorDebtToEquity == sectorDebtToEquity) &&
            (identical(other.dividendPerShare, dividendPerShare) || other.dividendPerShare == dividendPerShare) &&
            (identical(other.dividendFrequency, dividendFrequency) || other.dividendFrequency == dividendFrequency) &&
            const DeepCollectionEquality().equals(other._dividendHistory, _dividendHistory) &&
            const DeepCollectionEquality().equals(other._keyManagement, _keyManagement) &&
            (identical(other.promoterHolding, promoterHolding) || other.promoterHolding == promoterHolding) &&
            (identical(other.institutionalHolding, institutionalHolding) || other.institutionalHolding == institutionalHolding) &&
            (identical(other.publicHolding, publicHolding) || other.publicHolding == publicHolding) &&
            (identical(other.volatility30D, volatility30D) || other.volatility30D == volatility30D) &&
            (identical(other.volatility1Y, volatility1Y) || other.volatility1Y == volatility1Y) &&
            (identical(other.maxDrawdown, maxDrawdown) || other.maxDrawdown == maxDrawdown) &&
            (identical(other.sharpeRatio, sharpeRatio) || other.sharpeRatio == sharpeRatio) &&
            (identical(other.marketCapCategory, marketCapCategory) || other.marketCapCategory == marketCapCategory) &&
            (identical(other.isIndexConstituent, isIndexConstituent) || other.isIndexConstituent == isIndexConstituent) &&
            const DeepCollectionEquality().equals(other._indices, _indices) &&
            (identical(other.rsi, rsi) || other.rsi == rsi) &&
            (identical(other.sma50, sma50) || other.sma50 == sma50) &&
            (identical(other.sma200, sma200) || other.sma200 == sma200) &&
            (identical(other.ema12, ema12) || other.ema12 == ema12) &&
            (identical(other.ema26, ema26) || other.ema26 == ema26) &&
            (identical(other.isDebtFree, isDebtFree) || other.isDebtFree == isDebtFree) &&
            (identical(other.isProfitable, isProfitable) || other.isProfitable == isProfitable) &&
            (identical(other.hasConsistentProfits, hasConsistentProfits) || other.hasConsistentProfits == hasConsistentProfits) &&
            (identical(other.paysDividends, paysDividends) || other.paysDividends == paysDividends) &&
            (identical(other.isGrowthStock, isGrowthStock) || other.isGrowthStock == isGrowthStock) &&
            (identical(other.isValueStock, isValueStock) || other.isValueStock == isValueStock) &&
            (identical(other.isQualityStock, isQualityStock) || other.isQualityStock == isQualityStock));
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
        debtToEquity,
        currentRatio,
        quickRatio,
        interestCoverage,
        assetTurnover,
        inventoryTurnover,
        receivablesTurnover,
        payablesTurnover,
        workingCapital,
        enterpriseValue,
        evEbitda,
        priceToBook,
        priceToSales,
        pegRatio,
        betaValue,
        salesGrowth1Y,
        salesGrowth3Y,
        salesGrowth5Y,
        profitGrowth1Y,
        profitGrowth3Y,
        profitGrowth5Y,
        salesCAGR3Y,
        salesCAGR5Y,
        profitCAGR3Y,
        profitCAGR5Y,
        piotroskiScore,
        altmanZScore,
        creditRating,
        sector,
        industry,
        const DeepCollectionEquality().hash(_industryClassification),
        shareholdingPattern,
        const DeepCollectionEquality().hash(_ratiosData),
        const DeepCollectionEquality().hash(_growthTables),
        const DeepCollectionEquality().hash(_quarterlyDataHistory),
        const DeepCollectionEquality().hash(_annualDataHistory),
        const DeepCollectionEquality().hash(_peerCompanies),
        sectorPE,
        sectorROE,
        sectorDebtToEquity,
        dividendPerShare,
        dividendFrequency,
        const DeepCollectionEquality().hash(_dividendHistory),
        const DeepCollectionEquality().hash(_keyManagement),
        promoterHolding,
        institutionalHolding,
        publicHolding,
        volatility30D,
        volatility1Y,
        maxDrawdown,
        sharpeRatio,
        marketCapCategory,
        isIndexConstituent,
        const DeepCollectionEquality().hash(_indices),
        rsi,
        sma50,
        sma200,
        ema12,
        ema26,
        isDebtFree,
        isProfitable,
        hasConsistentProfits,
        paysDividends,
        isGrowthStock,
        isValueStock,
        isQualityStock
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
      @FinancialDataModelConverter() final FinancialDataModel? quarterlyResults,
      @FinancialDataModelConverter()
      final FinancialDataModel? profitLossStatement,
      @FinancialDataModelConverter() final FinancialDataModel? balanceSheet,
      @FinancialDataModelConverter()
      final FinancialDataModel? cashFlowStatement,
      @FinancialDataModelConverter() final FinancialDataModel? ratios,
      final double? debtToEquity,
      final double? currentRatio,
      final double? quickRatio,
      final double? interestCoverage,
      final double? assetTurnover,
      final double? inventoryTurnover,
      final double? receivablesTurnover,
      final double? payablesTurnover,
      final double? workingCapital,
      final double? enterpriseValue,
      final double? evEbitda,
      final double? priceToBook,
      final double? priceToSales,
      final double? pegRatio,
      final double? betaValue,
      final double? salesGrowth1Y,
      final double? salesGrowth3Y,
      final double? salesGrowth5Y,
      final double? profitGrowth1Y,
      final double? profitGrowth3Y,
      final double? profitGrowth5Y,
      final double? salesCAGR3Y,
      final double? salesCAGR5Y,
      final double? profitCAGR3Y,
      final double? profitCAGR5Y,
      final double? piotroskiScore,
      final double? altmanZScore,
      final String? creditRating,
      final String? sector,
      final String? industry,
      final List<String> industryClassification,
      @ShareholdingPatternConverter()
      final ShareholdingPattern? shareholdingPattern,
      final Map<String, dynamic> ratiosData,
      final Map<String, Map<String, String>> growthTables,
      final List<QuarterlyData> quarterlyDataHistory,
      final List<AnnualData> annualDataHistory,
      final List<String> peerCompanies,
      final double? sectorPE,
      final double? sectorROE,
      final double? sectorDebtToEquity,
      final double? dividendPerShare,
      final String? dividendFrequency,
      final List<DividendHistory> dividendHistory,
      final List<String> keyManagement,
      final double? promoterHolding,
      final double? institutionalHolding,
      final double? publicHolding,
      final double? volatility30D,
      final double? volatility1Y,
      final double? maxDrawdown,
      final double? sharpeRatio,
      final double? marketCapCategory,
      final bool? isIndexConstituent,
      final List<String> indices,
      final double? rsi,
      final double? sma50,
      final double? sma200,
      final double? ema12,
      final double? ema26,
      final bool isDebtFree,
      final bool isProfitable,
      final bool hasConsistentProfits,
      final bool paysDividends,
      final bool isGrowthStock,
      final bool isValueStock,
      final bool isQualityStock}) = _$CompanyModelImpl;
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
  @override // 🔥 CRITICAL FIX: Enhanced Financial statements with JsonConverter annotations
  @FinancialDataModelConverter()
  FinancialDataModel? get quarterlyResults;
  @override
  @FinancialDataModelConverter()
  FinancialDataModel? get profitLossStatement;
  @override
  @FinancialDataModelConverter()
  FinancialDataModel? get balanceSheet;
  @override
  @FinancialDataModelConverter()
  FinancialDataModel? get cashFlowStatement;
  @override
  @FinancialDataModelConverter()
  FinancialDataModel? get ratios;
  @override // Additional financial metrics
  double? get debtToEquity;
  @override
  double? get currentRatio;
  @override
  double? get quickRatio;
  @override
  double? get interestCoverage;
  @override
  double? get assetTurnover;
  @override
  double? get inventoryTurnover;
  @override
  double? get receivablesTurnover;
  @override
  double? get payablesTurnover;
  @override
  double? get workingCapital;
  @override
  double? get enterpriseValue;
  @override
  double? get evEbitda;
  @override
  double? get priceToBook;
  @override
  double? get priceToSales;
  @override
  double? get pegRatio;
  @override
  double? get betaValue;
  @override // Growth metrics
  double? get salesGrowth1Y;
  @override
  double? get salesGrowth3Y;
  @override
  double? get salesGrowth5Y;
  @override
  double? get profitGrowth1Y;
  @override
  double? get profitGrowth3Y;
  @override
  double? get profitGrowth5Y;
  @override
  double? get salesCAGR3Y;
  @override
  double? get salesCAGR5Y;
  @override
  double? get profitCAGR3Y;
  @override
  double? get profitCAGR5Y;
  @override // Valuation and quality scores
  double? get piotroskiScore;
  @override
  double? get altmanZScore;
  @override
  String? get creditRating;
  @override // Industry and shareholding data
  String? get sector;
  @override
  String? get industry;
  @override
  List<String> get industryClassification;
  @override
  @ShareholdingPatternConverter()
  ShareholdingPattern? get shareholdingPattern;
  @override
  Map<String, dynamic> get ratiosData;
  @override
  Map<String, Map<String, String>> get growthTables;
  @override // Historical data
  List<QuarterlyData> get quarterlyDataHistory;
  @override
  List<AnnualData> get annualDataHistory;
  @override // Peer comparison
  List<String> get peerCompanies;
  @override
  double? get sectorPE;
  @override
  double? get sectorROE;
  @override
  double? get sectorDebtToEquity;
  @override // Dividend information
  double? get dividendPerShare;
  @override
  String? get dividendFrequency;
  @override
  List<DividendHistory> get dividendHistory;
  @override // Management and governance
  List<String> get keyManagement;
  @override
  double? get promoterHolding;
  @override
  double? get institutionalHolding;
  @override
  double? get publicHolding;
  @override // Risk metrics
  double? get volatility30D;
  @override
  double? get volatility1Y;
  @override
  double? get maxDrawdown;
  @override
  double? get sharpeRatio;
  @override // Market data
  double? get marketCapCategory;
  @override
  bool? get isIndexConstituent;
  @override
  List<String> get indices;
  @override // Technical indicators
  double? get rsi;
  @override
  double? get sma50;
  @override
  double? get sma200;
  @override
  double? get ema12;
  @override
  double? get ema26;
  @override // Fundamental flags
  bool get isDebtFree;
  @override
  bool get isProfitable;
  @override
  bool get hasConsistentProfits;
  @override
  bool get paysDividends;
  @override
  bool get isGrowthStock;
  @override
  bool get isValueStock;
  @override
  bool get isQualityStock;
  @override
  @JsonKey(ignore: true)
  _$$CompanyModelImplCopyWith<_$CompanyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuarterlyData _$QuarterlyDataFromJson(Map<String, dynamic> json) {
  return _QuarterlyData.fromJson(json);
}

/// @nodoc
mixin _$QuarterlyData {
  String get quarter => throw _privateConstructorUsedError;
  String get year => throw _privateConstructorUsedError;
  double? get sales => throw _privateConstructorUsedError;
  double? get netProfit => throw _privateConstructorUsedError;
  double? get eps => throw _privateConstructorUsedError;
  double? get operatingProfit => throw _privateConstructorUsedError;
  double? get ebitda => throw _privateConstructorUsedError;
  double? get totalIncome => throw _privateConstructorUsedError;
  double? get totalExpenses => throw _privateConstructorUsedError;
  double? get otherIncome => throw _privateConstructorUsedError;
  double? get rawMaterials => throw _privateConstructorUsedError;
  double? get powerAndFuel => throw _privateConstructorUsedError;
  double? get employeeCost => throw _privateConstructorUsedError;
  double? get sellingExpenses => throw _privateConstructorUsedError;
  double? get adminExpenses => throw _privateConstructorUsedError;
  double? get researchAndDevelopment => throw _privateConstructorUsedError;
  double? get depreciation => throw _privateConstructorUsedError;
  double? get interestExpense => throw _privateConstructorUsedError;
  double? get taxExpense => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get reportDate => throw _privateConstructorUsedError;

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
      double? sales,
      double? netProfit,
      double? eps,
      double? operatingProfit,
      double? ebitda,
      double? totalIncome,
      double? totalExpenses,
      double? otherIncome,
      double? rawMaterials,
      double? powerAndFuel,
      double? employeeCost,
      double? sellingExpenses,
      double? adminExpenses,
      double? researchAndDevelopment,
      double? depreciation,
      double? interestExpense,
      double? taxExpense,
      @TimestampConverter() DateTime? reportDate});
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
    Object? sales = freezed,
    Object? netProfit = freezed,
    Object? eps = freezed,
    Object? operatingProfit = freezed,
    Object? ebitda = freezed,
    Object? totalIncome = freezed,
    Object? totalExpenses = freezed,
    Object? otherIncome = freezed,
    Object? rawMaterials = freezed,
    Object? powerAndFuel = freezed,
    Object? employeeCost = freezed,
    Object? sellingExpenses = freezed,
    Object? adminExpenses = freezed,
    Object? researchAndDevelopment = freezed,
    Object? depreciation = freezed,
    Object? interestExpense = freezed,
    Object? taxExpense = freezed,
    Object? reportDate = freezed,
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
      operatingProfit: freezed == operatingProfit
          ? _value.operatingProfit
          : operatingProfit // ignore: cast_nullable_to_non_nullable
              as double?,
      ebitda: freezed == ebitda
          ? _value.ebitda
          : ebitda // ignore: cast_nullable_to_non_nullable
              as double?,
      totalIncome: freezed == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double?,
      totalExpenses: freezed == totalExpenses
          ? _value.totalExpenses
          : totalExpenses // ignore: cast_nullable_to_non_nullable
              as double?,
      otherIncome: freezed == otherIncome
          ? _value.otherIncome
          : otherIncome // ignore: cast_nullable_to_non_nullable
              as double?,
      rawMaterials: freezed == rawMaterials
          ? _value.rawMaterials
          : rawMaterials // ignore: cast_nullable_to_non_nullable
              as double?,
      powerAndFuel: freezed == powerAndFuel
          ? _value.powerAndFuel
          : powerAndFuel // ignore: cast_nullable_to_non_nullable
              as double?,
      employeeCost: freezed == employeeCost
          ? _value.employeeCost
          : employeeCost // ignore: cast_nullable_to_non_nullable
              as double?,
      sellingExpenses: freezed == sellingExpenses
          ? _value.sellingExpenses
          : sellingExpenses // ignore: cast_nullable_to_non_nullable
              as double?,
      adminExpenses: freezed == adminExpenses
          ? _value.adminExpenses
          : adminExpenses // ignore: cast_nullable_to_non_nullable
              as double?,
      researchAndDevelopment: freezed == researchAndDevelopment
          ? _value.researchAndDevelopment
          : researchAndDevelopment // ignore: cast_nullable_to_non_nullable
              as double?,
      depreciation: freezed == depreciation
          ? _value.depreciation
          : depreciation // ignore: cast_nullable_to_non_nullable
              as double?,
      interestExpense: freezed == interestExpense
          ? _value.interestExpense
          : interestExpense // ignore: cast_nullable_to_non_nullable
              as double?,
      taxExpense: freezed == taxExpense
          ? _value.taxExpense
          : taxExpense // ignore: cast_nullable_to_non_nullable
              as double?,
      reportDate: freezed == reportDate
          ? _value.reportDate
          : reportDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      double? sales,
      double? netProfit,
      double? eps,
      double? operatingProfit,
      double? ebitda,
      double? totalIncome,
      double? totalExpenses,
      double? otherIncome,
      double? rawMaterials,
      double? powerAndFuel,
      double? employeeCost,
      double? sellingExpenses,
      double? adminExpenses,
      double? researchAndDevelopment,
      double? depreciation,
      double? interestExpense,
      double? taxExpense,
      @TimestampConverter() DateTime? reportDate});
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
    Object? sales = freezed,
    Object? netProfit = freezed,
    Object? eps = freezed,
    Object? operatingProfit = freezed,
    Object? ebitda = freezed,
    Object? totalIncome = freezed,
    Object? totalExpenses = freezed,
    Object? otherIncome = freezed,
    Object? rawMaterials = freezed,
    Object? powerAndFuel = freezed,
    Object? employeeCost = freezed,
    Object? sellingExpenses = freezed,
    Object? adminExpenses = freezed,
    Object? researchAndDevelopment = freezed,
    Object? depreciation = freezed,
    Object? interestExpense = freezed,
    Object? taxExpense = freezed,
    Object? reportDate = freezed,
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
      operatingProfit: freezed == operatingProfit
          ? _value.operatingProfit
          : operatingProfit // ignore: cast_nullable_to_non_nullable
              as double?,
      ebitda: freezed == ebitda
          ? _value.ebitda
          : ebitda // ignore: cast_nullable_to_non_nullable
              as double?,
      totalIncome: freezed == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double?,
      totalExpenses: freezed == totalExpenses
          ? _value.totalExpenses
          : totalExpenses // ignore: cast_nullable_to_non_nullable
              as double?,
      otherIncome: freezed == otherIncome
          ? _value.otherIncome
          : otherIncome // ignore: cast_nullable_to_non_nullable
              as double?,
      rawMaterials: freezed == rawMaterials
          ? _value.rawMaterials
          : rawMaterials // ignore: cast_nullable_to_non_nullable
              as double?,
      powerAndFuel: freezed == powerAndFuel
          ? _value.powerAndFuel
          : powerAndFuel // ignore: cast_nullable_to_non_nullable
              as double?,
      employeeCost: freezed == employeeCost
          ? _value.employeeCost
          : employeeCost // ignore: cast_nullable_to_non_nullable
              as double?,
      sellingExpenses: freezed == sellingExpenses
          ? _value.sellingExpenses
          : sellingExpenses // ignore: cast_nullable_to_non_nullable
              as double?,
      adminExpenses: freezed == adminExpenses
          ? _value.adminExpenses
          : adminExpenses // ignore: cast_nullable_to_non_nullable
              as double?,
      researchAndDevelopment: freezed == researchAndDevelopment
          ? _value.researchAndDevelopment
          : researchAndDevelopment // ignore: cast_nullable_to_non_nullable
              as double?,
      depreciation: freezed == depreciation
          ? _value.depreciation
          : depreciation // ignore: cast_nullable_to_non_nullable
              as double?,
      interestExpense: freezed == interestExpense
          ? _value.interestExpense
          : interestExpense // ignore: cast_nullable_to_non_nullable
              as double?,
      taxExpense: freezed == taxExpense
          ? _value.taxExpense
          : taxExpense // ignore: cast_nullable_to_non_nullable
              as double?,
      reportDate: freezed == reportDate
          ? _value.reportDate
          : reportDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuarterlyDataImpl implements _QuarterlyData {
  const _$QuarterlyDataImpl(
      {required this.quarter,
      required this.year,
      this.sales,
      this.netProfit,
      this.eps,
      this.operatingProfit,
      this.ebitda,
      this.totalIncome,
      this.totalExpenses,
      this.otherIncome,
      this.rawMaterials,
      this.powerAndFuel,
      this.employeeCost,
      this.sellingExpenses,
      this.adminExpenses,
      this.researchAndDevelopment,
      this.depreciation,
      this.interestExpense,
      this.taxExpense,
      @TimestampConverter() this.reportDate});

  factory _$QuarterlyDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuarterlyDataImplFromJson(json);

  @override
  final String quarter;
  @override
  final String year;
  @override
  final double? sales;
  @override
  final double? netProfit;
  @override
  final double? eps;
  @override
  final double? operatingProfit;
  @override
  final double? ebitda;
  @override
  final double? totalIncome;
  @override
  final double? totalExpenses;
  @override
  final double? otherIncome;
  @override
  final double? rawMaterials;
  @override
  final double? powerAndFuel;
  @override
  final double? employeeCost;
  @override
  final double? sellingExpenses;
  @override
  final double? adminExpenses;
  @override
  final double? researchAndDevelopment;
  @override
  final double? depreciation;
  @override
  final double? interestExpense;
  @override
  final double? taxExpense;
  @override
  @TimestampConverter()
  final DateTime? reportDate;

  @override
  String toString() {
    return 'QuarterlyData(quarter: $quarter, year: $year, sales: $sales, netProfit: $netProfit, eps: $eps, operatingProfit: $operatingProfit, ebitda: $ebitda, totalIncome: $totalIncome, totalExpenses: $totalExpenses, otherIncome: $otherIncome, rawMaterials: $rawMaterials, powerAndFuel: $powerAndFuel, employeeCost: $employeeCost, sellingExpenses: $sellingExpenses, adminExpenses: $adminExpenses, researchAndDevelopment: $researchAndDevelopment, depreciation: $depreciation, interestExpense: $interestExpense, taxExpense: $taxExpense, reportDate: $reportDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuarterlyDataImpl &&
            (identical(other.quarter, quarter) || other.quarter == quarter) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.sales, sales) || other.sales == sales) &&
            (identical(other.netProfit, netProfit) ||
                other.netProfit == netProfit) &&
            (identical(other.eps, eps) || other.eps == eps) &&
            (identical(other.operatingProfit, operatingProfit) ||
                other.operatingProfit == operatingProfit) &&
            (identical(other.ebitda, ebitda) || other.ebitda == ebitda) &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.totalExpenses, totalExpenses) ||
                other.totalExpenses == totalExpenses) &&
            (identical(other.otherIncome, otherIncome) ||
                other.otherIncome == otherIncome) &&
            (identical(other.rawMaterials, rawMaterials) ||
                other.rawMaterials == rawMaterials) &&
            (identical(other.powerAndFuel, powerAndFuel) ||
                other.powerAndFuel == powerAndFuel) &&
            (identical(other.employeeCost, employeeCost) ||
                other.employeeCost == employeeCost) &&
            (identical(other.sellingExpenses, sellingExpenses) ||
                other.sellingExpenses == sellingExpenses) &&
            (identical(other.adminExpenses, adminExpenses) ||
                other.adminExpenses == adminExpenses) &&
            (identical(other.researchAndDevelopment, researchAndDevelopment) ||
                other.researchAndDevelopment == researchAndDevelopment) &&
            (identical(other.depreciation, depreciation) ||
                other.depreciation == depreciation) &&
            (identical(other.interestExpense, interestExpense) ||
                other.interestExpense == interestExpense) &&
            (identical(other.taxExpense, taxExpense) ||
                other.taxExpense == taxExpense) &&
            (identical(other.reportDate, reportDate) ||
                other.reportDate == reportDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        quarter,
        year,
        sales,
        netProfit,
        eps,
        operatingProfit,
        ebitda,
        totalIncome,
        totalExpenses,
        otherIncome,
        rawMaterials,
        powerAndFuel,
        employeeCost,
        sellingExpenses,
        adminExpenses,
        researchAndDevelopment,
        depreciation,
        interestExpense,
        taxExpense,
        reportDate
      ]);

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

abstract class _QuarterlyData implements QuarterlyData {
  const factory _QuarterlyData(
      {required final String quarter,
      required final String year,
      final double? sales,
      final double? netProfit,
      final double? eps,
      final double? operatingProfit,
      final double? ebitda,
      final double? totalIncome,
      final double? totalExpenses,
      final double? otherIncome,
      final double? rawMaterials,
      final double? powerAndFuel,
      final double? employeeCost,
      final double? sellingExpenses,
      final double? adminExpenses,
      final double? researchAndDevelopment,
      final double? depreciation,
      final double? interestExpense,
      final double? taxExpense,
      @TimestampConverter() final DateTime? reportDate}) = _$QuarterlyDataImpl;

  factory _QuarterlyData.fromJson(Map<String, dynamic> json) =
      _$QuarterlyDataImpl.fromJson;

  @override
  String get quarter;
  @override
  String get year;
  @override
  double? get sales;
  @override
  double? get netProfit;
  @override
  double? get eps;
  @override
  double? get operatingProfit;
  @override
  double? get ebitda;
  @override
  double? get totalIncome;
  @override
  double? get totalExpenses;
  @override
  double? get otherIncome;
  @override
  double? get rawMaterials;
  @override
  double? get powerAndFuel;
  @override
  double? get employeeCost;
  @override
  double? get sellingExpenses;
  @override
  double? get adminExpenses;
  @override
  double? get researchAndDevelopment;
  @override
  double? get depreciation;
  @override
  double? get interestExpense;
  @override
  double? get taxExpense;
  @override
  @TimestampConverter()
  DateTime? get reportDate;
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
  double? get roe => throw _privateConstructorUsedError;
  double? get roce => throw _privateConstructorUsedError;
  double? get peRatio => throw _privateConstructorUsedError;
  double? get pbRatio => throw _privateConstructorUsedError;
  double? get dividendPerShare => throw _privateConstructorUsedError;
  double? get faceValue => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get yearEnd => throw _privateConstructorUsedError;

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
      double? roe,
      double? roce,
      double? peRatio,
      double? pbRatio,
      double? dividendPerShare,
      double? faceValue,
      @TimestampConverter() DateTime? yearEnd});
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
    Object? roe = freezed,
    Object? roce = freezed,
    Object? peRatio = freezed,
    Object? pbRatio = freezed,
    Object? dividendPerShare = freezed,
    Object? faceValue = freezed,
    Object? yearEnd = freezed,
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
      dividendPerShare: freezed == dividendPerShare
          ? _value.dividendPerShare
          : dividendPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      faceValue: freezed == faceValue
          ? _value.faceValue
          : faceValue // ignore: cast_nullable_to_non_nullable
              as double?,
      yearEnd: freezed == yearEnd
          ? _value.yearEnd
          : yearEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      double? roe,
      double? roce,
      double? peRatio,
      double? pbRatio,
      double? dividendPerShare,
      double? faceValue,
      @TimestampConverter() DateTime? yearEnd});
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
    Object? roe = freezed,
    Object? roce = freezed,
    Object? peRatio = freezed,
    Object? pbRatio = freezed,
    Object? dividendPerShare = freezed,
    Object? faceValue = freezed,
    Object? yearEnd = freezed,
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
      dividendPerShare: freezed == dividendPerShare
          ? _value.dividendPerShare
          : dividendPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      faceValue: freezed == faceValue
          ? _value.faceValue
          : faceValue // ignore: cast_nullable_to_non_nullable
              as double?,
      yearEnd: freezed == yearEnd
          ? _value.yearEnd
          : yearEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnnualDataImpl implements _AnnualData {
  const _$AnnualDataImpl(
      {required this.year,
      this.sales,
      this.netProfit,
      this.eps,
      this.bookValue,
      this.roe,
      this.roce,
      this.peRatio,
      this.pbRatio,
      this.dividendPerShare,
      this.faceValue,
      @TimestampConverter() this.yearEnd});

  factory _$AnnualDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnnualDataImplFromJson(json);

  @override
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
  final double? roe;
  @override
  final double? roce;
  @override
  final double? peRatio;
  @override
  final double? pbRatio;
  @override
  final double? dividendPerShare;
  @override
  final double? faceValue;
  @override
  @TimestampConverter()
  final DateTime? yearEnd;

  @override
  String toString() {
    return 'AnnualData(year: $year, sales: $sales, netProfit: $netProfit, eps: $eps, bookValue: $bookValue, roe: $roe, roce: $roce, peRatio: $peRatio, pbRatio: $pbRatio, dividendPerShare: $dividendPerShare, faceValue: $faceValue, yearEnd: $yearEnd)';
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
            (identical(other.roe, roe) || other.roe == roe) &&
            (identical(other.roce, roce) || other.roce == roce) &&
            (identical(other.peRatio, peRatio) || other.peRatio == peRatio) &&
            (identical(other.pbRatio, pbRatio) || other.pbRatio == pbRatio) &&
            (identical(other.dividendPerShare, dividendPerShare) ||
                other.dividendPerShare == dividendPerShare) &&
            (identical(other.faceValue, faceValue) ||
                other.faceValue == faceValue) &&
            (identical(other.yearEnd, yearEnd) || other.yearEnd == yearEnd));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      year,
      sales,
      netProfit,
      eps,
      bookValue,
      roe,
      roce,
      peRatio,
      pbRatio,
      dividendPerShare,
      faceValue,
      yearEnd);

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

abstract class _AnnualData implements AnnualData {
  const factory _AnnualData(
      {required final String year,
      final double? sales,
      final double? netProfit,
      final double? eps,
      final double? bookValue,
      final double? roe,
      final double? roce,
      final double? peRatio,
      final double? pbRatio,
      final double? dividendPerShare,
      final double? faceValue,
      @TimestampConverter() final DateTime? yearEnd}) = _$AnnualDataImpl;

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
  double? get roe;
  @override
  double? get roce;
  @override
  double? get peRatio;
  @override
  double? get pbRatio;
  @override
  double? get dividendPerShare;
  @override
  double? get faceValue;
  @override
  @TimestampConverter()
  DateTime? get yearEnd;
  @override
  @JsonKey(ignore: true)
  _$$AnnualDataImplCopyWith<_$AnnualDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DividendHistory _$DividendHistoryFromJson(Map<String, dynamic> json) {
  return _DividendHistory.fromJson(json);
}

/// @nodoc
mixin _$DividendHistory {
  String get year => throw _privateConstructorUsedError;
  double? get dividendPerShare => throw _privateConstructorUsedError;
  String? get dividendType => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get exDividendDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get recordDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get paymentDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DividendHistoryCopyWith<DividendHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DividendHistoryCopyWith<$Res> {
  factory $DividendHistoryCopyWith(
          DividendHistory value, $Res Function(DividendHistory) then) =
      _$DividendHistoryCopyWithImpl<$Res, DividendHistory>;
  @useResult
  $Res call(
      {String year,
      double? dividendPerShare,
      String? dividendType,
      @TimestampConverter() DateTime? exDividendDate,
      @TimestampConverter() DateTime? recordDate,
      @TimestampConverter() DateTime? paymentDate});
}

/// @nodoc
class _$DividendHistoryCopyWithImpl<$Res, $Val extends DividendHistory>
    implements $DividendHistoryCopyWith<$Res> {
  _$DividendHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? dividendPerShare = freezed,
    Object? dividendType = freezed,
    Object? exDividendDate = freezed,
    Object? recordDate = freezed,
    Object? paymentDate = freezed,
  }) {
    return _then(_value.copyWith(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      dividendPerShare: freezed == dividendPerShare
          ? _value.dividendPerShare
          : dividendPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendType: freezed == dividendType
          ? _value.dividendType
          : dividendType // ignore: cast_nullable_to_non_nullable
              as String?,
      exDividendDate: freezed == exDividendDate
          ? _value.exDividendDate
          : exDividendDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recordDate: freezed == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DividendHistoryImplCopyWith<$Res>
    implements $DividendHistoryCopyWith<$Res> {
  factory _$$DividendHistoryImplCopyWith(_$DividendHistoryImpl value,
          $Res Function(_$DividendHistoryImpl) then) =
      __$$DividendHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String year,
      double? dividendPerShare,
      String? dividendType,
      @TimestampConverter() DateTime? exDividendDate,
      @TimestampConverter() DateTime? recordDate,
      @TimestampConverter() DateTime? paymentDate});
}

/// @nodoc
class __$$DividendHistoryImplCopyWithImpl<$Res>
    extends _$DividendHistoryCopyWithImpl<$Res, _$DividendHistoryImpl>
    implements _$$DividendHistoryImplCopyWith<$Res> {
  __$$DividendHistoryImplCopyWithImpl(
      _$DividendHistoryImpl _value, $Res Function(_$DividendHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? dividendPerShare = freezed,
    Object? dividendType = freezed,
    Object? exDividendDate = freezed,
    Object? recordDate = freezed,
    Object? paymentDate = freezed,
  }) {
    return _then(_$DividendHistoryImpl(
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String,
      dividendPerShare: freezed == dividendPerShare
          ? _value.dividendPerShare
          : dividendPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendType: freezed == dividendType
          ? _value.dividendType
          : dividendType // ignore: cast_nullable_to_non_nullable
              as String?,
      exDividendDate: freezed == exDividendDate
          ? _value.exDividendDate
          : exDividendDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recordDate: freezed == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      paymentDate: freezed == paymentDate
          ? _value.paymentDate
          : paymentDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DividendHistoryImpl implements _DividendHistory {
  const _$DividendHistoryImpl(
      {required this.year,
      this.dividendPerShare,
      this.dividendType,
      @TimestampConverter() this.exDividendDate,
      @TimestampConverter() this.recordDate,
      @TimestampConverter() this.paymentDate});

  factory _$DividendHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DividendHistoryImplFromJson(json);

  @override
  final String year;
  @override
  final double? dividendPerShare;
  @override
  final String? dividendType;
  @override
  @TimestampConverter()
  final DateTime? exDividendDate;
  @override
  @TimestampConverter()
  final DateTime? recordDate;
  @override
  @TimestampConverter()
  final DateTime? paymentDate;

  @override
  String toString() {
    return 'DividendHistory(year: $year, dividendPerShare: $dividendPerShare, dividendType: $dividendType, exDividendDate: $exDividendDate, recordDate: $recordDate, paymentDate: $paymentDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DividendHistoryImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.dividendPerShare, dividendPerShare) ||
                other.dividendPerShare == dividendPerShare) &&
            (identical(other.dividendType, dividendType) ||
                other.dividendType == dividendType) &&
            (identical(other.exDividendDate, exDividendDate) ||
                other.exDividendDate == exDividendDate) &&
            (identical(other.recordDate, recordDate) ||
                other.recordDate == recordDate) &&
            (identical(other.paymentDate, paymentDate) ||
                other.paymentDate == paymentDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, year, dividendPerShare,
      dividendType, exDividendDate, recordDate, paymentDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DividendHistoryImplCopyWith<_$DividendHistoryImpl> get copyWith =>
      __$$DividendHistoryImplCopyWithImpl<_$DividendHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DividendHistoryImplToJson(
      this,
    );
  }
}

abstract class _DividendHistory implements DividendHistory {
  const factory _DividendHistory(
          {required final String year,
          final double? dividendPerShare,
          final String? dividendType,
          @TimestampConverter() final DateTime? exDividendDate,
          @TimestampConverter() final DateTime? recordDate,
          @TimestampConverter() final DateTime? paymentDate}) =
      _$DividendHistoryImpl;

  factory _DividendHistory.fromJson(Map<String, dynamic> json) =
      _$DividendHistoryImpl.fromJson;

  @override
  String get year;
  @override
  double? get dividendPerShare;
  @override
  String? get dividendType;
  @override
  @TimestampConverter()
  DateTime? get exDividendDate;
  @override
  @TimestampConverter()
  DateTime? get recordDate;
  @override
  @TimestampConverter()
  DateTime? get paymentDate;
  @override
  @JsonKey(ignore: true)
  _$$DividendHistoryImplCopyWith<_$DividendHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShareholdingPattern _$ShareholdingPatternFromJson(Map<String, dynamic> json) {
  return _ShareholdingPattern.fromJson(json);
}

/// @nodoc
mixin _$ShareholdingPattern {
  Map<String, Map<String, String>> get quarterly =>
      throw _privateConstructorUsedError;
  double? get promoterHolding => throw _privateConstructorUsedError;
  double? get publicHolding => throw _privateConstructorUsedError;
  double? get institutionalHolding => throw _privateConstructorUsedError;
  double? get foreignInstitutional => throw _privateConstructorUsedError;
  double? get domesticInstitutional => throw _privateConstructorUsedError;
  double? get governmentHolding => throw _privateConstructorUsedError;
  List<MajorShareholder> get majorShareholders =>
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
  $Res call(
      {Map<String, Map<String, String>> quarterly,
      double? promoterHolding,
      double? publicHolding,
      double? institutionalHolding,
      double? foreignInstitutional,
      double? domesticInstitutional,
      double? governmentHolding,
      List<MajorShareholder> majorShareholders});
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
    Object? promoterHolding = freezed,
    Object? publicHolding = freezed,
    Object? institutionalHolding = freezed,
    Object? foreignInstitutional = freezed,
    Object? domesticInstitutional = freezed,
    Object? governmentHolding = freezed,
    Object? majorShareholders = null,
  }) {
    return _then(_value.copyWith(
      quarterly: null == quarterly
          ? _value.quarterly
          : quarterly // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
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
      domesticInstitutional: freezed == domesticInstitutional
          ? _value.domesticInstitutional
          : domesticInstitutional // ignore: cast_nullable_to_non_nullable
              as double?,
      governmentHolding: freezed == governmentHolding
          ? _value.governmentHolding
          : governmentHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      majorShareholders: null == majorShareholders
          ? _value.majorShareholders
          : majorShareholders // ignore: cast_nullable_to_non_nullable
              as List<MajorShareholder>,
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
      {Map<String, Map<String, String>> quarterly,
      double? promoterHolding,
      double? publicHolding,
      double? institutionalHolding,
      double? foreignInstitutional,
      double? domesticInstitutional,
      double? governmentHolding,
      List<MajorShareholder> majorShareholders});
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
    Object? promoterHolding = freezed,
    Object? publicHolding = freezed,
    Object? institutionalHolding = freezed,
    Object? foreignInstitutional = freezed,
    Object? domesticInstitutional = freezed,
    Object? governmentHolding = freezed,
    Object? majorShareholders = null,
  }) {
    return _then(_$ShareholdingPatternImpl(
      quarterly: null == quarterly
          ? _value._quarterly
          : quarterly // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>,
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
      domesticInstitutional: freezed == domesticInstitutional
          ? _value.domesticInstitutional
          : domesticInstitutional // ignore: cast_nullable_to_non_nullable
              as double?,
      governmentHolding: freezed == governmentHolding
          ? _value.governmentHolding
          : governmentHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      majorShareholders: null == majorShareholders
          ? _value._majorShareholders
          : majorShareholders // ignore: cast_nullable_to_non_nullable
              as List<MajorShareholder>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShareholdingPatternImpl implements _ShareholdingPattern {
  const _$ShareholdingPatternImpl(
      {final Map<String, Map<String, String>> quarterly =
          const <String, Map<String, String>>{},
      this.promoterHolding,
      this.publicHolding,
      this.institutionalHolding,
      this.foreignInstitutional,
      this.domesticInstitutional,
      this.governmentHolding,
      final List<MajorShareholder> majorShareholders =
          const <MajorShareholder>[]})
      : _quarterly = quarterly,
        _majorShareholders = majorShareholders;

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
  final double? promoterHolding;
  @override
  final double? publicHolding;
  @override
  final double? institutionalHolding;
  @override
  final double? foreignInstitutional;
  @override
  final double? domesticInstitutional;
  @override
  final double? governmentHolding;
  final List<MajorShareholder> _majorShareholders;
  @override
  @JsonKey()
  List<MajorShareholder> get majorShareholders {
    if (_majorShareholders is EqualUnmodifiableListView)
      return _majorShareholders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_majorShareholders);
  }

  @override
  String toString() {
    return 'ShareholdingPattern(quarterly: $quarterly, promoterHolding: $promoterHolding, publicHolding: $publicHolding, institutionalHolding: $institutionalHolding, foreignInstitutional: $foreignInstitutional, domesticInstitutional: $domesticInstitutional, governmentHolding: $governmentHolding, majorShareholders: $majorShareholders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShareholdingPatternImpl &&
            const DeepCollectionEquality()
                .equals(other._quarterly, _quarterly) &&
            (identical(other.promoterHolding, promoterHolding) ||
                other.promoterHolding == promoterHolding) &&
            (identical(other.publicHolding, publicHolding) ||
                other.publicHolding == publicHolding) &&
            (identical(other.institutionalHolding, institutionalHolding) ||
                other.institutionalHolding == institutionalHolding) &&
            (identical(other.foreignInstitutional, foreignInstitutional) ||
                other.foreignInstitutional == foreignInstitutional) &&
            (identical(other.domesticInstitutional, domesticInstitutional) ||
                other.domesticInstitutional == domesticInstitutional) &&
            (identical(other.governmentHolding, governmentHolding) ||
                other.governmentHolding == governmentHolding) &&
            const DeepCollectionEquality()
                .equals(other._majorShareholders, _majorShareholders));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_quarterly),
      promoterHolding,
      publicHolding,
      institutionalHolding,
      foreignInstitutional,
      domesticInstitutional,
      governmentHolding,
      const DeepCollectionEquality().hash(_majorShareholders));

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
          {final Map<String, Map<String, String>> quarterly,
          final double? promoterHolding,
          final double? publicHolding,
          final double? institutionalHolding,
          final double? foreignInstitutional,
          final double? domesticInstitutional,
          final double? governmentHolding,
          final List<MajorShareholder> majorShareholders}) =
      _$ShareholdingPatternImpl;

  factory _ShareholdingPattern.fromJson(Map<String, dynamic> json) =
      _$ShareholdingPatternImpl.fromJson;

  @override
  Map<String, Map<String, String>> get quarterly;
  @override
  double? get promoterHolding;
  @override
  double? get publicHolding;
  @override
  double? get institutionalHolding;
  @override
  double? get foreignInstitutional;
  @override
  double? get domesticInstitutional;
  @override
  double? get governmentHolding;
  @override
  List<MajorShareholder> get majorShareholders;
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
  String? get shareholderType => throw _privateConstructorUsedError;

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
  $Res call({String name, double percentage, String? shareholderType});
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
    Object? shareholderType = freezed,
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
      shareholderType: freezed == shareholderType
          ? _value.shareholderType
          : shareholderType // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call({String name, double percentage, String? shareholderType});
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
    Object? shareholderType = freezed,
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
      shareholderType: freezed == shareholderType
          ? _value.shareholderType
          : shareholderType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MajorShareholderImpl implements _MajorShareholder {
  const _$MajorShareholderImpl(
      {required this.name, required this.percentage, this.shareholderType});

  factory _$MajorShareholderImpl.fromJson(Map<String, dynamic> json) =>
      _$$MajorShareholderImplFromJson(json);

  @override
  final String name;
  @override
  final double percentage;
  @override
  final String? shareholderType;

  @override
  String toString() {
    return 'MajorShareholder(name: $name, percentage: $percentage, shareholderType: $shareholderType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MajorShareholderImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.shareholderType, shareholderType) ||
                other.shareholderType == shareholderType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, percentage, shareholderType);

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
      {required final String name,
      required final double percentage,
      final String? shareholderType}) = _$MajorShareholderImpl;

  factory _MajorShareholder.fromJson(Map<String, dynamic> json) =
      _$MajorShareholderImpl.fromJson;

  @override
  String get name;
  @override
  double get percentage;
  @override
  String? get shareholderType;
  @override
  @JsonKey(ignore: true)
  _$$MajorShareholderImplCopyWith<_$MajorShareholderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
