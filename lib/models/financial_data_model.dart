import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

part 'financial_data_model.freezed.dart';
part 'financial_data_model.g.dart';

@freezed
class FinancialDataModel with _$FinancialDataModel {
  const factory FinancialDataModel({
    @Default([]) List<String> headers,
    @Default([]) List<FinancialDataRow> body,
    String? tableTitle,
    String? dataSource,
    @Default({}) Map<String, dynamic> metadata,
    @Default('') String tableType, // 'quarterly', 'annual', 'ratios', etc.
    DateTime? lastUpdated,
    @Default(false) bool isProcessed,
  }) = _FinancialDataModel;

  factory FinancialDataModel.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataModelFromJson(json);

  // Enhanced factory for raw scraped table data
  factory FinancialDataModel.fromRawTable(Map<String, dynamic> rawTable,
      {String? tableType}) {
    try {
      final headers = rawTable['headers'] != null
          ? List<String>.from(rawTable['headers'])
          : <String>[];

      final rawBody = rawTable['body'] != null
          ? List<dynamic>.from(rawTable['body'])
          : <dynamic>[];

      final body = rawBody.map((row) {
        if (row is Map &&
            row.containsKey('Description') &&
            row.containsKey('values')) {
          return FinancialDataRow(
            description: row['Description']?.toString() ?? '',
            values: row['values'] != null
                ? List<String>.from(row['values'])
                : <String>[],
            calculatedMetrics: _calculateRowMetrics(
              row['Description']?.toString() ?? '',
              row['values'] != null
                  ? List<String>.from(row['values'])
                  : <String>[],
            ),
          );
        }
        return const FinancialDataRow(description: '', values: []);
      }).toList();

      return FinancialDataModel(
        headers: headers,
        body: body,
        tableTitle: rawTable['title']?.toString(),
        dataSource: 'screener.in',
        metadata: rawTable is Map<String, dynamic> ? rawTable : {},
        tableType: tableType ?? _inferTableType(rawTable),
        lastUpdated: DateTime.now(),
        isProcessed: true,
      );
    } catch (e) {
      debugPrint('Error creating FinancialDataModel from raw table: $e');
      return const FinancialDataModel();
    }
  }

  // Infer table type from content
  static String _inferTableType(Map<String, dynamic> rawTable) {
    final title = rawTable['title']?.toString().toLowerCase() ?? '';
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

  // Calculate metrics for each row
  static Map<String, double> _calculateRowMetrics(
      String description, List<String> values) {
    Map<String, double> metrics = {};

    if (values.length >= 2) {
      final latest = _parseNumericValue(values[0]);
      final previous = _parseNumericValue(values[1]);

      if (latest != null && previous != null && previous != 0) {
        metrics['growth_rate'] = ((latest - previous) / previous) * 100;
        metrics['absolute_change'] = latest - previous;
      }

      if (latest != null) {
        metrics['latest_value'] = latest;
      }
    }

    return metrics;
  }

  static double? _parseNumericValue(String value) {
    if (value.isEmpty || value == '-' || value.toLowerCase() == 'n/a')
      return null;
    final cleaned = value.replaceAll(RegExp(r'[^\d.-]'), '');
    return double.tryParse(cleaned);
  }
}

@freezed
class FinancialDataRow with _$FinancialDataRow {
  const factory FinancialDataRow({
    required String description,
    @Default([]) List<String> values,
    @Default({}) Map<String, String> additionalData,
    @Default({}) Map<String, double> calculatedMetrics,
    String? category, // 'revenue', 'expense', 'asset', 'liability', etc.
    @Default(false) bool isKeyMetric,
  }) = _FinancialDataRow;

  factory FinancialDataRow.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataRowFromJson(json);
}

// Enhanced extension with expert-level analysis capabilities
extension FinancialDataModelExtensions on FinancialDataModel {
  // ============================================================================
  // ENHANCED DATA ACCESS METHODS
  // ============================================================================

