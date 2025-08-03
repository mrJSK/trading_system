import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:math';
import '../utils/json_parsing_utils.dart';

// ============================================================================
// FINANCIAL DATA ROW MODEL WITH MANUAL SERIALIZATION
// ============================================================================

class FinancialDataRow {
  final String description;
  final List<String> values;
  final Map<String, String> additionalData;
  final Map<String, double> calculatedMetrics;
  final String? category;
  final bool isKeyMetric;

  const FinancialDataRow({
    required this.description,
    this.values = const [],
    this.additionalData = const {},
    this.calculatedMetrics = const {},
    this.category,
    this.isKeyMetric = false,
  });

  factory FinancialDataRow.fromJson(Map<String, dynamic> json) {
    try {
      return FinancialDataRow(
        description: JsonParsingUtils.safeString(json['description']) ??
            JsonParsingUtils.safeString(json['Description']) ??
            '',
        values: JsonParsingUtils.cleanStringList(json['values']),
        additionalData: _parseAdditionalData(
            json['additional_data'] ?? json['additionalData']),
        calculatedMetrics: _parseCalculatedMetrics(
            json['calculated_metrics'] ?? json['calculatedMetrics']),
        category: JsonParsingUtils.safeString(json['category']),
        isKeyMetric: JsonParsingUtils.safeBool(
                json['is_key_metric'] ?? json['isKeyMetric']) ??
            false,
      );
    } catch (e) {
      debugPrint('Error creating FinancialDataRow from JSON: $e');
      return const FinancialDataRow(description: '');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'values': values,
      'additional_data': additionalData,
      'calculated_metrics': calculatedMetrics,
      'category': category,
      'is_key_metric': isKeyMetric,
    };
  }

  static Map<String, String> _parseAdditionalData(dynamic data) {
    if (data == null) return <String, String>{};
    try {
      if (data is Map<String, String>) return data;
      if (data is Map) {
        return Map<String, String>.from(data.map((k, v) => MapEntry(
            JsonParsingUtils.safeString(k) ?? '',
            JsonParsingUtils.safeString(v) ?? '')));
      }
      return <String, String>{};
    } catch (e) {
      debugPrint('Error parsing additional data: $e');
      return <String, String>{};
    }
  }

  static Map<String, double> _parseCalculatedMetrics(dynamic data) {
    if (data == null) return <String, double>{};
    try {
      if (data is Map<String, double>) return data;
      if (data is Map) {
        final result = <String, double>{};
        data.forEach((k, v) {
          final doubleValue = JsonParsingUtils.safeDouble(v);
          if (doubleValue != null) {
            result[JsonParsingUtils.safeString(k) ?? ''] = doubleValue;
          }
        });
        return result;
      }
      return <String, double>{};
    } catch (e) {
      debugPrint('Error parsing calculated metrics: $e');
      return <String, double>{};
    }
  }
}

// ============================================================================
// MAIN FINANCIAL DATA MODEL WITH MANUAL SERIALIZATION
// ============================================================================

class FinancialDataModel {
  final List<String> headers;
  final List<FinancialDataRow> body;
  final String? tableTitle;
  final String? dataSource;
  final Map<String, dynamic> metadata;
  final String tableType;
  final DateTime? lastUpdated;
  final bool isProcessed;

  const FinancialDataModel({
    this.headers = const [],
    this.body = const [],
    this.tableTitle,
    this.dataSource,
    this.metadata = const {},
    this.tableType = '',
    this.lastUpdated,
    this.isProcessed = false,
  });

  // ============================================================================
  // MANUAL JSON DESERIALIZATION
  // ============================================================================

  factory FinancialDataModel.fromJson(Map<String, dynamic> json) {
    try {
      return FinancialDataModel(
        headers: JsonParsingUtils.cleanStringList(json['headers']),
        body: _parseBodyData(json['body']),
        tableTitle: JsonParsingUtils.safeString(
            json['table_title'] ?? json['tableTitle']),
        dataSource: JsonParsingUtils.safeString(
            json['data_source'] ?? json['dataSource']),
        metadata: JsonParsingUtils.safeMap(json['metadata']),
        tableType: JsonParsingUtils.safeString(
                json['table_type'] ?? json['tableType']) ??
            '',
        lastUpdated: JsonParsingUtils.safeDateTime(
            json['last_updated'] ?? json['lastUpdated']),
        isProcessed: JsonParsingUtils.safeBool(
                json['is_processed'] ?? json['isProcessed']) ??
            false,
      );
    } catch (e) {
      debugPrint('Error creating FinancialDataModel from JSON: $e');
      return const FinancialDataModel();
    }
  }

