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
  List<String> get cons => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get lastUpdated => throw _privateConstructorUsedError;
  Map<String, dynamic> get ratiosData => throw _privateConstructorUsedError;
  double get changePercent => throw _privateConstructorUsedError;
  double get changeAmount => throw _privateConstructorUsedError;
  double get previousClose => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt =>
      throw _privateConstructorUsedError; // Comprehensive Financial Data - from your Firebase Functions
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
      throw _privateConstructorUsedError; // Growth tables data (flexible structure from your scraping)
  Map<String, dynamic> get growthTables =>
      throw _privateConstructorUsedError; // Additional financial metrics from screener.in
  double? get salesGrowth => throw _privateConstructorUsedError;
  double? get profitGrowth => throw _privateConstructorUsedError;
  double? get operatingMargin => throw _privateConstructorUsedError;
  double? get netMargin => throw _privateConstructorUsedError;
  double? get assetTurnover => throw _privateConstructorUsedError;
  double? get workingCapital => throw _privateConstructorUsedError;
  double? get debtToEquity => throw _privateConstructorUsedError;
  double? get currentRatio => throw _privateConstructorUsedError;
  double? get quickRatio => throw _privateConstructorUsedError;
  double? get interestCoverage =>
      throw _privateConstructorUsedError; // Valuation metrics
  double? get priceToBook => throw _privateConstructorUsedError;
  double? get evToEbitda => throw _privateConstructorUsedError;
  double? get pegRatio => throw _privateConstructorUsedError;
  double? get enterpriseValue =>
      throw _privateConstructorUsedError; // Per share data
  double? get earningsPerShare => throw _privateConstructorUsedError;
  double? get cashPerShare => throw _privateConstructorUsedError;
  double? get salesPerShare =>
      throw _privateConstructorUsedError; // Management quality indicators
  double? get returnOnAssets => throw _privateConstructorUsedError;
  double? get returnOnCapitalEmployed => throw _privateConstructorUsedError;
  double? get returnOnEquity =>
      throw _privateConstructorUsedError; // Additional screener.in specific data
  String? get sector => throw _privateConstructorUsedError;
  String? get industry => throw _privateConstructorUsedError;
  double? get beta => throw _privateConstructorUsedError;
  int? get sharesOutstanding => throw _privateConstructorUsedError;
  double? get promoterHolding => throw _privateConstructorUsedError;
  double? get publicHolding =>
      throw _privateConstructorUsedError; // Technical indicators
  double? get dayHigh => throw _privateConstructorUsedError;
  double? get dayLow => throw _privateConstructorUsedError;
  double? get weekHigh52 => throw _privateConstructorUsedError;
  double? get weekLow52 => throw _privateConstructorUsedError;
  double? get averageVolume => throw _privateConstructorUsedError;
  double? get marketLot =>
      throw _privateConstructorUsedError; // Dividend information
  double? get dividendPerShare => throw _privateConstructorUsedError;
  DateTime? get exDividendDate => throw _privateConstructorUsedError;
  DateTime? get recordDate =>
      throw _privateConstructorUsedError; // Corporate actions
  List<CorporateAction> get corporateActions =>
      throw _privateConstructorUsedError; // News and updates
  List<CompanyNews> get recentNews =>
      throw _privateConstructorUsedError; // Analyst recommendations
  AnalystRecommendations? get analystRecommendations =>
      throw _privateConstructorUsedError; // Peer comparison data
  List<String> get peerCompanies =>
      throw _privateConstructorUsedError; // ESG scores (if available)
  ESGScores? get esgScores => throw _privateConstructorUsedError;

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
      @TimestampConverter() DateTime? lastUpdated,
      Map<String, dynamic> ratiosData,
      double changePercent,
      double changeAmount,
      double previousClose,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      FinancialDataModel? quarterlyResults,
      FinancialDataModel? profitLossStatement,
      FinancialDataModel? balanceSheet,
      FinancialDataModel? cashFlowStatement,
      FinancialDataModel? ratios,
      List<String> industryClassification,
      ShareholdingPattern? shareholdingPattern,
      Map<String, dynamic> growthTables,
      double? salesGrowth,
      double? profitGrowth,
      double? operatingMargin,
      double? netMargin,
      double? assetTurnover,
      double? workingCapital,
      double? debtToEquity,
      double? currentRatio,
      double? quickRatio,
      double? interestCoverage,
      double? priceToBook,
      double? evToEbitda,
      double? pegRatio,
      double? enterpriseValue,
      double? earningsPerShare,
      double? cashPerShare,
      double? salesPerShare,
      double? returnOnAssets,
      double? returnOnCapitalEmployed,
      double? returnOnEquity,
      String? sector,
      String? industry,
      double? beta,
      int? sharesOutstanding,
      double? promoterHolding,
      double? publicHolding,
      double? dayHigh,
      double? dayLow,
      double? weekHigh52,
      double? weekLow52,
      double? averageVolume,
      double? marketLot,
      double? dividendPerShare,
      DateTime? exDividendDate,
      DateTime? recordDate,
      List<CorporateAction> corporateActions,
      List<CompanyNews> recentNews,
      AnalystRecommendations? analystRecommendations,
      List<String> peerCompanies,
      ESGScores? esgScores});

  $FinancialDataModelCopyWith<$Res>? get quarterlyResults;
  $FinancialDataModelCopyWith<$Res>? get profitLossStatement;
  $FinancialDataModelCopyWith<$Res>? get balanceSheet;
  $FinancialDataModelCopyWith<$Res>? get cashFlowStatement;
  $FinancialDataModelCopyWith<$Res>? get ratios;
  $ShareholdingPatternCopyWith<$Res>? get shareholdingPattern;
  $AnalystRecommendationsCopyWith<$Res>? get analystRecommendations;
  $ESGScoresCopyWith<$Res>? get esgScores;
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
    Object? lastUpdated = freezed,
    Object? ratiosData = null,
    Object? changePercent = null,
    Object? changeAmount = null,
    Object? previousClose = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? quarterlyResults = freezed,
    Object? profitLossStatement = freezed,
    Object? balanceSheet = freezed,
    Object? cashFlowStatement = freezed,
    Object? ratios = freezed,
    Object? industryClassification = null,
    Object? shareholdingPattern = freezed,
    Object? growthTables = null,
    Object? salesGrowth = freezed,
    Object? profitGrowth = freezed,
    Object? operatingMargin = freezed,
    Object? netMargin = freezed,
    Object? assetTurnover = freezed,
    Object? workingCapital = freezed,
    Object? debtToEquity = freezed,
    Object? currentRatio = freezed,
    Object? quickRatio = freezed,
    Object? interestCoverage = freezed,
    Object? priceToBook = freezed,
    Object? evToEbitda = freezed,
    Object? pegRatio = freezed,
    Object? enterpriseValue = freezed,
    Object? earningsPerShare = freezed,
    Object? cashPerShare = freezed,
    Object? salesPerShare = freezed,
    Object? returnOnAssets = freezed,
    Object? returnOnCapitalEmployed = freezed,
    Object? returnOnEquity = freezed,
    Object? sector = freezed,
    Object? industry = freezed,
    Object? beta = freezed,
    Object? sharesOutstanding = freezed,
    Object? promoterHolding = freezed,
    Object? publicHolding = freezed,
    Object? dayHigh = freezed,
    Object? dayLow = freezed,
    Object? weekHigh52 = freezed,
    Object? weekLow52 = freezed,
    Object? averageVolume = freezed,
    Object? marketLot = freezed,
    Object? dividendPerShare = freezed,
    Object? exDividendDate = freezed,
    Object? recordDate = freezed,
    Object? corporateActions = null,
    Object? recentNews = null,
    Object? analystRecommendations = freezed,
    Object? peerCompanies = null,
    Object? esgScores = freezed,
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
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ratiosData: null == ratiosData
          ? _value.ratiosData
          : ratiosData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      growthTables: null == growthTables
          ? _value.growthTables
          : growthTables // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      salesGrowth: freezed == salesGrowth
          ? _value.salesGrowth
          : salesGrowth // ignore: cast_nullable_to_non_nullable
              as double?,
      profitGrowth: freezed == profitGrowth
          ? _value.profitGrowth
          : profitGrowth // ignore: cast_nullable_to_non_nullable
              as double?,
      operatingMargin: freezed == operatingMargin
          ? _value.operatingMargin
          : operatingMargin // ignore: cast_nullable_to_non_nullable
              as double?,
      netMargin: freezed == netMargin
          ? _value.netMargin
          : netMargin // ignore: cast_nullable_to_non_nullable
              as double?,
      assetTurnover: freezed == assetTurnover
          ? _value.assetTurnover
          : assetTurnover // ignore: cast_nullable_to_non_nullable
              as double?,
      workingCapital: freezed == workingCapital
          ? _value.workingCapital
          : workingCapital // ignore: cast_nullable_to_non_nullable
              as double?,
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
      priceToBook: freezed == priceToBook
          ? _value.priceToBook
          : priceToBook // ignore: cast_nullable_to_non_nullable
              as double?,
      evToEbitda: freezed == evToEbitda
          ? _value.evToEbitda
          : evToEbitda // ignore: cast_nullable_to_non_nullable
              as double?,
      pegRatio: freezed == pegRatio
          ? _value.pegRatio
          : pegRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      enterpriseValue: freezed == enterpriseValue
          ? _value.enterpriseValue
          : enterpriseValue // ignore: cast_nullable_to_non_nullable
              as double?,
      earningsPerShare: freezed == earningsPerShare
          ? _value.earningsPerShare
          : earningsPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      cashPerShare: freezed == cashPerShare
          ? _value.cashPerShare
          : cashPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      salesPerShare: freezed == salesPerShare
          ? _value.salesPerShare
          : salesPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      returnOnAssets: freezed == returnOnAssets
          ? _value.returnOnAssets
          : returnOnAssets // ignore: cast_nullable_to_non_nullable
              as double?,
      returnOnCapitalEmployed: freezed == returnOnCapitalEmployed
          ? _value.returnOnCapitalEmployed
          : returnOnCapitalEmployed // ignore: cast_nullable_to_non_nullable
              as double?,
      returnOnEquity: freezed == returnOnEquity
          ? _value.returnOnEquity
          : returnOnEquity // ignore: cast_nullable_to_non_nullable
              as double?,
      sector: freezed == sector
          ? _value.sector
          : sector // ignore: cast_nullable_to_non_nullable
              as String?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String?,
      beta: freezed == beta
          ? _value.beta
          : beta // ignore: cast_nullable_to_non_nullable
              as double?,
      sharesOutstanding: freezed == sharesOutstanding
          ? _value.sharesOutstanding
          : sharesOutstanding // ignore: cast_nullable_to_non_nullable
              as int?,
      promoterHolding: freezed == promoterHolding
          ? _value.promoterHolding
          : promoterHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      publicHolding: freezed == publicHolding
          ? _value.publicHolding
          : publicHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      dayHigh: freezed == dayHigh
          ? _value.dayHigh
          : dayHigh // ignore: cast_nullable_to_non_nullable
              as double?,
      dayLow: freezed == dayLow
          ? _value.dayLow
          : dayLow // ignore: cast_nullable_to_non_nullable
              as double?,
      weekHigh52: freezed == weekHigh52
          ? _value.weekHigh52
          : weekHigh52 // ignore: cast_nullable_to_non_nullable
              as double?,
      weekLow52: freezed == weekLow52
          ? _value.weekLow52
          : weekLow52 // ignore: cast_nullable_to_non_nullable
              as double?,
      averageVolume: freezed == averageVolume
          ? _value.averageVolume
          : averageVolume // ignore: cast_nullable_to_non_nullable
              as double?,
      marketLot: freezed == marketLot
          ? _value.marketLot
          : marketLot // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendPerShare: freezed == dividendPerShare
          ? _value.dividendPerShare
          : dividendPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      exDividendDate: freezed == exDividendDate
          ? _value.exDividendDate
          : exDividendDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recordDate: freezed == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      corporateActions: null == corporateActions
          ? _value.corporateActions
          : corporateActions // ignore: cast_nullable_to_non_nullable
              as List<CorporateAction>,
      recentNews: null == recentNews
          ? _value.recentNews
          : recentNews // ignore: cast_nullable_to_non_nullable
              as List<CompanyNews>,
      analystRecommendations: freezed == analystRecommendations
          ? _value.analystRecommendations
          : analystRecommendations // ignore: cast_nullable_to_non_nullable
              as AnalystRecommendations?,
      peerCompanies: null == peerCompanies
          ? _value.peerCompanies
          : peerCompanies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      esgScores: freezed == esgScores
          ? _value.esgScores
          : esgScores // ignore: cast_nullable_to_non_nullable
              as ESGScores?,
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

  @override
  @pragma('vm:prefer-inline')
  $AnalystRecommendationsCopyWith<$Res>? get analystRecommendations {
    if (_value.analystRecommendations == null) {
      return null;
    }

    return $AnalystRecommendationsCopyWith<$Res>(_value.analystRecommendations!,
        (value) {
      return _then(_value.copyWith(analystRecommendations: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ESGScoresCopyWith<$Res>? get esgScores {
    if (_value.esgScores == null) {
      return null;
    }

    return $ESGScoresCopyWith<$Res>(_value.esgScores!, (value) {
      return _then(_value.copyWith(esgScores: value) as $Val);
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
      @TimestampConverter() DateTime? lastUpdated,
      Map<String, dynamic> ratiosData,
      double changePercent,
      double changeAmount,
      double previousClose,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      FinancialDataModel? quarterlyResults,
      FinancialDataModel? profitLossStatement,
      FinancialDataModel? balanceSheet,
      FinancialDataModel? cashFlowStatement,
      FinancialDataModel? ratios,
      List<String> industryClassification,
      ShareholdingPattern? shareholdingPattern,
      Map<String, dynamic> growthTables,
      double? salesGrowth,
      double? profitGrowth,
      double? operatingMargin,
      double? netMargin,
      double? assetTurnover,
      double? workingCapital,
      double? debtToEquity,
      double? currentRatio,
      double? quickRatio,
      double? interestCoverage,
      double? priceToBook,
      double? evToEbitda,
      double? pegRatio,
      double? enterpriseValue,
      double? earningsPerShare,
      double? cashPerShare,
      double? salesPerShare,
      double? returnOnAssets,
      double? returnOnCapitalEmployed,
      double? returnOnEquity,
      String? sector,
      String? industry,
      double? beta,
      int? sharesOutstanding,
      double? promoterHolding,
      double? publicHolding,
      double? dayHigh,
      double? dayLow,
      double? weekHigh52,
      double? weekLow52,
      double? averageVolume,
      double? marketLot,
      double? dividendPerShare,
      DateTime? exDividendDate,
      DateTime? recordDate,
      List<CorporateAction> corporateActions,
      List<CompanyNews> recentNews,
      AnalystRecommendations? analystRecommendations,
      List<String> peerCompanies,
      ESGScores? esgScores});

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
  @override
  $AnalystRecommendationsCopyWith<$Res>? get analystRecommendations;
  @override
  $ESGScoresCopyWith<$Res>? get esgScores;
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
    Object? lastUpdated = freezed,
    Object? ratiosData = null,
    Object? changePercent = null,
    Object? changeAmount = null,
    Object? previousClose = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? quarterlyResults = freezed,
    Object? profitLossStatement = freezed,
    Object? balanceSheet = freezed,
    Object? cashFlowStatement = freezed,
    Object? ratios = freezed,
    Object? industryClassification = null,
    Object? shareholdingPattern = freezed,
    Object? growthTables = null,
    Object? salesGrowth = freezed,
    Object? profitGrowth = freezed,
    Object? operatingMargin = freezed,
    Object? netMargin = freezed,
    Object? assetTurnover = freezed,
    Object? workingCapital = freezed,
    Object? debtToEquity = freezed,
    Object? currentRatio = freezed,
    Object? quickRatio = freezed,
    Object? interestCoverage = freezed,
    Object? priceToBook = freezed,
    Object? evToEbitda = freezed,
    Object? pegRatio = freezed,
    Object? enterpriseValue = freezed,
    Object? earningsPerShare = freezed,
    Object? cashPerShare = freezed,
    Object? salesPerShare = freezed,
    Object? returnOnAssets = freezed,
    Object? returnOnCapitalEmployed = freezed,
    Object? returnOnEquity = freezed,
    Object? sector = freezed,
    Object? industry = freezed,
    Object? beta = freezed,
    Object? sharesOutstanding = freezed,
    Object? promoterHolding = freezed,
    Object? publicHolding = freezed,
    Object? dayHigh = freezed,
    Object? dayLow = freezed,
    Object? weekHigh52 = freezed,
    Object? weekLow52 = freezed,
    Object? averageVolume = freezed,
    Object? marketLot = freezed,
    Object? dividendPerShare = freezed,
    Object? exDividendDate = freezed,
    Object? recordDate = freezed,
    Object? corporateActions = null,
    Object? recentNews = null,
    Object? analystRecommendations = freezed,
    Object? peerCompanies = null,
    Object? esgScores = freezed,
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
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ratiosData: null == ratiosData
          ? _value._ratiosData
          : ratiosData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
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
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      growthTables: null == growthTables
          ? _value._growthTables
          : growthTables // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      salesGrowth: freezed == salesGrowth
          ? _value.salesGrowth
          : salesGrowth // ignore: cast_nullable_to_non_nullable
              as double?,
      profitGrowth: freezed == profitGrowth
          ? _value.profitGrowth
          : profitGrowth // ignore: cast_nullable_to_non_nullable
              as double?,
      operatingMargin: freezed == operatingMargin
          ? _value.operatingMargin
          : operatingMargin // ignore: cast_nullable_to_non_nullable
              as double?,
      netMargin: freezed == netMargin
          ? _value.netMargin
          : netMargin // ignore: cast_nullable_to_non_nullable
              as double?,
      assetTurnover: freezed == assetTurnover
          ? _value.assetTurnover
          : assetTurnover // ignore: cast_nullable_to_non_nullable
              as double?,
      workingCapital: freezed == workingCapital
          ? _value.workingCapital
          : workingCapital // ignore: cast_nullable_to_non_nullable
              as double?,
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
      priceToBook: freezed == priceToBook
          ? _value.priceToBook
          : priceToBook // ignore: cast_nullable_to_non_nullable
              as double?,
      evToEbitda: freezed == evToEbitda
          ? _value.evToEbitda
          : evToEbitda // ignore: cast_nullable_to_non_nullable
              as double?,
      pegRatio: freezed == pegRatio
          ? _value.pegRatio
          : pegRatio // ignore: cast_nullable_to_non_nullable
              as double?,
      enterpriseValue: freezed == enterpriseValue
          ? _value.enterpriseValue
          : enterpriseValue // ignore: cast_nullable_to_non_nullable
              as double?,
      earningsPerShare: freezed == earningsPerShare
          ? _value.earningsPerShare
          : earningsPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      cashPerShare: freezed == cashPerShare
          ? _value.cashPerShare
          : cashPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      salesPerShare: freezed == salesPerShare
          ? _value.salesPerShare
          : salesPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      returnOnAssets: freezed == returnOnAssets
          ? _value.returnOnAssets
          : returnOnAssets // ignore: cast_nullable_to_non_nullable
              as double?,
      returnOnCapitalEmployed: freezed == returnOnCapitalEmployed
          ? _value.returnOnCapitalEmployed
          : returnOnCapitalEmployed // ignore: cast_nullable_to_non_nullable
              as double?,
      returnOnEquity: freezed == returnOnEquity
          ? _value.returnOnEquity
          : returnOnEquity // ignore: cast_nullable_to_non_nullable
              as double?,
      sector: freezed == sector
          ? _value.sector
          : sector // ignore: cast_nullable_to_non_nullable
              as String?,
      industry: freezed == industry
          ? _value.industry
          : industry // ignore: cast_nullable_to_non_nullable
              as String?,
      beta: freezed == beta
          ? _value.beta
          : beta // ignore: cast_nullable_to_non_nullable
              as double?,
      sharesOutstanding: freezed == sharesOutstanding
          ? _value.sharesOutstanding
          : sharesOutstanding // ignore: cast_nullable_to_non_nullable
              as int?,
      promoterHolding: freezed == promoterHolding
          ? _value.promoterHolding
          : promoterHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      publicHolding: freezed == publicHolding
          ? _value.publicHolding
          : publicHolding // ignore: cast_nullable_to_non_nullable
              as double?,
      dayHigh: freezed == dayHigh
          ? _value.dayHigh
          : dayHigh // ignore: cast_nullable_to_non_nullable
              as double?,
      dayLow: freezed == dayLow
          ? _value.dayLow
          : dayLow // ignore: cast_nullable_to_non_nullable
              as double?,
      weekHigh52: freezed == weekHigh52
          ? _value.weekHigh52
          : weekHigh52 // ignore: cast_nullable_to_non_nullable
              as double?,
      weekLow52: freezed == weekLow52
          ? _value.weekLow52
          : weekLow52 // ignore: cast_nullable_to_non_nullable
              as double?,
      averageVolume: freezed == averageVolume
          ? _value.averageVolume
          : averageVolume // ignore: cast_nullable_to_non_nullable
              as double?,
      marketLot: freezed == marketLot
          ? _value.marketLot
          : marketLot // ignore: cast_nullable_to_non_nullable
              as double?,
      dividendPerShare: freezed == dividendPerShare
          ? _value.dividendPerShare
          : dividendPerShare // ignore: cast_nullable_to_non_nullable
              as double?,
      exDividendDate: freezed == exDividendDate
          ? _value.exDividendDate
          : exDividendDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recordDate: freezed == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      corporateActions: null == corporateActions
          ? _value._corporateActions
          : corporateActions // ignore: cast_nullable_to_non_nullable
              as List<CorporateAction>,
      recentNews: null == recentNews
          ? _value._recentNews
          : recentNews // ignore: cast_nullable_to_non_nullable
              as List<CompanyNews>,
      analystRecommendations: freezed == analystRecommendations
          ? _value.analystRecommendations
          : analystRecommendations // ignore: cast_nullable_to_non_nullable
              as AnalystRecommendations?,
      peerCompanies: null == peerCompanies
          ? _value._peerCompanies
          : peerCompanies // ignore: cast_nullable_to_non_nullable
              as List<String>,
      esgScores: freezed == esgScores
          ? _value.esgScores
          : esgScores // ignore: cast_nullable_to_non_nullable
              as ESGScores?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyModelImpl extends _CompanyModel {
  const _$CompanyModelImpl(
      {required this.symbol,
      required this.name,
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
      @TimestampConverter() this.lastUpdated,
      final Map<String, dynamic> ratiosData = const {},
      this.changePercent = 0.0,
      this.changeAmount = 0.0,
      this.previousClose = 0.0,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt,
      this.quarterlyResults,
      this.profitLossStatement,
      this.balanceSheet,
      this.cashFlowStatement,
      this.ratios,
      final List<String> industryClassification = const [],
      this.shareholdingPattern,
      final Map<String, dynamic> growthTables = const {},
      this.salesGrowth,
      this.profitGrowth,
      this.operatingMargin,
      this.netMargin,
      this.assetTurnover,
      this.workingCapital,
      this.debtToEquity,
      this.currentRatio,
      this.quickRatio,
      this.interestCoverage,
      this.priceToBook,
      this.evToEbitda,
      this.pegRatio,
      this.enterpriseValue,
      this.earningsPerShare,
      this.cashPerShare,
      this.salesPerShare,
      this.returnOnAssets,
      this.returnOnCapitalEmployed,
      this.returnOnEquity,
      this.sector,
      this.industry,
      this.beta,
      this.sharesOutstanding,
      this.promoterHolding,
      this.publicHolding,
      this.dayHigh,
      this.dayLow,
      this.weekHigh52,
      this.weekLow52,
      this.averageVolume,
      this.marketLot,
      this.dividendPerShare,
      this.exDividendDate,
      this.recordDate,
      final List<CorporateAction> corporateActions = const [],
      final List<CompanyNews> recentNews = const [],
      this.analystRecommendations,
      final List<String> peerCompanies = const [],
      this.esgScores})
      : _pros = pros,
        _cons = cons,
        _ratiosData = ratiosData,
        _industryClassification = industryClassification,
        _growthTables = growthTables,
        _corporateActions = corporateActions,
        _recentNews = recentNews,
        _peerCompanies = peerCompanies,
        super._();

  factory _$CompanyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyModelImplFromJson(json);

  @override
  final String symbol;
  @override
  final String name;
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

  @override
  @TimestampConverter()
  final DateTime? lastUpdated;
  final Map<String, dynamic> _ratiosData;
  @override
  @JsonKey()
  Map<String, dynamic> get ratiosData {
    if (_ratiosData is EqualUnmodifiableMapView) return _ratiosData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_ratiosData);
  }

  @override
  @JsonKey()
  final double changePercent;
  @override
  @JsonKey()
  final double changeAmount;
  @override
  @JsonKey()
  final double previousClose;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
// Comprehensive Financial Data - from your Firebase Functions
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
// Growth tables data (flexible structure from your scraping)
  final Map<String, dynamic> _growthTables;
// Growth tables data (flexible structure from your scraping)
  @override
  @JsonKey()
  Map<String, dynamic> get growthTables {
    if (_growthTables is EqualUnmodifiableMapView) return _growthTables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_growthTables);
  }

// Additional financial metrics from screener.in
  @override
  final double? salesGrowth;
  @override
  final double? profitGrowth;
  @override
  final double? operatingMargin;
  @override
  final double? netMargin;
  @override
  final double? assetTurnover;
  @override
  final double? workingCapital;
  @override
  final double? debtToEquity;
  @override
  final double? currentRatio;
  @override
  final double? quickRatio;
  @override
  final double? interestCoverage;
// Valuation metrics
  @override
  final double? priceToBook;
  @override
  final double? evToEbitda;
  @override
  final double? pegRatio;
  @override
  final double? enterpriseValue;
// Per share data
  @override
  final double? earningsPerShare;
  @override
  final double? cashPerShare;
  @override
  final double? salesPerShare;
// Management quality indicators
  @override
  final double? returnOnAssets;
  @override
  final double? returnOnCapitalEmployed;
  @override
  final double? returnOnEquity;
// Additional screener.in specific data
  @override
  final String? sector;
  @override
  final String? industry;
  @override
  final double? beta;
  @override
  final int? sharesOutstanding;
  @override
  final double? promoterHolding;
  @override
  final double? publicHolding;
// Technical indicators
  @override
  final double? dayHigh;
  @override
  final double? dayLow;
  @override
  final double? weekHigh52;
  @override
  final double? weekLow52;
  @override
  final double? averageVolume;
  @override
  final double? marketLot;
// Dividend information
  @override
  final double? dividendPerShare;
  @override
  final DateTime? exDividendDate;
  @override
  final DateTime? recordDate;
// Corporate actions
  final List<CorporateAction> _corporateActions;
// Corporate actions
  @override
  @JsonKey()
  List<CorporateAction> get corporateActions {
    if (_corporateActions is EqualUnmodifiableListView)
      return _corporateActions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_corporateActions);
  }

// News and updates
  final List<CompanyNews> _recentNews;
// News and updates
  @override
  @JsonKey()
  List<CompanyNews> get recentNews {
    if (_recentNews is EqualUnmodifiableListView) return _recentNews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentNews);
  }

// Analyst recommendations
  @override
  final AnalystRecommendations? analystRecommendations;
// Peer comparison data
  final List<String> _peerCompanies;
// Peer comparison data
  @override
  @JsonKey()
  List<String> get peerCompanies {
    if (_peerCompanies is EqualUnmodifiableListView) return _peerCompanies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_peerCompanies);
  }

// ESG scores (if available)
  @override
  final ESGScores? esgScores;

  @override
  String toString() {
    return 'CompanyModel(symbol: $symbol, name: $name, about: $about, website: $website, bseCode: $bseCode, nseCode: $nseCode, marketCap: $marketCap, currentPrice: $currentPrice, highLow: $highLow, stockPe: $stockPe, bookValue: $bookValue, dividendYield: $dividendYield, roce: $roce, roe: $roe, faceValue: $faceValue, pros: $pros, cons: $cons, lastUpdated: $lastUpdated, ratiosData: $ratiosData, changePercent: $changePercent, changeAmount: $changeAmount, previousClose: $previousClose, createdAt: $createdAt, updatedAt: $updatedAt, quarterlyResults: $quarterlyResults, profitLossStatement: $profitLossStatement, balanceSheet: $balanceSheet, cashFlowStatement: $cashFlowStatement, ratios: $ratios, industryClassification: $industryClassification, shareholdingPattern: $shareholdingPattern, growthTables: $growthTables, salesGrowth: $salesGrowth, profitGrowth: $profitGrowth, operatingMargin: $operatingMargin, netMargin: $netMargin, assetTurnover: $assetTurnover, workingCapital: $workingCapital, debtToEquity: $debtToEquity, currentRatio: $currentRatio, quickRatio: $quickRatio, interestCoverage: $interestCoverage, priceToBook: $priceToBook, evToEbitda: $evToEbitda, pegRatio: $pegRatio, enterpriseValue: $enterpriseValue, earningsPerShare: $earningsPerShare, cashPerShare: $cashPerShare, salesPerShare: $salesPerShare, returnOnAssets: $returnOnAssets, returnOnCapitalEmployed: $returnOnCapitalEmployed, returnOnEquity: $returnOnEquity, sector: $sector, industry: $industry, beta: $beta, sharesOutstanding: $sharesOutstanding, promoterHolding: $promoterHolding, publicHolding: $publicHolding, dayHigh: $dayHigh, dayLow: $dayLow, weekHigh52: $weekHigh52, weekLow52: $weekLow52, averageVolume: $averageVolume, marketLot: $marketLot, dividendPerShare: $dividendPerShare, exDividendDate: $exDividendDate, recordDate: $recordDate, corporateActions: $corporateActions, recentNews: $recentNews, analystRecommendations: $analystRecommendations, peerCompanies: $peerCompanies, esgScores: $esgScores)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyModelImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.name, name) || other.name == name) &&
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
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            const DeepCollectionEquality()
                .equals(other._ratiosData, _ratiosData) &&
            (identical(other.changePercent, changePercent) ||
                other.changePercent == changePercent) &&
            (identical(other.changeAmount, changeAmount) ||
                other.changeAmount == changeAmount) &&
            (identical(other.previousClose, previousClose) ||
                other.previousClose == previousClose) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
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
                .equals(other._growthTables, _growthTables) &&
            (identical(other.salesGrowth, salesGrowth) ||
                other.salesGrowth == salesGrowth) &&
            (identical(other.profitGrowth, profitGrowth) ||
                other.profitGrowth == profitGrowth) &&
            (identical(other.operatingMargin, operatingMargin) ||
                other.operatingMargin == operatingMargin) &&
            (identical(other.netMargin, netMargin) ||
                other.netMargin == netMargin) &&
            (identical(other.assetTurnover, assetTurnover) ||
                other.assetTurnover == assetTurnover) &&
            (identical(other.workingCapital, workingCapital) ||
                other.workingCapital == workingCapital) &&
            (identical(other.debtToEquity, debtToEquity) ||
                other.debtToEquity == debtToEquity) &&
            (identical(other.currentRatio, currentRatio) ||
                other.currentRatio == currentRatio) &&
            (identical(other.quickRatio, quickRatio) ||
                other.quickRatio == quickRatio) &&
            (identical(other.interestCoverage, interestCoverage) ||
                other.interestCoverage == interestCoverage) &&
            (identical(other.priceToBook, priceToBook) ||
                other.priceToBook == priceToBook) &&
            (identical(other.evToEbitda, evToEbitda) ||
                other.evToEbitda == evToEbitda) &&
            (identical(other.pegRatio, pegRatio) ||
                other.pegRatio == pegRatio) &&
            (identical(other.enterpriseValue, enterpriseValue) ||
                other.enterpriseValue == enterpriseValue) &&
            (identical(other.earningsPerShare, earningsPerShare) ||
                other.earningsPerShare == earningsPerShare) &&
            (identical(other.cashPerShare, cashPerShare) ||
                other.cashPerShare == cashPerShare) &&
            (identical(other.salesPerShare, salesPerShare) ||
                other.salesPerShare == salesPerShare) &&
            (identical(other.returnOnAssets, returnOnAssets) ||
                other.returnOnAssets == returnOnAssets) &&
            (identical(other.returnOnCapitalEmployed, returnOnCapitalEmployed) ||
                other.returnOnCapitalEmployed == returnOnCapitalEmployed) &&
            (identical(other.returnOnEquity, returnOnEquity) ||
                other.returnOnEquity == returnOnEquity) &&
            (identical(other.sector, sector) || other.sector == sector) &&
            (identical(other.industry, industry) ||
                other.industry == industry) &&
            (identical(other.beta, beta) || other.beta == beta) &&
            (identical(other.sharesOutstanding, sharesOutstanding) ||
                other.sharesOutstanding == sharesOutstanding) &&
            (identical(other.promoterHolding, promoterHolding) ||
                other.promoterHolding == promoterHolding) &&
            (identical(other.publicHolding, publicHolding) || other.publicHolding == publicHolding) &&
            (identical(other.dayHigh, dayHigh) || other.dayHigh == dayHigh) &&
            (identical(other.dayLow, dayLow) || other.dayLow == dayLow) &&
            (identical(other.weekHigh52, weekHigh52) || other.weekHigh52 == weekHigh52) &&
            (identical(other.weekLow52, weekLow52) || other.weekLow52 == weekLow52) &&
            (identical(other.averageVolume, averageVolume) || other.averageVolume == averageVolume) &&
            (identical(other.marketLot, marketLot) || other.marketLot == marketLot) &&
            (identical(other.dividendPerShare, dividendPerShare) || other.dividendPerShare == dividendPerShare) &&
            (identical(other.exDividendDate, exDividendDate) || other.exDividendDate == exDividendDate) &&
            (identical(other.recordDate, recordDate) || other.recordDate == recordDate) &&
            const DeepCollectionEquality().equals(other._corporateActions, _corporateActions) &&
            const DeepCollectionEquality().equals(other._recentNews, _recentNews) &&
            (identical(other.analystRecommendations, analystRecommendations) || other.analystRecommendations == analystRecommendations) &&
            const DeepCollectionEquality().equals(other._peerCompanies, _peerCompanies) &&
            (identical(other.esgScores, esgScores) || other.esgScores == esgScores));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        symbol,
        name,
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
        lastUpdated,
        const DeepCollectionEquality().hash(_ratiosData),
        changePercent,
        changeAmount,
        previousClose,
        createdAt,
        updatedAt,
        quarterlyResults,
        profitLossStatement,
        balanceSheet,
        cashFlowStatement,
        ratios,
        const DeepCollectionEquality().hash(_industryClassification),
        shareholdingPattern,
        const DeepCollectionEquality().hash(_growthTables),
        salesGrowth,
        profitGrowth,
        operatingMargin,
        netMargin,
        assetTurnover,
        workingCapital,
        debtToEquity,
        currentRatio,
        quickRatio,
        interestCoverage,
        priceToBook,
        evToEbitda,
        pegRatio,
        enterpriseValue,
        earningsPerShare,
        cashPerShare,
        salesPerShare,
        returnOnAssets,
        returnOnCapitalEmployed,
        returnOnEquity,
        sector,
        industry,
        beta,
        sharesOutstanding,
        promoterHolding,
        publicHolding,
        dayHigh,
        dayLow,
        weekHigh52,
        weekLow52,
        averageVolume,
        marketLot,
        dividendPerShare,
        exDividendDate,
        recordDate,
        const DeepCollectionEquality().hash(_corporateActions),
        const DeepCollectionEquality().hash(_recentNews),
        analystRecommendations,
        const DeepCollectionEquality().hash(_peerCompanies),
        esgScores
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
      @TimestampConverter() final DateTime? lastUpdated,
      final Map<String, dynamic> ratiosData,
      final double changePercent,
      final double changeAmount,
      final double previousClose,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt,
      final FinancialDataModel? quarterlyResults,
      final FinancialDataModel? profitLossStatement,
      final FinancialDataModel? balanceSheet,
      final FinancialDataModel? cashFlowStatement,
      final FinancialDataModel? ratios,
      final List<String> industryClassification,
      final ShareholdingPattern? shareholdingPattern,
      final Map<String, dynamic> growthTables,
      final double? salesGrowth,
      final double? profitGrowth,
      final double? operatingMargin,
      final double? netMargin,
      final double? assetTurnover,
      final double? workingCapital,
      final double? debtToEquity,
      final double? currentRatio,
      final double? quickRatio,
      final double? interestCoverage,
      final double? priceToBook,
      final double? evToEbitda,
      final double? pegRatio,
      final double? enterpriseValue,
      final double? earningsPerShare,
      final double? cashPerShare,
      final double? salesPerShare,
      final double? returnOnAssets,
      final double? returnOnCapitalEmployed,
      final double? returnOnEquity,
      final String? sector,
      final String? industry,
      final double? beta,
      final int? sharesOutstanding,
      final double? promoterHolding,
      final double? publicHolding,
      final double? dayHigh,
      final double? dayLow,
      final double? weekHigh52,
      final double? weekLow52,
      final double? averageVolume,
      final double? marketLot,
      final double? dividendPerShare,
      final DateTime? exDividendDate,
      final DateTime? recordDate,
      final List<CorporateAction> corporateActions,
      final List<CompanyNews> recentNews,
      final AnalystRecommendations? analystRecommendations,
      final List<String> peerCompanies,
      final ESGScores? esgScores}) = _$CompanyModelImpl;
  const _CompanyModel._() : super._();

  factory _CompanyModel.fromJson(Map<String, dynamic> json) =
      _$CompanyModelImpl.fromJson;

  @override
  String get symbol;
  @override
  String get name;
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
  @override
  @TimestampConverter()
  DateTime? get lastUpdated;
  @override
  Map<String, dynamic> get ratiosData;
  @override
  double get changePercent;
  @override
  double get changeAmount;
  @override
  double get previousClose;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override // Comprehensive Financial Data - from your Firebase Functions
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
  @override // Growth tables data (flexible structure from your scraping)
  Map<String, dynamic> get growthTables;
  @override // Additional financial metrics from screener.in
  double? get salesGrowth;
  @override
  double? get profitGrowth;
  @override
  double? get operatingMargin;
  @override
  double? get netMargin;
  @override
  double? get assetTurnover;
  @override
  double? get workingCapital;
  @override
  double? get debtToEquity;
  @override
  double? get currentRatio;
  @override
  double? get quickRatio;
  @override
  double? get interestCoverage;
  @override // Valuation metrics
  double? get priceToBook;
  @override
  double? get evToEbitda;
  @override
  double? get pegRatio;
  @override
  double? get enterpriseValue;
  @override // Per share data
  double? get earningsPerShare;
  @override
  double? get cashPerShare;
  @override
  double? get salesPerShare;
  @override // Management quality indicators
  double? get returnOnAssets;
  @override
  double? get returnOnCapitalEmployed;
  @override
  double? get returnOnEquity;
  @override // Additional screener.in specific data
  String? get sector;
  @override
  String? get industry;
  @override
  double? get beta;
  @override
  int? get sharesOutstanding;
  @override
  double? get promoterHolding;
  @override
  double? get publicHolding;
  @override // Technical indicators
  double? get dayHigh;
  @override
  double? get dayLow;
  @override
  double? get weekHigh52;
  @override
  double? get weekLow52;
  @override
  double? get averageVolume;
  @override
  double? get marketLot;
  @override // Dividend information
  double? get dividendPerShare;
  @override
  DateTime? get exDividendDate;
  @override
  DateTime? get recordDate;
  @override // Corporate actions
  List<CorporateAction> get corporateActions;
  @override // News and updates
  List<CompanyNews> get recentNews;
  @override // Analyst recommendations
  AnalystRecommendations? get analystRecommendations;
  @override // Peer comparison data
  List<String> get peerCompanies;
  @override // ESG scores (if available)
  ESGScores? get esgScores;
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

