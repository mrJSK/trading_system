import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:math';

part 'financial_data_model.freezed.dart';
part 'financial_data_model.g.dart';

@freezed
class FinancialDataModel with _$FinancialDataModel {
  const factory FinancialDataModel({
    @Default([]) List<String> headers,
    @Default([]) List<FinancialDataRow> body,
  }) = _FinancialDataModel;

  // Let Freezed generate this automatically
  factory FinancialDataModel.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataModelFromJson(json);
}

@freezed
class FinancialDataRow with _$FinancialDataRow {
  const factory FinancialDataRow({
    required String description,
    @Default([]) List<String> values,
  }) = _FinancialDataRow;

  // Let Freezed generate this automatically
  factory FinancialDataRow.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataRowFromJson(json);
}

// Move all custom logic to extensions
extension FinancialDataModelX on FinancialDataModel {
  bool get isEmpty => headers.isEmpty || body.isEmpty;
  bool get isNotEmpty => !isEmpty;
  int get columnCount => headers.length;
  int get rowCount => body.length;

  // Custom JSON parsing for your cloud function's complex data structure
  static FinancialDataModel fromCloudFunctionJson(dynamic json) {
    // Handle the nested structure from your cloud functions
    if (json is Map<String, dynamic>) {
      if (json.containsKey('headers') && json.containsKey('body')) {
        return FinancialDataModel(
          headers: List<String>.from(json['headers'] ?? []),
          body: (json['body'] as List<dynamic>? ?? [])
              .map((row) => FinancialDataRowX.fromCloudFunctionJson(
                  row)) // CORRECTED: Use extension class name
              .toList(),
        );
      }
    }

    return const FinancialDataModel();
  }

  String getValueAt(int rowIndex, int columnIndex) {
    if (rowIndex >= 0 &&
        rowIndex < body.length &&
        columnIndex >= 0 &&
        columnIndex < body[rowIndex].values.length) {
      return body[rowIndex].values[columnIndex];
    }
    return '';
  }

  FinancialDataRow? findRowByDescription(String description) {
    if (body.isEmpty) return null;

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

    // Partial match for common financial terms
    final commonMappings = {
      'sales': ['revenue', 'total income', 'net sales'],
      'profit': ['net profit', 'pat', 'profit after tax'],
      'revenue': ['sales', 'total income'],
      'expenses': ['total expenses', 'expenditure'],
      'assets': ['total assets'],
      'liabilities': ['total liabilities'],
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
  }

  List<String> getColumnValues(int columnIndex) {
    if (columnIndex < 0 || columnIndex >= headers.length) {
      return [];
    }

    return body.map((row) {
      if (columnIndex < row.values.length) {
        return row.values[columnIndex];
      }
      return '';
    }).toList();
  }

  List<List<String>> get tableData {
    if (isEmpty) return [];

    List<List<String>> table = [];
    table.add(['Description', ...headers]);

    for (final row in body) {
      table.add([row.description, ...row.values]);
    }

    return table;
  }

  Map<String, List<double?>> get growthRates {
    if (columnCount < 2) return {};

    Map<String, List<double?>> growth = {};

    for (final row in body) {
      if (!row.hasNumericData) continue;

      List<double?> rates = [];
      for (int i = 1; i < row.values.length; i++) {
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
  }
}

extension FinancialDataRowX on FinancialDataRow {
  // Custom JSON parsing for your cloud function's array format
  static FinancialDataRow fromCloudFunctionJson(dynamic json) {
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
        description:
            json['description']?.toString() ?? json['0']?.toString() ?? '',
        values: json['values'] != null
            ? List<String>.from(json['values'])
            : json.entries
                .where(
                    (entry) => entry.key != 'description' && entry.key != '0')
                .map((entry) => entry.value?.toString() ?? '')
                .toList(),
      );
    }

    return const FinancialDataRow(description: '');
  }

  String get latestValue {
    if (values.isEmpty) return '';
    return values.last;
  }

  String get firstValue {
    if (values.isEmpty) return '';
    return values.first;
  }

  bool get hasNumericData {
    return values.any((value) => _parseNumericValue(value) != null);
  }

  double? getNumericValue(int index) {
    if (index >= 0 && index < values.length) {
      return _parseNumericValue(values[index]);
    }
    return null;
  }

  List<double?> get numericValues {
    return values.map((value) => _parseNumericValue(value)).toList();
  }

  double? get latestNumericValue {
    if (values.isEmpty) return null;
    return _parseNumericValue(latestValue);
  }

  double? get growthRate {
    final first = _parseNumericValue(firstValue);
    final last = _parseNumericValue(latestValue);

    if (first != null && last != null && first != 0) {
      return ((last - first) / first) * 100;
    }
    return null;
  }

  double? get cagr {
    if (values.length < 2) return null;

    final first = _parseNumericValue(firstValue);
    final last = _parseNumericValue(latestValue);
    final years = values.length - 1;

    if (first != null && last != null && first > 0 && years > 0) {
      return (pow(last / first, 1 / years) - 1) * 100;
    }
    return null;
  }

  double? _parseNumericValue(String value) {
    if (value.isEmpty) return null;

    String cleanValue = value
        .replaceAll(',', '')
        .replaceAll('₹', '')
        .replaceAll('Rs.', '')
        .replaceAll('Rs', '')
        .replaceAll('%', '')
        .replaceAll('(', '-')
        .replaceAll(')', '')
        .trim();

    if (value.contains('(') && value.contains(')')) {
      cleanValue = '-' + cleanValue.replaceAll('-', '');
    }

    if (cleanValue.toLowerCase().endsWith('cr')) {
      final numPart = cleanValue.toLowerCase().replaceAll('cr', '').trim();
      final parsed = double.tryParse(numPart);
      return parsed != null ? parsed * 100 : null;
    }

    return double.tryParse(cleanValue);
  }
}
