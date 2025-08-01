import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'financial_data_model.dart';
import 'fundamental_filter.dart'; // Import this to use FundamentalType

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  const CompanyModel._();

  const factory CompanyModel({
    required String symbol,
    required String name,
    required String displayName,
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

    // Firebase document timestamps
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    // API data timestamp
    required String lastUpdated,
    @Default(0.0) double changePercent,
    @Default(0.0) double changeAmount,
    @Default(0.0) double previousClose,

    // Enhanced Financial statements with time-series data
    FinancialDataModel? quarterlyResults,
    FinancialDataModel? profitLossStatement,
    FinancialDataModel? balanceSheet,
    FinancialDataModel? cashFlowStatement,
    FinancialDataModel? ratios,

    // Additional financial metrics for comprehensive analysis
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

    // Growth metrics
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

    // Valuation and quality scores
    double? piotroskiScore,
    double? altmanZScore,
    String? creditRating,

    // Industry and shareholding data
    String? sector,
    String? industry,
    @Default([]) List<String> industryClassification,
    ShareholdingPattern? shareholdingPattern,
    @Default({}) Map<String, dynamic> ratiosData,
    @Default({}) Map<String, Map<String, String>> growthTables,

    // Historical quarterly data for time-series analysis
    @Default([]) List<QuarterlyData> quarterlyDataHistory,
    @Default([]) List<AnnualData> annualDataHistory,

    // Peer comparison data
    @Default([]) List<String> peerCompanies,
    double? sectorPE,
    double? sectorROE,
    double? sectorDebtToEquity,

    // Dividend information
    double? dividendPerShare,
    String? dividendFrequency,
    @Default([]) List<DividendHistory> dividendHistory,

    // Management and governance
    @Default([]) List<String> keyManagement,
    double? promoterHolding,
    double? institutionalHolding,
    double? publicHolding,

    // Risk metrics
    double? volatility30D,
    double? volatility1Y,
    double? maxDrawdown,
    double? sharpeRatio,

    // Market data
    double? marketCapCategory, // 1=Small, 2=Mid, 3=Large
    bool? isIndexConstituent,
    @Default([]) List<String> indices,

    // Technical indicators
    double? rsi,
    double? sma50,
    double? sma200,
    double? ema12,
    double? ema26,

    // Fundamental flags for screening
    @Default(false) bool isDebtFree,
    @Default(false) bool isProfitable,
    @Default(false) bool hasConsistentProfits,
    @Default(false) bool paysDividends,
    @Default(false) bool isGrowthStock,
    @Default(false) bool isValueStock,
    @Default(false) bool isQualityStock,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  // FIXED: Enhanced fromFirestore method with proper null handling
  factory CompanyModel.fromFirestore(DocumentSnapshot doc) {
    try {
      final data = doc.data() as Map<String, dynamic>?;

      if (data == null) {
        throw Exception('Document data is null for ${doc.id}');
      }

      // Safely extract and provide defaults for required fields
      final symbol = doc.id;
      final name = _safeString(data['name']) ??
          _safeString(data['displayName']) ??
          'Unknown Company';
      final displayName = _safeString(data['displayName']) ??
          _safeString(data['name']) ??
          'Unknown Company';
      final lastUpdated =
          _safeString(data['lastUpdated']) ?? DateTime.now().toIso8601String();

      return CompanyModel.fromJson({
        ...data,
        'symbol': symbol,
        'name': name,
        'displayName': displayName,
        'lastUpdated': lastUpdated,
        // Ensure numeric fields are properly typed
        'marketCap': _safeDouble(data['marketCap']),
        'currentPrice': _safeDouble(data['currentPrice']),
        'stockPe': _safeDouble(data['stockPe']),
        'roe': _safeDouble(data['roe']),
        'changePercent': _safeDouble(data['changePercent']) ?? 0.0,
        'changeAmount': _safeDouble(data['changeAmount']) ?? 0.0,
        'previousClose': _safeDouble(data['previousClose']) ?? 0.0,
        // Ensure boolean fields are properly typed
        'isDebtFree': _safeBool(data['isDebtFree']) ?? false,
        'isProfitable': _safeBool(data['isProfitable']) ?? false,
        'hasConsistentProfits':
            _safeBool(data['hasConsistentProfits']) ?? false,
        'paysDividends': _safeBool(data['paysDividends']) ?? false,
        'isGrowthStock': _safeBool(data['isGrowthStock']) ?? false,
        'isValueStock': _safeBool(data['isValueStock']) ?? false,
        'isQualityStock': _safeBool(data['isQualityStock']) ?? false,
        // Ensure array fields are properly typed
        'pros': _safeStringList(data['pros']) ?? [],
        'cons': _safeStringList(data['cons']) ?? [],
        'industryClassification':
            _safeStringList(data['industryClassification']) ?? [],
        'peerCompanies': _safeStringList(data['peerCompanies']) ?? [],
        'keyManagement': _safeStringList(data['keyManagement']) ?? [],
        'indices': _safeStringList(data['indices']) ?? [],
        'quarterlyDataHistory':
            _parseQuarterlyDataList(data['quarterlyDataHistory']),
        'annualDataHistory': _parseAnnualDataList(data['annualDataHistory']),
        'dividendHistory': _parseDividendHistoryList(data['dividendHistory']),
      });
    } catch (e) {
      print('Error parsing company ${doc.id}: $e');
      rethrow;
    }
  }

  // Helper methods for safe type conversion
  static String? _safeString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    return value.toString();
  }

  static double? _safeDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static bool? _safeBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) {
      final lower = value.toLowerCase();
      if (lower == 'true') return true;
      if (lower == 'false') return false;
    }
    if (value is int) return value != 0;
    return null;
  }

  static List<String>? _safeStringList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      return value
          .map((e) => e?.toString() ?? '')
          .where((e) => e.isNotEmpty)
          .toList();
    }
    return null;
  }

  static List<QuarterlyData> _parseQuarterlyDataList(dynamic value) {
    if (value == null || value is! List) return [];
    return value
        .map((item) {
          try {
            if (item is Map<String, dynamic>) {
              return QuarterlyData.fromJson(item);
            }
            return null;
          } catch (e) {
            print('Error parsing quarterly data: $e');
            return null;
          }
        })
        .where((item) => item != null)
        .cast<QuarterlyData>()
        .toList();
  }

  static List<AnnualData> _parseAnnualDataList(dynamic value) {
    if (value == null || value is! List) return [];
    return value
        .map((item) {
          try {
            if (item is Map<String, dynamic>) {
              return AnnualData.fromJson(item);
            }
            return null;
          } catch (e) {
            print('Error parsing annual data: $e');
            return null;
          }
        })
        .where((item) => item != null)
        .cast<AnnualData>()
        .toList();
  }

  static List<DividendHistory> _parseDividendHistoryList(dynamic value) {
    if (value == null || value is! List) return [];
    return value
        .map((item) {
          try {
            if (item is Map<String, dynamic>) {
              return DividendHistory.fromJson(item);
            }
            return null;
          } catch (e) {
            print('Error parsing dividend history: $e');
            return null;
          }
        })
        .where((item) => item != null)
        .cast<DividendHistory>()
        .toList();
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('symbol');
    return json;
  }

  // Essential computed properties
  bool get isGainer => changePercent > 0;
  bool get isLoser => changePercent < 0;

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

  String get formattedMarketCap {
    if (marketCap == null) return 'N/A';
    if (marketCap! >= 100000) {
      return '₹${(marketCap! / 100000).toStringAsFixed(1)}L Cr';
    } else if (marketCap! >= 1000) {
      return '₹${(marketCap! / 1000).toStringAsFixed(1)}K Cr';
    }
    return '₹${marketCap!.toStringAsFixed(0)} Cr';
  }

  String get marketCapCategoryText {
    if (marketCap == null) return 'Unknown';
    if (marketCap! >= 20000) return 'Large Cap';
    if (marketCap! >= 5000) return 'Mid Cap';
    return 'Small Cap';
  }

  String get formattedLastUpdated {
    try {
      final date = DateTime.parse(lastUpdated);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else {
        return '${difference.inMinutes}m ago';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  // FIXED: Fundamental screening helpers with proper import
  bool matchesFundamentalFilter(FundamentalType type) {
    switch (type) {
      case FundamentalType.debtFree:
        return isDebtFree || (debtToEquity != null && debtToEquity! < 0.1);
      case FundamentalType.highROE:
        return roe != null && roe! > 15.0;
      case FundamentalType.lowPE:
        return stockPe != null && stockPe! < 20.0;
      case FundamentalType.dividendStocks:
        return paysDividends || (dividendYield != null && dividendYield! > 2.0);
      case FundamentalType.growthStocks:
        return isGrowthStock ||
            (salesGrowth3Y != null && salesGrowth3Y! > 15.0) ||
            (profitGrowth3Y != null && profitGrowth3Y! > 15.0);
      case FundamentalType.valueStocks:
        return isValueStock || (stockPe != null && stockPe! < 15.0);
      case FundamentalType.largeCap:
        return marketCap != null && marketCap! > 20000;
      case FundamentalType.midCap:
        return marketCap != null && marketCap! >= 5000 && marketCap! <= 20000;
      case FundamentalType.smallCap:
        return marketCap != null && marketCap! < 5000;
      case FundamentalType.profitableStocks:
        return isProfitable || (roe != null && roe! > 0);
      case FundamentalType.highSalesGrowth:
        return salesGrowth3Y != null && salesGrowth3Y! > 20.0;
      case FundamentalType.qualityStocks:
        return isQualityStock || qualityScore >= 3;
      case FundamentalType.momentumStocks:
        return (salesGrowth1Y != null && salesGrowth1Y! > 20.0) ||
            (profitGrowth1Y != null && profitGrowth1Y! > 20.0);
      case FundamentalType.contrarian:
        return changePercent < -10.0 &&
            (roe != null && roe! > 10.0) &&
            qualityScore >= 2;
      default:
        return false;
    }
  }

  // Quality score calculation
  int get qualityScore {
    int score = 0;
    if (roe != null && roe! > 15) score++;
    if (debtToEquity != null && debtToEquity! < 0.5) score++;
    if (currentRatio != null && currentRatio! > 1.5) score++;
    if (interestCoverage != null && interestCoverage! > 5) score++;
    if (hasConsistentProfits) score++;
    return score;
  }

  // Risk assessment
  String get riskLevel {
    if (betaValue == null) return 'Unknown';
    if (betaValue! > 1.5) return 'High';
    if (betaValue! > 1.0) return 'Medium';
    return 'Low';
  }

  // Search helper methods
  bool matchesSearchQuery(String query) {
    if (query.isEmpty) return true;
    final queryLower = query.toLowerCase();
    return name.toLowerCase().contains(queryLower) ||
        symbol.toLowerCase().contains(queryLower) ||
        displayName.toLowerCase().contains(queryLower) ||
        (sector?.toLowerCase().contains(queryLower) ?? false);
  }
}

@freezed
class QuarterlyData with _$QuarterlyData {
  const factory QuarterlyData({
    required String quarter,
    required String year,
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
    @TimestampConverter() DateTime? reportDate,
  }) = _QuarterlyData;

  factory QuarterlyData.fromJson(Map<String, dynamic> json) =>
      _$QuarterlyDataFromJson(json);
}

@freezed
class AnnualData with _$AnnualData {
  const factory AnnualData({
    required String year,
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
    @TimestampConverter() DateTime? yearEnd,
  }) = _AnnualData;

  factory AnnualData.fromJson(Map<String, dynamic> json) =>
      _$AnnualDataFromJson(json);
}

@freezed
class DividendHistory with _$DividendHistory {
  const factory DividendHistory({
    required String year,
    double? dividendPerShare,
    String? dividendType, // Interim, Final, Special
    @TimestampConverter() DateTime? exDividendDate,
    @TimestampConverter() DateTime? recordDate,
    @TimestampConverter() DateTime? paymentDate,
  }) = _DividendHistory;

  factory DividendHistory.fromJson(Map<String, dynamic> json) =>
      _$DividendHistoryFromJson(json);
}

@freezed
class ShareholdingPattern with _$ShareholdingPattern {
  const factory ShareholdingPattern({
    @Default({}) Map<String, Map<String, String>> quarterly,
    double? promoterHolding,
    double? publicHolding,
    double? institutionalHolding,
    double? foreignInstitutional,
    double? domesticInstitutional,
    double? governmentHolding,
    @Default([]) List<MajorShareholder> majorShareholders,
  }) = _ShareholdingPattern;

  factory ShareholdingPattern.fromJson(Map<String, dynamic> json) =>
      _$ShareholdingPatternFromJson(json);
}

@freezed
class MajorShareholder with _$MajorShareholder {
  const factory MajorShareholder({
    required String name,
    required double percentage,
    String? shareholderType, // Promoter, Institution, Public, etc.
  }) = _MajorShareholder;

  factory MajorShareholder.fromJson(Map<String, dynamic> json) =>
      _$MajorShareholderFromJson(json);
}

class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.tryParse(json);
    if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
    return null;
  }

  @override
  Object? toJson(DateTime? dateTime) {
    if (dateTime == null) return null;
    return Timestamp.fromDate(dateTime);
  }
}
