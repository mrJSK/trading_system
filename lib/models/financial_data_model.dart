import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

part 'financial_data_model.freezed.dart';
part 'financial_data_model.g.dart';

// ============================================================================
// ENHANCED FINANCIAL DATA MODELS FOR LATEST SCRAPER DATA
// ============================================================================

@freezed
class FinancialDataModel with _$FinancialDataModel {
  const FinancialDataModel._();

  const factory FinancialDataModel({
    @Default([]) List<String> headers,
    @Default([]) List<FinancialDataRow> body,
    @Default('') String dataType,
    @Default('') String sourceUrl,
    @Default('') String lastUpdated,
  }) = _FinancialDataModel;

  factory FinancialDataModel.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataModelFromJson(json);
}

@freezed
class FinancialDataRow with _$FinancialDataRow {
  const FinancialDataRow._();

  const factory FinancialDataRow({
    @Default('') String description,
    @Default([]) List<String?> values,
    @Default('') String category,
    @Default(false) bool isCalculated,
  }) = _FinancialDataRow;

  factory FinancialDataRow.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataRowFromJson(json);
}

// ============================================================================
// QUARTERLY DATA MODEL (FROM LATEST SCRAPER)
// ============================================================================

@freezed
class QuarterlyData with _$QuarterlyData {
  const QuarterlyData._();

  const factory QuarterlyData({
    @Default('') String quarter,
    @Default('') String year,
    @Default('') String period,
    double? sales,
    double? netProfit,
    double? eps,
    double? ebitda,
    double? operatingProfit,
    double? operatingMargin,
    double? netMargin,
    @Default({}) Map<String, dynamic> additionalMetrics,
  }) = _QuarterlyData;

  factory QuarterlyData.fromJson(Map<String, dynamic> json) =>
      _$QuarterlyDataFromJson(json);
}

// ============================================================================
// ANNUAL DATA MODEL (FROM LATEST SCRAPER)
// ============================================================================

@freezed
class AnnualData with _$AnnualData {
  const AnnualData._();

  const factory AnnualData({
    @Default('') String year,
    double? sales,
    double? netProfit,
    double? eps,
    double? bookValue,
    double? dividendYield,
    double? roe,
    double? roce,
    double? peRatio,
    double? pbRatio,
    double? debtToEquity,
    double? currentRatio,
    double? interestCoverage,
    double? totalAssets,
    double? shareholdersEquity,
    double? totalDebt,
    double? workingCapital,
    double? operatingCashFlow,
    double? investingCashFlow,
    double? financingCashFlow,
    double? freeCashFlow,
    double? ebitda,
    double? operatingProfit,
    @Default({}) Map<String, dynamic> additionalMetrics,
  }) = _AnnualData;

  factory AnnualData.fromJson(Map<String, dynamic> json) =>
      _$AnnualDataFromJson(json);
}

// ============================================================================
// SHAREHOLDING PATTERN (FROM LATEST SCRAPER)
// ============================================================================

@freezed
class ShareholdingPattern with _$ShareholdingPattern {
  const ShareholdingPattern._();

  const factory ShareholdingPattern({
    double? promoterHolding,
    double? publicHolding,
    double? institutionalHolding,
    double? foreignInstitutional,
    @Default([]) List<MajorShareholder> majorShareholders,
    @Default({}) Map<String, Map<String, String>> quarterly,
    @Default('') String lastUpdated,
  }) = _ShareholdingPattern;

  factory ShareholdingPattern.fromJson(Map<String, dynamic> json) =>
      _$ShareholdingPatternFromJson(json);
}

@freezed
class MajorShareholder with _$MajorShareholder {
  const factory MajorShareholder({
    @Default('') String name,
    @Default(0.0) double percentage,
    @Default('') String category,
  }) = _MajorShareholder;

  factory MajorShareholder.fromJson(Map<String, dynamic> json) =>
      _$MajorShareholderFromJson(json);
}

// ============================================================================
// KEY POINTS MODELS (FROM LATEST SCRAPER)
// ============================================================================

@freezed
class KeyMilestone with _$KeyMilestone {
  const factory KeyMilestone({
    @Default('') String year,
    @Default('') String description,
    @Default('') String category,
    @Default('') String impact,
  }) = _KeyMilestone;

