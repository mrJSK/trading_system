import 'package:freezed_annotation/freezed_annotation.dart';

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
    @Default('') String description,
    @Default([]) List<String> values,
  }) = _FinancialDataRow;

  factory FinancialDataRow.fromJson(Map<String, dynamic> json) =>
      _$FinancialDataRowFromJson(json);
}

// Extensions for convenience methods
extension FinancialDataModelX on FinancialDataModel {
  bool get isEmpty => headers.isEmpty || body.isEmpty;

  bool get isNotEmpty => !isEmpty;

  int get columnCount => headers.length;

  int get rowCount => body.length;

  // Get a specific cell value
  String getValueAt(int rowIndex, int columnIndex) {
    if (rowIndex >= 0 &&
        rowIndex < body.length &&
        columnIndex >= 0 &&
        columnIndex < body[rowIndex].values.length) {
      return body[rowIndex].values[columnIndex];
    }
    return '';
  }

  // Find a row by description
  FinancialDataRow? findRowByDescription(String description) {
    try {
      return body.firstWhere(
        (row) =>
            row.description.toLowerCase().contains(description.toLowerCase()),
      );
    } catch (e) {
      return null;
    }
  }

  // Get all values for a specific column (year/quarter)
  List<String> getColumnValues(int columnIndex) {
    if (columnIndex < 0 || columnIndex >= columnCount) {
      return [];
    }

    return body.map((row) {
      if (columnIndex < row.values.length) {
        return row.values[columnIndex];
      }
      return '';
    }).toList();
  }
}

extension FinancialDataRowX on FinancialDataRow {
  // Get the latest value (assuming values are ordered chronologically)
  String get latestValue {
    if (values.isEmpty) return '';
    return values.last;
  }

  // Get the first value
  String get firstValue {
    if (values.isEmpty) return '';
    return values.first;
  }

  // Check if the row has any numeric data
  bool get hasNumericData {
    return values
        .any((value) => double.tryParse(value.replaceAll(',', '')) != null);
  }

  // Get numeric value at index (removes commas and converts)
  double? getNumericValue(int index) {
    if (index >= 0 && index < values.length) {
      final cleanValue = values[index].replaceAll(',', '').replaceAll('%', '');
      return double.tryParse(cleanValue);
    }
    return null;
  }
}
