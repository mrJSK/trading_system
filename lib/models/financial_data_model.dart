import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';

part 'financial_data_model.freezed.dart';
part 'financial_data_model.g.dart';

// ============================================================================
// SIMPLIFIED FINANCIAL DATA MODELS USING FREEZED AUTOMATIC PARSING
// ============================================================================

@freezed
class FinancialDataModel with _$FinancialDataModel {
  const FinancialDataModel._();

  const factory FinancialDataModel({
    @Default([]) List<String> headers,
    @Default([]) List<FinancialDataRow> body,
  }) = _FinancialDataModel;

  // Single line - Freezed automatically generates all JSON parsing
  factory FinancialDataModel.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataModelFromJson(json);
}

@freezed
class FinancialDataRow with _$FinancialDataRow {
  const FinancialDataRow._();

  const factory FinancialDataRow({
    @Default('') String description,
    @Default([]) List<String> values,
  }) = _FinancialDataRow;

  // Single line - Freezed automatically generates all JSON parsing
  factory FinancialDataRow.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataRowFromJson(json);
}

// ============================================================================
// EXTENSIONS FOR ENHANCED FUNCTIONALITY (SIMPLIFIED)
// ============================================================================

extension FinancialDataModelX on FinancialDataModel {
  bool get isEmpty => headers.isEmpty || body.isEmpty;
  bool get isNotEmpty => !isEmpty;
  int get columnCount => headers.length;
  int get rowCount => body.length;

  /// Enhanced parsing from Firebase cloud function data
  static FinancialDataModel fromFirebaseData(dynamic json) {
    try {
      if (json == null) return const FinancialDataModel();

      // If it's already a properly structured Map, use Freezed's automatic parsing
      if (json is Map<String, dynamic> &&
          json.containsKey('headers') &&
          json.containsKey('body')) {
        return FinancialDataModel.fromJson(json);
      }

      // Handle alternative formats from your Firebase scraper
      if (json is Map<String, dynamic>) {
        final headers = (json['headers'] as List<dynamic>? ?? [])
            .map((e) => e?.toString() ?? '')
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

        return FinancialDataModel(headers: headers, body: bodyData);
      }

      return const FinancialDataModel();
    } catch (e) {
      debugPrint('Error parsing Firebase financial data: $e');
      return const FinancialDataModel();
    }
  }

  // Safe data access methods
  String getValueAt(int rowIndex, int columnIndex) {
    try {
      if (rowIndex >= 0 &&
          rowIndex < body.length &&
          columnIndex >= 0 &&
          columnIndex < body[rowIndex].values.length) {
        return body[rowIndex].values[columnIndex];
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

      // Exact match first
      for (final row in body) {
        if (row.description.toLowerCase().trim() == searchTerm) {
          return row;
        }
      }

      // Contains match
      for (final row in body) {
        if (row.description.toLowerCase().contains(searchTerm)) {
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
          return row.values[columnIndex];
        }
        return '';
      }).toList();
    } catch (e) {
      return [];
    }
  }

  // Generate table data for display
  List<List<String>> get tableData {
    try {
      if (isEmpty) return [];

      List<List<String>> table = [];
      table.add(['Description', ...headers]);

      for (final row in body) {
        final rowData = [row.description];
        for (int i = 0; i < headers.length; i++) {
          if (i < row.values.length) {
            rowData.add(row.values[i]);
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

  // Calculate growth rates between periods
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
}

// ============================================================================
// FINANCIAL DATA ROW EXTENSIONS
// ============================================================================

extension FinancialDataRowX on FinancialDataRow {
  String get latestValue => values.isEmpty ? '' : values.last;
  String get firstValue => values.isEmpty ? '' : values.first;
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

  // Calculate growth rate between first and last values
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

  // Calculate Compound Annual Growth Rate (CAGR)
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

  // Calculate average value
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

  // Check if trend is generally growing
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

  // Enhanced numeric value parser for Indian financial data
  double? _parseNumericValue(String value) {
    try {
      if (value.isEmpty) return null;

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

      // Handle negative values in parentheses
      if (value.contains('(') && value.contains(')')) {
        cleanValue = '-' + cleanValue.replaceAll('-', '');
      }

      // Handle "N/A", "NA", "-", etc.
      if (cleanValue.toLowerCase() == 'na' ||
          cleanValue.toLowerCase() == 'n/a' ||
          cleanValue == '-' ||
          cleanValue.isEmpty) {
        return null;
      }

      // Handle Crores (multiply by 100 for conversion to actual number)
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

// ============================================================================
// UTILITY FUNCTIONS FOR FINANCIAL ANALYSIS
// ============================================================================

extension FinancialAnalysisX on FinancialDataModel {
  /// Get latest financial metric by name (e.g., "Sales", "Net Profit")
  double? getLatestMetric(String metricName) {
    final row = findRowByDescription(metricName);
    return row?.latestNumericValue;
  }

  /// Get metric growth rate over available periods
  double? getMetricGrowthRate(String metricName) {
    final row = findRowByDescription(metricName);
    return row?.growthRate;
  }

  /// Get CAGR for a specific metric
  double? getMetricCAGR(String metricName) {
    final row = findRowByDescription(metricName);
    return row?.cagr;
  }

  /// Check if a metric is trending upward
  bool isMetricTrendingUp(String metricName) {
    final row = findRowByDescription(metricName);
    return row?.isGrowingTrend ?? false;
  }

  /// Get all available metrics as a summary map
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