  factory KeyMilestone.fromJson(Map<String, dynamic> json) =>
      _$KeyMilestoneFromJson(json);
}

@freezed
class InvestmentHighlight with _$InvestmentHighlight {
  const factory InvestmentHighlight({
    @Default('') String type,
    @Default('') String description,
    @Default('') String impact,
    @Default('') String category,
  }) = _InvestmentHighlight;

  factory InvestmentHighlight.fromJson(Map<String, dynamic> json) =>
      _$InvestmentHighlightFromJson(json);
}

// ============================================================================
// ENHANCED EXTENSIONS FOR LATEST SCRAPER DATA
// ============================================================================

extension FinancialDataModelX on FinancialDataModel {
  bool get isEmpty => headers.isEmpty || body.isEmpty;
  bool get isNotEmpty => !isEmpty;
  int get columnCount => headers.length;
  int get rowCount => body.length;

  static FinancialDataModel fromFirebaseData(dynamic json) {
    try {
      if (json == null) return const FinancialDataModel();

      if (json is Map<String, dynamic>) {
        // Handle direct structure from latest scraper
        if (json.containsKey('headers') && json.containsKey('body')) {
          return FinancialDataModel.fromJson(json);
        }

        // Handle nested quarterly/annual data structure
        if (json.containsKey('quarterly_results')) {
          return _parseQuarterlyResults(json['quarterly_results']);
        }

        if (json.containsKey('annual_data')) {
          return _parseAnnualData(json['annual_data']);
        }

        if (json.containsKey('profit_loss')) {
          return _parseProfitLoss(json['profit_loss']);
        }

        if (json.containsKey('balance_sheet')) {
          return _parseBalanceSheet(json['balance_sheet']);
        }

        if (json.containsKey('cash_flow')) {
          return _parseCashFlow(json['cash_flow']);
        }

        if (json.containsKey('ratios')) {
          return _parseRatios(json['ratios']);
        }

        return _parseGenericStructure(json);
      }

      return const FinancialDataModel();
    } catch (e) {
      debugPrint('Error parsing Firebase financial data: $e');
      return const FinancialDataModel();
    }
  }

  static FinancialDataModel _parseQuarterlyResults(dynamic data) {
    try {
      if (data is! Map<String, dynamic>) return const FinancialDataModel();

      final headers = (data['headers'] as List<dynamic>? ?? [])
          .map((e) => e?.toString() ?? '')
          .where((h) => h.isNotEmpty)
          .toList();

      final bodyData = <FinancialDataRow>[];

      // Parse quarterly metrics
      final metrics = [
        'Sales',
        'Net Profit',
        'EPS',
        'EBITDA',
        'Operating Profit',
        'Operating Margin',
        'Net Margin',
      ];

      for (final metric in metrics) {
        final values = (data[metric.toLowerCase().replaceAll(' ', '_')]
                    as List<dynamic>? ??
                [])
            .map((e) => e?.toString())
            .toList();

        if (values.any((v) => v != null && v.isNotEmpty)) {
          bodyData.add(FinancialDataRow(
            description: metric,
            values: values,
            category: 'quarterly',
          ));
        }
      }

      return FinancialDataModel(
        headers: headers,
        body: bodyData,
        dataType: 'quarterly',
        lastUpdated: data['last_updated']?.toString() ?? '',
      );
    } catch (e) {
      debugPrint('Error parsing quarterly results: $e');
      return const FinancialDataModel();
    }
  }

