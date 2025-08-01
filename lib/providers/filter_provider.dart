import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/filter_settings.dart';

class FilterSettingsNotifier extends StateNotifier<FilterSettings> {
  FilterSettingsNotifier() : super(const FilterSettings()) {
    _loadSettings();
  }

  static const String _storageKey = 'trading_dashboard_filters';

  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);

      if (jsonString != null) {
        final json = jsonDecode(jsonString);
        state = FilterSettings.fromJson(json);
      } else {
        // Set default filters for first time users
        state = state.getDefaultFilter();
        await _saveSettings();
      }
    } catch (e) {
      print('Error loading filter settings: $e');
      // Fallback to default
      state = state.getDefaultFilter();
    }
  }

  Future<void> _saveSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(state.toJson());
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      print('Error saving filter settings: $e');
    }
  }

  void updateMarketCapFilter(double? min, double? max) {
    state = state.copyWith(
      marketCap:
          RangeFilter(min: min, max: max, isActive: min != null || max != null),
    );
    _saveSettings();
  }

  void updatePeFilter(double? min, double? max) {
    state = state.copyWith(
      pe: RangeFilter(min: min, max: max, isActive: min != null || max != null),
    );
    _saveSettings();
  }

  void updatePriceFilter(double? min, double? max) {
    state = state.copyWith(
      priceRange:
          RangeFilter(min: min, max: max, isActive: min != null || max != null),
    );
    _saveSettings();
  }

  void updateSectors(List<String> sectors) {
    state = state.copyWith(sectors: sectors);
    _saveSettings();
  }

  void updateSorting(String sortBy, bool descending) {
    state = state.copyWith(
      sortBy: sortBy,
      sortDescending: descending,
    );
    _saveSettings();
  }

  void updatePageSize(int size) {
    state = state.copyWith(pageSize: size);
    _saveSettings();
  }

  void resetFilters() {
    state = const FilterSettings();
    _saveSettings();
  }

  void applyDefaultFilters() {
    state = state.getDefaultFilter();
    _saveSettings();
  }
}

final filterSettingsProvider =
    StateNotifierProvider<FilterSettingsNotifier, FilterSettings>(
  (ref) => FilterSettingsNotifier(),
);
