// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      about: json['about'] as String?,
      website: json['website'] as String?,
      bseCode: json['bseCode'] as String?,
      nseCode: json['nseCode'] as String?,
      marketCap: (json['marketCap'] as num?)?.toDouble(),
      currentPrice: (json['currentPrice'] as num?)?.toDouble(),
      highLow: json['highLow'] as String?,
      stockPe: (json['stockPe'] as num?)?.toDouble(),
      bookValue: (json['bookValue'] as num?)?.toDouble(),
      dividendYield: (json['dividendYield'] as num?)?.toDouble(),
      roce: (json['roce'] as num?)?.toDouble(),
      roe: (json['roe'] as num?)?.toDouble(),
      faceValue: (json['faceValue'] as num?)?.toDouble(),
      pros:
          (json['pros'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      cons:
          (json['cons'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      lastUpdated: json['lastUpdated'] as String,
      changePercent: (json['changePercent'] as num?)?.toDouble() ?? 0.0,
      changeAmount: (json['changeAmount'] as num?)?.toDouble() ?? 0.0,
      previousClose: (json['previousClose'] as num?)?.toDouble() ?? 0.0,
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
      industryClassification: (json['industryClassification'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      shareholdingPattern: json['shareholdingPattern'] == null
          ? null
          : ShareholdingPattern.fromJson(
              json['shareholdingPattern'] as Map<String, dynamic>),
      ratiosData: json['ratiosData'] as Map<String, dynamic>? ?? const {},
      growthTables: (json['growthTables'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
          ) ??
          const {},
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'displayName': instance.displayName,
      'about': instance.about,
      'website': instance.website,
      'bseCode': instance.bseCode,
      'nseCode': instance.nseCode,
      'marketCap': instance.marketCap,
      'currentPrice': instance.currentPrice,
      'highLow': instance.highLow,
      'stockPe': instance.stockPe,
      'bookValue': instance.bookValue,
      'dividendYield': instance.dividendYield,
      'roce': instance.roce,
      'roe': instance.roe,
      'faceValue': instance.faceValue,
      'pros': instance.pros,
      'cons': instance.cons,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'lastUpdated': instance.lastUpdated,
      'changePercent': instance.changePercent,
      'changeAmount': instance.changeAmount,
      'previousClose': instance.previousClose,
      'quarterlyResults': instance.quarterlyResults,
      'profitLossStatement': instance.profitLossStatement,
      'balanceSheet': instance.balanceSheet,
      'cashFlowStatement': instance.cashFlowStatement,
      'ratios': instance.ratios,
      'industryClassification': instance.industryClassification,
      'shareholdingPattern': instance.shareholdingPattern,
      'ratiosData': instance.ratiosData,
      'growthTables': instance.growthTables,
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
