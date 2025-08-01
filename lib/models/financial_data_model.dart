import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'dart:math';
import 'dart:convert';

part 'financial_data_model.freezed.dart';
part 'financial_data_model.g.dart';

// ============================================================================
// FINANCIAL DATA MODELS (FIXED FOR PROPER CODE GENERATION)
// ============================================================================

@freezed
class FinancialDataModel with _$FinancialDataModel {
  const factory FinancialDataModel({
    @Default([]) List<String> headers,
    @Default([]) List<FinancialDataRow> body,
  }) = _FinancialDataModel;

  // 🔥 FIXED: Let Freezed generate this automatically - DO NOT override
  factory FinancialDataModel.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataModelFromJson(json);
}

@freezed
class FinancialDataRow with _$FinancialDataRow {
  const factory FinancialDataRow({
    @Default('')
    String description, // 🔥 FIXED: Uses default instead of required
    @Default([]) List<String> values,
  }) = _FinancialDataRow;

  // 🔥 FIXED: Let Freezed generate this automatically - DO NOT override
  factory FinancialDataRow.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataRowFromJson(json);
}

// ============================================================================
// EXTENSIONS FOR ENHANCED FUNCTIONALITY
// ============================================================================

extension FinancialDataModelX on FinancialDataModel {
  bool get isEmpty => headers.isEmpty || body.isEmpty;
  bool get isNotEmpty => !isEmpty;
  int get columnCount => headers.length;
  int get rowCount => body.length;

  /// 🔥 SAFE: Custom parsing method with different name to avoid conflicts
  static FinancialDataModel fromCloudFunctionJson(dynamic json) {
    try {
      if (json == null) return const FinancialDataModel();

      if (json is Map<String, dynamic>) {
        if (json.containsKey('headers') && json.containsKey('body')) {
          return FinancialDataModel(
            headers: (json['headers'] as List<dynamic>? ?? [])
                .map((e) => e?.toString() ?? '')
                .toList(),
            body: (json['body'] as List<dynamic>? ?? [])
                .map((row) => FinancialDataRowX.fromCloudFunctionJson(row))
                .where((row) => row.description.isNotEmpty)
                .toList(),
          );
        }

        // Alternative format where keys are column headers
        final entries = json.entries.toList();
        if (entries.isNotEmpty) {
          final headers = entries.map((e) => e.key).toList();
          final values = entries.map((e) => e.value?.toString() ?? '').toList();

          return FinancialDataModel(
            headers: headers,
            body: [FinancialDataRow(description: 'Data', values: values)],
          );
        }
      }

      if (json is List && json.isNotEmpty) {
        if (json.length > 1 && json[0] is List) {
          final headers =
              (json[0] as List).map((e) => e?.toString() ?? '').toList();

          final body = json
              .skip(1)
              .map((row) => FinancialDataRowX.fromCloudFunctionJson(row))
              .toList();

          return FinancialDataModel(headers: headers, body: body);
        }
      }

      return const FinancialDataModel();
    } catch (e) {
      debugPrint('Error parsing cloud function JSON: $e');
      return const FinancialDataModel();
    }
  }

  /// 🔥 SAFE: Enhanced parsing with null safety for Firestore data
  static FinancialDataModel fromFirestoreData(dynamic data) {
    try {
      if (data == null) return const FinancialDataModel();

      if (data is Map<String, dynamic>) {
        return FinancialDataModel(
          headers: (data['headers'] as List<dynamic>? ?? [])
              .map((e) => e?.toString() ?? '')
              .toList(),
          body: (data['body'] as List<dynamic>? ?? [])
              .map((item) {
                try {
                  if (item is Map<String, dynamic>) {
                    return FinancialDataRow(
                      description: item['description']?.toString() ?? '',
                      values: (item['values'] as List<dynamic>? ?? [])
                          .map((e) => e?.toString() ?? '')
                          .toList(),
                    );
                  }
                  return const FinancialDataRow();
                } catch (e) {
                  debugPrint('Error parsing row: $e');
                  return const FinancialDataRow();
                }
              })
              .where((row) => row.description.isNotEmpty)
              .toList(),
        );
      }

      return const FinancialDataModel();
    } catch (e) {
      debugPrint('Error parsing Firestore data: $e');
      return const FinancialDataModel();
    }
  }

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
      debugPrint('Error getting value at [$rowIndex, $columnIndex]: $e');
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

      // Enhanced financial term mappings
      final commonMappings = {
        'sales': ['revenue', 'total income', 'net sales', 'turnover'],
        'profit': ['net profit', 'pat', 'profit after tax', 'earnings'],
        'revenue': ['sales', 'total income', 'turnover'],
        'expenses': ['total expenses', 'expenditure', 'costs'],
        'assets': ['total assets', 'current assets', 'fixed assets'],
        'liabilities': ['total liabilities', 'current liabilities'],
        'equity': ['shareholders equity', 'net worth'],
        'debt': ['total debt', 'borrowings', 'loans'],
        'ebitda': ['ebitda', 'operating profit'],
        'eps': ['earnings per share', 'basic eps'],
        'roe': ['return on equity', 'roe'],
        'roce': ['return on capital employed', 'roce'],
      };

      if (commonMappings.containsKey(searchTerm)) {
        for (final synonym in commonMappings[searchTerm]!) {
          for (final row in body) {
            if (row.description.toLowerCase().contains(synonym)) {
              return row;
            }
          }
        }
      }

      return null;
    } catch (e) {
      debugPrint('Error finding row by description "$description": $e');
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
      debugPrint('Error getting column values for index $columnIndex: $e');
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
            rowData.add(row.values[i]);
          } else {
            rowData.add('');
          }
        }
        table.add(rowData);
      }

      return table;
    } catch (e) {
      debugPrint('Error generating table data: $e');
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
      debugPrint('Error calculating growth rates: $e');
      return {};
    }
  }
}

extension FinancialDataRowX on FinancialDataRow {
  /// 🔥 SAFE: Custom parsing method with different name to avoid conflicts
  static FinancialDataRow fromCloudFunctionJson(dynamic json) {
    try {
      if (json == null) return const FinancialDataRow();

      // Handle array format: [description, value1, value2, ...]
      if (json is List && json.isNotEmpty) {
        return FinancialDataRow(
          description: json[0]?.toString() ?? '',
          values: json.skip(1).map((e) => e?.toString() ?? '').toList(),
        );
      }

      // Handle object format: {description: "...", values: [...]}
      if (json is Map<String, dynamic>) {
        return FinancialDataRow(
          description: json['description']?.toString() ??
              json['0']?.toString() ??
              json['label']?.toString() ??
              '',
          values: json['values'] != null
              ? (json['values'] as List<dynamic>? ?? [])
                  .map((e) => e?.toString() ?? '')
                  .toList()
              : json.entries
                  .where((entry) =>
                      entry.key != 'description' &&
                      entry.key != '0' &&
                      entry.key != 'label')
                  .map((entry) => entry.value?.toString() ?? '')
                  .toList(),
        );
      }

      // Handle string (single value)
      if (json is String) {
        return FinancialDataRow(description: json);
      }

      return const FinancialDataRow();
    } catch (e) {
      debugPrint('Error parsing FinancialDataRow JSON: $e');
      return const FinancialDataRow();
    }
  }

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
