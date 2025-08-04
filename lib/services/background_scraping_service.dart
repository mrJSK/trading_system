// lib/services/background_scraping_service.dart
//
// Single source of truth for background-scraping state.
// Keeps SharedPreferences in sync with WorkManager progress and
// guarantees that the UI always receives a final “completed” status.

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'database_service.dart';
import 'scraping_service.dart';

class BackgroundScrapingService {
/* ───────────────────────────── keys ───────────────────────────── */
  static const _scrapingStatusKey = 'scraping_status';
  static const _scrapingProgressKey = 'scraping_progress';

/* ─────────────────────────── task names ───────────────────────── */
  static const scrapingTaskName = 'scraping_task';
  static const dataScrapingTaskName = 'data_scraping_task';

/* ───────────────────────── singleton glue ─────────────────────── */
  BackgroundScrapingService._internal();
  static final BackgroundScrapingService _instance =
      BackgroundScrapingService._internal();
  factory BackgroundScrapingService() => _instance;

/* ───────────────────────── initialise (UI) ────────────────────── */
  ///
  /// Call this **once** from `main.dart` **before** `runApp()`.
  ///
  Future<void> initialise() async {}

/* ──────────────────────── public controls ────────────────────── */

// Add this method to handle background tasks
  @pragma('vm:entry-point')
  static Future<bool> executeBackgroundTask(
      String task, dynamic inputData) async {
    final service = BackgroundScrapingService();
    switch (task) {
      case scrapingTaskName:
        return await BackgroundScrapingService._performListScraping(
            inputData ?? {});
      case dataScrapingTaskName:
        return await BackgroundScrapingService._performDataScraping();
      default:
        return false;
    }
  }

  Future<void> startListScraping(int totalPages) async {
    await _updateScrapingStatus('list_scraping', {
      'totalPages': totalPages,
      'currentPage': 0,
      'companiesFound': 0,
      'isActive': true,
      'startTime': DateTime.now().toIso8601String(),
    });

    await Workmanager().registerOneOffTask(
      'scraping_${DateTime.now().millisecondsSinceEpoch}',
      scrapingTaskName,
      inputData: {
        'totalPages': totalPages,
      },
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  Future<void> startDataScraping() async {
    await _updateScrapingStatus('data_scraping', {
      'isActive': true,
      'startTime': DateTime.now().toIso8601String(),
    });

    await Workmanager().registerOneOffTask(
      'data_scraping_${DateTime.now().millisecondsSinceEpoch}',
      dataScrapingTaskName,
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  Future<void> stopScraping() async {
    await _updateScrapingStatus('stopped', {
      'isActive': false,
      'stoppedAt': DateTime.now().toIso8601String(),
    });
    await Workmanager().cancelAll();
  }

/* ────────────────────── status / progress ────────────────────── */
  Future<String> getScrapingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_scrapingStatusKey) ?? 'idle';
  }

  Future<Map<String, dynamic>> getScrapingProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_scrapingProgressKey);
    return raw == null ? {} : jsonDecode(raw) as Map<String, dynamic>;
  }

  Stream<Map<String, dynamic>> getProgressStream({
    Duration interval = const Duration(seconds: 1),
  }) async* {
    while (true) {
      yield await getScrapingProgress();
      await Future.delayed(interval);
    }
  }

/* ─────────────────── private helper (shared) ─────────────────── */
  static Future<void> _updateScrapingStatus(
    String status,
    Map<String, dynamic> progress,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_scrapingStatusKey, status);
    await prefs.setString(_scrapingProgressKey, jsonEncode(progress));
  }

  static Future<Map<String, dynamic>> _getCurrentProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_scrapingProgressKey);
    return raw == null ? {} : jsonDecode(raw) as Map<String, dynamic>;
  }

/* ──────────────── WorkManager TOP-LEVEL entry-point ───────────── */
  ///
  /// MUST stay **top-level** – do **not** move inside the class.
  ///
  @pragma('vm:entry-point')
  static void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) async {
      try {
        switch (taskName) {
          case scrapingTaskName:
            return await _performListScraping(inputData ?? {});
          case dataScrapingTaskName:
            return await _performDataScraping();
          default:
            return false;
        }
      } catch (e) {
        await _updateScrapingStatus('error', {
          'error': e.toString(),
          'isActive': false,
        });
        return false;
      }
    });
  }

/* ──────────────── LIST-SCRAPING implementation ──────────────── */
  static Future<bool> _performListScraping(Map<String, dynamic> input) async {
    final totalPages = input['totalPages'] as int? ?? 5;
    final scrapingService = ScrapingService();
    int totalCompanies = 0;

    for (int page = 1; page <= totalPages; page++) {
      // cancellation?
      final progress = await _getCurrentProgress();
      if (progress['isActive'] != true) return false;

      // update step progress
      await _updateScrapingStatus('list_scraping', {
        'totalPages': totalPages,
        'currentPage': page,
        'companiesFound': totalCompanies,
        'isActive': true,
      });

      try {
        final list = await scrapingService.scrapeCompanyList(page);
        totalCompanies += list.length;
      } catch (_) {/* ignore page failures */}
    }

    await _updateScrapingStatus('completed', {
      'type': 'list_scraping',
      'totalCompanies': totalCompanies,
      'isActive': false,
      'completedAt': DateTime.now().toIso8601String(),
    });
    return true;
  }

/* ──────────────── DATA-SCRAPING implementation ──────────────── */
  static Future<bool> _performDataScraping() async {
    final db = DatabaseService();
    final svc = ScrapingService();

    final companies = await db.getAllCompanies();
    int processed = 0;
    int successful = 0;

    for (final company in companies) {
      // cancellation?
      final progress = await _getCurrentProgress();
      if (progress['isActive'] != true) return false;

      await _updateScrapingStatus('data_scraping', {
        'current': processed,
        'total': companies.length,
        'companyName': company.name,
        'successful': successful,
        'isActive': true,
      });

      try {
        final data = await svc.scrapeCompanyData(company);
        if (data != null) successful++;
      } catch (_) {/* ignore individual failures */}
      processed++;
    }

    await _updateScrapingStatus('completed', {
      'type': 'data_scraping',
      'processed': processed,
      'successful': successful,
      'isActive': false,
      'completedAt': DateTime.now().toIso8601String(),
    });
    return true;
  }
}
