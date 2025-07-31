import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_settings.freezed.dart';
part 'filter_settings.g.dart';

@freezed
class FilterSettings with _$FilterSettings {
  const factory FilterSettings({
    @Default(RangeFilter()) RangeFilter marketCap,
    @Default(RangeFilter()) RangeFilter pe,
    @Default(RangeFilter()) RangeFilter priceRange,
    @Default(RangeFilter()) RangeFilter dividend,
    @Default(RangeFilter()) RangeFilter roce,
    @Default(RangeFilter()) RangeFilter roe,
    @Default([]) List<String> sectors,
    @Default('market_cap') String sortBy,
    @Default(true) bool sortDescending,
    @Default(10) int pageSize,
  }) = _FilterSettings;

  factory FilterSettings.fromJson(Map<String, dynamic> json) =>
      _$FilterSettingsFromJson(json);
}

extension FilterSettingsX on FilterSettings {
  bool hasActiveFilters() {
    return marketCap.isActive ||
        pe.isActive ||
        priceRange.isActive ||
        dividend.isActive ||
        roce.isActive ||
        roe.isActive ||
        sectors.isNotEmpty;
  }

  FilterSettings getDefaultFilter() {
    return const FilterSettings(
      marketCap: RangeFilter(min: 1000, max: 500000, isActive: true),
      pe: RangeFilter(min: 5, max: 50, isActive: true),
      pageSize: 10,
      sortBy: 'market_cap',
      sortDescending: true,
    );
  }
}

@freezed
class RangeFilter with _$RangeFilter {
  const factory RangeFilter({
    @Default(null) double? min,
    @Default(null) double? max,
    @Default(false) bool isActive,
  }) = _RangeFilter;

  factory RangeFilter.fromJson(Map<String, dynamic> json) =>
      _$RangeFilterFromJson(json);
}

extension RangeFilterX on RangeFilter {
  bool get isActive => min != null || max != null;
}
