// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FinancialDataModelImpl _$$FinancialDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FinancialDataModelImpl(
      headers: (json['headers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      body: (json['body'] as List<dynamic>?)
              ?.map((e) => FinancialDataRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      dataType: json['dataType'] as String? ?? '',
      sourceUrl: json['sourceUrl'] as String? ?? '',
      lastUpdated: json['lastUpdated'] as String? ?? '',
    );

Map<String, dynamic> _$$FinancialDataModelImplToJson(
        _$FinancialDataModelImpl instance) =>
    <String, dynamic>{
      'headers': instance.headers,
      'body': instance.body,
      'dataType': instance.dataType,
      'sourceUrl': instance.sourceUrl,
      'lastUpdated': instance.lastUpdated,
    };

_$FinancialDataRowImpl _$$FinancialDataRowImplFromJson(
        Map<String, dynamic> json) =>
    _$FinancialDataRowImpl(
      description: json['description'] as String? ?? '',
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList() ??
          const [],
      category: json['category'] as String? ?? '',
      isCalculated: json['isCalculated'] as bool? ?? false,
    );

Map<String, dynamic> _$$FinancialDataRowImplToJson(
        _$FinancialDataRowImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'values': instance.values,
      'category': instance.category,
      'isCalculated': instance.isCalculated,
    };

_$QuarterlyDataImpl _$$QuarterlyDataImplFromJson(Map<String, dynamic> json) =>
    _$QuarterlyDataImpl(
      quarter: json['quarter'] as String? ?? '',
      year: json['year'] as String? ?? '',
      period: json['period'] as String? ?? '',
      sales: (json['sales'] as num?)?.toDouble(),
      netProfit: (json['netProfit'] as num?)?.toDouble(),
      eps: (json['eps'] as num?)?.toDouble(),
      ebitda: (json['ebitda'] as num?)?.toDouble(),
      operatingProfit: (json['operatingProfit'] as num?)?.toDouble(),
      operatingMargin: (json['operatingMargin'] as num?)?.toDouble(),
      netMargin: (json['netMargin'] as num?)?.toDouble(),
      additionalMetrics:
          json['additionalMetrics'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$QuarterlyDataImplToJson(_$QuarterlyDataImpl instance) =>
    <String, dynamic>{
      'quarter': instance.quarter,
      'year': instance.year,
      'period': instance.period,
      'sales': instance.sales,
      'netProfit': instance.netProfit,
      'eps': instance.eps,
      'ebitda': instance.ebitda,
      'operatingProfit': instance.operatingProfit,
      'operatingMargin': instance.operatingMargin,
      'netMargin': instance.netMargin,
      'additionalMetrics': instance.additionalMetrics,
    };

_$AnnualDataImpl _$$AnnualDataImplFromJson(Map<String, dynamic> json) =>
    _$AnnualDataImpl(
      year: json['year'] as String? ?? '',
      sales: (json['sales'] as num?)?.toDouble(),
      netProfit: (json['netProfit'] as num?)?.toDouble(),
      eps: (json['eps'] as num?)?.toDouble(),
      bookValue: (json['bookValue'] as num?)?.toDouble(),
      dividendYield: (json['dividendYield'] as num?)?.toDouble(),
      roe: (json['roe'] as num?)?.toDouble(),
      roce: (json['roce'] as num?)?.toDouble(),
      peRatio: (json['peRatio'] as num?)?.toDouble(),
      pbRatio: (json['pbRatio'] as num?)?.toDouble(),
      debtToEquity: (json['debtToEquity'] as num?)?.toDouble(),
      currentRatio: (json['currentRatio'] as num?)?.toDouble(),
      interestCoverage: (json['interestCoverage'] as num?)?.toDouble(),
      totalAssets: (json['totalAssets'] as num?)?.toDouble(),
      shareholdersEquity: (json['shareholdersEquity'] as num?)?.toDouble(),
      totalDebt: (json['totalDebt'] as num?)?.toDouble(),
      workingCapital: (json['workingCapital'] as num?)?.toDouble(),
      operatingCashFlow: (json['operatingCashFlow'] as num?)?.toDouble(),
      investingCashFlow: (json['investingCashFlow'] as num?)?.toDouble(),
      financingCashFlow: (json['financingCashFlow'] as num?)?.toDouble(),
      freeCashFlow: (json['freeCashFlow'] as num?)?.toDouble(),
      ebitda: (json['ebitda'] as num?)?.toDouble(),
      operatingProfit: (json['operatingProfit'] as num?)?.toDouble(),
      additionalMetrics:
          json['additionalMetrics'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$AnnualDataImplToJson(_$AnnualDataImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'sales': instance.sales,
      'netProfit': instance.netProfit,
      'eps': instance.eps,
      'bookValue': instance.bookValue,
      'dividendYield': instance.dividendYield,
      'roe': instance.roe,
      'roce': instance.roce,
      'peRatio': instance.peRatio,
      'pbRatio': instance.pbRatio,
      'debtToEquity': instance.debtToEquity,
      'currentRatio': instance.currentRatio,
      'interestCoverage': instance.interestCoverage,
      'totalAssets': instance.totalAssets,
      'shareholdersEquity': instance.shareholdersEquity,
      'totalDebt': instance.totalDebt,
      'workingCapital': instance.workingCapital,
      'operatingCashFlow': instance.operatingCashFlow,
      'investingCashFlow': instance.investingCashFlow,
      'financingCashFlow': instance.financingCashFlow,
      'freeCashFlow': instance.freeCashFlow,
      'ebitda': instance.ebitda,
      'operatingProfit': instance.operatingProfit,
      'additionalMetrics': instance.additionalMetrics,
    };

_$ShareholdingPatternImpl _$$ShareholdingPatternImplFromJson(
        Map<String, dynamic> json) =>
    _$ShareholdingPatternImpl(
      promoterHolding: (json['promoterHolding'] as num?)?.toDouble(),
      publicHolding: (json['publicHolding'] as num?)?.toDouble(),
      institutionalHolding: (json['institutionalHolding'] as num?)?.toDouble(),
      foreignInstitutional: (json['foreignInstitutional'] as num?)?.toDouble(),
      majorShareholders: (json['majorShareholders'] as List<dynamic>?)
              ?.map((e) => MajorShareholder.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      quarterly: (json['quarterly'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
          ) ??
          const {},
      lastUpdated: json['lastUpdated'] as String? ?? '',
    );

Map<String, dynamic> _$$ShareholdingPatternImplToJson(
        _$ShareholdingPatternImpl instance) =>
    <String, dynamic>{
      'promoterHolding': instance.promoterHolding,
      'publicHolding': instance.publicHolding,
      'institutionalHolding': instance.institutionalHolding,
      'foreignInstitutional': instance.foreignInstitutional,
      'majorShareholders': instance.majorShareholders,
      'quarterly': instance.quarterly,
      'lastUpdated': instance.lastUpdated,
    };

_$MajorShareholderImpl _$$MajorShareholderImplFromJson(
        Map<String, dynamic> json) =>
    _$MajorShareholderImpl(
      name: json['name'] as String? ?? '',
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? '',
    );

Map<String, dynamic> _$$MajorShareholderImplToJson(
        _$MajorShareholderImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'percentage': instance.percentage,
      'category': instance.category,
    };

_$KeyMilestoneImpl _$$KeyMilestoneImplFromJson(Map<String, dynamic> json) =>
    _$KeyMilestoneImpl(
      year: json['year'] as String? ?? '',
      description: json['description'] as String? ?? '',
      category: json['category'] as String? ?? '',
      impact: json['impact'] as String? ?? '',
    );

Map<String, dynamic> _$$KeyMilestoneImplToJson(_$KeyMilestoneImpl instance) =>
    <String, dynamic>{
      'year': instance.year,
      'description': instance.description,
      'category': instance.category,
      'impact': instance.impact,
    };

_$InvestmentHighlightImpl _$$InvestmentHighlightImplFromJson(
        Map<String, dynamic> json) =>
    _$InvestmentHighlightImpl(
      type: json['type'] as String? ?? '',
      description: json['description'] as String? ?? '',
      impact: json['impact'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );

Map<String, dynamic> _$$InvestmentHighlightImplToJson(
        _$InvestmentHighlightImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'description': instance.description,
      'impact': instance.impact,
      'category': instance.category,
    };