  // ============================================================================
  // MANUAL JSON SERIALIZATION
  // ============================================================================

  Map<String, dynamic> toJson() {
    return {
      'headers': headers,
      'body': body.map((row) => row.toJson()).toList(),
      'table_title': tableTitle,
      'data_source': dataSource,
      'metadata': metadata,
      'table_type': tableType,
      'last_updated': lastUpdated?.toIso8601String(),
      'is_processed': isProcessed,
    };
  }

  // ============================================================================
  // HELPER PARSING METHODS
  // ============================================================================

  static List<FinancialDataRow> _parseBodyData(dynamic data) {
    if (data == null) return <FinancialDataRow>[];
    try {
      if (data is List) {
        return data
            .map((item) {
              if (item is FinancialDataRow) return item;
              if (item is Map<String, dynamic>) {
                return FinancialDataRow.fromJson(item);
              }
              if (item is Map) {
                return FinancialDataRow.fromJson(
                    Map<String, dynamic>.from(item));
              }
              return null;
            })
            .where((item) => item != null)
            .cast<FinancialDataRow>()
            .toList();
      }
      return <FinancialDataRow>[];
    } catch (e) {
      debugPrint('Error parsing body data: $e');
      return <FinancialDataRow>[];
    }
  }

  // ============================================================================
  // ENHANCED FACTORY FOR RAW TABLE DATA
  // ============================================================================

  factory FinancialDataModel.fromRawTable(
    Map<String, dynamic> rawTable, {
    String? tableType,
  }) {
    try {
      final headers = _extractHeaders(rawTable);
      final body = _extractBody(rawTable, headers);

      return FinancialDataModel(
        headers: headers,
        body: body,
        tableTitle: JsonParsingUtils.safeString(rawTable['title']),
        dataSource: 'screener.in',
        metadata: JsonParsingUtils.safeMap(rawTable),
        tableType: tableType ?? _inferTableType(rawTable),
        lastUpdated: DateTime.now(),
        isProcessed: true,
      );
    } catch (e) {
      debugPrint('Error creating FinancialDataModel from raw table: $e');
      return const FinancialDataModel();
    }
  }

  static List<String> _extractHeaders(Map<String, dynamic> rawTable) {
    try {
      final headers = rawTable['headers'];
      if (headers is List) {
        return headers
            .map((h) => JsonParsingUtils.safeString(h) ?? '')
            .where((h) => h.isNotEmpty)
            .toList();
      }
      return <String>[];
    } catch (e) {
      debugPrint('Error extracting headers: $e');
      return <String>[];
    }
  }

  static List<FinancialDataRow> _extractBody(
    Map<String, dynamic> rawTable,
    List<String> headers,
  ) {
    try {
      final rawBody = rawTable['body'];
      if (rawBody is! List) return <FinancialDataRow>[];

      return rawBody
          .map((row) => _createFinancialDataRow(row, headers))
          .where((row) => row != null)
          .cast<FinancialDataRow>()
          .toList();
    } catch (e) {
      debugPrint('Error extracting body: $e');
      return <FinancialDataRow>[];
    }
  }

  static FinancialDataRow? _createFinancialDataRow(
    dynamic row,
    List<String> headers,
  ) {
    try {
      if (row is! Map) return null;

      final description = JsonParsingUtils.safeString(
              row['Description'] ?? row['description']) ??
          '';
      if (description.isEmpty) return null;

      final values = JsonParsingUtils.cleanStringList(row['values']);
      final calculatedMetrics = _calculateRowMetrics(description, values);

      return FinancialDataRow(
        description: description,
        values: values,
        calculatedMetrics: calculatedMetrics,
        category: _categorizeMetric(description),
        isKeyMetric: _isKeyMetric(description),
      );
    } catch (e) {
      debugPrint('Error creating FinancialDataRow: $e');
      return null;
    }
  }

