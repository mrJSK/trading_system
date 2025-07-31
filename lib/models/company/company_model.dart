import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'financial_data_model.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const CompanyModel._(); // Private constructor for custom methods

  const factory CompanyModel({
    required String symbol,
    required String name,
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
    @Default([]) List<String> pros,
    @Default([]) List<String> cons,
    @TimestampConverter() DateTime? lastUpdated,
    @Default({}) Map<String, dynamic> ratiosData,
    @Default(0.0) double changePercent,
    @Default(0.0) double changeAmount,
    @Default(0.0) double previousClose,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,

    // Comprehensive Financial Data - from your Firebase Functions
    FinancialDataModel? quarterlyResults,
    FinancialDataModel? profitLossStatement,
    FinancialDataModel? balanceSheet,
    FinancialDataModel? cashFlowStatement,
    FinancialDataModel? ratios,

    // Industry and shareholding data
    @Default([]) List<String> industryClassification,
    ShareholdingPattern? shareholdingPattern,

    // Growth tables data (flexible structure from your scraping)
    @Default({}) Map<String, dynamic> growthTables,

    // Additional financial metrics from screener.in
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

    // Valuation metrics
    double? priceToBook,
    double? evToEbitda,
    double? pegRatio,
    double? enterpriseValue,

    // Per share data
    double? earningsPerShare,
    double? cashPerShare,
    double? salesPerShare,

    // Management quality indicators
    double? returnOnAssets,
    double? returnOnCapitalEmployed,
    double? returnOnEquity,

    // Additional screener.in specific data
    String? sector,
    String? industry,
    double? beta,
    int? sharesOutstanding,
    double? promoterHolding,
    double? publicHolding,

    // Technical indicators
    double? dayHigh,
    double? dayLow,
    double? weekHigh52,
    double? weekLow52,
    double? averageVolume,
    double? marketLot,

    // Dividend information
    double? dividendPerShare,
    DateTime? exDividendDate,
    DateTime? recordDate,

    // Corporate actions
    @Default([]) List<CorporateAction> corporateActions,

    // News and updates
    @Default([]) List<CompanyNews> recentNews,

    // Analyst recommendations
    AnalystRecommendations? analystRecommendations,

    // Peer comparison data
    @Default([]) List<String> peerCompanies,

    // ESG scores (if available)
    ESGScores? esgScores,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  factory CompanyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CompanyModel.fromJson({...data, 'symbol': doc.id});
  }

  // Custom method for Firestore conversion
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('symbol'); // Remove symbol for Firestore (it's the doc ID)
    return json;
  }

  // Computed properties
  bool get isGainer => changePercent > 0;
  bool get isLoser => changePercent < 0;
  bool get isFlat => changePercent == 0;

  String get formattedMarketCap {
    if (marketCap == null) return 'N/A';
    if (marketCap! >= 100000) {
      return '₹${(marketCap! / 100000).toStringAsFixed(2)} Lakh Cr';
    } else if (marketCap! >= 1000) {
      return '₹${(marketCap! / 1000).toStringAsFixed(2)} Thousand Cr';
    } else {
      return '₹${marketCap!.toStringAsFixed(2)} Cr';
    }
  }

  String get formattedPrice {
    return currentPrice != null
        ? '₹${currentPrice!.toStringAsFixed(2)}'
        : 'N/A';
  }

  String get formattedChange {
    if (changePercent == 0.0) return '0.00%';
    final sign = changePercent > 0 ? '+' : '';
    return '$sign${changePercent.toStringAsFixed(2)}%';
  }

  String get formattedChangeAmount {
    if (changeAmount == 0.0) return '₹0.00';
    final sign = changeAmount > 0 ? '+' : '';
    return '$sign₹${changeAmount.abs().toStringAsFixed(2)}';
  }

  // Helper methods
  bool hasRatio(String ratio) => ratiosData.containsKey(ratio);

  String getRatio(String key) {
    return ratiosData[key]?.toString() ?? 'N/A';
  }

  // Market cap category
  String get marketCapCategory {
    if (marketCap == null) return 'Unknown';
    if (marketCap! >= 20000) return 'Large Cap';
    if (marketCap! >= 5000) return 'Mid Cap';
    return 'Small Cap';
  }

  // Financial health indicators
  bool get hasStrongFinancials {
    return (roe != null && roe! > 15) &&
        (roce != null && roce! > 15) &&
        (debtToEquity != null && debtToEquity! < 1);
  }

  bool get isUndervalued {
    return (stockPe != null && stockPe! < 20) &&
        (priceToBook != null && priceToBook! < 3);
  }

  bool get hasGrowthPotential {
    return (salesGrowth != null && salesGrowth! > 10) &&
        (profitGrowth != null && profitGrowth! > 15);
  }

  // Get latest quarterly revenue (from quarterly results)
  double? get latestQuarterlyRevenue {
    final revenueRow = quarterlyResults?.findRowByDescription('Sales');
    if (revenueRow != null) {
      return revenueRow.getNumericValue(0); // Latest quarter
    }
    return null;
  }

  // Get latest quarterly profit
  double? get latestQuarterlyProfit {
    final profitRow = quarterlyResults?.findRowByDescription('Net Profit');
    if (profitRow != null) {
      return profitRow.getNumericValue(0);
    }
    return null;
  }

  // Check if company has complete financial data
  bool get hasCompleteFinancialData {
    return quarterlyResults?.isNotEmpty == true &&
        profitLossStatement?.isNotEmpty == true &&
        balanceSheet?.isNotEmpty == true &&
        cashFlowStatement?.isNotEmpty == true;
  }

  // Get investment grade (basic algorithm)
  InvestmentGrade get investmentGrade {
    int score = 0;

    // ROE score
    if (roe != null) {
      if (roe! > 20)
        score += 2;
      else if (roe! > 15) score += 1;
    }

    // ROCE score
    if (roce != null) {
      if (roce! > 20)
        score += 2;
      else if (roce! > 15) score += 1;
    }

    // Debt to Equity score
    if (debtToEquity != null) {
      if (debtToEquity! < 0.5)
        score += 2;
      else if (debtToEquity! < 1) score += 1;
    }

    // P/E score
    if (stockPe != null) {
      if (stockPe! < 15)
        score += 2;
      else if (stockPe! < 25) score += 1;
    }

    if (score >= 6) return InvestmentGrade.excellent;
    if (score >= 4) return InvestmentGrade.good;
    if (score >= 2) return InvestmentGrade.average;
    return InvestmentGrade.poor;
  }
}

