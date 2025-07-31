// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FilterSettingsImpl _$$FilterSettingsImplFromJson(Map<String, dynamic> json) =>
    _$FilterSettingsImpl(
      marketCap: json['marketCap'] == null
          ? const RangeFilter()
          : RangeFilter.fromJson(json['marketCap'] as Map<String, dynamic>),
      pe: json['pe'] == null
          ? const RangeFilter()
          : RangeFilter.fromJson(json['pe'] as Map<String, dynamic>),
      priceRange: json['priceRange'] == null
          ? const RangeFilter()
          : RangeFilter.fromJson(json['priceRange'] as Map<String, dynamic>),
      dividend: json['dividend'] == null
          ? const RangeFilter()
          : RangeFilter.fromJson(json['dividend'] as Map<String, dynamic>),
      roce: json['roce'] == null
          ? const RangeFilter()
          : RangeFilter.fromJson(json['roce'] as Map<String, dynamic>),
      roe: json['roe'] == null
          ? const RangeFilter()
          : RangeFilter.fromJson(json['roe'] as Map<String, dynamic>),
      sectors: (json['sectors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sortBy: json['sortBy'] as String? ?? 'market_cap',
      sortDescending: json['sortDescending'] as bool? ?? true,
      pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
    );

Map<String, dynamic> _$$FilterSettingsImplToJson(
        _$FilterSettingsImpl instance) =>
    <String, dynamic>{
      'marketCap': instance.marketCap,
      'pe': instance.pe,
      'priceRange': instance.priceRange,
      'dividend': instance.dividend,
      'roce': instance.roce,
      'roe': instance.roe,
      'sectors': instance.sectors,
      'sortBy': instance.sortBy,
      'sortDescending': instance.sortDescending,
      'pageSize': instance.pageSize,
    };

_$RangeFilterImpl _$$RangeFilterImplFromJson(Map<String, dynamic> json) =>
    _$RangeFilterImpl(
      min: (json['min'] as num?)?.toDouble() ?? null,
      max: (json['max'] as num?)?.toDouble() ?? null,
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$RangeFilterImplToJson(_$RangeFilterImpl instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'isActive': instance.isActive,
    };
