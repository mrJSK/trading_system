import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';
import 'dart:math';

part 'financial_data_model.freezed.dart';
part 'financial_data_model.g.dart';

@freezed
class FinancialDataModel with _$FinancialDataModel {
  const factory FinancialDataModel({
    @Default([]) List<String> headers,
    @Default([]) List<FinancialDataRow> body,
  }) = _FinancialDataModel;

  factory FinancialDataModel.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataModelFromJson(json);
}

@freezed
class FinancialDataRow with _$FinancialDataRow {
  const factory FinancialDataRow({
    required String description,
    @Default([]) List<String> values,
  }) = _FinancialDataRow;

  factory FinancialDataRow.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataRowFromJson(json);
}

extension FinancialDataModelX on FinancialDataModel {
  bool get isEmpty => headers.isEmpty || body.isEmpty;
  bool get isNotEmpty => !isEmpty;
  int get columnCount => headers.length;
  int get rowCount => body.length;

  static FinancialDataModel fromCloudFunctionJson(dynamic json) {
    try {
      if (json == null) return const FinancialDataModel();

      // Handle string input
      if (json is String) {
        try {
          json = jsonDecode(json);
        } catch (e) {
          return const FinancialDataModel();
        }
      }

      // Handle Map input
      if (json is Map<String, dynamic>) {
        return FinancialDataModel(
          headers: _safeStringList(json['headers']) ?? [],
          body: _safeList(json['body'])
                  ?.map((row) => FinancialDataRowX.tryParse(row))
                  .whereType<FinancialDataRow>()
                  .toList() ??
              [],
        );
      }

      // Handle List input (assuming it's the body)
      if (json is List) {
        return FinancialDataModel(
          body: json
              .map((row) => FinancialDataRowX.tryParse(row))
              .whereType<FinancialDataRow>()
              .toList(),
        );
      }
    } catch (e) {
      print('Error parsing FinancialDataModel: $e');
    }

    return const FinancialDataModel();
  }

  String getValueAt(int rowIndex, int columnIndex) {
    if (rowIndex >= 0 &&
        rowIndex < body.length &&
        columnIndex >= 0 &&
        columnIndex < headers.length &&
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
        final current = row.getNumericValueAtIndex(i);
        final previous = row.getNumericValueAtIndex(i - 1);

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

  // Helper methods
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

  static List<dynamic>? _safeList(dynamic value) {
    if (value == null) return null;
    if (value is List) return value;
    return null;
  }
}

extension FinancialDataRowX on FinancialDataRow {
  static FinancialDataRow? tryParse(dynamic json) {
    try {
      return fromCloudFunctionJson(json);
    } catch (e) {
      print('Error parsing FinancialDataRow: $e');
      return null;
    }
  }

  static FinancialDataRow fromCloudFunctionJson(dynamic json) {
    // Handle array format: [description, value1, value2, ...]
    if (json is List) {
      return FinancialDataRow(
        description: json.isNotEmpty ? json[0]?.toString() ?? '' : '',
        values: json.length > 1
            ? json.sublist(1).map((e) => e?.toString() ?? '').toList()
            : [],
      );
    }

    // Handle object format: {description: "...", values: [...]}
    if (json is Map<String, dynamic>) {
      return FinancialDataRow(
        description: json['description']?.toString() ??
            json['0']?.toString() ??
            json['name']?.toString() ??
            '',
        values: _parseValues(json),
      );
    }

    // Handle string input (maybe JSON string)
    if (json is String) {
      try {
        final decoded = jsonDecode(json);
        return fromCloudFunctionJson(decoded);
      } catch (e) {
        return FinancialDataRow(description: json);
      }
    }

    return FinancialDataRow(
      description: json?.toString() ?? '',
      values: [],
    );
  }

  static List<String> _parseValues(Map<String, dynamic> json) {
    // First try the 'values' key
    if (json['values'] is List) {
      return (json['values'] as List).map((e) => e?.toString() ?? '').toList();
    }

    // Otherwise gather all non-description fields
    return json.entries
        .where((entry) => !['description', '0', 'name'].contains(entry.key))
        .map((entry) => entry.value?.toString() ?? '')
        .toList();
  }

  String get latestValue => values.isNotEmpty ? values.last : '';
  String get firstValue => values.isNotEmpty ? values.first : '';

  bool get hasNumericData =>
      values.any((value) => parseNumericValue(value) != null);

  double? getNumericValueAtIndex(int index) {
    if (index >= 0 && index < values.length) {
      return parseNumericValue(values[index]);
    }
    return null;
  }

  List<double?> get numericValues => values.map(parseNumericValue).toList();
  double? get latestNumericValue => parseNumericValue(latestValue);

  double? get growthRate {
    final first = parseNumericValue(firstValue);
    final last = parseNumericValue(latestValue);

    if (first != null && last != null && first != 0) {
      return ((last - first) / first) * 100;
    }
    return null;
  }

  double? get cagr {
    if (values.length < 2) return null;

    final first = parseNumericValue(firstValue);
    final last = parseNumericValue(latestValue);
    final years = values.length - 1;

    if (first != null && last != null && first > 0 && years > 0) {
      return (pow(last / first, 1 / years) - 1) * 100;
    }
    return null;
  }

  static double? parseNumericValue(String? value) {
    if (value == null || value.isEmpty) return null;

    try {
      String cleanValue = value
          .replaceAll(',', '')
          .replaceAll('₹', '')
          .replaceAll('Rs.', '')
          .replaceAll('Rs', '')
          .replaceAll('%', '')
          .replaceAll('(', '-')
          .replaceAll(')', '')
          .trim();

      // Handle negative values in parentheses
      if (value.contains('(') && value.contains(')')) {
        cleanValue = '-${cleanValue.replaceAll('-', '')}';
      }

      // Handle crore values
      if (cleanValue.toLowerCase().endsWith('cr')) {
        final numPart = cleanValue.toLowerCase().replaceAll('cr', '').trim();
        final parsed = double.tryParse(numPart);
        return parsed != null ? parsed * 100 : null;
      }

      return double.tryParse(cleanValue);
    } catch (e) {
      print('Error parsing numeric value: $value');
      return null;
    }
  }
}