  /// Get value by description and header with fuzzy matching
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
      debugPrint('Error getting value: $e');
      return null;
    }
  }

  /// Enhanced fuzzy matching for financial terms
  bool _fuzzyMatch(String text, String pattern) {
    final textLower = text.toLowerCase();
    final patternLower = pattern.toLowerCase();

    // Direct match
    if (textLower.contains(patternLower)) return true;

    // Common financial term mappings
    final synonyms = {
      'sales': ['revenue', 'income from operations', 'turnover'],
      'net profit': ['profit after tax', 'net income', 'pat'],
      'total assets': ['assets'],
      'shareholders equity': ['net worth', 'equity', 'shareholders fund'],
      'debt to equity': ['d/e', 'debt equity ratio'],
      'return on equity': ['roe'],
      'return on assets': ['roa'],
      'earnings per share': ['eps'],
      'interest coverage': ['interest cover', 'times interest earned'],
      'current ratio': ['cr'],
      'quick ratio': ['acid test ratio'],
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
      return [];
    }
  }

  /// Get latest value (first column after description)
  String? getLatestValue(String description) {
    try {
      final values = getRowValues(description);
      return values.isNotEmpty ? values.first : null;
    } catch (e) {
      return null;
    }
  }

  /// Enhanced numeric value parsing with better cleaning
  double? getNumericValue(String description, String header) {
    final value = getValue(description, header);
    return _parseCleanNumeric(value);
  }

  /// Get latest numeric value with enhanced parsing
  double? getLatestNumericValue(String description) {
    final value = getLatestValue(description);
    return _parseCleanNumeric(value);
  }

  /// Enhanced numeric parsing
  double? _parseCleanNumeric(String? value) {
    if (value == null ||
        value.isEmpty ||
        value == '-' ||
        value.toLowerCase() == 'n/a') return null;

    // Handle special cases
    if (value.toLowerCase().contains('inf') ||
        value.toLowerCase().contains('infinity')) return null;

    // Remove currency symbols, commas, parentheses, and other formatting
    String cleaned = value
        .replaceAll(RegExp(r'[₹$€£¥,\s()%]'), '')
        .replaceAll('Cr.', '')
        .replaceAll('cr', '')
        .replaceAll('L', '')
        .trim();

    // Handle negative values in parentheses
    if (value.contains('(') && value.contains(')')) {
      cleaned = '-' + cleaned.replaceAll(RegExp(r'[()]'), '');
    }

    final parsed = double.tryParse(cleaned);

    // Handle very large or very small values
    if (parsed != null && (parsed.isInfinite || parsed.isNaN)) return null;

    return parsed;
  }

  // ============================================================================
  // EXPERT-LEVEL ANALYSIS METHODS
  // ============================================================================

  /// Calculate comprehensive growth metrics
  Map<String, double> calculateComprehensiveGrowth() {
    if (headers.length < 2) return {};

    Map<String, double> growthMetrics = {};

    // Calculate 1-year, 3-year, and 5-year growth for key metrics
    final keyMetrics = [
      'Sales',
      'Net Profit',
      'Total Assets',
      'Shareholders Equity',
      'EBITDA'
    ];

    for (final metric in keyMetrics) {
      final values = getRowValues(metric);
      if (values.isNotEmpty) {
        final numericValues = values
            .map((v) => _parseCleanNumeric(v))
            .where((v) => v != null)
            .cast<double>()
            .toList();

        if (numericValues.length >= 2) {
          // 1-year growth
          final growth1Y =
              _calculateGrowthRate(numericValues[0], numericValues[1]);
          if (growth1Y != null) {
            growthMetrics['${metric.toLowerCase().replaceAll(' ', '_')}_1y'] =
                growth1Y;
          }
        }

        if (numericValues.length >= 4) {
          // 3-year CAGR
          final cagr3Y = _calculateCAGR(numericValues[0], numericValues[3], 3);
          if (cagr3Y != null) {
            growthMetrics[
                    '${metric.toLowerCase().replaceAll(' ', '_')}_3y_cagr'] =
                cagr3Y;
          }
        }

        if (numericValues.length >= 6) {
          // 5-year CAGR
          final cagr5Y = _calculateCAGR(numericValues[0], numericValues[5], 5);
          if (cagr5Y != null) {
            growthMetrics[
                    '${metric.toLowerCase().replaceAll(' ', '_')}_5y_cagr'] =
                cagr5Y;
          }
        }
      }
    }

    return growthMetrics;
  }

  /// Calculate CAGR (Compound Annual Growth Rate)
  double? _calculateCAGR(double endValue, double beginValue, int years) {
    if (beginValue <= 0 || endValue <= 0 || years <= 0) return null;
    return (pow(endValue / beginValue, 1 / years) - 1) * 100;
  }

  /// Calculate simple growth rate
  double? _calculateGrowthRate(double current, double previous) {
    if (previous == 0) return null;
    return ((current - previous) / previous) * 100;
  }

  /// Extract financial health indicators
  Map<String, dynamic> analyzeFinancialHealth() {
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

  /// Get trend analysis for key metrics
  Map<String, String> analyzeTrends() {
    final trends = <String, String>{};

    final keyMetrics = [
      'Sales',
      'Net Profit',
      'Total Assets',
      'ROE',
      'Current Ratio'
    ];

    for (final metric in keyMetrics) {
      final values = getRowValues(metric);
      if (values.length >= 3) {
        final numericValues = values
            .take(3)
            .map((v) => _parseCleanNumeric(v))
            .where((v) => v != null)
            .cast<double>()
            .toList();

        if (numericValues.length >= 3) {
          trends[metric.toLowerCase().replaceAll(' ', '_')] =
              _calculateTrend(numericValues);
        }
      }
    }

    return trends;
  }

  String _calculateTrend(List<double> values) {
    if (values.length < 3) return 'Insufficient Data';

    final recent = values[0];
    final middle = values[1];
    final old = values[2];

    final recentChange = (recent - middle) / middle * 100;
    final olderChange = (middle - old) / old * 100;

    if (recentChange > 5 && olderChange > 5) return 'Strong Upward';
    if (recentChange > 0 && olderChange > 0) return 'Upward';
    if (recentChange < -5 && olderChange < -5) return 'Strong Downward';
    if (recentChange < 0 && olderChange < 0) return 'Downward';
    return 'Sideways';
  }

  // ============================================================================
  // EXISTING METHODS (Enhanced)
  // ============================================================================

  /// Enhanced toMap with calculated metrics
  Map<String, Map<String, dynamic>> toMap() {
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
  }

  /// Find rows containing specific keywords (enhanced)
  List<FinancialDataRow> findRows(List<String> keywords) {
    return body.where((row) {
      final description = row.description.toLowerCase();
      return keywords.any((keyword) => _fuzzyMatch(description, keyword));
    }).toList();
  }

  /// Enhanced growth rate calculation
  double? getGrowthRate(
      String description, String currentPeriod, String previousPeriod) {
    final currentValue = getNumericValue(description, currentPeriod);
    final previousValue = getNumericValue(description, previousPeriod);

    if (currentValue == null || previousValue == null || previousValue == 0) {
      return null;
    }

    return ((currentValue - previousValue) / previousValue) * 100;
  }

  /// Check if table has meaningful data
  bool get hasData =>
      headers.isNotEmpty &&
      body.isNotEmpty &&
      body.any(
          (row) => row.values.any((value) => value.isNotEmpty && value != '-'));

  /// Get time periods (headers excluding description)
  List<String> get timePeriods => headers;

  /// Get all metric names (descriptions)
  List<String> get metrics => body.map((row) => row.description).toList();

  /// Get key financial metrics only
  List<String> get keyMetrics => body
      .where((row) => row.isKeyMetric || _isKeyMetric(row.description))
      .map((row) => row.description)
      .toList();

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
      'debt to equity'
    ];
    return keyTerms.any((term) => _fuzzyMatch(description, term));
  }
}

