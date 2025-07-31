import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'financial_data_model.dart';

part 'financial_statement_models.freezed.dart';
part 'financial_statement_models.g.dart';

@freezed
class CompanyFinancials with _$CompanyFinancials {
  const factory CompanyFinancials({
    FinancialDataModel? quarterlyResults,
    FinancialDataModel? profitLossStatement,
    FinancialDataModel? balanceSheet,
    FinancialDataModel? cashFlowStatement,
    FinancialDataModel? ratios,
    ShareholdingPattern? shareholdingPattern,
    @Default({}) Map<String, dynamic> growthTables,
  }) = _CompanyFinancials;

  factory CompanyFinancials.fromJson(Map<String, dynamic> json) =>
      _$CompanyFinancialsFromJson(json);
}

@freezed
class ShareholdingPattern with _$ShareholdingPattern {
  const factory ShareholdingPattern({
    @Default({}) Map<String, Map<String, String>> quarterly,
  }) = _ShareholdingPattern;

  factory ShareholdingPattern.fromJson(Map<String, dynamic> json) =>
      _$ShareholdingPatternFromJson(json);
}

// Enum for different financial statement types
enum FinancialStatementType {
  quarterlyResults,
  profitLoss,
  balanceSheet,
  cashFlow,
  ratios,
  shareholding,
}

extension FinancialStatementTypeX on FinancialStatementType {
  String get displayName {
    switch (this) {
      case FinancialStatementType.quarterlyResults:
        return 'Quarterly Results';
      case FinancialStatementType.profitLoss:
        return 'Profit & Loss';
      case FinancialStatementType.balanceSheet:
        return 'Balance Sheet';
      case FinancialStatementType.cashFlow:
        return 'Cash Flow';
      case FinancialStatementType.ratios:
        return 'Financial Ratios';
      case FinancialStatementType.shareholding:
        return 'Shareholding Pattern';
    }
  }

  IconData get icon {
    switch (this) {
      case FinancialStatementType.quarterlyResults:
        return Icons.calendar_today;
      case FinancialStatementType.profitLoss:
        return Icons.trending_up;
      case FinancialStatementType.balanceSheet:
        return Icons.account_balance;
      case FinancialStatementType.cashFlow:
        return Icons.water_drop;
      case FinancialStatementType.ratios:
        return Icons.analytics;
      case FinancialStatementType.shareholding:
        return Icons.pie_chart;
    }
  }
}