  // Infer table type from content with enhanced detection
  static String _inferTableType(Map<String, dynamic> rawTable) {
    final title =
        JsonParsingUtils.safeString(rawTable['title'])?.toLowerCase() ?? '';
    final headers = rawTable['headers'] as List?;

    if (title.contains('quarterly') ||
        (headers != null && headers.any((h) => h.toString().contains('Q')))) {
      return 'quarterly';
    } else if (title.contains('ratio')) {
      return 'ratios';
    } else if (title.contains('balance')) {
      return 'balance_sheet';
    } else if (title.contains('cash')) {
      return 'cash_flow';
    } else if (title.contains('profit') || title.contains('loss')) {
      return 'profit_loss';
    }
    return 'annual';
  }

  // Calculate metrics for each row with enhanced error handling
  static Map<String, double> _calculateRowMetrics(
    String description,
    List<String> values,
  ) {
    Map<String, double> metrics = <String, double>{};

    try {
      if (values.length >= 2) {
        final latest = JsonParsingUtils.parseCleanNumeric(values[0]);
        final previous = JsonParsingUtils.parseCleanNumeric(values[1]);

        if (latest != null && previous != null && previous != 0) {
          final growthRate =
              JsonParsingUtils.calculateGrowthRate(latest, previous);
          if (growthRate != null) {
            metrics['growth_rate'] = growthRate;
          }
          metrics['absolute_change'] = latest - previous;
        }

        if (latest != null) {
          metrics['latest_value'] = latest;
        }
      }
    } catch (e) {
      debugPrint('Error calculating row metrics for $description: $e');
    }

    return metrics;
  }

  static String? _categorizeMetric(String description) {
    final desc = description.toLowerCase();
    if (desc.contains('sales') ||
        desc.contains('revenue') ||
        desc.contains('income')) {
      return 'revenue';
    } else if (desc.contains('expense') || desc.contains('cost')) {
      return 'expense';
    } else if (desc.contains('asset')) {
      return 'asset';
    } else if (desc.contains('liability') || desc.contains('debt')) {
      return 'liability';
    } else if (desc.contains('equity')) {
      return 'equity';
    } else if (desc.contains('ratio') || desc.contains('return')) {
      return 'ratio';
    }
    return null;
  }

  static bool _isKeyMetric(String description) {
    final keyTerms = [
      'sales',
      'revenue',
      'net profit',
      'ebitda',
      'total assets',
      'shareholders equity',
      'roe',
      'roce',
      'current ratio',
      'debt to equity',
      'eps',
      'book value',
      'operating profit',
      'cash flow'
    ];
    final desc = description.toLowerCase();
    return keyTerms.any((term) => desc.contains(term));
  }
}

// ============================================================================
// ENHANCED EXTENSION WITH EXPERT-LEVEL ANALYSIS CAPABILITIES
// ============================================================================

extension FinancialDataModelExtensions on FinancialDataModel {
  // ============================================================================
  // ENHANCED DATA ACCESS METHODS
  // ============================================================================

  /// Get value by description and header with fuzzy matching and enhanced error handling
  String? getValue(String description, String header) {
    try {
      final rowIndex =
          body.indexWhere((row) => _fuzzyMatch(row.description, description));
      if (rowIndex == -1) return null;

      final headerIndex = headers.indexWhere((h) => _fuzzyMatch(h, header));
      if (headerIndex == -1) return null;

      if (headerIndex < body[rowIndex].values.length) {
        return body[rowIndex].values[headerIndex];
      }
      return null;
    } catch (e) {
      debugPrint('Error getting value for $description, $header: $e');
      return null;
    }
  }

