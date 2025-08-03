import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:math';
import 'financial_data_model.dart';
import 'fundamental_filter.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

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

class RawFinancialTablesConverter
    implements JsonConverter<RawFinancialTables?, Object?> {
  const RawFinancialTablesConverter();

  @override
  RawFinancialTables? fromJson(Object? json) {
    if (json == null) return null;
    try {
      if (json is RawFinancialTables) return json;
      if (json is Map<String, dynamic>) {
        return RawFinancialTables.fromJson(json);
      }
      return null;
    } catch (e) {
      debugPrint('Error converting RawFinancialTables: $e');
      return null;
    }
  }

  @override
  Object? toJson(RawFinancialTables? object) {
    return object?.toJson();
  }
}

class CompanyKeyPointsConverter
    implements JsonConverter<CompanyKeyPoints?, Object?> {
  const CompanyKeyPointsConverter();

  @override
  CompanyKeyPoints? fromJson(Object? json) {
    if (json == null) return null;
    try {
      if (json is CompanyKeyPoints) return json;
      if (json is Map<String, dynamic>) {
        return CompanyKeyPoints.fromJson(json);
      }
      return null;
    } catch (e) {
      debugPrint('Error converting CompanyKeyPoints: $e');
      return null;
    }
  }

  @override
  Object? toJson(CompanyKeyPoints? object) {
    return object?.toJson();
  }
}