  static FinancialDataModel _parseAnnualData(dynamic data) {
    try {
      if (data is! Map<String, dynamic>) return const FinancialDataModel();

      final headers = (data['headers'] as List<dynamic>? ?? [])
          .map((e) => e?.toString() ?? '')
          .where((h) => h.isNotEmpty)
          .toList();

      final bodyData = <FinancialDataRow>[];

      // Parse annual metrics with enhanced field mapping
      final metricsMap = {
        'Revenue': ['sales', 'revenue', 'total_income'],
        'Net Profit': ['net_profit', 'profit_after_tax', 'pat'],
        'EBITDA': ['ebitda', 'operating_profit_before_depreciation'],
        'Operating Profit': ['operating_profit', 'ebit'],
        'EPS': ['eps', 'earnings_per_share'],
        'Book Value': ['book_value', 'nav_per_share'],
        'Dividend Yield': ['dividend_yield', 'dividend_percent'],
        'ROE': ['roe', 'return_on_equity'],
        'ROCE': ['roce', 'return_on_capital_employed'],
        'Total Assets': ['total_assets', 'assets'],
        'Shareholders Equity': ['shareholders_equity', 'equity'],
        'Total Debt': ['total_debt', 'debt'],
        'Free Cash Flow': ['free_cash_flow', 'fcf'],
      };

      for (final entry in metricsMap.entries) {
        final metric = entry.key;
        final possibleKeys = entry.value;

        List<String?>? values;
        for (final key in possibleKeys) {
          if (data.containsKey(key)) {
            values = (data[key] as List<dynamic>? ?? [])
                .map((e) => e?.toString())
                .toList();
            break;
          }
        }

        if (values != null && values.any((v) => v != null && v!.isNotEmpty)) {
          bodyData.add(FinancialDataRow(
            description: metric,
            values: values,
            category: 'annual',
          ));
        }
      }

      return FinancialDataModel(
        headers: headers,
        body: bodyData,
        dataType: 'annual',
        lastUpdated: data['last_updated']?.toString() ?? '',
      );
    } catch (e) {
      debugPrint('Error parsing annual data: $e');
      return const FinancialDataModel();
    }
  }

  static FinancialDataModel _parseProfitLoss(dynamic data) {
    try {
      if (data is! Map<String, dynamic>) return const FinancialDataModel();

      final headers = (data['headers'] as List<dynamic>? ?? [])
          .map((e) => e?.toString() ?? '')
          .toList();

      final bodyData = <FinancialDataRow>[];

      // Enhanced P&L structure parsing
      final plMetrics = {
        'Total Income': ['total_income', 'revenue', 'sales'],
        'Total Expenses': ['total_expenses', 'operating_expenses'],
        'Operating Profit': ['operating_profit', 'ebit'],
        'Interest & Tax': ['interest_tax', 'finance_costs'],
        'Net Profit': ['net_profit', 'profit_after_tax'],
        'EPS': ['eps', 'earnings_per_share'],
        'Operating Margin': ['operating_margin', 'ebit_margin'],
        'Net Margin': ['net_margin', 'profit_margin'],
      };

      for (final entry in plMetrics.entries) {
        final metric = entry.key;
        final keys = entry.value;

        for (final key in keys) {
          if (data.containsKey(key)) {
            final values = (data[key] as List<dynamic>? ?? [])
                .map((e) => e?.toString())
                .toList();

            if (values.any((v) => v != null && v!.isNotEmpty)) {
              bodyData.add(FinancialDataRow(
                description: metric,
                values: values,
                category: 'profit_loss',
              ));
              break;
            }
          }
        }
      }

      return FinancialDataModel(
        headers: headers,
        body: bodyData,
        dataType: 'profit_loss',
        lastUpdated: data['last_updated']?.toString() ?? '',
      );
    } catch (e) {
      debugPrint('Error parsing P&L data: $e');
      return const FinancialDataModel();
    }
  }