  /// Enhanced fuzzy matching for financial terms
  bool _fuzzyMatch(String text, String pattern) {
    if (text.isEmpty || pattern.isEmpty) return false;

    final textLower = text.toLowerCase();
    final patternLower = pattern.toLowerCase();

    // Direct match
    if (textLower.contains(patternLower)) return true;

    // Common financial term mappings
    final synonyms = {
      'sales': [
        'revenue',
        'income from operations',
        'turnover',
        'total income'
      ],
      'net profit': [
        'profit after tax',
        'net income',
        'pat',
        'profit attributable'
      ],
      'total assets': ['assets', 'total assets'],
      'shareholders equity': [
        'net worth',
        'equity',
        'shareholders fund',
        'shareholders funds'
      ],
      'debt to equity': ['d/e', 'debt equity ratio', 'debt-equity'],
      'return on equity': ['roe', 'return on equity %'],
      'return on assets': ['roa', 'return on assets %'],
      'earnings per share': ['eps', 'basic eps', 'diluted eps'],
      'interest coverage': [
        'interest cover',
        'times interest earned',
        'interest coverage ratio'
      ],
      'current ratio': ['cr', 'current ratio'],
      'quick ratio': ['acid test ratio', 'liquid ratio'],
      'ebitda': ['ebitda', 'operating ebitda'],
      'operating profit': ['operating profit', 'ebit'],
      'book value': ['book value per share', 'bvps'],
    };

    for (final entry in synonyms.entries) {
      if (patternLower.contains(entry.key) ||
          entry.value.any((syn) => patternLower.contains(syn))) {
        if (textLower.contains(entry.key) ||
            entry.value.any((syn) => textLower.contains(syn))) {
          return true;
        }
      }
    }

    return false;
  }

  /// Get all values for a specific description with enhanced matching
  List<String> getRowValues(String description) {
    try {
      final row = body.firstWhere(
        (row) => _fuzzyMatch(row.description, description),
        orElse: () => const FinancialDataRow(description: '', values: []),
      );
      return row.values;
    } catch (e) {
      debugPrint('Error getting row values for $description: $e');
      return <String>[];
    }
  }

  /// Get latest value (first column after description)
  String? getLatestValue(String description) {
    try {
      final values = getRowValues(description);
      return values.isNotEmpty ? values.first : null;
    } catch (e) {
      debugPrint('Error getting latest value for $description: $e');
      return null;
    }
  }

  /// Enhanced numeric value parsing with better cleaning
  double? getNumericValue(String description, String header) {
    try {
      final value = getValue(description, header);
      return JsonParsingUtils.parseCleanNumeric(value);
    } catch (e) {
      debugPrint('Error getting numeric value for $description, $header: $e');
      return null;
    }
  }

  /// Get latest numeric value with enhanced parsing
  double? getLatestNumericValue(String description) {
    try {
      final value = getLatestValue(description);
      return JsonParsingUtils.parseCleanNumeric(value);
    } catch (e) {
      debugPrint('Error getting latest numeric value for $description: $e');
      return null;
    }
  }

  // ============================================================================
  // EXPERT-LEVEL ANALYSIS METHODS (Enhanced with error handling)
  // ============================================================================

  /// Calculate comprehensive growth metrics with enhanced error handling
  Map<String, double> calculateComprehensiveGrowth() {
    try {
      if (headers.length < 2) return <String, double>{};

      Map<String, double> growthMetrics = <String, double>{};

      // Calculate 1-year, 3-year, and 5-year growth for key metrics
      final keyMetrics = [
        'Sales',
        'Net Profit',
        'Total Assets',
        'Shareholders Equity',
        'EBITDA'
      ];

      for (final metric in keyMetrics) {
        try {
          final values = getRowValues(metric);
          if (values.isNotEmpty) {
            final numericValues = values
                .map((v) => JsonParsingUtils.parseCleanNumeric(v))
                .where((v) => v != null)
                .cast<double>()
                .toList();

            if (numericValues.length >= 2) {
              // 1-year growth
              final growth1Y = JsonParsingUtils.calculateGrowthRate(
                  numericValues[0], numericValues[1]);
              if (growth1Y != null) {
                growthMetrics[
                        '${metric.toLowerCase().replaceAll(' ', '_')}_1y'] =
                    growth1Y;
              }
            }

            if (numericValues.length >= 4) {
              // 3-year CAGR
              final cagr3Y = JsonParsingUtils.calculateCAGR(
                  numericValues[0], numericValues[3], 3);
              if (cagr3Y != null) {
                growthMetrics[
                        '${metric.toLowerCase().replaceAll(' ', '_')}_3y_cagr'] =
                    cagr3Y;
              }
            }

            if (numericValues.length >= 6) {
              // 5-year CAGR
              final cagr5Y = JsonParsingUtils.calculateCAGR(
                  numericValues[0], numericValues[5], 5);
              if (cagr5Y != null) {
                growthMetrics[
                        '${metric.toLowerCase().replaceAll(' ', '_')}_5y_cagr'] =
                    cagr5Y;
              }
            }
          }
        } catch (e) {
          debugPrint('Error calculating growth for $metric: $e');
          continue;
        }
      }

      return growthMetrics;
    } catch (e) {
      debugPrint('Error calculating comprehensive growth: $e');
      return <String, double>{};
    }
  }

