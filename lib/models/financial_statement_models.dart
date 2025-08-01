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
    @Default({}) Map<String, Map<String, String>> growthTables,
    @Default({}) Map<String, dynamic> ratiosData,
  }) = _CompanyFinancials;

  // Let Freezed generate this automatically
  factory CompanyFinancials.fromJson(Map<String, dynamic> json) =>
      _$CompanyFinancialsFromJson(json);
}

@freezed
class ShareholdingPattern with _$ShareholdingPattern {
  const factory ShareholdingPattern({
    @Default({}) Map<String, Map<String, String>> quarterly,
  }) = _ShareholdingPattern;

  // Let Freezed generate this automatically
  factory ShareholdingPattern.fromJson(Map<String, dynamic> json) =>
      _$ShareholdingPatternFromJson(json);
}

// Move all custom logic to extensions
extension CompanyFinancialsX on CompanyFinancials {
  // Custom JSON parsing for your cloud function's complex data structure
  static CompanyFinancials fromCloudFunctionJson(Map<String, dynamic> json) {
    return CompanyFinancials(
      quarterlyResults: json['quarterlyResults'] != null
          ? FinancialDataModelX.fromCloudFunctionJson(json['quarterlyResults'])
          : null,
      profitLossStatement: json['profitLossStatement'] != null
          ? FinancialDataModelX.fromCloudFunctionJson(
              json['profitLossStatement'])
          : null,
      balanceSheet: json['balanceSheet'] != null
          ? FinancialDataModelX.fromCloudFunctionJson(json['balanceSheet'])
          : null,
      cashFlowStatement: json['cashFlowStatement'] != null
          ? FinancialDataModelX.fromCloudFunctionJson(json['cashFlowStatement'])
          : null,
      ratios: json['ratios'] != null
          ? FinancialDataModelX.fromCloudFunctionJson(json['ratios'])
          : null,
      shareholdingPattern: json['shareholdingPattern'] != null
          ? ShareholdingPatternX.fromCloudFunctionJson(
              json['shareholdingPattern'])
          : null,
      growthTables: json['growthTables'] != null
          ? Map<String, Map<String, String>>.from(
              json['growthTables'].map((key, value) => MapEntry(
                    key.toString(),
                    Map<String, String>.from(value ?? {}),
                  )))
          : {},
      ratiosData: Map<String, dynamic>.from(json['ratiosData'] ?? {}),
    );
  }

  // Helper methods for checking data availability
  bool get hasQuarterlyResults => quarterlyResults?.isNotEmpty == true;
  bool get hasProfitLoss => profitLossStatement?.isNotEmpty == true;
  bool get hasBalanceSheet => balanceSheet?.isNotEmpty == true;
  bool get hasCashFlow => cashFlowStatement?.isNotEmpty == true;
  bool get hasRatios => ratios?.isNotEmpty == true;
  bool get hasShareholdingPattern =>
      shareholdingPattern?.quarterly.isNotEmpty == true;
  bool get hasGrowthTables => growthTables.isNotEmpty;

  // Get available financial statements
  List<FinancialStatementType> get availableStatements {
    List<FinancialStatementType> available = [];

    if (hasQuarterlyResults)
      available.add(FinancialStatementType.quarterlyResults);
    if (hasProfitLoss) available.add(FinancialStatementType.profitLoss);
    if (hasBalanceSheet) available.add(FinancialStatementType.balanceSheet);
    if (hasCashFlow) available.add(FinancialStatementType.cashFlow);
    if (hasRatios) available.add(FinancialStatementType.ratios);
    if (hasShareholdingPattern)
      available.add(FinancialStatementType.shareholding);

    return available;
  }

  // Get financial data by type
  FinancialDataModel? getFinancialData(FinancialStatementType type) {
    switch (type) {
      case FinancialStatementType.quarterlyResults:
        return quarterlyResults;
      case FinancialStatementType.profitLoss:
        return profitLossStatement;
      case FinancialStatementType.balanceSheet:
        return balanceSheet;
      case FinancialStatementType.cashFlow:
        return cashFlowStatement;
      case FinancialStatementType.ratios:
        return ratios;
      case FinancialStatementType.shareholding:
        return null; // Shareholding pattern is separate
    }
  }