class CalculatedMetricsConverter
    implements JsonConverter<CalculatedMetrics?, Object?> {
  const CalculatedMetricsConverter();

  @override
  CalculatedMetrics? fromJson(Object? json) {
    if (json == null) return null;
    try {
      if (json is CalculatedMetrics) return json;
      if (json is Map<String, dynamic>) {
        return CalculatedMetrics.fromJson(json);
      }
      return null;
    } catch (e) {
      debugPrint('Error converting CalculatedMetrics: $e');
      return null;
    }
  }

  @override
  Object? toJson(CalculatedMetrics? object) {
    return object?.toJson();
  }
}

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
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    required String lastUpdated,
    @Default(0.0) double changePercent,
    @Default(0.0) double changeAmount,
    @Default(0.0) double previousClose,
    @FinancialDataModelConverter() FinancialDataModel? quarterlyResults,
    @FinancialDataModelConverter() FinancialDataModel? profitLossStatement,
    @FinancialDataModelConverter() FinancialDataModel? balanceSheet,
    @FinancialDataModelConverter() FinancialDataModel? cashFlowStatement,
    @FinancialDataModelConverter() FinancialDataModel? ratios,
    double? debtToEquity,
    double? currentRatio,
    double? quickRatio,
    double? workingCapitalDays,
    double? debtorDays,
    double? inventoryDays,
    double? cashConversionCycle,
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
    @RawFinancialTablesConverter() RawFinancialTables? rawFinancialTables,
    @CompanyKeyPointsConverter() CompanyKeyPoints? companyKeyPoints,
    @CalculatedMetricsConverter() CalculatedMetrics? calculatedMetrics,
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
    @Default(3) int qualityScore,
    @Default('C') String overallQualityGrade,
    @Default('Unknown') String workingCapitalEfficiency,
    @Default('Unknown') String cashCycleEfficiency,
    @Default('Unknown') String liquidityStatus,
    @Default('Unknown') String debtStatus,
    @Default('Medium') String riskLevel,
    double? piotroskiScore,
    double? altmanZScore,
    String? qualityGrade,
    String? creditRating,
    double? grahamNumber,
    double? roic,
    double? fcfYield,
    double? debtServiceCoverage,
    double? comprehensiveScore,
    String? investmentRecommendation,
    @ShareholdingPatternConverter() ShareholdingPattern? shareholdingPattern,
    @Default({}) Map<String, dynamic> ratiosData,
    @Default({}) Map<String, Map<String, String>> growthTables,
    @Default([]) List<QuarterlyData> quarterlyDataHistory,
    @Default([]) List<AnnualData> annualDataHistory,
    @Default([]) List<String> peerCompanies,
    double? sectorPE,
    double? sectorROE,
    double? sectorDebtToEquity,
    double? dividendPerShare,
    String? dividendFrequency,
    @Default([]) List<DividendHistory> dividendHistory,
    @Default([]) List<String> keyManagement,
    double? promoterHolding,
    double? institutionalHolding,
    double? publicHolding,
    double? volatility30D,
    double? volatility1Y,
    double? maxDrawdown,
    double? sharpeRatio,
    double? marketCapCategory,
    bool? isIndexConstituent,
    @Default([]) List<String> indices,
    double? rsi,
    double? sma50,
    double? sma200,
    double? ema12,
    double? ema26,
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

  factory CompanyModel.fromFirestore(DocumentSnapshot doc) {
    try {
      final rawData = doc.data();
      if (rawData == null) {
        throw Exception('Document data is null for ${doc.id}');
      }

      final dataMap = rawData is Map
          ? Map<String, dynamic>.from(rawData)
          : <String, dynamic>{};

      final symbol = doc.id;
      final name = _safeString(dataMap['name']) ?? 'Unknown Company';
      final displayName = _safeString(dataMap['display_name']) ?? name;
      final lastUpdated = _safeString(dataMap['last_updated']) ??
          DateTime.now().toIso8601String();

      return CompanyModel.fromJson({
        'symbol': symbol,
        'name': name,
        'displayName': displayName,
        'about': _safeString(dataMap['about']),
        'website': _safeString(dataMap['website']),
        'lastUpdated': lastUpdated,
        'bseCode': _safeString(dataMap['bse_code']),
        'nseCode': _safeString(dataMap['nse_code']),
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
        'debtToEquity': _safeDouble(dataMap['debt_to_equity']),
        'currentRatio': _safeDouble(dataMap['current_ratio']),
        'quickRatio': _safeDouble(dataMap['quick_ratio']),
        'workingCapitalDays': _safeDouble(dataMap['working_capital_days']),
        'debtorDays': _safeDouble(dataMap['debtor_days']),
        'inventoryDays': _safeDouble(dataMap['inventory_days']),
        'cashConversionCycle': _safeDouble(dataMap['cash_conversion_cycle']),
        'interestCoverage': _safeDouble(dataMap['interest_coverage']),
        'assetTurnover': _safeDouble(dataMap['asset_turnover']),
        'priceToBook': _calculatePriceToBook(dataMap),
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
        'rawFinancialTables':
            _parseRawFinancialTables(dataMap['raw_financial_tables']),
        'companyKeyPoints':
            _parseCompanyKeyPoints(dataMap['company_key_points']),
        'salesGrowth3Y': _safeDouble(dataMap['sales_growth_3y']) ??
            _safeDouble(dataMap['Compounded Sales Growth']),
        'profitGrowth3Y': _safeDouble(dataMap['profit_growth_3y']) ??
            _safeDouble(dataMap['Compounded Profit Growth']),
        'salesCAGR3Y': _safeDouble(dataMap['Stock Price CAGR']),
        'pros': _safeStringList(dataMap['pros']) ?? [],
        'cons': _safeStringList(dataMap['cons']) ?? [],
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
        'isDebtFree': _calculateIsDebtFree(dataMap),
        'isProfitable': _calculateIsProfitable(dataMap),
        'hasConsistentProfits': _calculateHasConsistentProfits(dataMap),
        'paysDividends': _calculatePaysDividends(dataMap),
        'isGrowthStock': _calculateIsGrowthStock(dataMap),
        'isValueStock': _calculateIsValueStock(dataMap),
        'isQualityStock': _calculateIsQualityStock(dataMap),
        'createdAt': null,
        'updatedAt': null,
        'quarterlyDataHistory': _processRawQuarterlyData(dataMap),
        'annualDataHistory': _processRawAnnualData(dataMap),
        'dividendHistory': [],
        'peerCompanies': [],
        'keyManagement': [],
        'indices': [],
        'growthTables': <String, Map<String, String>>{},
      });
    } catch (e, stack) {
      debugPrint('🔥 Error parsing company ${doc.id}: $e\n$stack');

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

  static double? _calculatePriceToBook(Map<String, dynamic> data) {
    final price = _safeDouble(data['current_price']);
    final book = _safeDouble(data['book_value']);
    if (price != null && book != null && book > 0) {
      return double.parse((price / book).toStringAsFixed(2));
    }
    return null;
  }

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

  static ShareholdingPattern? _parseShareholdingPatternSafe(dynamic value) {
    if (value == null) return null;
    try {
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

  static RawFinancialTables? _parseRawFinancialTables(dynamic value) {
    if (value == null) return null;
    try {
      if (value is RawFinancialTables) return value;
      if (value is Map<String, dynamic>) {
        return RawFinancialTables.fromJson(value);
      }
      return null;
    } catch (e) {
      debugPrint('Error parsing raw financial tables: $e');
      return null;
    }
  }

  static CompanyKeyPoints? _parseCompanyKeyPoints(dynamic value) {
    if (value == null) return null;
    try {
      if (value is CompanyKeyPoints) return value;
      if (value is Map<String, dynamic>) {
        return CompanyKeyPoints.fromJson(value);
      }
      return null;
    } catch (e) {
      debugPrint('Error parsing company key points: $e');
      return null;
    }
  }

  static List<AnnualData> _processRawAnnualData(Map<String, dynamic> dataMap) {
    final rawProfitLoss = dataMap['profit_loss_statement'];
    if (rawProfitLoss == null || rawProfitLoss is! Map) return [];

    try {
      final headers = rawProfitLoss['headers'] as List?;
      final body = rawProfitLoss['body'] as List?;

      if (headers == null || body == null) return [];

      List<AnnualData> annualData = [];

      for (int i = 0; i < headers.length; i++) {
        final header = headers[i].toString();
        final yearMatch = RegExp(r'(\d{4})').firstMatch(header);
        if (yearMatch == null) continue;

        final year = yearMatch.group(1)!;

        Map<String, double?> metrics = {};

        for (var row in body) {
          if (row is! Map ||
              !row.containsKey('Description') ||
              !row.containsKey('values')) continue;

          final description = row['Description'].toString().toLowerCase();
          final values = row['values'] as List;

          if (i < values.length) {
            final value = _parseFinancialValue(values[i].toString());

            if (description.contains('sales') ||
                description.contains('revenue')) {
              metrics['sales'] = value;
            } else if (description.contains('net profit')) {
              metrics['netProfit'] = value;
            } else if (description.contains('eps')) {
              metrics['eps'] = value;
            } else if (description.contains('total assets')) {
              metrics['totalAssets'] = value;
            } else if (description.contains('total liabilities')) {
              metrics['totalLiabilities'] = value;
            } else if (description.contains('shareholders equity') ||
                description.contains('net worth')) {
              metrics['shareholdersEquity'] = value;
            } else if (description.contains('ebitda')) {
              metrics['ebitda'] = value;
            }
            // ADD THIS FOR INTEREST EXPENSE:
            else if (description.contains('interest expense') ||
                description.contains('finance cost')) {
              metrics['interestExpense'] = value;
            } else if (description.contains('tax expense') ||
                description.contains('provision for tax')) {
              metrics['taxExpense'] = value;
            } else if (description.contains('depreciation')) {
              metrics['depreciation'] = value;
            } else if (description.contains('operating cash flow')) {
              metrics['operatingCashFlow'] = value;
            } else if (description.contains('free cash flow')) {
              metrics['freeCashFlow'] = value;
            }
          }
        }

        annualData.add(AnnualData(
          year: year,
          sales: metrics['sales'],
          netProfit: metrics['netProfit'],
          eps: metrics['eps'],
          totalAssets: metrics['totalAssets'],
          totalLiabilities: metrics['totalLiabilities'],
          shareholdersEquity: metrics['shareholdersEquity'],
          ebitda: metrics['ebitda'],
          interestExpense: metrics['interestExpense'], // ADD THIS
          taxExpense: metrics['taxExpense'],
          depreciation: metrics['depreciation'],
          operatingCashFlow: metrics['operatingCashFlow'],
          freeCashFlow: metrics['freeCashFlow'],
        ));
      }

      return annualData;
    } catch (e) {
      debugPrint('Error processing raw annual data: $e');
      return [];
    }
  }

  static List<QuarterlyData> _processRawQuarterlyData(
      Map<String, dynamic> dataMap) {
    final rawQuarterly = dataMap['quarterly_results'];
    if (rawQuarterly == null || rawQuarterly is! Map) return [];

    try {
      final headers = rawQuarterly['headers'] as List?;
      final body = rawQuarterly['body'] as List?;

      if (headers == null || body == null) return [];

      List<QuarterlyData> quarterlyData = [];

      for (int i = 0; i < headers.length; i++) {
        final header = headers[i].toString();

        Map<String, double?> metrics = {};

        for (var row in body) {
          if (row is! Map ||
              !row.containsKey('Description') ||
              !row.containsKey('values')) continue;

          final description = row['Description'].toString().toLowerCase();
          final values = row['values'] as List;

          if (i < values.length) {
            final value = _parseFinancialValue(values[i].toString());

            if (description.contains('sales') ||
                description.contains('revenue')) {
              metrics['sales'] = value;
            } else if (description.contains('net profit')) {
              metrics['netProfit'] = value;
            } else if (description.contains('eps')) {
              metrics['eps'] = value;
            } else if (description.contains('ebitda')) {
              metrics['ebitda'] = value;
            }
          }
        }

        quarterlyData.add(QuarterlyData(
          quarter: header,
          year: DateTime.now().year.toString(),
          sales: metrics['sales'],
          netProfit: metrics['netProfit'],
          eps: metrics['eps'],
          ebitda: metrics['ebitda'],
        ));
      }

      return quarterlyData;
    } catch (e) {
      debugPrint('Error processing raw quarterly data: $e');
      return [];
    }
  }

  static double? _parseFinancialValue(String value) {
    if (value.isEmpty || value == '-' || value.toLowerCase() == 'n/a') {
      return null;
    }

    String cleaned = value.replaceAll(RegExp(r'[^\d.-]'), '');
    return double.tryParse(cleaned);
  }

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

  double get calculatedPiotroskiScore {
    if (piotroskiScore != null) return piotroskiScore!;

    double score = 0;

    if (roe != null && roe! > 0) score += 1;
    if (currentRatio != null && currentRatio! > 1.5) score += 1;

    if (annualDataHistory.isNotEmpty && annualDataHistory.length > 1) {
      final current = annualDataHistory[0];
      final previous = annualDataHistory[1];

      if (current.operatingCashFlow != null && current.netProfit != null) {
        if (current.operatingCashFlow! > current.netProfit!) score += 1;
      }

      if (current.roe != null && previous.roe != null) {
        if (current.roe! > previous.roe!) score += 1;
      }
    }

    if (debtToEquity != null && debtToEquity! < 0.3) score += 1;
    if (currentRatio != null && currentRatio! > 1.5) score += 1;

    if (assetTurnover != null && assetTurnover! > 0.8) score += 1;
    if (workingCapitalDays != null && workingCapitalDays! < 60) score += 1;

    return score;
  }

  double get calculatedAltmanZScore {
    if (altmanZScore != null) return altmanZScore!;
    if (annualDataHistory.isEmpty) return 0;

    final latest = annualDataHistory.first;
    if (latest.totalAssets == null || latest.totalAssets! <= 0) return 0;

    double score = 0;
    final totalAssets = latest.totalAssets!;

    if (latest.workingCapital != null) {
      score += (latest.workingCapital! / totalAssets) * 1.2;
    }

    if (latest.shareholdersEquity != null) {
      score += (latest.shareholdersEquity! / totalAssets) * 1.4;
    }

    if (latest.ebitda != null) {
      score += (latest.ebitda! / totalAssets) * 3.3;
    }

    if (latest.totalLiabilities != null && marketCap != null) {
      score += (marketCap! / latest.totalLiabilities!) * 0.6;
    }

    if (latest.sales != null) {
      score += (latest.sales! / totalAssets) * 1.0;
    }

    return score;
  }

  double? get calculatedGrahamNumber {
    if (grahamNumber != null) return grahamNumber;
    if (bookValue == null || annualDataHistory.isEmpty) return null;

    final latest = annualDataHistory.first;
    if (latest.eps == null || latest.eps! <= 0) return null;

    return sqrt(22.5 * latest.eps! * bookValue!);
  }

  double? get calculatedPEGRatio {
    if (pegRatio != null) return pegRatio;
    if (stockPe == null || profitGrowth3Y == null) return null;
    if (profitGrowth3Y! <= 0) return null;

    return stockPe! / profitGrowth3Y!;
  }

  double? get calculatedROIC {
    if (roic != null) return roic;
    if (annualDataHistory.isEmpty) return null;

    final latest = annualDataHistory.first;
    if (latest.ebitda == null ||
        latest.totalAssets == null ||
        latest.totalLiabilities == null) {
      return null;
    }

    final investedCapital = latest.totalAssets! - latest.totalLiabilities!;
    if (investedCapital <= 0) return null;

    return (latest.ebitda! / investedCapital) * 100;
  }

  double? get calculatedFCFYield {
    if (fcfYield != null) return fcfYield;
    if (marketCap == null || annualDataHistory.isEmpty) return null;

    final latest = annualDataHistory.first;
    if (latest.freeCashFlow == null) return null;

    return (latest.freeCashFlow! / marketCap!) * 100;
  }

  double get calculatedComprehensiveScore {
    if (comprehensiveScore != null) return comprehensiveScore!;

    double totalScore = 0;
    int criteria = 0;

    if (roe != null) {
      if (roe! > 20)
        totalScore += 25;
      else if (roe! > 15)
        totalScore += 20;
      else if (roe! > 10)
        totalScore += 15;
      else if (roe! > 5) totalScore += 10;
      criteria++;
    }

    if (debtToEquity != null) {
      if (debtToEquity! < 0.1)
        totalScore += 25;
      else if (debtToEquity! < 0.3)
        totalScore += 20;
      else if (debtToEquity! < 0.6)
        totalScore += 15;
      else if (debtToEquity! < 1.0) totalScore += 10;
      criteria++;
    }

    if (salesGrowth3Y != null && profitGrowth3Y != null) {
      final avgGrowth = (salesGrowth3Y! + profitGrowth3Y!) / 2;
      if (avgGrowth > 25)
        totalScore += 25;
      else if (avgGrowth > 15)
        totalScore += 20;
      else if (avgGrowth > 10)
        totalScore += 15;
      else if (avgGrowth > 5) totalScore += 10;
      criteria++;
    }

    if (stockPe != null) {
      if (stockPe! < 10)
        totalScore += 25;
      else if (stockPe! < 15)
        totalScore += 20;
      else if (stockPe! < 20)
        totalScore += 15;
      else if (stockPe! < 30) totalScore += 10;
      criteria++;
    }

    return criteria > 0 ? totalScore / criteria : 0;
  }

  String get calculatedRiskAssessment {
    int riskFactors = 0;

    if (debtToEquity != null && debtToEquity! > 1.0) riskFactors++;
    if (currentRatio != null && currentRatio! < 1.0) riskFactors++;
    if (roe != null && roe! < 5) riskFactors++;
    if (interestCoverage != null && interestCoverage! < 2.5) riskFactors++;
    if (stockPe != null && stockPe! > 40) riskFactors++;

    if (riskFactors >= 4) return 'Very High';
    if (riskFactors >= 3) return 'High';
    if (riskFactors >= 2) return 'Medium';
    if (riskFactors >= 1) return 'Low';
    return 'Very Low';
  }

  String get calculatedInvestmentGrade {
    final score = calculatedComprehensiveScore;
    final piotroski = calculatedPiotroskiScore;

    if (score > 80 && piotroski > 7) return 'AAA';
    if (score > 70 && piotroski > 6) return 'AA';
    if (score > 60 && piotroski > 5) return 'A';
    if (score > 50 && piotroski > 4) return 'BBB';
    if (score > 40 && piotroski > 3) return 'BB';
    if (score > 30 && piotroski > 2) return 'B';
    return 'C';
  }

  double? get safetyMargin {
    final intrinsic = calculatedGrahamNumber;
    if (intrinsic == null || currentPrice == null || currentPrice! <= 0) {
      return null;
    }

    return ((intrinsic - currentPrice!) / intrinsic) * 100;
  }

  String get calculatedInvestmentRecommendation {
    if (investmentRecommendation != null) return investmentRecommendation!;

    final qualityScore = calculatedComprehensiveScore;
    final piotroskiScore = calculatedPiotroskiScore;
    final riskLevel = calculatedRiskAssessment;

    if (qualityScore > 80 && piotroskiScore > 7 && riskLevel == 'Low') {
      return 'Strong Buy - High quality company with excellent fundamentals';
    } else if (qualityScore > 60 &&
        piotroskiScore > 5 &&
        riskLevel != 'Very High') {
      return 'Buy - Good fundamentals with manageable risk';
    } else if (qualityScore > 40 && riskLevel == 'Medium') {
      return 'Hold - Average fundamentals, monitor closely';
    } else if (riskLevel == 'High' || riskLevel == 'Very High') {
      return 'Sell - High risk factors present';
    } else {
      return 'Hold - Mixed signals, requires deeper analysis';
    }
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
        return isQualityStock || calculatedComprehensiveScore >= 60;
      case FundamentalType.momentumStocks:
        return (salesGrowth1Y != null && salesGrowth1Y! > 20.0) ||
            (profitGrowth1Y != null && profitGrowth1Y! > 20.0);
      case FundamentalType.contrarian:
        return changePercent < -10.0 &&
            (roe != null && roe! > 10.0) &&
            calculatedComprehensiveScore >= 40;
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

@freezed
class RawFinancialTables with _$RawFinancialTables {
  const factory RawFinancialTables({
    @Default({}) Map<String, dynamic> quarterlyResults,
    @Default({}) Map<String, dynamic> profitLossStatement,
    @Default({}) Map<String, dynamic> balanceSheet,
    @Default({}) Map<String, dynamic> cashFlowStatement,
    @Default({}) Map<String, dynamic> ratiosTable,
    @Default({}) Map<String, dynamic> shareholdingTable,
  }) = _RawFinancialTables;

  factory RawFinancialTables.fromJson(Map<String, dynamic> json) =>
      _$RawFinancialTablesFromJson(json);
}

@freezed
class CompanyKeyPoints with _$CompanyKeyPoints {
  const factory CompanyKeyPoints({
    @Default([]) List<BusinessHighlight> businessHighlights,
    @Default([]) List<FinancialStrength> financialStrengths,
    @Default([]) List<RiskFactor> riskFactors,
    @Default([]) List<CompetitiveAdvantage> competitiveAdvantages,
    @Default([]) List<RecentDevelopment> recentDevelopments,
    @Default([]) List<ManagementInsight> managementInsights,
  }) = _CompanyKeyPoints;

  factory CompanyKeyPoints.fromJson(Map<String, dynamic> json) =>
      _$CompanyKeyPointsFromJson(json);
}

@freezed
class BusinessHighlight with _$BusinessHighlight {
  const factory BusinessHighlight({
    required String type,
    required String description,
    required String impact,
  }) = _BusinessHighlight;

  factory BusinessHighlight.fromJson(Map<String, dynamic> json) =>
      _$BusinessHighlightFromJson(json);
}

@freezed
class FinancialStrength with _$FinancialStrength {
  const factory FinancialStrength({
    required String type,
    required String description,
    required String impact,
    double? value,
    String? trend,
  }) = _FinancialStrength;

  factory FinancialStrength.fromJson(Map<String, dynamic> json) =>
      _$FinancialStrengthFromJson(json);
}

@freezed
class RiskFactor with _$RiskFactor {
  const factory RiskFactor({
    required String type,
    required String description,
    required String impact,
    required String severity,
  }) = _RiskFactor;

  factory RiskFactor.fromJson(Map<String, dynamic> json) =>
      _$RiskFactorFromJson(json);
}

@freezed
class CompetitiveAdvantage with _$CompetitiveAdvantage {
  const factory CompetitiveAdvantage({
    required String type,
    required String description,
    required String impact,
    String? sustainability,
  }) = _CompetitiveAdvantage;

  factory CompetitiveAdvantage.fromJson(Map<String, dynamic> json) =>
      _$CompetitiveAdvantageFromJson(json);
}

@freezed
class RecentDevelopment with _$RecentDevelopment {
  const factory RecentDevelopment({
    required String type,
    required String description,
    required String impact,
    DateTime? date,
  }) = _RecentDevelopment;

  factory RecentDevelopment.fromJson(Map<String, dynamic> json) =>
      _$RecentDevelopmentFromJson(json);
}

@freezed
class ManagementInsight with _$ManagementInsight {
  const factory ManagementInsight({
    required String type,
    required String description,
    required String impact,
  }) = _ManagementInsight;

  factory ManagementInsight.fromJson(Map<String, dynamic> json) =>
      _$ManagementInsightFromJson(json);
}

@freezed
class CalculatedMetrics with _$CalculatedMetrics {
  const factory CalculatedMetrics({
    double? piotroskiScore,
    double? altmanZScore,
    double? grahamNumber,
    double? pegRatio,
    double? roic,
    double? fcfYield,
    double? comprehensiveScore,
    String? riskAssessment,
    String? investmentGrade,
    String? investmentRecommendation,
    double? safetyMargin,
    double? debtServiceCoverage,
    double? workingCapitalTurnover,
    double? returnOnAssets,
    double? returnOnCapital,
    double? evToEbitda,
    double? priceToFreeCashFlow,
    double? enterpriseValueToSales,
    Map<String, double>? sectorComparison,
    Map<String, String>? qualityMetrics,
    List<String>? strengthFactors,
    List<String>? weaknessFactors,
    Map<String, dynamic>? valuationMetrics,
  }) = _CalculatedMetrics;

  factory CalculatedMetrics.fromJson(Map<String, dynamic> json) =>
      _$CalculatedMetricsFromJson(json);
}

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
    required String impact,
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
    String? trend,
  }) = _FinancialSummary;

  factory FinancialSummary.fromJson(Map<String, dynamic> json) =>
      _$FinancialSummaryFromJson(json);
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
    // ADD THIS MISSING FIELD:
    double? interestExpense,
    // You might also want to add these commonly used fields:
    double? taxExpense,
    double? depreciation,
    double? amortization,
    double? capitalExpenditures,
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