  /// Extract financial health indicators with comprehensive error handling
  Map<String, dynamic> analyzeFinancialHealth() {
    try {
      final healthMetrics = <String, dynamic>{};

      // Liquidity ratios
      final currentRatio = getLatestNumericValue('Current Ratio');
      final quickRatio = getLatestNumericValue('Quick Ratio');

      healthMetrics['liquidity'] = {
        'current_ratio': currentRatio,
        'quick_ratio': quickRatio,
        'liquidity_status': _assessLiquidity(currentRatio, quickRatio),
      };

      // Leverage ratios
      final debtToEquity = getLatestNumericValue('Debt to Equity');
      final interestCoverage = getLatestNumericValue('Interest Coverage');

      healthMetrics['leverage'] = {
        'debt_to_equity': debtToEquity,
        'interest_coverage': interestCoverage,
        'leverage_status': _assessLeverage(debtToEquity, interestCoverage),
      };

      // Profitability ratios
      final roe = getLatestNumericValue('Return on Equity');
      final roa = getLatestNumericValue('Return on Assets');
      final roce = getLatestNumericValue('Return on Capital Employed');

      healthMetrics['profitability'] = {
        'roe': roe,
        'roa': roa,
        'roce': roce,
        'profitability_status': _assessProfitability(roe, roa, roce),
      };

      return healthMetrics;
    } catch (e) {
      debugPrint('Error analyzing financial health: $e');
      return <String, dynamic>{};
    }
  }

  String _assessLiquidity(double? currentRatio, double? quickRatio) {
    if (currentRatio == null) return 'Unknown';
    if (currentRatio > 2.0 && (quickRatio == null || quickRatio > 1.5))
      return 'Excellent';
    if (currentRatio > 1.5) return 'Good';
    if (currentRatio > 1.0) return 'Adequate';
    return 'Poor';
  }

  String _assessLeverage(double? debtToEquity, double? interestCoverage) {
    if (debtToEquity == null) return 'Unknown';
    if (debtToEquity < 0.1) return 'Conservative';
    if (debtToEquity < 0.5 &&
        (interestCoverage == null || interestCoverage > 5)) return 'Moderate';
    if (debtToEquity < 1.0) return 'Leveraged';
    return 'High Risk';
  }

  String _assessProfitability(double? roe, double? roa, double? roce) {
    if (roe == null) return 'Unknown';
    if (roe > 20 && (roce == null || roce > 20)) return 'Excellent';
    if (roe > 15) return 'Good';
    if (roe > 10) return 'Average';
    if (roe > 0) return 'Weak';
    return 'Loss Making';
  }

  /// Get trend analysis for key metrics with enhanced error handling
  Map<String, String> analyzeTrends() {
    try {
      final trends = <String, String>{};

      final keyMetrics = [
        'Sales',
        'Net Profit',
        'Total Assets',
        'ROE',
        'Current Ratio'
      ];

      for (final metric in keyMetrics) {
        try {
          final values = getRowValues(metric);
          if (values.length >= 3) {
            final numericValues = values
                .take(3)
                .map((v) => JsonParsingUtils.parseCleanNumeric(v))
                .where((v) => v != null)
                .cast<double>()
                .toList();

            if (numericValues.length >= 3) {
              trends[metric.toLowerCase().replaceAll(' ', '_')] =
                  _calculateTrend(numericValues);
            }
          }
        } catch (e) {
          debugPrint('Error analyzing trend for $metric: $e');
          continue;
        }
      }

      return trends;
    } catch (e) {
      debugPrint('Error analyzing trends: $e');
      return <String, String>{};
    }
  }

