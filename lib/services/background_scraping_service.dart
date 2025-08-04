// lib/services/background_scraping_service.dart
//
// SINGLE SOURCE OF TRUTH for every background-scraping operation.
// 2025-08-05  ➜  Added queue/batch support + enhanced logging.
// 2025-08-06  ➜  Added random delays (1.5-3s) to handle HTTP 429 rate limits.

import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'database_service.dart';
import 'scraping_service.dart';
import 'batch_queue_service.dart';

class BackgroundScrapingService {
/* ───────────────────────────── keys ───────────────────────────── */
  static const _scrapingStatusKey = 'scraping_status';
  static const _scrapingProgressKey = 'scraping_progress';

/* ─────────────────────────── task names ───────────────────────── */
  static const scrapingTaskName = 'scraping_task';
  static const dataScrapingTaskName = 'data_scraping_task';
  static const initQueueTaskName = 'init_queue_task';
  static const batchQueueTaskName = 'batch_queue_task';

/* ───────────────────────── random delay helper ─────────────────── */
  static final Random _random = Random();

  /// Generate random delay between 1.5-3 seconds to avoid rate limits
  static Future<void> _randomDelay() async {
    final delayMs = 1500 + _random.nextInt(1500); // 1500ms to 3000ms
    debugPrint('⏳ Random delay: ${delayMs}ms to avoid HTTP 429');
    await Future.delayed(Duration(milliseconds: delayMs));
  }

/* ───────────────────────── singleton glue ─────────────────────── */
  BackgroundScrapingService._internal();
  static final BackgroundScrapingService _instance =
      BackgroundScrapingService._internal();
  factory BackgroundScrapingService() => _instance;

/* ───────────────────────── initialise (UI) ────────────────────── */
  Future<void> initialise() async {
    // Reserved for future hot-reload safe initialisation
  }

/* ──────────────────────── public controls ────────────────────── */