// Supporting models for comprehensive data
@freezed
class ShareholdingPattern with _$ShareholdingPattern {
  const factory ShareholdingPattern({
    @Default({}) Map<String, Map<String, String>> quarterly,
  }) = _ShareholdingPattern;

  factory ShareholdingPattern.fromJson(Map<String, dynamic> json) =>
      _$ShareholdingPatternFromJson(json);
}

@freezed
class CorporateAction with _$CorporateAction {
  const factory CorporateAction({
    required String type, // 'dividend', 'bonus', 'split', 'rights'
    required String description,
    DateTime? exDate,
    DateTime? recordDate,
    String? ratio,
    double? amount,
  }) = _CorporateAction;

  factory CorporateAction.fromJson(Map<String, dynamic> json) =>
      _$CorporateActionFromJson(json);
}

@freezed
class CompanyNews with _$CompanyNews {
  const factory CompanyNews({
    required String title,
    String? summary,
    String? url,
    DateTime? publishedAt,
    String? source,
  }) = _CompanyNews;

  factory CompanyNews.fromJson(Map<String, dynamic> json) =>
      _$CompanyNewsFromJson(json);
}

@freezed
class AnalystRecommendations with _$AnalystRecommendations {
  const factory AnalystRecommendations({
    @Default(0) int strongBuy,
    @Default(0) int buy,
    @Default(0) int hold,
    @Default(0) int sell,
    @Default(0) int strongSell,
    double? averageTargetPrice,
    double? highTargetPrice,
    double? lowTargetPrice,
  }) = _AnalystRecommendations;

  factory AnalystRecommendations.fromJson(Map<String, dynamic> json) =>
      _$AnalystRecommendationsFromJson(json);
}

@freezed
class ESGScores with _$ESGScores {
  const factory ESGScores({
    double? environmental,
    double? social,
    double? governance,
    double? overall,
  }) = _ESGScores;

  factory ESGScores.fromJson(Map<String, dynamic> json) =>
      _$ESGScoresFromJson(json);
}

enum InvestmentGrade {
  excellent,
  good,
  average,
  poor,
}

extension InvestmentGradeX on InvestmentGrade {
  String get displayName {
    switch (this) {
      case InvestmentGrade.excellent:
        return 'Excellent';
      case InvestmentGrade.good:
        return 'Good';
      case InvestmentGrade.average:
        return 'Average';
      case InvestmentGrade.poor:
        return 'Poor';
    }
  }

  Color get color {
    switch (this) {
      case InvestmentGrade.excellent:
        return Colors.green[700]!;
      case InvestmentGrade.good:
        return Colors.green[500]!;
      case InvestmentGrade.average:
        return Colors.orange[600]!;
      case InvestmentGrade.poor:
        return Colors.red[600]!;
    }
  }
}

@freezed
class StockPrice with _$StockPrice {
  const StockPrice._();

  const factory StockPrice({
    required String symbol,
    required double price,
    required double change,
    required double changePercent,
    required double volume,
    double? high,
    double? low,
    double? open,
    double? previousClose,
    @TimestampConverter() required DateTime timestamp,
  }) = _StockPrice;

  factory StockPrice.fromJson(Map<String, dynamic> json) =>
      _$StockPriceFromJson(json);

  factory StockPrice.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return StockPrice.fromJson({...data, 'symbol': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('symbol');
    return json;
  }

  bool get isGainer => changePercent > 0;
  bool get isLoser => changePercent < 0;

  String get formattedPrice => '₹${price.toStringAsFixed(2)}';
  String get formattedChange {
    final sign = changePercent > 0 ? '+' : '';
    return '$sign${changePercent.toStringAsFixed(2)}%';
  }
}

@freezed
class WatchlistItem with _$WatchlistItem {
  const WatchlistItem._();

  const factory WatchlistItem({
    required String id,
    required String userId,
    required String symbol,
    required String companyName,
    double? targetPrice,
    double? stopLoss,
    String? notes,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _WatchlistItem;

  factory WatchlistItem.fromJson(Map<String, dynamic> json) =>
      _$WatchlistItemFromJson(json);

  factory WatchlistItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WatchlistItem.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  bool get hasTargetPrice => targetPrice != null;
  bool get hasStopLoss => stopLoss != null;
}

// Custom converter for Firestore Timestamps
class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    return null;
  }

  @override
  Object? toJson(DateTime? object) {
    return object?.toIso8601String();
  }
}
