import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:math';

class JsonParsingUtils {
  // ============================================================================
  // SAFE TYPE CONVERSION METHODS (your existing code)
  // ============================================================================

  static String? safeString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.isEmpty ? null : value;
    return value.toString();
  }

  static double? safeDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String && value.isNotEmpty) {
      final clean = value.replaceAll(RegExp(r'[^0-9.-]'), '');
      return double.tryParse(clean);
    }
    return null;
  }

  static int? safeInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.round();
    if (value is String && value.isNotEmpty) {
      final clean = value.replaceAll(RegExp(r'[^0-9.-]'), '');
      return int.tryParse(clean);
    }
    return null;
  }

  static bool? safeBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is String) {
      return value.toLowerCase() == 'true';
    }
    if (value is int) return value != 0;
    return null;
  }

  static List<String>? safeStringList(dynamic value) {
    if (value == null) return null;
    if (value is List<String>) return value;
    if (value is List) {
      return value
          .map((e) => e?.toString())
          .where((e) => e != null && e.isNotEmpty)
          .cast<String>()
          .toList();
    }
    return null;
  }

  static Map<String, dynamic> safeMap(dynamic value) {
    if (value == null) return <String, dynamic>{};
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }
    return <String, dynamic>{};
  }

  static DateTime? safeDateTime(dynamic value) {
    if (value == null) return null;
    try {
      if (value is DateTime) return value;
      if (value is Timestamp) return value.toDate();
      if (value is String && value.isNotEmpty) {
        return DateTime.tryParse(value);
      }
      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      }
      return null;
    } catch (e) {
      debugPrint('Error converting to DateTime: $e');
      return null;
    }
  }

  // ============================================================================
  // ENHANCED NUMERIC PARSING (your existing code)
  // ============================================================================

  static double? parseCleanNumeric(String? value) {
    if (value == null ||
        value.isEmpty ||
        value == '-' ||
        value.toLowerCase() == 'n/a') {
      return null;
    }

    try {
      // Handle special cases
      if (value.toLowerCase().contains('inf') ||
          value.toLowerCase().contains('infinity')) return null;

      // Remove currency symbols, commas, parentheses, and other formatting
      String cleaned = value
          .replaceAll(RegExp(r'[₹$€£¥,\s()%]'), '')
          .replaceAll('Cr.', '')
          .replaceAll('cr', '')
          .replaceAll('L', '')
          .replaceAll('K', '')
          .trim();

      // Handle negative values in parentheses
      if (value.contains('(') && value.contains(')')) {
        cleaned = '-' + cleaned.replaceAll(RegExp(r'[()]'), '');
      }

      final parsed = double.tryParse(cleaned);

      // Handle very large or very small values
      if (parsed != null && (parsed.isInfinite || parsed.isNaN)) return null;

      return parsed;
    } catch (e) {
      debugPrint('Error parsing numeric value "$value": $e');
      return null;
    }
  }

  static double? parseFinancialValue(String value) {
    if (value.isEmpty || value == '-' || value.toLowerCase() == 'n/a') {
      return null;
    }

    String cleaned = value.replaceAll(RegExp(r'[^\d.-]'), '');
    return double.tryParse(cleaned);
  }

  // ============================================================================
  // JSON DATA CLEANING (your existing code)
  // ============================================================================

  static Map<String, dynamic> cleanJsonData(Map<String, dynamic> json) {
    final cleaned = Map<String, dynamic>.from(json);

    // Clean string fields
    cleaned.forEach((key, value) {
      if (value is String && value.isEmpty) {
        cleaned[key] = null;
      }
    });

    return cleaned;
  }

  static List<String> cleanStringList(dynamic data) {
    if (data == null) return <String>[];
    if (data is List<String>) return data;
    if (data is List) {
      return data
          .map((item) => item?.toString())
          .where((item) => item != null && item.isNotEmpty)
          .cast<String>()
          .toList();
    }
    return <String>[];
  }

  static List<Map<String, dynamic>> cleanMapList(dynamic data) {
    if (data == null) return <Map<String, dynamic>>[];
    if (data is List) {
      return data
          .map((item) {
            if (item is Map<String, dynamic>) {
              return item;
            }
            if (item is Map) {
              return Map<String, dynamic>.from(item);
            }
            return null;
          })
          .where((item) => item != null)
          .cast<Map<String, dynamic>>()
          .toList();
    }
    return <Map<String, dynamic>>[];
  }

  // ============================================================================
  // QUARTERLY DATA CLEANING (your existing code)
  // ============================================================================

  static dynamic cleanQuarterlyData(dynamic data) {
    if (data == null) return null;

    try {
      if (data is List) {
        return data
            .map((item) {
              if (item is Map<String, dynamic>) {
                return item;
              } else if (item.runtimeType
                  .toString()
                  .contains('QuarterlyData')) {
                // Convert QuarterlyData object to Map
                try {
                  return (item as dynamic).toJson();
                } catch (e) {
                  debugPrint('Failed to convert QuarterlyData to JSON: $e');
                  return null;
                }
              }
              return item;
            })
            .where((item) => item != null)
            .toList();
      }
      return data;
    } catch (e) {
      debugPrint('Error cleaning quarterly data: $e');
      return null;
    }
  }

  // ============================================================================
  // SAFE JSON PARSING WITH ERROR HANDLING (your existing code)
  // ============================================================================

  static T? safeJsonParse<T>(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
    String debugName,
  ) {
    if (json == null) return null;

    try {
      if (json is T) return json;

      if (json is Map<String, dynamic>) {
        return fromJson(json);
      }

      if (json is Map) {
        return fromJson(Map<String, dynamic>.from(json));
      }

      if (json is String && json.isNotEmpty) {
        try {
          final decoded = jsonDecode(json);
          if (decoded is Map<String, dynamic>) {
            return fromJson(decoded);
          }
        } catch (jsonError) {
          debugPrint('JSON decode error for $debugName: $jsonError');
        }
      }

      return null;
    } catch (e, stack) {
      debugPrint('Error parsing $debugName: $e\n$stack');
      return null;
    }
  }

  static List<T>? safeJsonParseList<T>(
    dynamic json,
    T Function(Map<String, dynamic>) fromJson,
    String debugName,
  ) {
    if (json == null) return null;

    try {
      if (json is List) {
        return json
            .map((item) {
              if (item is T) return item;
              if (item is Map<String, dynamic>) {
                try {
                  return fromJson(item);
                } catch (e) {
                  debugPrint('Error parsing list item in $debugName: $e');
                  return null;
                }
              }
              // Handle serialized objects
              if (item.runtimeType
                  .toString()
                  .contains(T.toString().split('<').first)) {
                try {
                  return item as T;
                } catch (e) {
                  debugPrint('Failed to cast $debugName item: $e');
                  return null;
                }
              }
              return null;
            })
            .where((item) => item != null)
            .cast<T>()
            .toList();
      }
      return null;
    } catch (e) {
      debugPrint('Error parsing list for $debugName: $e');
      return null;
    }
  }

  // ============================================================================
  // FINANCIAL CALCULATIONS (your existing code)
  // ============================================================================

  static double? calculatePriceToBook(Map<String, dynamic> data) {
    final price = safeDouble(data['current_price']);
    final book = safeDouble(data['book_value']);
    if (price != null && book != null && book > 0) {
      return double.parse((price / book).toStringAsFixed(2));
    }
    return null;
  }

  static bool calculateIsDebtFree(Map<String, dynamic> data) {
    final debtToEquity = safeDouble(data['debt_to_equity']);
    return debtToEquity != null && debtToEquity < 0.1;
  }

  static bool calculateIsProfitable(Map<String, dynamic> data) {
    final roe = safeDouble(data['roe']);
    final returnOnEquity = safeDouble(data['Return on Equity']);
    return (roe != null && roe > 0) ||
        (returnOnEquity != null && returnOnEquity > 0);
  }

  static bool calculateHasConsistentProfits(Map<String, dynamic> data) {
    final roe = safeDouble(data['roe']);
    final profitGrowth = safeDouble(data['Compounded Profit Growth']) ??
        safeDouble(data['profit_growth_3y']);
    return (roe != null && roe > 10.0) &&
        (profitGrowth != null && profitGrowth > 0);
  }

  static bool calculatePaysDividends(Map<String, dynamic> data) {
    final dividendYield = safeDouble(data['dividend_yield']);
    return dividendYield != null && dividendYield > 0;
  }

  static bool calculateIsGrowthStock(Map<String, dynamic> data) {
    final salesGrowth = safeDouble(data['Compounded Sales Growth']) ??
        safeDouble(data['sales_growth_3y']);
    final profitGrowth = safeDouble(data['Compounded Profit Growth']) ??
        safeDouble(data['profit_growth_3y']);
    return (salesGrowth != null && salesGrowth > 15.0) ||
        (profitGrowth != null && profitGrowth > 15.0);
  }

  static bool calculateIsValueStock(Map<String, dynamic> data) {
    final pe = safeDouble(data['stock_pe']);
    final roe = safeDouble(data['roe']);
    return (pe != null && pe < 15.0 && pe > 0) && (roe != null && roe > 10.0);
  }

  static bool calculateIsQualityStock(Map<String, dynamic> data) {
    final roe = safeDouble(data['roe']);
    final roce = safeDouble(data['roce']);
    final piotroskiScore = safeDouble(data['piotroski_score']);
    final qualityScore = safeInt(data['quality_score']);
    return (roe != null && roe > 15.0) ||
        (roce != null && roce > 15.0) ||
        (piotroskiScore != null && piotroskiScore >= 7) ||
        (qualityScore != null && qualityScore >= 4);
  }

  // ============================================================================
  // ADDITIONAL METHODS FOR MANUAL SERIALIZATION
  // ============================================================================

  static double? calculateCAGR(double endValue, double beginValue, int years) {
    try {
      if (beginValue <= 0 || endValue <= 0 || years <= 0) return null;
      final result = (pow(endValue / beginValue, 1 / years) - 1) * 100;
      return result.isFinite ? result.toDouble() : null;
    } catch (e) {
      debugPrint('Error calculating CAGR: $e');
      return null;
    }
  }

  static double? calculateGrowthRate(double current, double previous) {
    try {
      if (previous == 0) return null;
      final result = ((current - previous) / previous) * 100;
      return result.isFinite ? result.toDouble() : null;
    } catch (e) {
      debugPrint('Error calculating growth rate: $e');
      return null;
    }
  }
}
