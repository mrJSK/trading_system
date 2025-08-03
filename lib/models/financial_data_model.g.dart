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
      tableTitle: json['tableTitle'] as String?,
      dataSource: json['dataSource'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      tableType: json['tableType'] as String? ?? '',
      lastUpdated: json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
      isProcessed: json['isProcessed'] as bool? ?? false,
    );

Map<String, dynamic> _$$FinancialDataModelImplToJson(
        _$FinancialDataModelImpl instance) =>
    <String, dynamic>{
      'headers': instance.headers,
      'body': instance.body,
      'tableTitle': instance.tableTitle,
      'dataSource': instance.dataSource,
      'metadata': instance.metadata,
      'tableType': instance.tableType,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'isProcessed': instance.isProcessed,
    };

_$FinancialDataRowImpl _$$FinancialDataRowImplFromJson(
        Map<String, dynamic> json) =>
    _$FinancialDataRowImpl(
      description: json['description'] as String,
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      additionalData: (json['additionalData'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      calculatedMetrics:
          (json['calculatedMetrics'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      category: json['category'] as String?,
      isKeyMetric: json['isKeyMetric'] as bool? ?? false,
    );

Map<String, dynamic> _$$FinancialDataRowImplToJson(
        _$FinancialDataRowImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'values': instance.values,
      'additionalData': instance.additionalData,
      'calculatedMetrics': instance.calculatedMetrics,
      'category': instance.category,
      'isKeyMetric': instance.isKeyMetric,
    };