  static FinancialDataModel _parseBalanceSheet(dynamic data) {
    try {
      if (data is! Map<String, dynamic>) return const FinancialDataModel();

      final headers = (data['headers'] as List<dynamic>? ?? [])
          .map((e) => e?.toString() ?? '')
          .toList();

      final bodyData = <FinancialDataRow>[];

      final bsMetrics = {
        'Total Assets': ['total_assets', 'assets'],
        'Fixed Assets': ['fixed_assets', 'tangible_assets'],
        'Current Assets': ['current_assets'],
        'Total Liabilities': ['total_liabilities', 'liabilities'],
        'Current Liabilities': ['current_liabilities'],
        'Long Term Debt': ['long_term_debt', 'total_debt'],
        'Shareholders Equity': ['shareholders_equity', 'equity'],
        'Reserves': ['reserves', 'retained_earnings'],
        'Book Value Per Share': ['book_value', 'nav_per_share'],
        'Tangible Book Value': ['tangible_book_value'],
      };

      for (final entry in bsMetrics.entries) {
        final metric = entry.key;
        final keys = entry.value;

        for (final key in keys) {
          if (data.containsKey(key)) {
            final values = (data[key] as List<dynamic>? ?? [])
                .map((e) => e?.toString())
                .toList();

            if (values.any((v) => v != null && v!.isNotEmpty)) {
              bodyData.add(FinancialDataRow(
                description: metric,
                values: values,
                category: 'balance_sheet',
              ));
              break;
            }
          }
        }
      }

      return FinancialDataModel(
        headers: headers,
        body: bodyData,
        dataType: 'balance_sheet',
        lastUpdated: data['last_updated']?.toString() ?? '',
      );
    } catch (e) {
      debugPrint('Error parsing balance sheet data: $e');
      return const FinancialDataModel();
    }
  }

  static FinancialDataModel _parseCashFlow(dynamic data) {
    try {
      if (data is! Map<String, dynamic>) return const FinancialDataModel();

      final headers = (data['headers'] as List<dynamic>? ?? [])
          .map((e) => e?.toString() ?? '')
          .toList();

      final bodyData = <FinancialDataRow>[];

      final cfMetrics = {
        'Operating Cash Flow': ['operating_cash_flow', 'cash_from_operations'],
        'Investing Cash Flow': ['investing_cash_flow', 'cash_from_investing'],
        'Financing Cash Flow': ['financing_cash_flow', 'cash_from_financing'],
        'Net Cash Flow': ['net_cash_flow', 'change_in_cash'],
        'Free Cash Flow': ['free_cash_flow', 'fcf'],
        'Cash and Equivalents': ['cash_equivalents', 'cash'],
      };

      for (final entry in cfMetrics.entries) {
        final metric = entry.key;
        final keys = entry.value;

        for (final key in keys) {
          if (data.containsKey(key)) {
            final values = (data[key] as List<dynamic>? ?? [])
                .map((e) => e?.toString())
                .toList();

            if (values.any((v) => v != null && v!.isNotEmpty)) {
              bodyData.add(FinancialDataRow(
                description: metric,
                values: values,
                category: 'cash_flow',
              ));
              break;
            }
          }
        }
      }

      return FinancialDataModel(
        headers: headers,
        body: bodyData,
        dataType: 'cash_flow',
        lastUpdated: data['last_updated']?.toString() ?? '',
      );
    } catch (e) {
      debugPrint('Error parsing cash flow data: $e');
      return const FinancialDataModel();
    }
  }

  static FinancialDataModel _parseRatios(dynamic data) {
    try {
      if (data is! Map<String, dynamic>) return const FinancialDataModel();

      final headers = (data['headers'] as List<dynamic>? ?? [])
          .map((e) => e?.toString() ?? '')
          .toList();

      final bodyData = <FinancialDataRow>[];

      final ratioMetrics = {
        'P/E Ratio': ['pe_ratio', 'stock_pe'],
        'P/B Ratio': ['pb_ratio', 'price_to_book'],
        'ROE (%)': ['roe', 'return_on_equity'],
        'ROCE (%)': ['roce', 'return_on_capital_employed'],
        'Current Ratio': ['current_ratio'],
        'Quick Ratio': ['quick_ratio'],
        'Debt to Equity': ['debt_to_equity', 'debt_equity_ratio'],
        'Interest Coverage': ['interest_coverage', 'times_interest_earned'],
        'Asset Turnover': ['asset_turnover', 'total_asset_turnover'],
        'Inventory Turnover': ['inventory_turnover'],
        'Working Capital Days': ['working_capital_days'],
        'Cash Conversion Cycle': ['cash_conversion_cycle'],
        'Dividend Yield (%)': ['dividend_yield'],
      };

      for (final entry in ratioMetrics.entries) {
        final metric = entry.key;
        final keys = entry.value;

        for (final key in keys) {
          if (data.containsKey(key)) {
            final values = (data[key] as List<dynamic>? ?? [])
                .map((e) => e?.toString())
                .toList();

            if (values.any((v) => v != null && v!.isNotEmpty)) {
              bodyData.add(FinancialDataRow(
                description: metric,
                values: values,
                category: 'ratios',
                isCalculated: true,
              ));
              break;
            }
          }
        }
      }

      return FinancialDataModel(
        headers: headers,
        body: bodyData,
        dataType: 'ratios',
        lastUpdated: data['last_updated']?.toString() ?? '',
      );
    } catch (e) {
      debugPrint('Error parsing ratios data: $e');
      return const FinancialDataModel();
    }
  }