  String _calculateTrend(List<double> values) {
    try {
      if (values.length < 3) return 'Insufficient Data';

      final recent = values[0];
      final middle = values[1];
      final old = values[2];

      if (middle == 0 || old == 0) return 'Invalid Data';

      final recentChange = (recent - middle) / middle * 100;
      final olderChange = (middle - old) / old * 100;

      if (recentChange > 5 && olderChange > 5) return 'Strong Upward';
      if (recentChange > 0 && olderChange > 0) return 'Upward';
      if (recentChange < -5 && olderChange < -5) return 'Strong Downward';
      if (recentChange < 0 && olderChange < 0) return 'Downward';
      return 'Sideways';
    } catch (e) {
      debugPrint('Error calculating trend: $e');
      return 'Error';
    }
  }

  // ============================================================================
  // EXISTING METHODS (Enhanced with better error handling)
  // ============================================================================

  /// Enhanced toMap with calculated metrics and error handling
  Map<String, Map<String, dynamic>> toMap() {
    try {
      final result = <String, Map<String, dynamic>>{};

      for (final row in body) {
        if (row.description.isNotEmpty) {
          final rowMap = <String, dynamic>{};
          for (int i = 0; i < headers.length && i < row.values.length; i++) {
            rowMap[headers[i]] = row.values[i];
          }
          // Add calculated metrics
          rowMap.addAll(row.calculatedMetrics);
          result[row.description] = rowMap;
        }
      }

      return result;
    } catch (e) {
      debugPrint('Error converting to map: $e');
      return <String, Map<String, dynamic>>{};
    }
  }

  /// Find rows containing specific keywords (enhanced)
  List<FinancialDataRow> findRows(List<String> keywords) {
    try {
      return body.where((row) {
        final description = row.description.toLowerCase();
        return keywords
            .any((keyword) => _fuzzyMatch(description, keyword.toLowerCase()));
      }).toList();
    } catch (e) {
      debugPrint('Error finding rows: $e');
      return <FinancialDataRow>[];
    }
  }

  /// Enhanced growth rate calculation
  double? getGrowthRate(
      String description, String currentPeriod, String previousPeriod) {
    try {
      final currentValue = getNumericValue(description, currentPeriod);
      final previousValue = getNumericValue(description, previousPeriod);

      if (currentValue == null || previousValue == null || previousValue == 0) {
        return null;
      }

      return JsonParsingUtils.calculateGrowthRate(currentValue, previousValue);
    } catch (e) {
      debugPrint('Error calculating growth rate for $description: $e');
      return null;
    }
  }

  /// Check if table has meaningful data
  bool get hasData {
    try {
      return headers.isNotEmpty &&
          body.isNotEmpty &&
          body.any((row) =>
              row.values.any((value) => value.isNotEmpty && value != '-'));
    } catch (e) {
      debugPrint('Error checking hasData: $e');
      return false;
    }
  }

  /// Get time periods (headers excluding description)
  List<String> get timePeriods => headers;

  /// Get all metric names (descriptions)
  List<String> get metrics {
    try {
      return body
          .map((row) => row.description)
          .where((desc) => desc.isNotEmpty)
          .toList();
    } catch (e) {
      debugPrint('Error getting metrics: $e');
      return <String>[];
    }
  }

  /// Get key financial metrics only
  List<String> get keyMetrics {
    try {
      return body
          .where((row) => row.isKeyMetric || _isKeyMetric(row.description))
          .map((row) => row.description)
          .toList();
    } catch (e) {
      debugPrint('Error getting key metrics: $e');
      return <String>[];
    }
  }

  bool _isKeyMetric(String description) {
    final keyTerms = [
      'sales',
      'revenue',
      'net profit',
      'ebitda',
      'total assets',
      'shareholders equity',
      'roe',
      'roce',
      'current ratio',
      'debt to equity',
      'eps',
      'book value',
      'operating profit',
      'cash flow'
    ];
    final desc = description.toLowerCase();
    return keyTerms.any((term) => desc.contains(term));
  }
}

// ============================================================================
// ENHANCED UTILITY CLASS FOR FINANCIAL METRICS EXTRACTION
// ============================================================================

