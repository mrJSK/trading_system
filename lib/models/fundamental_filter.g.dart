// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fundamental_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FundamentalFilterImpl _$$FundamentalFilterImplFromJson(
        Map<String, dynamic> json) =>
    _$FundamentalFilterImpl(
      type: $enumDecode(_$FundamentalTypeEnumMap, json['type']),
      name: json['name'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$FilterCategoryEnumMap, json['category']),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      icon: json['icon'] as String? ?? '',
      isPremium: json['isPremium'] as bool? ?? false,
      minimumQualityScore: (json['minimumQualityScore'] as num?)?.toInt() ?? 0,
      criteria: json['criteria'] as Map<String, dynamic>? ?? const {},
      difficulty: (json['difficulty'] as num?)?.toInt() ?? 0,
      explanation: json['explanation'] as String? ?? '',
      relatedFilters: (json['relatedFilters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      successRate: (json['successRate'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$FundamentalFilterImplToJson(
        _$FundamentalFilterImpl instance) =>
    <String, dynamic>{
      'type': _$FundamentalTypeEnumMap[instance.type]!,
      'name': instance.name,
      'description': instance.description,
      'category': _$FilterCategoryEnumMap[instance.category]!,
      'tags': instance.tags,
      'icon': instance.icon,
      'isPremium': instance.isPremium,
      'minimumQualityScore': instance.minimumQualityScore,
      'criteria': instance.criteria,
      'difficulty': instance.difficulty,
      'explanation': instance.explanation,
      'relatedFilters': instance.relatedFilters,
      'successRate': instance.successRate,
    };

const _$FundamentalTypeEnumMap = {
  FundamentalType.debtFree: 'debtFree',
  FundamentalType.qualityStocks: 'qualityStocks',
  FundamentalType.strongBalance: 'strongBalance',
  FundamentalType.piotroskiHigh: 'piotroskiHigh',
  FundamentalType.altmanSafe: 'altmanSafe',
  FundamentalType.compoundingMachines: 'compoundingMachines',
  FundamentalType.highROE: 'highROE',
  FundamentalType.profitableStocks: 'profitableStocks',
  FundamentalType.consistentProfits: 'consistentProfits',
  FundamentalType.highROIC: 'highROIC',
  FundamentalType.freeCashFlowRich: 'freeCashFlowRich',
  FundamentalType.growthStocks: 'growthStocks',
  FundamentalType.highSalesGrowth: 'highSalesGrowth',
  FundamentalType.momentumStocks: 'momentumStocks',
  FundamentalType.lowPE: 'lowPE',
  FundamentalType.valueStocks: 'valueStocks',
  FundamentalType.undervalued: 'undervalued',
  FundamentalType.grahamValue: 'grahamValue',
  FundamentalType.dividendStocks: 'dividendStocks',
  FundamentalType.highDividendYield: 'highDividendYield',
  FundamentalType.largeCap: 'largeCap',
  FundamentalType.midCap: 'midCap',
  FundamentalType.smallCap: 'smallCap',
  FundamentalType.workingCapitalEfficient: 'workingCapitalEfficient',
  FundamentalType.cashEfficientStocks: 'cashEfficientStocks',
  FundamentalType.businessInsightRich: 'businessInsightRich',
  FundamentalType.recentMilestones: 'recentMilestones',
  FundamentalType.lowVolatility: 'lowVolatility',
  FundamentalType.contrarian: 'contrarian',
};

const _$FilterCategoryEnumMap = {
  FilterCategory.quality: 'quality',
  FilterCategory.profitability: 'profitability',
  FilterCategory.growth: 'growth',
  FilterCategory.value: 'value',
  FilterCategory.income: 'income',
  FilterCategory.marketCap: 'marketCap',
  FilterCategory.efficiency: 'efficiency',
  FilterCategory.insights: 'insights',
  FilterCategory.risk: 'risk',
  FilterCategory.opportunity: 'opportunity',
};
