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
    );

Map<String, dynamic> _$$FinancialDataModelImplToJson(
        _$FinancialDataModelImpl instance) =>
    <String, dynamic>{
      'headers': instance.headers,
      'body': instance.body,
    };

_$FinancialDataRowImpl _$$FinancialDataRowImplFromJson(
        Map<String, dynamic> json) =>
    _$FinancialDataRowImpl(
      description: json['description'] as String,
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$FinancialDataRowImplToJson(
        _$FinancialDataRowImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'values': instance.values,
    };