// Enhanced utility class for financial metrics extraction
class FinancialMetricsExtractor {
  /// Extract comprehensive key metrics with enhanced parsing
  static Map<String, double?> extractKeyMetrics(FinancialDataModel model) {
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
      'shareholdersEquity': model.getLatestNumericValue('Shareholders Equity'),
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
  }

  /// Extract time series data with enhanced period detection
  static List<Map<String, dynamic>> extractTimeSeriesData(
      FinancialDataModel model, String metric) {
    final values = model.getRowValues(metric);
    final headers = model.headers;

    List<Map<String, dynamic>> timeSeries = [];

    for (int i = 0; i < headers.length && i < values.length; i++) {
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
    }

    return timeSeries;
  }

  static String _determinePeriodType(String header) {
    if (header.contains('Q') || header.contains('quarter')) return 'quarterly';
    if (RegExp(r'\d{4}').hasMatch(header)) return 'annual';
    return 'unknown';
  }

  static int? _extractYear(String header) {
    final yearMatch = RegExp(r'(\d{4})').firstMatch(header);
    return yearMatch != null ? int.tryParse(yearMatch.group(1)!) : null;
  }

  static String? _extractQuarter(String header) {
    final quarterMatch = RegExp(r'Q(\d)').firstMatch(header);
    return quarterMatch?.group(1);
  }

  /// Calculate enhanced growth rates with CAGR
  static Map<String, double?> calculateGrowthRates(FinancialDataModel model) {
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
      final values = model.getRowValues(metric);
      final numericValues = values
          .map((v) => model._parseCleanNumeric(v))
          .where((v) => v != null)
          .cast<double>()
          .toList();

      if (numericValues.length >= 2) {
        // 1-year growth
        final growth1Y =
            model._calculateGrowthRate(numericValues[0], numericValues[1]);
        if (growth1Y != null) {
          growthRates['${metric.toLowerCase().replaceAll(' ', '_')}_1y'] =
              growth1Y;
        }
      }

      if (numericValues.length >= 4) {
        // 3-year CAGR
        final cagr3Y =
            model._calculateCAGR(numericValues[0], numericValues[3], 3);
        if (cagr3Y != null) {
          growthRates['${metric.toLowerCase().replaceAll(' ', '_')}_3y_cagr'] =
              cagr3Y;
        }
      }
    }

    return growthRates;
  }

  /// Extract quality indicators
  static Map<String, dynamic> extractQualityIndicators(
      FinancialDataModel model) {
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
  }

  static double _calculateDataCompleteness(FinancialDataModel model) {
    if (model.body.isEmpty) return 0.0;

    int totalCells = 0;
    int filledCells = 0;

    for (final row in model.body) {
      for (final value in row.values) {
        totalCells++;
        if (value.isNotEmpty && value != '-' && value.toLowerCase() != 'n/a') {
          filledCells++;
        }
      }
    }

    return totalCells > 0 ? (filledCells / totalCells) * 100 : 0.0;
  }

  static double _calculateDataConsistency(FinancialDataModel model) {
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
  }
}
