import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'financial_data_model.dart';
import 'fundamental_filter.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

// ============================================================================
// JSON CONVERTERS FOR COMPLEX TYPES
// ============================================================================

/// 🔥 CRITICAL FIX: JsonConverter for FinancialDataModel to resolve serialization errors
class FinancialDataModelConverter
    implements JsonConverter<FinancialDataModel?, Object?> {
  const FinancialDataModelConverter();

  @override
  FinancialDataModel? fromJson(Object? json) {
    if (json == null) return null;
    try {
      if (json is FinancialDataModel) return json;
      if (json is Map<String, dynamic>) {
        return FinancialDataModel.fromJson(json);
      }
      if (json is String) {
        return FinancialDataModel.fromJson(jsonDecode(json));
      }
      return null;
    } catch (e) {
      debugPrint('Error converting from JSON to FinancialDataModel: $e');
      return null;
    }
  }

  @override
  Object? toJson(FinancialDataModel? object) {
    return object?.toJson();
  }
}

/// JsonConverter for ShareholdingPattern to handle already-parsed objects
class ShareholdingPatternConverter
    implements JsonConverter<ShareholdingPattern?, Object?> {
  const ShareholdingPatternConverter();

  @override
  ShareholdingPattern? fromJson(Object? json) {
    if (json == null) return null;
    try {
      if (json is ShareholdingPattern) return json;
      if (json.runtimeType.toString().contains('ShareholdingPattern')) {
        return json as ShareholdingPattern;
      }
      if (json is Map<String, dynamic>) {
        return ShareholdingPattern.fromJson(json);
      }
      if (json is String) {
        return ShareholdingPattern.fromJson(jsonDecode(json));
      }
      return null;
    } catch (e) {
      debugPrint('Error converting from JSON to ShareholdingPattern: $e');
      return null;
    }
  }

  @override
  Object? toJson(ShareholdingPattern? object) {
    return object?.toJson();
  }
}