  Future<void> startListScraping(int totalPages) async {
    await _updateScrapingStatus('list_scraping', {
      'totalPages': totalPages,
      'currentPage': 0,
      'companiesFound': 0,
      'isActive': true,
      'startTime': DateTime.now().toIso8601String(),
      'activityLogs': <String>[],
    });

    await Workmanager().registerOneOffTask(
      'scraping_${DateTime.now().millisecondsSinceEpoch}',
      scrapingTaskName,
      inputData: {'totalPages': totalPages},
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  Future<void> startDataScraping() async {
    await _updateScrapingStatus('data_scraping', {
      'isActive': true,
      'startTime': DateTime.now().toIso8601String(),
      'activityLogs': <String>[],
    });

    await Workmanager().registerOneOffTask(
      'data_scraping_${DateTime.now().millisecondsSinceEpoch}',
      dataScrapingTaskName,
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  /* ───────────── queue/batch public API ───────────── */
  Future<void> startBatchQueue() async {
    await _updateScrapingStatus('initializing_queue', {
      'isActive': true,
      'startTime': DateTime.now().toIso8601String(),
      'activityLogs': <String>[],
    });

    await Workmanager().registerOneOffTask(
      'init_queue_${DateTime.now().millisecondsSinceEpoch}',
      initQueueTaskName,
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
    await prefs.reload();
    return prefs.getString(_scrapingStatusKey) ?? 'idle';
  }

  Future<Map<String, dynamic>> getScrapingProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_scrapingProgressKey);
    await prefs.reload();
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

/* ──────────────── WorkManager TOP-LEVEL dispatcher ───────────── */
  @pragma('vm:entry-point')
  static void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) async {
      try {
        switch (taskName) {
          case scrapingTaskName:
            return await _performListScraping(inputData ?? {});
          case dataScrapingTaskName:
            return await _performDataScraping();
          case initQueueTaskName:
            return await _performQueueInit();
          case batchQueueTaskName:
            return await _performBatchQueue();
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

/* ─────────────── LIST-SCRAPING implementation ─────────────── */
  static Future<bool> _performListScraping(Map<String, dynamic> input) async {
    final totalPages = input['totalPages'] as int? ?? 5;
    final svc = ScrapingService();
    int totalCompanies = 0;

    final List<String> logs = [];
    void addLog(String msg) {
      final t = DateTime.now().toString().substring(11, 19);
      logs.add('$t: $msg');
      debugPrint('ScrapingLog: $msg');
    }

    addLog('🚀 Started list scraping for $totalPages pages');

    for (int page = 1; page <= totalPages; page++) {
      // cancellation?
      final progress = await _getCurrentProgress();
      if (progress['isActive'] != true) {
        addLog('⏹️  List scraping cancelled by user');
        return false;
      }

      addLog('🌐 Scraping page $page/$totalPages');

      await _updateScrapingStatus('list_scraping', {
        'totalPages': totalPages,
        'currentPage': page,
        'companiesFound': totalCompanies,
        'isActive': true,
        'activityLogs': logs,
        'currentActivity': 'Page $page/$totalPages',
      });

      try {
        final list = await svc.scrapeCompanyList(page);
        totalCompanies += list.length;
        addLog(
            '✅ Page $page done: ${list.length} companies (total $totalCompanies)');
      } catch (e) {
        addLog('❌ Page $page failed: $e');
      }

      // ADD RANDOM DELAY BETWEEN PAGES (except for last page)
      if (page < totalPages) {
        addLog('⏳ Adding random delay to avoid rate limits...');
        await _randomDelay();
      }
    }

    addLog('🎉 List scraping completed with $totalCompanies companies');

    await _updateScrapingStatus('completed', {
      'type': 'list_scraping',
      'totalCompanies': totalCompanies,
      'isActive': false,
      'completedAt': DateTime.now().toIso8601String(),
      'activityLogs': logs,
    });
    return true;
  }

/* ─────────────── DATA-SCRAPING implementation ─────────────── */
  static Future<bool> _performDataScraping() async {
    final db = DatabaseService();
    final svc = ScrapingService();

    final companies = await db.getAllCompanies();
    int processed = 0, successful = 0, failed = 0;

    final List<String> logs = [];
    void addLog(String msg) {
      final t = DateTime.now().toString().substring(11, 19);
      logs.add('$t: $msg');
      debugPrint('ScrapingLog: $msg');
    }

    addLog('🔍 Starting data scraping for ${companies.length} companies');

    for (final company in companies) {
      // cancellation?
      final progress = await _getCurrentProgress();
      if (progress['isActive'] != true) {
        addLog('⏹️  Data scraping cancelled by user');
        return false;
      }

      addLog(
          '🏢 Processing ${company.name} (${processed + 1}/${companies.length})');

      await _updateScrapingStatus('data_scraping', {
        'current': processed,
        'total': companies.length,
        'companyName': company.name,
        'successful': successful,
        'failed': failed,
        'isActive': true,
        'activityLogs': logs,
        'currentActivity': 'Scraping ${company.name}',
      });

      try {
        final data = await svc.scrapeCompanyData(company);
        if (data != null) {
          successful++;
          addLog('✅ Success: ${company.name}');
        } else {
          failed++;
          addLog('❌ Failed: ${company.name} (no data)');
        }
      } catch (e) {
        failed++;
        addLog('💥 Error: ${company.name} - $e');
      }
      processed++;

      // ADD RANDOM DELAY BETWEEN COMPANIES (except for last company)
      if (processed < companies.length) {
        await _randomDelay();
      }

      // Progress update every 5 companies
      if (processed % 5 == 0) {
        addLog(
            '📊 Progress: $processed/${companies.length} ($successful✅ $failed❌)');
      }
    }

    addLog('🎊 Data scraping finished: $successful/$processed successful');

    await _updateScrapingStatus('completed', {
      'type': 'data_scraping',
      'processed': processed,
      'successful': successful,
      'failed': failed,
      'isActive': false,
      'completedAt': DateTime.now().toIso8601String(),
      'activityLogs': logs,
    });
    return true;
  }

/* ──────────────── QUEUE / BATCH implementation ────────────── */
  static Future<bool> _performQueueInit() async {
    await BatchQueueService.initializeQueue();

    await _updateScrapingStatus('queue_initialized', {
      'isActive': false,
      'completedAt': DateTime.now().toIso8601String(),
      'activityLogs': <String>[
        '${DateTime.now().toString().substring(11, 19)}: 🛠️ Queue initialised'
      ],
    });

    // schedule first batch
    await BackgroundScrapingService()._scheduleNextBatch();
    return true;
  }

  static Future<bool> _performBatchQueue() async {
    final hasMore = await BatchQueueService.processNextBatch();
    if (hasMore) {
      await BackgroundScrapingService()._scheduleNextBatch();
    }
    return true;
  }

  Future<void> _scheduleNextBatch() async {
    await Workmanager().registerOneOffTask(
      'batch_${DateTime.now().millisecondsSinceEpoch}',
      batchQueueTaskName,
      initialDelay: BatchQueueService.batchDelay,
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }
}