CorporateAction _$CorporateActionFromJson(Map<String, dynamic> json) {
  return _CorporateAction.fromJson(json);
}

/// @nodoc
mixin _$CorporateAction {
  String get type =>
      throw _privateConstructorUsedError; // 'dividend', 'bonus', 'split', 'rights'
  String get description => throw _privateConstructorUsedError;
  DateTime? get exDate => throw _privateConstructorUsedError;
  DateTime? get recordDate => throw _privateConstructorUsedError;
  String? get ratio => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateActionCopyWith<CorporateAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateActionCopyWith<$Res> {
  factory $CorporateActionCopyWith(
          CorporateAction value, $Res Function(CorporateAction) then) =
      _$CorporateActionCopyWithImpl<$Res, CorporateAction>;
  @useResult
  $Res call(
      {String type,
      String description,
      DateTime? exDate,
      DateTime? recordDate,
      String? ratio,
      double? amount});
}

/// @nodoc
class _$CorporateActionCopyWithImpl<$Res, $Val extends CorporateAction>
    implements $CorporateActionCopyWith<$Res> {
  _$CorporateActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? description = null,
    Object? exDate = freezed,
    Object? recordDate = freezed,
    Object? ratio = freezed,
    Object? amount = freezed,
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
      exDate: freezed == exDate
          ? _value.exDate
          : exDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recordDate: freezed == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ratio: freezed == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateActionImplCopyWith<$Res>
    implements $CorporateActionCopyWith<$Res> {
  factory _$$CorporateActionImplCopyWith(_$CorporateActionImpl value,
          $Res Function(_$CorporateActionImpl) then) =
      __$$CorporateActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String description,
      DateTime? exDate,
      DateTime? recordDate,
      String? ratio,
      double? amount});
}