  // Check if company has complete financial data
  bool get isCompleteFinancialData {
    return hasQuarterlyResults &&
        hasProfitLoss &&
        hasBalanceSheet &&
        hasCashFlow;
  }

  // Get data completeness percentage
  double get dataCompletenessPercentage {
    int totalPossible = 6; // Including shareholding pattern
    int available = availableStatements.length;
    return (available / totalPossible) * 100;
  }
}

extension ShareholdingPatternX on ShareholdingPattern {
  // Custom JSON parsing for your cloud function's data structure
  static ShareholdingPattern fromCloudFunctionJson(Map<String, dynamic> json) {
    if (json['quarterly'] != null) {
      return ShareholdingPattern(
        quarterly: Map<String, Map<String, String>>.from(
          json['quarterly'].map((key, value) => MapEntry(
                key.toString(),
                Map<String, String>.from(value ?? {}),
              )),
        ),
      );
    }
    return const ShareholdingPattern();
  }

  // Helper methods for shareholding analysis
  List<String> get availableQuarters {
    return quarterly.keys.toList()..sort();
  }

  Map<String, String>? getQuarterData(String quarter) {
    return quarterly[quarter];
  }

  // Get latest quarter data
  Map<String, String>? get latestQuarterData {
    if (quarterly.isEmpty) return null;
    final sortedQuarters = availableQuarters;
    return quarterly[sortedQuarters.last];
  }

  // Get promoter holding for a specific quarter
  double? getPromoterHolding(String quarter) {
    final quarterData = quarterly[quarter];
    if (quarterData == null) return null;

    // Try different possible keys for promoter holding
    final promoterKeys = ['Promoters', 'Promoter', 'Promoter & Promoter Group'];
    for (final key in promoterKeys) {
      final value = quarterData[key];
      if (value != null) {
        return double.tryParse(value.replaceAll('%', '').trim());
      }
    }
    return null;
  }

  // Get public holding for a specific quarter
  double? getPublicHolding(String quarter) {
    final quarterData = quarterly[quarter];
    if (quarterData == null) return null;

    final publicKeys = ['Public', 'Public Shareholders', 'Others'];
    for (final key in publicKeys) {
      final value = quarterData[key];
      if (value != null) {
        return double.tryParse(value.replaceAll('%', '').trim());
      }
    }
    return null;
  }

  // Get latest promoter holding
  double? get latestPromoterHolding {
    if (availableQuarters.isEmpty) return null;
    return getPromoterHolding(availableQuarters.last);
  }

  // Get latest public holding
  double? get latestPublicHolding {
    if (availableQuarters.isEmpty) return null;
    return getPublicHolding(availableQuarters.last);
  }

  // Check if shareholding pattern shows consistent promoter holding
  bool get hasStablePromoterHolding {
    if (availableQuarters.length < 2) return false;

    final holdings = availableQuarters
        .map((quarter) => getPromoterHolding(quarter))
        .where((holding) => holding != null)
        .cast<double>()
        .toList();

    if (holdings.length < 2) return false;

    // Check if variation is less than 5%
    final maxVariation = holdings.reduce((a, b) => a > b ? a : b) -
        holdings.reduce((a, b) => a < b ? a : b);

    return maxVariation < 5.0;
  }
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

  Color get color {
    switch (this) {
      case FinancialStatementType.quarterlyResults:
        return Colors.blue[600]!;
      case FinancialStatementType.profitLoss:
        return Colors.green[600]!;
      case FinancialStatementType.balanceSheet:
        return Colors.orange[600]!;
      case FinancialStatementType.cashFlow:
        return Colors.cyan[600]!;
      case FinancialStatementType.ratios:
        return Colors.purple[600]!;
      case FinancialStatementType.shareholding:
        return Colors.indigo[600]!;
    }
  }

  String get description {
    switch (this) {
      case FinancialStatementType.quarterlyResults:
        return 'Quarterly financial performance summary';
      case FinancialStatementType.profitLoss:
        return 'Revenue, expenses, and profit analysis';
      case FinancialStatementType.balanceSheet:
        return 'Assets, liabilities, and equity overview';
      case FinancialStatementType.cashFlow:
        return 'Cash inflows and outflows tracking';
      case FinancialStatementType.ratios:
        return 'Key financial performance ratios';
      case FinancialStatementType.shareholding:
        return 'Ownership structure and shareholding breakdown';
    }
  }
}
