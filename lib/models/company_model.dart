import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'financial_data_model.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

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

    // Firebase document timestamps
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
    // API data timestamp
    required String lastUpdated,
    @Default(0.0) double changePercent,
    @Default(0.0) double changeAmount,
    @Default(0.0) double previousClose,

    // Financial statements from your cloud functions
    FinancialDataModel? quarterlyResults,
    FinancialDataModel? profitLossStatement,
    FinancialDataModel? balanceSheet,
    FinancialDataModel? cashFlowStatement,
    FinancialDataModel? ratios,

    // Industry and shareholding data
    @Default([]) List<String> industryClassification,
    ShareholdingPattern? shareholdingPattern,
    @Default({}) Map<String, dynamic> ratiosData,
    @Default({}) Map<String, Map<String, String>> growthTables,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  factory CompanyModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CompanyModel.fromJson({...data, 'symbol': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('symbol');
    return json;
  }

  // Essential computed properties only
  bool get isGainer => changePercent > 0;
  bool get isLoser => changePercent < 0;

  String get formattedPrice {
    return currentPrice != null
        ? '₹${currentPrice!.toStringAsFixed(2)}'
        : 'N/A';
  }

  String get formattedChange {
    if (changePercent == 0.0) return '0.00%';
    final sign = changePercent > 0 ? '+' : '';
    return '$sign${changePercent.toStringAsFixed(2)}%';
  }

  String get formattedLastUpdated {
    try {
      final date = DateTime.parse(lastUpdated);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else {
        return '${difference.inMinutes}m ago';
      }
    } catch (e) {
      return 'Unknown';
    }
  }
}

@freezed
class ShareholdingPattern with _$ShareholdingPattern {
  const factory ShareholdingPattern({
    @Default({}) Map<String, Map<String, String>> quarterly,
  }) = _ShareholdingPattern;

  factory ShareholdingPattern.fromJson(Map<String, dynamic> json) =>
      _$ShareholdingPatternFromJson(json);
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