  static FinancialDataModel _parseGenericStructure(Map<String, dynamic> json) {
    try {
      final headers = (json['headers'] as List<dynamic>? ?? [])
          .map((e) => e?.toString() ?? '')
          .where((h) => h.isNotEmpty)
          .toList();

      final bodyData = (json['body'] as List<dynamic>? ?? [])
          .map((item) {
            if (item is Map<String, dynamic>) {
              return FinancialDataRow.fromJson(item);
            }
            return const FinancialDataRow();
          })
          .where((row) => row.description.isNotEmpty)
          .toList();

      return FinancialDataModel(
        headers: headers,
        body: bodyData,
        dataType: json['data_type']?.toString() ?? '',
        sourceUrl: json['source_url']?.toString() ?? '',
        lastUpdated: json['last_updated']?.toString() ?? '',
      );
    } catch (e) {
      debugPrint('Error parsing generic structure: $e');
      return const FinancialDataModel();
    }
  }

  // Enhanced safe data access methods
  String getValueAt(int rowIndex, int columnIndex) {
    try {
      if (rowIndex >= 0 &&
          rowIndex < body.length &&
          columnIndex >= 0 &&
          columnIndex < body[rowIndex].values.length) {
        return body[rowIndex].values[columnIndex] ?? '';
      }
      return '';
    } catch (e) {
      return '';
    }
  }

