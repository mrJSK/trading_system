import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_functions/cloud_functions.dart';

// Scraping preferences provider
final scrapingPreferencesProvider =
    StateNotifierProvider<ScrapingPreferencesNotifier, ScrapingPreferences>(
        (ref) {
  return ScrapingPreferencesNotifier();
});

class ScrapingPreferences {
  final bool isAutoScrapingEnabled;
  final TimeOfDay scheduledTime;
  final bool isDailyEnabled;
  final List<int> selectedDays; // 1-7 for Mon-Sun
  final DateTime? lastManualTrigger;
  final DateTime? lastAutoTrigger;

  const ScrapingPreferences({
    this.isAutoScrapingEnabled = true,
    this.scheduledTime = const TimeOfDay(hour: 9, minute: 30),
    this.isDailyEnabled = true,
    this.selectedDays = const [1, 2, 3, 4, 5], // Weekdays only
    this.lastManualTrigger,
    this.lastAutoTrigger,
  });

  ScrapingPreferences copyWith({
    bool? isAutoScrapingEnabled,
    TimeOfDay? scheduledTime,
    bool? isDailyEnabled,
    List<int>? selectedDays,
    DateTime? lastManualTrigger,
    DateTime? lastAutoTrigger,
  }) {
    return ScrapingPreferences(
      isAutoScrapingEnabled:
          isAutoScrapingEnabled ?? this.isAutoScrapingEnabled,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      isDailyEnabled: isDailyEnabled ?? this.isDailyEnabled,
      selectedDays: selectedDays ?? this.selectedDays,
      lastManualTrigger: lastManualTrigger ?? this.lastManualTrigger,
      lastAutoTrigger: lastAutoTrigger ?? this.lastAutoTrigger,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isAutoScrapingEnabled': isAutoScrapingEnabled,
      'scheduledTimeHour': scheduledTime.hour,
      'scheduledTimeMinute': scheduledTime.minute,
      'isDailyEnabled': isDailyEnabled,
      'selectedDays': selectedDays,
      'lastManualTrigger': lastManualTrigger?.toIso8601String(),
      'lastAutoTrigger': lastAutoTrigger?.toIso8601String(),
    };
  }

  factory ScrapingPreferences.fromJson(Map<String, dynamic> json) {
    return ScrapingPreferences(
      isAutoScrapingEnabled: json['isAutoScrapingEnabled'] ?? true,
      scheduledTime: TimeOfDay(
        hour: json['scheduledTimeHour'] ?? 9,
        minute: json['scheduledTimeMinute'] ?? 30,
      ),
      isDailyEnabled: json['isDailyEnabled'] ?? true,
      selectedDays: List<int>.from(json['selectedDays'] ?? [1, 2, 3, 4, 5]),
      lastManualTrigger: json['lastManualTrigger'] != null
          ? DateTime.parse(json['lastManualTrigger'])
          : null,
      lastAutoTrigger: json['lastAutoTrigger'] != null
          ? DateTime.parse(json['lastAutoTrigger'])
          : null,
    );
  }
}

class ScrapingPreferencesNotifier extends StateNotifier<ScrapingPreferences> {
  ScrapingPreferencesNotifier() : super(const ScrapingPreferences()) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('scraping_preferences');
      if (jsonString != null) {
        final json = Map<String, dynamic>.from(jsonDecode(jsonString));
        state = ScrapingPreferences.fromJson(json);
      }
    } catch (e) {
      print('Error loading scraping preferences: $e');
    }
  }

  Future<void> _savePreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('scraping_preferences', jsonEncode(state.toJson()));
    } catch (e) {
      print('Error saving scraping preferences: $e');
    }
  }

  Future<void> updateAutoScrapingEnabled(bool enabled) async {
    state = state.copyWith(isAutoScrapingEnabled: enabled);
    await _savePreferences();
    await _updateScrapingSchedule();
  }

  Future<void> updateScheduledTime(TimeOfDay time) async {
    state = state.copyWith(scheduledTime: time);
    await _savePreferences();
    await _updateScrapingSchedule();
  }

  Future<void> updateDailyEnabled(bool enabled) async {
    state = state.copyWith(isDailyEnabled: enabled);
    await _savePreferences();
    await _updateScrapingSchedule();
  }

  Future<void> updateSelectedDays(List<int> days) async {
    state = state.copyWith(selectedDays: days);
    await _savePreferences();
    await _updateScrapingSchedule();
  }

  Future<void> triggerManualScraping() async {
    try {
      // Update last manual trigger time
      state = state.copyWith(lastManualTrigger: DateTime.now());
      await _savePreferences();

      // Call Firebase Cloud Function
      final functions = FirebaseFunctions.instance;
      final callable = functions.httpsCallable('manual_scrape_trigger');
      final result = await callable.call();

      // Store trigger record in Firestore
      await FirebaseFirestore.instance.collection('scraping_triggers').add({
        'type': 'manual',
        'timestamp': FieldValue.serverTimestamp(),
        'triggered_by': 'mobile_app',
        'status': 'initiated',
      });

      print('Manual scraping triggered: ${result.data}');
    } catch (e) {
      throw Exception('Failed to trigger manual scraping: $e');
    }
  }

  Future<void> _updateScrapingSchedule() async {
    try {
      // Update scraping schedule in Firestore
      await FirebaseFirestore.instance
          .collection('system_config')
          .doc('scraping_schedule')
          .set({
        'auto_enabled': state.isAutoScrapingEnabled,
        'scheduled_time': {
          'hour': state.scheduledTime.hour,
          'minute': state.scheduledTime.minute,
        },
        'daily_enabled': state.isDailyEnabled,
        'selected_days': state.selectedDays,
        'updated_at': FieldValue.serverTimestamp(),
        'updated_by': 'mobile_app',
      }, SetOptions(merge: true));

      print('Scraping schedule updated');
    } catch (e) {
      print('Error updating scraping schedule: $e');
    }
  }
}