/// @nodoc
class __$$CorporateActionImplCopyWithImpl<$Res>
    extends _$CorporateActionCopyWithImpl<$Res, _$CorporateActionImpl>
    implements _$$CorporateActionImplCopyWith<$Res> {
  __$$CorporateActionImplCopyWithImpl(
      _$CorporateActionImpl _value, $Res Function(_$CorporateActionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? description = null,
    Object? exDate = freezed,
    Object? recordDate = freezed,
    Object? ratio = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$CorporateActionImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      exDate: freezed == exDate
          ? _value.exDate
          : exDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      recordDate: freezed == recordDate
          ? _value.recordDate
          : recordDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ratio: freezed == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateActionImpl implements _CorporateAction {
  const _$CorporateActionImpl(
      {required this.type,
      required this.description,
      this.exDate,
      this.recordDate,
      this.ratio,
      this.amount});

  factory _$CorporateActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$CorporateActionImplFromJson(json);

  @override
  final String type;
// 'dividend', 'bonus', 'split', 'rights'
  @override
  final String description;
  @override
  final DateTime? exDate;
  @override
  final DateTime? recordDate;
  @override
  final String? ratio;
  @override
  final double? amount;

  @override
  String toString() {
    return 'CorporateAction(type: $type, description: $description, exDate: $exDate, recordDate: $recordDate, ratio: $ratio, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CorporateActionImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.exDate, exDate) || other.exDate == exDate) &&
            (identical(other.recordDate, recordDate) ||
                other.recordDate == recordDate) &&
            (identical(other.ratio, ratio) || other.ratio == ratio) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, description, exDate, recordDate, ratio, amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateActionImplCopyWith<_$CorporateActionImpl> get copyWith =>
      __$$CorporateActionImplCopyWithImpl<_$CorporateActionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateActionImplToJson(
      this,
    );
  }
}

abstract class _CorporateAction implements CorporateAction {
  const factory _CorporateAction(
      {required final String type,
      required final String description,
      final DateTime? exDate,
      final DateTime? recordDate,
      final String? ratio,
      final double? amount}) = _$CorporateActionImpl;

  factory _CorporateAction.fromJson(Map<String, dynamic> json) =
      _$CorporateActionImpl.fromJson;

  @override
  String get type;
  @override // 'dividend', 'bonus', 'split', 'rights'
  String get description;
  @override
  DateTime? get exDate;
  @override
  DateTime? get recordDate;
  @override
  String? get ratio;
  @override
  double? get amount;
  @override
  @JsonKey(ignore: true)
  _$$CorporateActionImplCopyWith<_$CorporateActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CompanyNews _$CompanyNewsFromJson(Map<String, dynamic> json) {
  return _CompanyNews.fromJson(json);
}

/// @nodoc
mixin _$CompanyNews {
  String get title => throw _privateConstructorUsedError;
  String? get summary => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  DateTime? get publishedAt => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CompanyNewsCopyWith<CompanyNews> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyNewsCopyWith<$Res> {
  factory $CompanyNewsCopyWith(
          CompanyNews value, $Res Function(CompanyNews) then) =
      _$CompanyNewsCopyWithImpl<$Res, CompanyNews>;
  @useResult
  $Res call(
      {String title,
      String? summary,
      String? url,
      DateTime? publishedAt,
      String? source});
}

/// @nodoc
class _$CompanyNewsCopyWithImpl<$Res, $Val extends CompanyNews>
    implements $CompanyNewsCopyWith<$Res> {
  _$CompanyNewsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? summary = freezed,
    Object? url = freezed,
    Object? publishedAt = freezed,
    Object? source = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CompanyNewsImplCopyWith<$Res>
    implements $CompanyNewsCopyWith<$Res> {
  factory _$$CompanyNewsImplCopyWith(
          _$CompanyNewsImpl value, $Res Function(_$CompanyNewsImpl) then) =
      __$$CompanyNewsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String? summary,
      String? url,
      DateTime? publishedAt,
      String? source});
}

/// @nodoc
class __$$CompanyNewsImplCopyWithImpl<$Res>
    extends _$CompanyNewsCopyWithImpl<$Res, _$CompanyNewsImpl>
    implements _$$CompanyNewsImplCopyWith<$Res> {
  __$$CompanyNewsImplCopyWithImpl(
      _$CompanyNewsImpl _value, $Res Function(_$CompanyNewsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? summary = freezed,
    Object? url = freezed,
    Object? publishedAt = freezed,
    Object? source = freezed,
  }) {
    return _then(_$CompanyNewsImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      summary: freezed == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      publishedAt: freezed == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      source: freezed == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompanyNewsImpl implements _CompanyNews {
  const _$CompanyNewsImpl(
      {required this.title,
      this.summary,
      this.url,
      this.publishedAt,
      this.source});

  factory _$CompanyNewsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CompanyNewsImplFromJson(json);

  @override
  final String title;
  @override
  final String? summary;
  @override
  final String? url;
  @override
  final DateTime? publishedAt;
  @override
  final String? source;

  @override
  String toString() {
    return 'CompanyNews(title: $title, summary: $summary, url: $url, publishedAt: $publishedAt, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompanyNewsImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.source, source) || other.source == source));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, summary, url, publishedAt, source);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CompanyNewsImplCopyWith<_$CompanyNewsImpl> get copyWith =>
      __$$CompanyNewsImplCopyWithImpl<_$CompanyNewsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CompanyNewsImplToJson(
      this,
    );
  }
}

abstract class _CompanyNews implements CompanyNews {
  const factory _CompanyNews(
      {required final String title,
      final String? summary,
      final String? url,
      final DateTime? publishedAt,
      final String? source}) = _$CompanyNewsImpl;

  factory _CompanyNews.fromJson(Map<String, dynamic> json) =
      _$CompanyNewsImpl.fromJson;

  @override
  String get title;
  @override
  String? get summary;
  @override
  String? get url;
  @override
  DateTime? get publishedAt;
  @override
  String? get source;
  @override
  @JsonKey(ignore: true)
  _$$CompanyNewsImplCopyWith<_$CompanyNewsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AnalystRecommendations _$AnalystRecommendationsFromJson(
    Map<String, dynamic> json) {
  return _AnalystRecommendations.fromJson(json);
}

/// @nodoc
mixin _$AnalystRecommendations {
  int get strongBuy => throw _privateConstructorUsedError;
  int get buy => throw _privateConstructorUsedError;
  int get hold => throw _privateConstructorUsedError;
  int get sell => throw _privateConstructorUsedError;
  int get strongSell => throw _privateConstructorUsedError;
  double? get averageTargetPrice => throw _privateConstructorUsedError;
  double? get highTargetPrice => throw _privateConstructorUsedError;
  double? get lowTargetPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnalystRecommendationsCopyWith<AnalystRecommendations> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalystRecommendationsCopyWith<$Res> {
  factory $AnalystRecommendationsCopyWith(AnalystRecommendations value,
          $Res Function(AnalystRecommendations) then) =
      _$AnalystRecommendationsCopyWithImpl<$Res, AnalystRecommendations>;
  @useResult
  $Res call(
      {int strongBuy,
      int buy,
      int hold,
      int sell,
      int strongSell,
      double? averageTargetPrice,
      double? highTargetPrice,
      double? lowTargetPrice});
}

/// @nodoc
class _$AnalystRecommendationsCopyWithImpl<$Res,
        $Val extends AnalystRecommendations>
    implements $AnalystRecommendationsCopyWith<$Res> {
  _$AnalystRecommendationsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strongBuy = null,
    Object? buy = null,
    Object? hold = null,
    Object? sell = null,
    Object? strongSell = null,
    Object? averageTargetPrice = freezed,
    Object? highTargetPrice = freezed,
    Object? lowTargetPrice = freezed,
  }) {
    return _then(_value.copyWith(
      strongBuy: null == strongBuy
          ? _value.strongBuy
          : strongBuy // ignore: cast_nullable_to_non_nullable
              as int,
      buy: null == buy
          ? _value.buy
          : buy // ignore: cast_nullable_to_non_nullable
              as int,
      hold: null == hold
          ? _value.hold
          : hold // ignore: cast_nullable_to_non_nullable
              as int,
      sell: null == sell
          ? _value.sell
          : sell // ignore: cast_nullable_to_non_nullable
              as int,
      strongSell: null == strongSell
          ? _value.strongSell
          : strongSell // ignore: cast_nullable_to_non_nullable
              as int,
      averageTargetPrice: freezed == averageTargetPrice
          ? _value.averageTargetPrice
          : averageTargetPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      highTargetPrice: freezed == highTargetPrice
          ? _value.highTargetPrice
          : highTargetPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      lowTargetPrice: freezed == lowTargetPrice
          ? _value.lowTargetPrice
          : lowTargetPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalystRecommendationsImplCopyWith<$Res>
    implements $AnalystRecommendationsCopyWith<$Res> {
  factory _$$AnalystRecommendationsImplCopyWith(
          _$AnalystRecommendationsImpl value,
          $Res Function(_$AnalystRecommendationsImpl) then) =
      __$$AnalystRecommendationsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int strongBuy,
      int buy,
      int hold,
      int sell,
      int strongSell,
      double? averageTargetPrice,
      double? highTargetPrice,
      double? lowTargetPrice});
}

/// @nodoc
class __$$AnalystRecommendationsImplCopyWithImpl<$Res>
    extends _$AnalystRecommendationsCopyWithImpl<$Res,
        _$AnalystRecommendationsImpl>
    implements _$$AnalystRecommendationsImplCopyWith<$Res> {
  __$$AnalystRecommendationsImplCopyWithImpl(
      _$AnalystRecommendationsImpl _value,
      $Res Function(_$AnalystRecommendationsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? strongBuy = null,
    Object? buy = null,
    Object? hold = null,
    Object? sell = null,
    Object? strongSell = null,
    Object? averageTargetPrice = freezed,
    Object? highTargetPrice = freezed,
    Object? lowTargetPrice = freezed,
  }) {
    return _then(_$AnalystRecommendationsImpl(
      strongBuy: null == strongBuy
          ? _value.strongBuy
          : strongBuy // ignore: cast_nullable_to_non_nullable
              as int,
      buy: null == buy
          ? _value.buy
          : buy // ignore: cast_nullable_to_non_nullable
              as int,
      hold: null == hold
          ? _value.hold
          : hold // ignore: cast_nullable_to_non_nullable
              as int,
      sell: null == sell
          ? _value.sell
          : sell // ignore: cast_nullable_to_non_nullable
              as int,
      strongSell: null == strongSell
          ? _value.strongSell
          : strongSell // ignore: cast_nullable_to_non_nullable
              as int,
      averageTargetPrice: freezed == averageTargetPrice
          ? _value.averageTargetPrice
          : averageTargetPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      highTargetPrice: freezed == highTargetPrice
          ? _value.highTargetPrice
          : highTargetPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      lowTargetPrice: freezed == lowTargetPrice
          ? _value.lowTargetPrice
          : lowTargetPrice // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AnalystRecommendationsImpl implements _AnalystRecommendations {
  const _$AnalystRecommendationsImpl(
      {this.strongBuy = 0,
      this.buy = 0,
      this.hold = 0,
      this.sell = 0,
      this.strongSell = 0,
      this.averageTargetPrice,
      this.highTargetPrice,
      this.lowTargetPrice});

  factory _$AnalystRecommendationsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnalystRecommendationsImplFromJson(json);

  @override
  @JsonKey()
  final int strongBuy;
  @override
  @JsonKey()
  final int buy;
  @override
  @JsonKey()
  final int hold;
  @override
  @JsonKey()
  final int sell;
  @override
  @JsonKey()
  final int strongSell;
  @override
  final double? averageTargetPrice;
  @override
  final double? highTargetPrice;
  @override
  final double? lowTargetPrice;

  @override
  String toString() {
    return 'AnalystRecommendations(strongBuy: $strongBuy, buy: $buy, hold: $hold, sell: $sell, strongSell: $strongSell, averageTargetPrice: $averageTargetPrice, highTargetPrice: $highTargetPrice, lowTargetPrice: $lowTargetPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalystRecommendationsImpl &&
            (identical(other.strongBuy, strongBuy) ||
                other.strongBuy == strongBuy) &&
            (identical(other.buy, buy) || other.buy == buy) &&
            (identical(other.hold, hold) || other.hold == hold) &&
            (identical(other.sell, sell) || other.sell == sell) &&
            (identical(other.strongSell, strongSell) ||
                other.strongSell == strongSell) &&
            (identical(other.averageTargetPrice, averageTargetPrice) ||
                other.averageTargetPrice == averageTargetPrice) &&
            (identical(other.highTargetPrice, highTargetPrice) ||
                other.highTargetPrice == highTargetPrice) &&
            (identical(other.lowTargetPrice, lowTargetPrice) ||
                other.lowTargetPrice == lowTargetPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, strongBuy, buy, hold, sell,
      strongSell, averageTargetPrice, highTargetPrice, lowTargetPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalystRecommendationsImplCopyWith<_$AnalystRecommendationsImpl>
      get copyWith => __$$AnalystRecommendationsImplCopyWithImpl<
          _$AnalystRecommendationsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AnalystRecommendationsImplToJson(
      this,
    );
  }
}

abstract class _AnalystRecommendations implements AnalystRecommendations {
  const factory _AnalystRecommendations(
      {final int strongBuy,
      final int buy,
      final int hold,
      final int sell,
      final int strongSell,
      final double? averageTargetPrice,
      final double? highTargetPrice,
      final double? lowTargetPrice}) = _$AnalystRecommendationsImpl;

  factory _AnalystRecommendations.fromJson(Map<String, dynamic> json) =
      _$AnalystRecommendationsImpl.fromJson;

  @override
  int get strongBuy;
  @override
  int get buy;
  @override
  int get hold;
  @override
  int get sell;
  @override
  int get strongSell;
  @override
  double? get averageTargetPrice;
  @override
  double? get highTargetPrice;
  @override
  double? get lowTargetPrice;
  @override
  @JsonKey(ignore: true)
  _$$AnalystRecommendationsImplCopyWith<_$AnalystRecommendationsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ESGScores _$ESGScoresFromJson(Map<String, dynamic> json) {
  return _ESGScores.fromJson(json);
}

/// @nodoc
mixin _$ESGScores {
  double? get environmental => throw _privateConstructorUsedError;
  double? get social => throw _privateConstructorUsedError;
  double? get governance => throw _privateConstructorUsedError;
  double? get overall => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ESGScoresCopyWith<ESGScores> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ESGScoresCopyWith<$Res> {
  factory $ESGScoresCopyWith(ESGScores value, $Res Function(ESGScores) then) =
      _$ESGScoresCopyWithImpl<$Res, ESGScores>;
  @useResult
  $Res call(
      {double? environmental,
      double? social,
      double? governance,
      double? overall});
}

/// @nodoc
class _$ESGScoresCopyWithImpl<$Res, $Val extends ESGScores>
    implements $ESGScoresCopyWith<$Res> {
  _$ESGScoresCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? environmental = freezed,
    Object? social = freezed,
    Object? governance = freezed,
    Object? overall = freezed,
  }) {
    return _then(_value.copyWith(
      environmental: freezed == environmental
          ? _value.environmental
          : environmental // ignore: cast_nullable_to_non_nullable
              as double?,
      social: freezed == social
          ? _value.social
          : social // ignore: cast_nullable_to_non_nullable
              as double?,
      governance: freezed == governance
          ? _value.governance
          : governance // ignore: cast_nullable_to_non_nullable
              as double?,
      overall: freezed == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ESGScoresImplCopyWith<$Res>
    implements $ESGScoresCopyWith<$Res> {
  factory _$$ESGScoresImplCopyWith(
          _$ESGScoresImpl value, $Res Function(_$ESGScoresImpl) then) =
      __$$ESGScoresImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? environmental,
      double? social,
      double? governance,
      double? overall});
}

/// @nodoc
class __$$ESGScoresImplCopyWithImpl<$Res>
    extends _$ESGScoresCopyWithImpl<$Res, _$ESGScoresImpl>
    implements _$$ESGScoresImplCopyWith<$Res> {
  __$$ESGScoresImplCopyWithImpl(
      _$ESGScoresImpl _value, $Res Function(_$ESGScoresImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? environmental = freezed,
    Object? social = freezed,
    Object? governance = freezed,
    Object? overall = freezed,
  }) {
    return _then(_$ESGScoresImpl(
      environmental: freezed == environmental
          ? _value.environmental
          : environmental // ignore: cast_nullable_to_non_nullable
              as double?,
      social: freezed == social
          ? _value.social
          : social // ignore: cast_nullable_to_non_nullable
              as double?,
      governance: freezed == governance
          ? _value.governance
          : governance // ignore: cast_nullable_to_non_nullable
              as double?,
      overall: freezed == overall
          ? _value.overall
          : overall // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ESGScoresImpl implements _ESGScores {
  const _$ESGScoresImpl(
      {this.environmental, this.social, this.governance, this.overall});

  factory _$ESGScoresImpl.fromJson(Map<String, dynamic> json) =>
      _$$ESGScoresImplFromJson(json);

  @override
  final double? environmental;
  @override
  final double? social;
  @override
  final double? governance;
  @override
  final double? overall;

  @override
  String toString() {
    return 'ESGScores(environmental: $environmental, social: $social, governance: $governance, overall: $overall)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ESGScoresImpl &&
            (identical(other.environmental, environmental) ||
                other.environmental == environmental) &&
            (identical(other.social, social) || other.social == social) &&
            (identical(other.governance, governance) ||
                other.governance == governance) &&
            (identical(other.overall, overall) || other.overall == overall));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, environmental, social, governance, overall);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ESGScoresImplCopyWith<_$ESGScoresImpl> get copyWith =>
      __$$ESGScoresImplCopyWithImpl<_$ESGScoresImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ESGScoresImplToJson(
      this,
    );
  }
}

abstract class _ESGScores implements ESGScores {
  const factory _ESGScores(
      {final double? environmental,
      final double? social,
      final double? governance,
      final double? overall}) = _$ESGScoresImpl;

  factory _ESGScores.fromJson(Map<String, dynamic> json) =
      _$ESGScoresImpl.fromJson;

  @override
  double? get environmental;
  @override
  double? get social;
  @override
  double? get governance;
  @override
  double? get overall;
  @override
  @JsonKey(ignore: true)
  _$$ESGScoresImplCopyWith<_$ESGScoresImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StockPrice _$StockPriceFromJson(Map<String, dynamic> json) {
  return _StockPrice.fromJson(json);
}

/// @nodoc
mixin _$StockPrice {
  String get symbol => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  double get change => throw _privateConstructorUsedError;
  double get changePercent => throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;
  double? get high => throw _privateConstructorUsedError;
  double? get low => throw _privateConstructorUsedError;
  double? get open => throw _privateConstructorUsedError;
  double? get previousClose => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StockPriceCopyWith<StockPrice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StockPriceCopyWith<$Res> {
  factory $StockPriceCopyWith(
          StockPrice value, $Res Function(StockPrice) then) =
      _$StockPriceCopyWithImpl<$Res, StockPrice>;
  @useResult
  $Res call(
      {String symbol,
      double price,
      double change,
      double changePercent,
      double volume,
      double? high,
      double? low,
      double? open,
      double? previousClose,
      @TimestampConverter() DateTime timestamp});
}

/// @nodoc
class _$StockPriceCopyWithImpl<$Res, $Val extends StockPrice>
    implements $StockPriceCopyWith<$Res> {
  _$StockPriceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? price = null,
    Object? change = null,
    Object? changePercent = null,
    Object? volume = null,
    Object? high = freezed,
    Object? low = freezed,
    Object? open = freezed,
    Object? previousClose = freezed,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      changePercent: null == changePercent
          ? _value.changePercent
          : changePercent // ignore: cast_nullable_to_non_nullable
              as double,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      high: freezed == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double?,
      low: freezed == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double?,
      open: freezed == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double?,
      previousClose: freezed == previousClose
          ? _value.previousClose
          : previousClose // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StockPriceImplCopyWith<$Res>
    implements $StockPriceCopyWith<$Res> {
  factory _$$StockPriceImplCopyWith(
          _$StockPriceImpl value, $Res Function(_$StockPriceImpl) then) =
      __$$StockPriceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      double price,
      double change,
      double changePercent,
      double volume,
      double? high,
      double? low,
      double? open,
      double? previousClose,
      @TimestampConverter() DateTime timestamp});
}

/// @nodoc
class __$$StockPriceImplCopyWithImpl<$Res>
    extends _$StockPriceCopyWithImpl<$Res, _$StockPriceImpl>
    implements _$$StockPriceImplCopyWith<$Res> {
  __$$StockPriceImplCopyWithImpl(
      _$StockPriceImpl _value, $Res Function(_$StockPriceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? price = null,
    Object? change = null,
    Object? changePercent = null,
    Object? volume = null,
    Object? high = freezed,
    Object? low = freezed,
    Object? open = freezed,
    Object? previousClose = freezed,
    Object? timestamp = null,
  }) {
    return _then(_$StockPriceImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      change: null == change
          ? _value.change
          : change // ignore: cast_nullable_to_non_nullable
              as double,
      changePercent: null == changePercent
          ? _value.changePercent
          : changePercent // ignore: cast_nullable_to_non_nullable
              as double,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
      high: freezed == high
          ? _value.high
          : high // ignore: cast_nullable_to_non_nullable
              as double?,
      low: freezed == low
          ? _value.low
          : low // ignore: cast_nullable_to_non_nullable
              as double?,
      open: freezed == open
          ? _value.open
          : open // ignore: cast_nullable_to_non_nullable
              as double?,
      previousClose: freezed == previousClose
          ? _value.previousClose
          : previousClose // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StockPriceImpl extends _StockPrice {
  const _$StockPriceImpl(
      {required this.symbol,
      required this.price,
      required this.change,
      required this.changePercent,
      required this.volume,
      this.high,
      this.low,
      this.open,
      this.previousClose,
      @TimestampConverter() required this.timestamp})
      : super._();

  factory _$StockPriceImpl.fromJson(Map<String, dynamic> json) =>
      _$$StockPriceImplFromJson(json);

  @override
  final String symbol;
  @override
  final double price;
  @override
  final double change;
  @override
  final double changePercent;
  @override
  final double volume;
  @override
  final double? high;
  @override
  final double? low;
  @override
  final double? open;
  @override
  final double? previousClose;
  @override
  @TimestampConverter()
  final DateTime timestamp;

  @override
  String toString() {
    return 'StockPrice(symbol: $symbol, price: $price, change: $change, changePercent: $changePercent, volume: $volume, high: $high, low: $low, open: $open, previousClose: $previousClose, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StockPriceImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.change, change) || other.change == change) &&
            (identical(other.changePercent, changePercent) ||
                other.changePercent == changePercent) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.high, high) || other.high == high) &&
            (identical(other.low, low) || other.low == low) &&
            (identical(other.open, open) || other.open == open) &&
            (identical(other.previousClose, previousClose) ||
                other.previousClose == previousClose) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, symbol, price, change,
      changePercent, volume, high, low, open, previousClose, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StockPriceImplCopyWith<_$StockPriceImpl> get copyWith =>
      __$$StockPriceImplCopyWithImpl<_$StockPriceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StockPriceImplToJson(
      this,
    );
  }
}

abstract class _StockPrice extends StockPrice {
  const factory _StockPrice(
          {required final String symbol,
          required final double price,
          required final double change,
          required final double changePercent,
          required final double volume,
          final double? high,
          final double? low,
          final double? open,
          final double? previousClose,
          @TimestampConverter() required final DateTime timestamp}) =
      _$StockPriceImpl;
  const _StockPrice._() : super._();

  factory _StockPrice.fromJson(Map<String, dynamic> json) =
      _$StockPriceImpl.fromJson;

  @override
  String get symbol;
  @override
  double get price;
  @override
  double get change;
  @override
  double get changePercent;
  @override
  double get volume;
  @override
  double? get high;
  @override
  double? get low;
  @override
  double? get open;
  @override
  double? get previousClose;
  @override
  @TimestampConverter()
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$StockPriceImplCopyWith<_$StockPriceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WatchlistItem _$WatchlistItemFromJson(Map<String, dynamic> json) {
  return _WatchlistItem.fromJson(json);
}

/// @nodoc
mixin _$WatchlistItem {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get companyName => throw _privateConstructorUsedError;
  double? get targetPrice => throw _privateConstructorUsedError;
  double? get stopLoss => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WatchlistItemCopyWith<WatchlistItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WatchlistItemCopyWith<$Res> {
  factory $WatchlistItemCopyWith(
          WatchlistItem value, $Res Function(WatchlistItem) then) =
      _$WatchlistItemCopyWithImpl<$Res, WatchlistItem>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String symbol,
      String companyName,
      double? targetPrice,
      double? stopLoss,
      String? notes,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$WatchlistItemCopyWithImpl<$Res, $Val extends WatchlistItem>
    implements $WatchlistItemCopyWith<$Res> {
  _$WatchlistItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? symbol = null,
    Object? companyName = null,
    Object? targetPrice = freezed,
    Object? stopLoss = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      targetPrice: freezed == targetPrice
          ? _value.targetPrice
          : targetPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      stopLoss: freezed == stopLoss
          ? _value.stopLoss
          : stopLoss // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WatchlistItemImplCopyWith<$Res>
    implements $WatchlistItemCopyWith<$Res> {
  factory _$$WatchlistItemImplCopyWith(
          _$WatchlistItemImpl value, $Res Function(_$WatchlistItemImpl) then) =
      __$$WatchlistItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String symbol,
      String companyName,
      double? targetPrice,
      double? stopLoss,
      String? notes,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$WatchlistItemImplCopyWithImpl<$Res>
    extends _$WatchlistItemCopyWithImpl<$Res, _$WatchlistItemImpl>
    implements _$$WatchlistItemImplCopyWith<$Res> {
  __$$WatchlistItemImplCopyWithImpl(
      _$WatchlistItemImpl _value, $Res Function(_$WatchlistItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? symbol = null,
    Object? companyName = null,
    Object? targetPrice = freezed,
    Object? stopLoss = freezed,
    Object? notes = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$WatchlistItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      targetPrice: freezed == targetPrice
          ? _value.targetPrice
          : targetPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      stopLoss: freezed == stopLoss
          ? _value.stopLoss
          : stopLoss // ignore: cast_nullable_to_non_nullable
              as double?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WatchlistItemImpl extends _WatchlistItem {
  const _$WatchlistItemImpl(
      {required this.id,
      required this.userId,
      required this.symbol,
      required this.companyName,
      this.targetPrice,
      this.stopLoss,
      this.notes,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt})
      : super._();

  factory _$WatchlistItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WatchlistItemImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String symbol;
  @override
  final String companyName;
  @override
  final double? targetPrice;
  @override
  final double? stopLoss;
  @override
  final String? notes;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'WatchlistItem(id: $id, userId: $userId, symbol: $symbol, companyName: $companyName, targetPrice: $targetPrice, stopLoss: $stopLoss, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WatchlistItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.targetPrice, targetPrice) ||
                other.targetPrice == targetPrice) &&
            (identical(other.stopLoss, stopLoss) ||
                other.stopLoss == stopLoss) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, symbol, companyName,
      targetPrice, stopLoss, notes, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WatchlistItemImplCopyWith<_$WatchlistItemImpl> get copyWith =>
      __$$WatchlistItemImplCopyWithImpl<_$WatchlistItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WatchlistItemImplToJson(
      this,
    );
  }
}

abstract class _WatchlistItem extends WatchlistItem {
  const factory _WatchlistItem(
      {required final String id,
      required final String userId,
      required final String symbol,
      required final String companyName,
      final double? targetPrice,
      final double? stopLoss,
      final String? notes,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$WatchlistItemImpl;
  const _WatchlistItem._() : super._();

  factory _WatchlistItem.fromJson(Map<String, dynamic> json) =
      _$WatchlistItemImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get symbol;
  @override
  String get companyName;
  @override
  double? get targetPrice;
  @override
  double? get stopLoss;
  @override
  String? get notes;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$WatchlistItemImplCopyWith<_$WatchlistItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