// ============================================================================
// MAIN COMPANY MODEL
// ============================================================================

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

    // 🔥 CRITICAL FIX: Enhanced Financial statements with JsonConverter annotations
    @FinancialDataModelConverter() FinancialDataModel? quarterlyResults,
    @FinancialDataModelConverter() FinancialDataModel? profitLossStatement,
    @FinancialDataModelConverter() FinancialDataModel? balanceSheet,
    @FinancialDataModelConverter() FinancialDataModel? cashFlowStatement,
    @FinancialDataModelConverter() FinancialDataModel? ratios,

    // Additional financial metrics
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
    @ShareholdingPatternConverter() ShareholdingPattern? shareholdingPattern,
    @Default({}) Map<String, dynamic> ratiosData,
    @Default({}) Map<String, Map<String, String>> growthTables,

    // Historical data
    @Default([]) List<QuarterlyData> quarterlyDataHistory,
    @Default([]) List<AnnualData> annualDataHistory,

    // Peer comparison
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
    double? marketCapCategory,
    bool? isIndexConstituent,
    @Default([]) List<String> indices,

    // Technical indicators
    double? rsi,
    double? sma50,
    double? sma200,
    double? ema12,
    double? ema26,

    // Fundamental flags
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

  /// 🔥 BULLETPROOF: Enhanced fromFirestore method with comprehensive error handling
  factory CompanyModel.fromFirestore(DocumentSnapshot doc) {
    try {
      final rawData = doc.data();

      if (rawData == null) {
        throw Exception('Document data is null for ${doc.id}');
      }

      // Convert data to Map with enhanced type safety
      final dataMap = rawData is Map
          ? Map<String, dynamic>.from(rawData)
          : <String, dynamic>{};

      // Extract basic information with null safety
      final symbol = doc.id;
      final name = _safeString(dataMap['name']) ?? 'Unknown Company';
      final displayName = _safeString(dataMap['display_name']) ?? name;
      final lastUpdated = _safeString(dataMap['last_updated']) ??
          DateTime.now().toIso8601String();

      return CompanyModel.fromJson({
        // Basic company information
        'symbol': symbol,
        'name': name,
        'displayName': displayName,
        'about': _safeString(dataMap['about']),
        'website': _safeString(dataMap['website']),
        'lastUpdated': lastUpdated,

        // Stock codes (map from snake_case to camelCase)
        'bseCode': _safeString(dataMap['bse_code']),
        'nseCode': _safeString(dataMap['nse_code']),

        // 🔥 CRITICAL FIX: Correct field name mappings from Firestore snake_case to camelCase
        'marketCap': _safeDouble(dataMap['market_cap']),
        'currentPrice': _safeDouble(dataMap['current_price']),
        'changePercent': _safeDouble(dataMap['change_percent']) ?? 0.0,
        'changeAmount': _safeDouble(dataMap['change_amount']) ?? 0.0,
        'previousClose': _safeDouble(dataMap['previous_close']) ?? 0.0,
        'stockPe': _safeDouble(dataMap['stock_pe']),
        'bookValue': _safeDouble(dataMap['book_value']),
        'dividendYield': _safeDouble(dataMap['dividend_yield']),
        'roe': _safeDouble(dataMap['roe']),
        'roce': _safeDouble(dataMap['roce']),
        'faceValue': _safeDouble(dataMap['face_value']),
        'highLow': _safeString(dataMap['high_low']),

        // Growth metrics using exact field names from database
        'salesGrowth3Y': _safeDouble(dataMap['Compounded Sales Growth']),
        'profitGrowth3Y': _safeDouble(dataMap['Compounded Profit Growth']),
        'salesCAGR3Y': _safeDouble(dataMap['Stock Price CAGR']),

        // Arrays with safe parsing
        'pros': _safeStringList(dataMap['pros']) ?? [],
        'cons': _safeStringList(dataMap['cons']) ?? [],
        'industryClassification':
            _safeStringList(dataMap['industry_classification']) ?? [],

        // 🔥 FIXED: Complex objects with bulletproof parsing
        'quarterlyResults':
            _parseFinancialDataSafe(dataMap['quarterly_results']),
        'balanceSheet': _parseFinancialDataSafe(dataMap['balance_sheet']),
        'cashFlowStatement':
            _parseFinancialDataSafe(dataMap['cash_flow_statement']),
        'profitLossStatement':
            _parseFinancialDataSafe(dataMap['profit_loss_statement']),
        'ratios': _parseFinancialDataSafe(dataMap['ratios']),
        'ratiosData': _safeMap(dataMap['ratios_data']),
        'shareholdingPattern':
            _parseShareholdingPatternSafe(dataMap['shareholding_pattern']),

        // Calculated boolean flags with proper type conversion
        'isDebtFree': _calculateIsDebtFree(dataMap),
        'isProfitable': _calculateIsProfitable(dataMap),
        'hasConsistentProfits': _calculateHasConsistentProfits(dataMap),
        'paysDividends': _calculatePaysDividends(dataMap),
        'isGrowthStock': _calculateIsGrowthStock(dataMap),
        'isValueStock': _calculateIsValueStock(dataMap),
        'isQualityStock': _calculateIsQualityStock(dataMap),

        // Set defaults for missing fields
        'createdAt': null,
        'updatedAt': null,
        'quarterlyDataHistory': [],
        'annualDataHistory': [],
        'dividendHistory': [],
        'peerCompanies': [],
        'keyManagement': [],
        'indices': [],
        'growthTables': <String, Map<String, String>>{},
      });
    } catch (e, stack) {
      debugPrint('🔥 Error parsing company ${doc.id}: $e\n$stack');

      // 🔥 FALLBACK: Return minimal working company instead of crashing
      final rawData = doc.data();
      final dataMap = rawData is Map
          ? Map<String, dynamic>.from(rawData)
          : <String, dynamic>{};

      return CompanyModel.fromJson({
        'symbol': doc.id,
        'name': _safeString(dataMap['name']) ?? 'Unknown Company',
        'displayName':
            _safeString(dataMap['display_name']) ?? 'Unknown Company',
        'lastUpdated': DateTime.now().toIso8601String(),
        'marketCap': _safeDouble(dataMap['market_cap']),
        'currentPrice': _safeDouble(dataMap['current_price']),
        'changePercent': _safeDouble(dataMap['change_percent']) ?? 0.0,
        'changeAmount': 0.0,
        'previousClose': 0.0,
        'pros': <String>[],
        'cons': <String>[],
        'industryClassification': <String>[],
        'quarterlyDataHistory': <QuarterlyData>[],
        'annualDataHistory': <AnnualData>[],
        'dividendHistory': <DividendHistory>[],
        'peerCompanies': <String>[],
        'keyManagement': <String>[],
        'indices': <String>[],
        'ratiosData': <String, dynamic>{},
        'growthTables': <String, Map<String, String>>{},
      });
    }
  }

  // ============================================================================
  // HELPER METHODS FOR SAFE TYPE CONVERSION
  // ============================================================================

  static String? _safeString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    return value.toString();
  }

  static double? _safeDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      final clean = value.replaceAll(RegExp(r'[^0-9.-]'), '');
      return double.tryParse(clean);
    }
    return null;
  }

  static bool? _safeBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    if (value is int) return value != 0;
    return null;
  }

  static List<String>? _safeStringList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      return value
          .map((e) => e?.toString())
          .where((e) => e != null && e.isNotEmpty)
          .cast<String>()
          .toList();
    }
    return null;
  }

  static Map<String, dynamic> _safeMap(dynamic value) {
    if (value == null) return {};
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return {};
  }

  // ============================================================================
  // BULLETPROOF COMPLEX OBJECT PARSERS
  // ============================================================================

  /// 🔥 FIXED: Bulletproof financial data parsing with all edge cases handled
  static FinancialDataModel? _parseFinancialDataSafe(dynamic value) {
    if (value == null) return null;
    try {
      if (value is FinancialDataModel) return value;
      if (value is Map<String, dynamic>) {
        return FinancialDataModel.fromJson(value);
      }
      if (value is Map) {
        return FinancialDataModel.fromJson(Map<String, dynamic>.from(value));
      }
      if (value is String) {
        try {
          return FinancialDataModel.fromJson(jsonDecode(value));
        } catch (jsonError) {
          debugPrint('JSON decode error for FinancialDataModel: $jsonError');
          return null;
        }
      }
      return null;
    } catch (e, stack) {
      debugPrint('Error parsing financial data: $e\n$stack');
      return null;
    }
  }

  /// 🔥 FIXED: Bulletproof shareholding pattern parsing to handle Freezed objects
  static ShareholdingPattern? _parseShareholdingPatternSafe(dynamic value) {
    if (value == null) return null;
    try {
      // Handle already parsed ShareholdingPattern objects (main issue from logs!)
      if (value is ShareholdingPattern) return value;
      if (value.runtimeType.toString().contains('ShareholdingPattern')) {
        return value as ShareholdingPattern;
      }
      if (value is Map<String, dynamic>) {
        return ShareholdingPattern.fromJson(value);
      }
      if (value is Map) {
        return ShareholdingPattern.fromJson(Map<String, dynamic>.from(value));
      }
      if (value is String) {
        try {
          return ShareholdingPattern.fromJson(jsonDecode(value));
        } catch (jsonError) {
          debugPrint('JSON decode error for ShareholdingPattern: $jsonError');
          return null;
        }
      }
      return null;
    } catch (e, stack) {
      debugPrint('Error parsing shareholding pattern: $e\n$stack');
      return null;
    }
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
            debugPrint('Error parsing quarterly data: $e');
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
            debugPrint('Error parsing annual data: $e');
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
            debugPrint('Error parsing dividend history: $e');
            return null;
          }
        })
        .where((item) => item != null)
        .cast<DividendHistory>()
        .toList();
  }

  // ============================================================================
  // CALCULATED BOOLEAN FLAGS (Since they don't exist in your database)
  // ============================================================================

  static bool _calculateIsDebtFree(Map<String, dynamic> data) {
    final debtToEquity = _safeDouble(data['debt_to_equity']);
    return debtToEquity != null && debtToEquity < 0.1;
  }

  static bool _calculateIsProfitable(Map<String, dynamic> data) {
    final roe = _safeDouble(data['roe']);
    final returnOnEquity = _safeDouble(data['Return on Equity']);
    return (roe != null && roe > 0) ||
        (returnOnEquity != null && returnOnEquity > 0);
  }

  static bool _calculateHasConsistentProfits(Map<String, dynamic> data) {
    final roe = _safeDouble(data['roe']);
    final profitGrowth = _safeDouble(data['Compounded Profit Growth']);
    return (roe != null && roe > 10.0) &&
        (profitGrowth != null && profitGrowth > 0);
  }

  static bool _calculatePaysDividends(Map<String, dynamic> data) {
    final dividendYield = _safeDouble(data['dividend_yield']);
    return dividendYield != null && dividendYield > 0;
  }

  static bool _calculateIsGrowthStock(Map<String, dynamic> data) {
    final salesGrowth = _safeDouble(data['Compounded Sales Growth']);
    final profitGrowth = _safeDouble(data['Compounded Profit Growth']);
    return (salesGrowth != null && salesGrowth > 15.0) ||
        (profitGrowth != null && profitGrowth > 15.0);
  }

  static bool _calculateIsValueStock(Map<String, dynamic> data) {
    final pe = _safeDouble(data['stock_pe']);
    final roe = _safeDouble(data['roe']);
    return (pe != null && pe < 15.0 && pe > 0) && (roe != null && roe > 10.0);
  }

  static bool _calculateIsQualityStock(Map<String, dynamic> data) {
    final roe = _safeDouble(data['roe']);
    final roce = _safeDouble(data['roce']);
    return (roe != null && roe > 15.0) || (roce != null && roce > 15.0);
  }

  // ============================================================================
  // INSTANCE METHODS
  // ============================================================================

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('symbol');
    return json;
  }

  bool get isGainer => changePercent > 0;
  bool get isLoser => changePercent < 0;

  String get formattedPrice {
    return currentPrice != null
        ? '₹${currentPrice!.toStringAsFixed(2)}'
        : 'N/A';
  }

  String get formattedChange {
    if (changePercent == 0.0) return '0.00%';
    return '${changePercent > 0 ? '+' : ''}${changePercent.toStringAsFixed(2)}%';
  }

  String get formattedMarketCap {
    if (marketCap == null) return 'N/A';
    if (marketCap! >= 100000)
      return '₹${(marketCap! / 100000).toStringAsFixed(1)}L Cr';
    if (marketCap! >= 1000)
      return '₹${(marketCap! / 1000).toStringAsFixed(1)}K Cr';
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
      final diff = DateTime.now().difference(date);
      if (diff.inDays > 0) return '${diff.inDays}d ago';
      if (diff.inHours > 0) return '${diff.inHours}h ago';
      return '${diff.inMinutes}m ago';
    } catch (e) {
      return 'Unknown';
    }
  }

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

  int get qualityScore {
    int score = 0;
    if (roe != null && roe! > 15) score++;
    if (debtToEquity != null && debtToEquity! < 0.5) score++;
    if (currentRatio != null && currentRatio! > 1.5) score++;
    if (interestCoverage != null && interestCoverage! > 5) score++;
    if (hasConsistentProfits) score++;
    return score;
  }

  String get riskLevel {
    if (betaValue == null) return 'Unknown';
    if (betaValue! > 1.5) return 'High';
    if (betaValue! > 1.0) return 'Medium';
    return 'Low';
  }

  bool matchesSearchQuery(String query) {
    if (query.isEmpty) return true;
    final queryLower = query.toLowerCase();
    return name.toLowerCase().contains(queryLower) ||
        symbol.toLowerCase().contains(queryLower) ||
        displayName.toLowerCase().contains(queryLower) ||
        (sector?.toLowerCase().contains(queryLower) ?? false);
  }
}

