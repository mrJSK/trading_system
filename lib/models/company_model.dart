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

/// JsonConverter for FinancialDataModel to resolve serialization errors
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

/// JsonConverter for KeyMilestone list
class KeyMilestoneListConverter
    implements JsonConverter<List<KeyMilestone>?, Object?> {
  const KeyMilestoneListConverter();

  @override
  List<KeyMilestone>? fromJson(Object? json) {
    if (json == null) return null;
    try {
      if (json is List) {
        return json
            .map((item) => item is Map<String, dynamic>
                ? KeyMilestone.fromJson(item)
                : null)
            .where((item) => item != null)
            .cast<KeyMilestone>()
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error converting from JSON to List<KeyMilestone>: $e');
      return null;
    }
  }

  @override
  Object? toJson(List<KeyMilestone>? object) {
    return object?.map((item) => item.toJson()).toList();
  }
}

/// JsonConverter for InvestmentHighlight list
class InvestmentHighlightListConverter
    implements JsonConverter<List<InvestmentHighlight>?, Object?> {
  const InvestmentHighlightListConverter();

  @override
  List<InvestmentHighlight>? fromJson(Object? json) {
    if (json == null) return null;
    try {
      if (json is List) {
        return json
            .map((item) => item is Map<String, dynamic>
                ? InvestmentHighlight.fromJson(item)
                : null)
            .where((item) => item != null)
            .cast<InvestmentHighlight>()
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error converting from JSON to List<InvestmentHighlight>: $e');
      return null;
    }
  }

  @override
  Object? toJson(List<InvestmentHighlight>? object) {
    return object?.map((item) => item.toJson()).toList();
  }
}

/// JsonConverter for FinancialSummary list
class FinancialSummaryListConverter
    implements JsonConverter<List<FinancialSummary>?, Object?> {
  const FinancialSummaryListConverter();

  @override
  List<FinancialSummary>? fromJson(Object? json) {
    if (json == null) return null;
    try {
      if (json is List) {
        return json
            .map((item) => item is Map<String, dynamic>
                ? FinancialSummary.fromJson(item)
                : null)
            .where((item) => item != null)
            .cast<FinancialSummary>()
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error converting from JSON to List<FinancialSummary>: $e');
      return null;
    }
  }

  @override
  Object? toJson(List<FinancialSummary>? object) {
    return object?.map((item) => item.toJson()).toList();
  }
}

// ============================================================================
// MAIN COMPANY MODEL - UPDATED WITH KEY POINTS AND ENHANCED RATIOS
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

    // Enhanced Financial statements with JsonConverter annotations
    @FinancialDataModelConverter() FinancialDataModel? quarterlyResults,
    @FinancialDataModelConverter() FinancialDataModel? profitLossStatement,
    @FinancialDataModelConverter() FinancialDataModel? balanceSheet,
    @FinancialDataModelConverter() FinancialDataModel? cashFlowStatement,
    @FinancialDataModelConverter() FinancialDataModel? ratios,

    // **ENHANCED RATIOS FROM UPDATED SCRAPER** - All new fields
    double? debtToEquity,
    double? currentRatio,
    double? quickRatio,
    double? workingCapitalDays, // NEW: Working Capital Days
    double? debtorDays, // NEW: Debtor Days
    double? inventoryDays, // NEW: Inventory Days
    double? cashConversionCycle, // NEW: Cash Conversion Cycle
    double? interestCoverage,
    double? assetTurnover,

    // Additional financial metrics (keeping existing ones)
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

    // Growth metrics - using exact field names from scraper
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

    // **NEW: KEY POINTS AND COMPANY INSIGHTS FROM ENHANCED SCRAPER**
    @Default('') String businessOverview,
    String? sector,
    String? industry,
    @Default([]) List<String> industryClassification,
    @Default({}) Map<String, dynamic> recentPerformance,
    @KeyMilestoneListConverter() @Default([]) List<KeyMilestone> keyMilestones,
    @InvestmentHighlightListConverter()
    @Default([])
    List<InvestmentHighlight> investmentHighlights,
    @FinancialSummaryListConverter()
    @Default([])
    List<FinancialSummary> financialSummary,

    // **NEW: ENHANCED QUALITY AND EFFICIENCY METRICS**
    @Default(3) int qualityScore, // 1-5 score from scraper
    @Default('C') String overallQualityGrade, // A, B, C, D grade
    @Default('Unknown')
    String workingCapitalEfficiency, // Excellent, Good, Average, Poor
    @Default('Unknown') String cashCycleEfficiency,
    @Default('Unknown') String liquidityStatus,
    @Default('Unknown') String debtStatus,
    @Default('Medium') String riskLevel, // Low, Medium, High

    // Quality scores (if available from scraper)
    double? piotroskiScore,
    double? altmanZScore,
    String? qualityGrade,
    String? creditRating,

    // Shareholding data
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

  /// Enhanced fromFirestore method with new key points and ratios fields
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

        // Basic financial metrics
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

        // **NEW ENHANCED RATIOS FROM UPDATED SCRAPER**
        'debtToEquity': _safeDouble(dataMap['debt_to_equity']),
        'currentRatio': _safeDouble(dataMap['current_ratio']),
        'quickRatio': _safeDouble(dataMap['quick_ratio']),
        'workingCapitalDays': _safeDouble(dataMap['working_capital_days']),
        'debtorDays': _safeDouble(dataMap['debtor_days']),
        'inventoryDays': _safeDouble(dataMap['inventory_days']),
        'cashConversionCycle': _safeDouble(dataMap['cash_conversion_cycle']),
        'interestCoverage': _safeDouble(dataMap['interest_coverage']),
        'assetTurnover': _safeDouble(dataMap['asset_turnover']),

        // Calculate price to book if available
        'priceToBook': _calculatePriceToBook(dataMap),

        // **NEW: KEY POINTS AND COMPANY INSIGHTS**
        'businessOverview': _safeString(dataMap['business_overview']) ?? '',
        'sector': _safeString(dataMap['sector']),
        'industry': _safeString(dataMap['industry']),
        'industryClassification':
            _safeStringList(dataMap['industry_classification']) ?? [],
        'recentPerformance': _safeMap(dataMap['recent_performance']),
        'keyMilestones': _parseKeyMilestones(dataMap['key_milestones']),
        'investmentHighlights':
            _parseInvestmentHighlights(dataMap['investment_highlights']),
        'financialSummary':
            _parseFinancialSummary(dataMap['financial_summary']),

        // **NEW: ENHANCED QUALITY AND EFFICIENCY METRICS**
        'qualityScore': _safeInt(dataMap['quality_score']) ?? 3,
        'overallQualityGrade':
            _safeString(dataMap['overall_quality_grade']) ?? 'C',
        'workingCapitalEfficiency':
            _safeString(dataMap['working_capital_efficiency']) ?? 'Unknown',
        'cashCycleEfficiency':
            _safeString(dataMap['cash_cycle_efficiency']) ?? 'Unknown',
        'liquidityStatus':
            _safeString(dataMap['liquidity_status']) ?? 'Unknown',
        'debtStatus': _safeString(dataMap['debt_status']) ?? 'Unknown',
        'riskLevel': _safeString(dataMap['risk_level']) ?? 'Medium',

        // Quality scores (if available from scraper)
        'piotroskiScore': _safeDouble(dataMap['piotroski_score']),
        'altmanZScore': _safeDouble(dataMap['altman_z_score']),
        'qualityGrade': _safeString(dataMap['quality_grade']),

        // Growth metrics using exact field names from database
        'salesGrowth3Y': _safeDouble(dataMap['sales_growth_3y']) ??
            _safeDouble(dataMap['Compounded Sales Growth']),
        'profitGrowth3Y': _safeDouble(dataMap['profit_growth_3y']) ??
            _safeDouble(dataMap['Compounded Profit Growth']),
        'salesCAGR3Y': _safeDouble(dataMap['Stock Price CAGR']),

        // Arrays with safe parsing
        'pros': _safeStringList(dataMap['pros']) ?? [],
        'cons': _safeStringList(dataMap['cons']) ?? [],

        // Complex objects with bulletproof parsing
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

        // Enhanced calculated boolean flags
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

      // Fallback: Return minimal working company instead of crashing
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
        'businessOverview': '',
        'marketCap': _safeDouble(dataMap['market_cap']),
        'currentPrice': _safeDouble(dataMap['current_price']),
        'changePercent': _safeDouble(dataMap['change_percent']) ?? 0.0,
        'changeAmount': 0.0,
        'previousClose': 0.0,
        'qualityScore': 3,
        'overallQualityGrade': 'C',
        'workingCapitalEfficiency': 'Unknown',
        'cashCycleEfficiency': 'Unknown',
        'liquidityStatus': 'Unknown',
        'debtStatus': 'Unknown',
        'riskLevel': 'Medium',
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
        'recentPerformance': <String, dynamic>{},
        'keyMilestones': <KeyMilestone>[],
        'investmentHighlights': <InvestmentHighlight>[],
        'financialSummary': <FinancialSummary>[],
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

  static int? _safeInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String) {
      final clean = value.replaceAll(RegExp(r'[^0-9.-]'), '');
      return int.tryParse(clean);
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

  // Calculate price to book ratio
  static double? _calculatePriceToBook(Map<String, dynamic> data) {
    final price = _safeDouble(data['current_price']);
    final book = _safeDouble(data['book_value']);
    if (price != null && book != null && book > 0) {
      return double.parse((price / book).toStringAsFixed(2));
    }
    return null;
  }

  // ============================================================================
  // NEW: KEY POINTS PARSING METHODS
  // ============================================================================

  static List<KeyMilestone> _parseKeyMilestones(dynamic value) {
    if (value == null) return [];
    try {
      if (value is List) {
        return value
            .map((item) => item is Map<String, dynamic>
                ? KeyMilestone.fromJson(item)
                : null)
            .where((item) => item != null)
            .cast<KeyMilestone>()
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error parsing key milestones: $e');
      return [];
    }
  }

  static List<InvestmentHighlight> _parseInvestmentHighlights(dynamic value) {
    if (value == null) return [];
    try {
      if (value is List) {
        return value
            .map((item) => item is Map<String, dynamic>
                ? InvestmentHighlight.fromJson(item)
                : null)
            .where((item) => item != null)
            .cast<InvestmentHighlight>()
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error parsing investment highlights: $e');
      return [];
    }
  }

  static List<FinancialSummary> _parseFinancialSummary(dynamic value) {
    if (value == null) return [];
    try {
      if (value is List) {
        return value
            .map((item) => item is Map<String, dynamic>
                ? FinancialSummary.fromJson(item)
                : null)
            .where((item) => item != null)
            .cast<FinancialSummary>()
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error parsing financial summary: $e');
      return [];
    }
  }

  // ============================================================================
  // BULLETPROOF COMPLEX OBJECT PARSERS
  // ============================================================================

  /// Bulletproof financial data parsing with all edge cases handled
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

  /// Bulletproof shareholding pattern parsing to handle Freezed objects
  static ShareholdingPattern? _parseShareholdingPatternSafe(dynamic value) {
    if (value == null) return null;
    try {
      // Handle already parsed ShareholdingPattern objects
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

  // ============================================================================
  // ENHANCED CALCULATED BOOLEAN FLAGS
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
    final profitGrowth = _safeDouble(data['Compounded Profit Growth']) ??
        _safeDouble(data['profit_growth_3y']);
    return (roe != null && roe > 10.0) &&
        (profitGrowth != null && profitGrowth > 0);
  }

  static bool _calculatePaysDividends(Map<String, dynamic> data) {
    final dividendYield = _safeDouble(data['dividend_yield']);
    return dividendYield != null && dividendYield > 0;
  }

  static bool _calculateIsGrowthStock(Map<String, dynamic> data) {
    final salesGrowth = _safeDouble(data['Compounded Sales Growth']) ??
        _safeDouble(data['sales_growth_3y']);
    final profitGrowth = _safeDouble(data['Compounded Profit Growth']) ??
        _safeDouble(data['profit_growth_3y']);
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
    final piotroskiScore = _safeDouble(data['piotroski_score']);
    final qualityScore = _safeInt(data['quality_score']);
    return (roe != null && roe > 15.0) ||
        (roce != null && roce > 15.0) ||
        (piotroskiScore != null && piotroskiScore >= 7) ||
        (qualityScore != null && qualityScore >= 4);
  }

  // ============================================================================
  // ENHANCED INSTANCE METHODS & GETTERS
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

  // NEW: Additional formatted getters for display
  String get formattedBusinessOverview {
    if (businessOverview.isEmpty) {
      return '$name operates in the ${sector ?? "various"} sector'
          '${industry != null ? ", specifically in $industry" : ""}. '
          'With a market capitalization of $formattedMarketCap, '
          'the company is classified as a ${marketCapCategoryText.toLowerCase()} entity.';
    }
    return businessOverview;
  }

  String get formattedSector {
    return sector ?? 'Unknown Sector';
  }

  String get formattedIndustry {
    return industry ?? 'Unknown Industry';
  }

  bool matchesFundamentalFilter(FundamentalType type) {
    switch (type) {
      case FundamentalType.debtFree:
        return isDebtFree || (debtToEquity != null && debtToEquity! < 0.1);
      case FundamentalType.highROE:
        return roe != null && roe! > 15.0;
      case FundamentalType.lowPE:
        return stockPe != null && stockPe! < 20.0 && stockPe! > 0;
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

  bool matchesSearchQuery(String query) {
    if (query.isEmpty) return true;
    final queryLower = query.toLowerCase();
    return name.toLowerCase().contains(queryLower) ||
        symbol.toLowerCase().contains(queryLower) ||
        displayName.toLowerCase().contains(queryLower) ||
        (sector?.toLowerCase().contains(queryLower) ?? false) ||
        (industry?.toLowerCase().contains(queryLower) ?? false);
  }
}

// ============================================================================
// NEW: KEY POINTS SUPPORTING DATA MODELS
// ============================================================================

@freezed
class KeyMilestone with _$KeyMilestone {
  const factory KeyMilestone({
    required String category,
    required String description,
    @Default('medium') String relevance,
    String? year,
    @TimestampConverter() DateTime? date,
  }) = _KeyMilestone;

  factory KeyMilestone.fromJson(Map<String, dynamic> json) =>
      _$KeyMilestoneFromJson(json);
}

@freezed
class InvestmentHighlight with _$InvestmentHighlight {
  const factory InvestmentHighlight({
    required String type,
    required String description,
    required String impact, // positive, negative, neutral
    double? value,
    String? unit,
  }) = _InvestmentHighlight;

  factory InvestmentHighlight.fromJson(Map<String, dynamic> json) =>
      _$InvestmentHighlightFromJson(json);
}

@freezed
class FinancialSummary with _$FinancialSummary {
  const factory FinancialSummary({
    required String metric,
    required String value,
    String? unit,
    String? trend, // up, down, stable
  }) = _FinancialSummary;

  factory FinancialSummary.fromJson(Map<String, dynamic> json) =>
      _$FinancialSummaryFromJson(json);
}

// ============================================================================
// SUPPORTING DATA MODELS (keeping all your existing ones)
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
    double? profitMargin,
    double? ebitdaMargin,
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
    double? operatingProfit,
    double? ebitda,
    double? grossProfit,
    double? totalAssets,
    double? totalLiabilities,
    double? shareholdersEquity,
    double? totalDebt,
    double? workingCapital,
    double? operatingCashFlow,
    double? investingCashFlow,
    double? financingCashFlow,
    double? freeCashFlow,
    double? currentRatio,
    double? quickRatio,
    double? debtToEquity,
    double? profitMargin,
    double? ebitdaMargin,
    double? assetTurnover,
    double? inventoryTurnover,
    double? interestCoverage,
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
