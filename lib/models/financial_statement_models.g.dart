// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_statement_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyFinancialsImpl _$$CompanyFinancialsImplFromJson(
        Map<String, dynamic> json) =>
    _$CompanyFinancialsImpl(
      quarterlyResults: json['quarterlyResults'] == null
          ? null
          : FinancialDataModel.fromJson(
              json['quarterlyResults'] as Map<String, dynamic>),
      profitLossStatement: json['profitLossStatement'] == null
          ? null
          : FinancialDataModel.fromJson(
              json['profitLossStatement'] as Map<String, dynamic>),
      balanceSheet: json['balanceSheet'] == null
          ? null
          : FinancialDataModel.fromJson(
              json['balanceSheet'] as Map<String, dynamic>),
      cashFlowStatement: json['cashFlowStatement'] == null
          ? null
          : FinancialDataModel.fromJson(
              json['cashFlowStatement'] as Map<String, dynamic>),
      ratios: json['ratios'] == null
          ? null
          : FinancialDataModel.fromJson(json['ratios'] as Map<String, dynamic>),
      shareholdingPattern: json['shareholdingPattern'] == null
          ? null
          : ShareholdingPattern.fromJson(
              json['shareholdingPattern'] as Map<String, dynamic>),
      growthTables: (json['growthTables'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
          ) ??
          const {},
      ratiosData: json['ratiosData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$CompanyFinancialsImplToJson(
        _$CompanyFinancialsImpl instance) =>
    <String, dynamic>{
      'quarterlyResults': instance.quarterlyResults,
      'profitLossStatement': instance.profitLossStatement,
      'balanceSheet': instance.balanceSheet,
      'cashFlowStatement': instance.cashFlowStatement,
      'ratios': instance.ratios,
      'shareholdingPattern': instance.shareholdingPattern,
      'growthTables': instance.growthTables,
      'ratiosData': instance.ratiosData,
    };

_$ShareholdingPatternImpl _$$ShareholdingPatternImplFromJson(
        Map<String, dynamic> json) =>
    _$ShareholdingPatternImpl(
      quarterly: (json['quarterly'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$ShareholdingPatternImplToJson(
        _$ShareholdingPatternImpl instance) =>
    <String, dynamic>{
      'quarterly': instance.quarterly,
    };