// ============================================================================
// SUPPORTING DATA MODELS
// ============================================================================

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
    String? dividendType,
    @TimestampConverter() DateTime? exDividendDate,
    @TimestampConverter() DateTime? recordDate,
    @TimestampConverter() DateTime? paymentDate,
  }) = _DividendHistory;

  factory DividendHistory.fromJson(Map<String, dynamic> json) =>
      _$DividendHistoryFromJson(json);
}

// 🔥 FIXED: ShareholdingPattern with proper factory constructor
@freezed
class ShareholdingPattern with _$ShareholdingPattern {
  const factory ShareholdingPattern({
    @Default(<String, Map<String, String>>{})
    Map<String, Map<String, String>> quarterly,
    double? promoterHolding,
    double? publicHolding,
    double? institutionalHolding,
    double? foreignInstitutional,
    double? domesticInstitutional,
    double? governmentHolding,
    @Default(<MajorShareholder>[]) List<MajorShareholder> majorShareholders,
  }) = _ShareholdingPattern;

  // 🔥 FIXED: Proper fromJson method that will generate _$ShareholdingPatternFromJson
  factory ShareholdingPattern.fromJson(Map<String, dynamic> json) =>
      _$ShareholdingPatternFromJson(json);
}

@freezed
class MajorShareholder with _$MajorShareholder {
  const factory MajorShareholder({
    required String name,
    required double percentage,
    String? shareholderType,
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