class FinancialMetricsExtractor {
  /// Extract comprehensive key metrics with enhanced parsing and error handling
  static Map<String, double?> extractKeyMetrics(FinancialDataModel model) {
    try {
      return {
        // Revenue metrics
        'sales': model.getLatestNumericValue('Sales'),
        'revenue': model.getLatestNumericValue('Revenue'),
        'totalIncome': model.getLatestNumericValue('Total Income'),

        // Profit metrics
        'netProfit': model.getLatestNumericValue('Net Profit'),
        'grossProfit': model.getLatestNumericValue('Gross Profit'),
        'operatingProfit': model.getLatestNumericValue('Operating Profit'),
        'ebitda': model.getLatestNumericValue('EBITDA'),
        'ebit': model.getLatestNumericValue('EBIT'),

        // Balance sheet metrics
        'totalAssets': model.getLatestNumericValue('Total Assets'),
        'totalLiabilities': model.getLatestNumericValue('Total Liabilities'),
        'shareholdersEquity':
            model.getLatestNumericValue('Shareholders Equity'),
        'totalDebt': model.getLatestNumericValue('Total Debt'),
        'workingCapital': model.getLatestNumericValue('Working Capital'),

        // Cash flow metrics
        'operatingCashFlow': model.getLatestNumericValue('Operating Cash Flow'),
        'freeCashFlow': model.getLatestNumericValue('Free Cash Flow'),
        'investingCashFlow': model.getLatestNumericValue('Investing Cash Flow'),
        'financingCashFlow': model.getLatestNumericValue('Financing Cash Flow'),

        // Per share metrics
        'eps': model.getLatestNumericValue('EPS'),
        'bookValue': model.getLatestNumericValue('Book Value'),
        'dividendPerShare': model.getLatestNumericValue('Dividend Per Share'),

        // Ratios
        'currentRatio': model.getLatestNumericValue('Current Ratio'),
        'quickRatio': model.getLatestNumericValue('Quick Ratio'),
        'debtToEquity': model.getLatestNumericValue('Debt to Equity'),
        'returnOnEquity': model.getLatestNumericValue('Return on Equity'),
        'returnOnAssets': model.getLatestNumericValue('Return on Assets'),
        'returnOnCapital': model.getLatestNumericValue('Return on Capital'),
        'interestCoverage': model.getLatestNumericValue('Interest Coverage'),
        'assetTurnover': model.getLatestNumericValue('Asset Turnover'),
        'inventoryTurnover': model.getLatestNumericValue('Inventory Turnover'),

        // Expense metrics
        'interestExpense': model.getLatestNumericValue('Interest Expense'),
        'taxExpense': model.getLatestNumericValue('Tax Expense'),
        'depreciation': model.getLatestNumericValue('Depreciation'),
      };
    } catch (e) {
      debugPrint('Error extracting key metrics: $e');
      return <String, double?>{};
    }
  }

  /// Extract time series data with enhanced period detection and error handling
  static List<Map<String, dynamic>> extractTimeSeriesData(
      FinancialDataModel model, String metric) {
    try {
      final values = model.getRowValues(metric);
      final headers = model.headers;

      List<Map<String, dynamic>> timeSeries = [];

      for (int i = 0; i < headers.length && i < values.length; i++) {
        try {
          final numericValue = model.getNumericValue(metric, headers[i]);
          if (numericValue != null) {
            timeSeries.add({
              'period': headers[i],
              'value': numericValue,
              'rawValue': values[i],
              'periodType': _determinePeriodType(headers[i]),
              'year': _extractYear(headers[i]),
              'quarter': _extractQuarter(headers[i]),
            });
          }
        } catch (e) {
          debugPrint(
              'Error processing time series data for period ${headers[i]}: $e');
          continue;
        }
      }

      return timeSeries;
    } catch (e) {
      debugPrint('Error extracting time series data for $metric: $e');
      return <Map<String, dynamic>>[];
    }
  }

  static String _determinePeriodType(String header) {
    try {
      if (header.contains('Q') || header.toLowerCase().contains('quarter'))
        return 'quarterly';
      if (RegExp(r'\d{4}').hasMatch(header)) return 'annual';
      return 'unknown';
    } catch (e) {
      debugPrint('Error determining period type for $header: $e');
      return 'unknown';
    }
  }