  FinancialDataRow? findRowByDescription(String description) {
    if (body.isEmpty || description.isEmpty) return null;

    try {
      final searchTerm = description.toLowerCase().trim();

      for (final row in body) {
        final rowDesc = row.description.toLowerCase().trim();
        if (rowDesc == searchTerm || rowDesc.contains(searchTerm)) {
          return row;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  List<String> getColumnValues(int columnIndex) {
    try {
      if (columnIndex < 0 || columnIndex >= headers.length) {
        return [];
      }

      return body.map((row) {
        if (columnIndex < row.values.length) {
          return row.values[columnIndex] ?? '';
        }
        return '';
      }).toList();
    } catch (e) {
      return [];
    }
  }

  List<List<String>> get tableData {
    try {
      if (isEmpty) return [];

      List<List<String>> table = [];
      table.add(['Description', ...headers]);

      for (final row in body) {
        final rowData = [row.description];
        for (int i = 0; i < headers.length; i++) {
          if (i < row.values.length) {
            rowData.add(row.values[i] ?? '');
          } else {
            rowData.add('');
          }
        }
        table.add(rowData);
      }

      return table;
    } catch (e) {
      return [];
    }
  }

  Map<String, List<double?>> get growthRates {
    try {
      if (columnCount < 2) return {};

      Map<String, List<double?>> growth = {};

      for (final row in body) {
        if (!row.hasNumericData) continue;

        List<double?> rates = [];
        for (int i = 1; i < row.values.length && i < headers.length; i++) {
          final current = row.getNumericValue(i);
          final previous = row.getNumericValue(i - 1);

          if (current != null && previous != null && previous != 0) {
            final rate = ((current - previous) / previous) * 100;
            rates.add(rate);
          } else {
            rates.add(null);
          }
        }

        if (rates.any((rate) => rate != null)) {
          growth[row.description] = rates;
        }
      }

      return growth;
    } catch (e) {
      return {};
    }
  }

  double? getLatestMetric(String metricName) {
    final row = findRowByDescription(metricName);
    return row?.latestNumericValue;
  }

  double? getMetricGrowthRate(String metricName) {
    final row = findRowByDescription(metricName);
    return row?.growthRate;
  }

  double? getMetricCAGR(String metricName) {
    final row = findRowByDescription(metricName);
    return row?.cagr;
  }

  bool isMetricTrendingUp(String metricName) {
    final row = findRowByDescription(metricName);
    return row?.isGrowingTrend ?? false;
  }

  Map<String, double?> get latestMetricsSummary {
    Map<String, double?> summary = {};
    for (final row in body) {
      if (row.hasNumericData) {
        summary[row.description] = row.latestNumericValue;
      }
    }
    return summary;
  }
}

// ============================================================================
// ENHANCED FINANCIAL DATA ROW EXTENSIONS
// ============================================================================

extension FinancialDataRowX on FinancialDataRow {
  String get latestValue => values.isEmpty ? '' : (values.last ?? '');
  String get firstValue => values.isEmpty ? '' : (values.first ?? '');
  bool get hasNumericData =>
      values.any((value) => _parseNumericValue(value) != null);

  double? getNumericValue(int index) {
    try {
      if (index >= 0 && index < values.length) {
        return _parseNumericValue(values[index]);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  List<double?> get numericValues => values.map(_parseNumericValue).toList();

  double? get latestNumericValue =>
      values.isEmpty ? null : _parseNumericValue(latestValue);

  double? get growthRate {
    try {
      final first = _parseNumericValue(firstValue);
      final last = _parseNumericValue(latestValue);

      if (first != null && last != null && first != 0) {
        return ((last - first) / first) * 100;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  double? get cagr {
    try {
      if (values.length < 2) return null;

      final first = _parseNumericValue(firstValue);
      final last = _parseNumericValue(latestValue);
      final years = values.length - 1;

      if (first != null && last != null && first > 0 && years > 0) {
        return (pow(last / first, 1 / years) - 1) * 100;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  double? get averageValue {
    try {
      final nums =
          numericValues.where((v) => v != null).cast<double>().toList();
      if (nums.isEmpty) return null;
      return nums.reduce((a, b) => a + b) / nums.length;
    } catch (e) {
      return null;
    }
  }

  bool get isGrowingTrend {
    try {
      final nums =
          numericValues.where((v) => v != null).cast<double>().toList();
      if (nums.length < 2) return false;

      int upCount = 0;
      for (int i = 1; i < nums.length; i++) {
        if (nums[i] > nums[i - 1]) upCount++;
      }

      return upCount > nums.length / 2;
    } catch (e) {
      return false;
    }
  }

  double? _parseNumericValue(String? value) {
    try {
      if (value == null || value.isEmpty) return null;

      String cleanValue = value
          .replaceAll(',', '')
          .replaceAll('₹', '')
          .replaceAll('Rs.', '')
          .replaceAll('Rs', '')
          .replaceAll('%', '')
          .replaceAll('(', '-')
          .replaceAll(')', '')
          .replaceAll(' ', '')
          .trim();

      if (value.contains('(') && value.contains(')')) {
        cleanValue = '-' + cleanValue.replaceAll('-', '');
      }

      if (cleanValue.toLowerCase() == 'na' ||
          cleanValue.toLowerCase() == 'n/a' ||
          cleanValue == '-' ||
          cleanValue.isEmpty) {
        return null;
      }

      // Handle Crores
      if (cleanValue.toLowerCase().endsWith('cr')) {
        final numPart = cleanValue.toLowerCase().replaceAll('cr', '').trim();
        final parsed = double.tryParse(numPart);
        return parsed != null ? parsed * 100 : null;
      }

      // Handle Lakhs
      if (cleanValue.toLowerCase().endsWith('l') ||
          cleanValue.toLowerCase().endsWith('lakh')) {
        final numPart = cleanValue
            .toLowerCase()
            .replaceAll('l', '')
            .replaceAll('lakh', '')
            .trim();
        final parsed = double.tryParse(numPart);
        return parsed;
      }

      // Handle thousands (K)
      if (cleanValue.toLowerCase().endsWith('k')) {
        final numPart = cleanValue.toLowerCase().replaceAll('k', '').trim();
        final parsed = double.tryParse(numPart);
        return parsed != null ? parsed * 1000 : null;
      }

      return double.tryParse(cleanValue);
    } catch (e) {
      return null;
    }
  }
}