  static int? _extractYear(String header) {
    try {
      final yearMatch = RegExp(r'(\d{4})').firstMatch(header);
      return yearMatch != null ? int.tryParse(yearMatch.group(1)!) : null;
    } catch (e) {
      debugPrint('Error extracting year from $header: $e');
      return null;
    }
  }

  static String? _extractQuarter(String header) {
    try {
      final quarterMatch = RegExp(r'Q(\d)').firstMatch(header);
      return quarterMatch?.group(1);
    } catch (e) {
      debugPrint('Error extracting quarter from $header: $e');
      return null;
    }
  }

  /// Calculate enhanced growth rates with CAGR and comprehensive error handling
  static Map<String, double?> calculateGrowthRates(FinancialDataModel model) {
    try {
      final headers = model.headers;
      final growthRates = <String, double?>{};

      if (headers.length < 2) return growthRates;

      final keyMetrics = [
        'Sales',
        'Net Profit',
        'Total Assets',
        'Shareholders Equity'
      ];

      for (final metric in keyMetrics) {
        try {
          final values = model.getRowValues(metric);
          final numericValues = values
              .map((v) => JsonParsingUtils.parseCleanNumeric(v))
              .where((v) => v != null)
              .cast<double>()
              .toList();

          if (numericValues.length >= 2) {
            // 1-year growth
            final growth1Y = JsonParsingUtils.calculateGrowthRate(
                numericValues[0], numericValues[1]);
            if (growth1Y != null) {
              growthRates['${metric.toLowerCase().replaceAll(' ', '_')}_1y'] =
                  growth1Y;
            }
          }

          if (numericValues.length >= 4) {
            // 3-year CAGR
            final cagr3Y = JsonParsingUtils.calculateCAGR(
                numericValues[0], numericValues[3], 3);
            if (cagr3Y != null) {
              growthRates[
                      '${metric.toLowerCase().replaceAll(' ', '_')}_3y_cagr'] =
                  cagr3Y;
            }
          }
        } catch (e) {
          debugPrint('Error calculating growth rates for $metric: $e');
          continue;
        }
      }

      return growthRates;
    } catch (e) {
      debugPrint('Error calculating growth rates: $e');
      return <String, double?>{};
    }
  }

  /// Extract quality indicators with comprehensive error handling
  static Map<String, dynamic> extractQualityIndicators(
      FinancialDataModel model) {
    try {
      return {
        'financial_health': model.analyzeFinancialHealth(),
        'growth_metrics': model.calculateComprehensiveGrowth(),
        'trend_analysis': model.analyzeTrends(),
        'data_quality': {
          'completeness': _calculateDataCompleteness(model),
          'consistency': _calculateDataConsistency(model),
          'recency': model.lastUpdated?.toIso8601String(),
        },
      };
    } catch (e) {
      debugPrint('Error extracting quality indicators: $e');
      return <String, dynamic>{};
    }
  }

  static double _calculateDataCompleteness(FinancialDataModel model) {
    try {
      if (model.body.isEmpty) return 0.0;

      int totalCells = 0;
      int filledCells = 0;

      for (final row in model.body) {
        for (final value in row.values) {
          totalCells++;
          if (value.isNotEmpty &&
              value != '-' &&
              value.toLowerCase() != 'n/a') {
            filledCells++;
          }
        }
      }

      return totalCells > 0 ? (filledCells / totalCells) * 100 : 0.0;
    } catch (e) {
      debugPrint('Error calculating data completeness: $e');
      return 0.0;
    }
  }

  static double _calculateDataConsistency(FinancialDataModel model) {
    try {
      // Check for logical consistency in financial data
      double consistencyScore = 100.0;

      // Example: Check if assets = liabilities + equity (roughly)
      final assets = model.getLatestNumericValue('Total Assets');
      final liabilities = model.getLatestNumericValue('Total Liabilities');
      final equity = model.getLatestNumericValue('Shareholders Equity');

      if (assets != null && liabilities != null && equity != null) {
        final difference = (assets - (liabilities + equity)).abs();
        final tolerance = assets * 0.05; // 5% tolerance
        if (difference > tolerance) {
          consistencyScore -= 20;
        }
      }

      return max(0.0, consistencyScore);
    } catch (e) {
      debugPrint('Error calculating data consistency: $e');
      return 0.0;
    }
  }
}
