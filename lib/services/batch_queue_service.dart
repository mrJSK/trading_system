import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_service.dart';
import 'scraping_service.dart';

class BatchQueueService {
  static const String _queueKey = 'scraping_queue';
  static const String _currentBatchKey = 'current_batch';
  static const String _queueStatsKey = 'queue_stats';

  static const int batchSize = 25; // Companies per batch
  static const Duration batchDelay =
      Duration(minutes: 2); // Delay between batches
  static const Duration itemDelay = Duration(seconds: 5); // Delay between items

  // Initialize queue with all companies
  static Future<void> initializeQueue() async {
    final prefs = await SharedPreferences.getInstance();
    final db = DatabaseService();

    // Get all companies without data
    final companiesWithoutData = await db.getCompaniesWithoutData();

    if (companiesWithoutData.isEmpty) {
      print('📊 No companies need data scraping');
      return;
    }

    // Create batches
    final batches = <List<Map<String, dynamic>>>[];
    for (int i = 0; i < companiesWithoutData.length; i += batchSize) {
      final end = (i + batchSize < companiesWithoutData.length)
          ? i + batchSize
          : companiesWithoutData.length;

      final batch = companiesWithoutData
          .sublist(i, end)
          .map((company) => {
                'id': company.id,
                'name': company.name,
                'url': company.url,
                'status': 'pending', // pending, processing, completed, failed
              })
          .toList();

      batches.add(batch);
    }

    // Save queue to preferences
    await prefs.setString(_queueKey, jsonEncode(batches));
    await prefs.setInt(_currentBatchKey, 0);

    // Save stats
    await prefs.setString(
        _queueStatsKey,
        jsonEncode({
          'totalBatches': batches.length,
          'totalCompanies': companiesWithoutData.length,
          'completedBatches': 0,
          'completedCompanies': 0,
          'failedCompanies': 0,
          'startTime': DateTime.now().toIso8601String(),
        }));

    print(
        '🚀 Queue initialized: ${batches.length} batches, ${companiesWithoutData.length} companies');
  }

  // Process next batch
  static Future<bool> processNextBatch() async {
    final prefs = await SharedPreferences.getInstance();

    final queueJson = prefs.getString(_queueKey);
    if (queueJson == null) {
      print('❌ No queue found');
      return false;
    }

    final queue = List<List<dynamic>>.from(jsonDecode(queueJson));
    final currentBatchIndex = prefs.getInt(_currentBatchKey) ?? 0;

    if (currentBatchIndex >= queue.length) {
      print('🎉 All batches completed!');
      await _completeQueue();
      return false;
    }

    final currentBatch = List<Map<String, dynamic>>.from(
        queue[currentBatchIndex]
            .map((item) => Map<String, dynamic>.from(item)));

    print(
        '📦 Processing batch ${currentBatchIndex + 1}/${queue.length} (${currentBatch.length} companies)');

    await _updateQueueProgress('batch_processing', {
      'currentBatch': currentBatchIndex + 1,
      'totalBatches': queue.length,
      'batchSize': currentBatch.length,
      'isActive': true,
    });

    // Process batch
    final batchResult = await _processBatch(currentBatch, currentBatchIndex);

    // Update batch in queue
    queue[currentBatchIndex] = currentBatch;
    await prefs.setString(_queueKey, jsonEncode(queue));

    // Move to next batch
    await prefs.setInt(_currentBatchKey, currentBatchIndex + 1);

    // Update stats
    await _updateBatchStats(batchResult);

    // Schedule next batch if not the last one
    if (currentBatchIndex + 1 < queue.length) {
      print('⏰ Scheduling next batch in ${batchDelay.inMinutes} minutes');
      await _scheduleNextBatch();
    } else {
      print('🎉 Queue processing completed!');
      await _completeQueue();
    }

    return true;
  }

  // Process individual batch
  static Future<Map<String, int>> _processBatch(
      List<Map<String, dynamic>> batch, int batchIndex) async {
    final db = DatabaseService();
    final scraper = ScrapingService();

    int successful = 0;
    int failed = 0;

    for (int i = 0; i < batch.length; i++) {
      final item = batch[i];

      try {
        // Update item status
        item['status'] = 'processing';
        await _updateQueueProgress('item_processing', {
          'currentBatch': batchIndex + 1,
          'currentItem': i + 1,
          'batchSize': batch.length,
          'companyName': item['name'],
          'isActive': true,
        });

        print('🔍 Processing: ${item['name']} (${i + 1}/${batch.length})');

        // Get company from database
        final company = await db.getCompanyById(item['id']);
        if (company == null) {
          throw Exception('Company not found in database');
        }

        // Scrape data
        final data = await scraper.scrapeCompanyData(company);

        if (data != null) {
          item['status'] = 'completed';
          successful++;
          print('✅ Success: ${item['name']}');
        } else {
          item['status'] = 'failed';
          failed++;
          print('❌ Failed: ${item['name']} - No data returned');
        }
      } catch (e) {
        item['status'] = 'failed';
        item['error'] = e.toString();
        failed++;
        print('💥 Error: ${item['name']} - $e');
      }

      // Delay between items (except for last item)
      if (i < batch.length - 1) {
        print('⏳ Waiting ${itemDelay.inSeconds}s before next company...');
        await Future.delayed(itemDelay);
      }
    }

    print(
        '📊 Batch ${batchIndex + 1} completed: $successful successful, $failed failed');
    return {'successful': successful, 'failed': failed};
  }

  // Update queue progress
  static Future<void> _updateQueueProgress(
      String status, Map<String, dynamic> progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('queue_status', status);
    await prefs.setString('queue_progress', jsonEncode(progress));
  }

  // Update batch statistics
  static Future<void> _updateBatchStats(Map<String, int> batchResult) async {
    final prefs = await SharedPreferences.getInstance();
    final statsJson = prefs.getString(_queueStatsKey);

    if (statsJson != null) {
      final stats = Map<String, dynamic>.from(jsonDecode(statsJson));
      stats['completedBatches'] = (stats['completedBatches'] ?? 0) + 1;
      stats['completedCompanies'] =
          (stats['completedCompanies'] ?? 0) + batchResult['successful']!;
      stats['failedCompanies'] =
          (stats['failedCompanies'] ?? 0) + batchResult['failed']!;
      stats['lastBatchTime'] = DateTime.now().toIso8601String();

      await prefs.setString(_queueStatsKey, jsonEncode(stats));
    }
  }

  // Schedule next batch
  static Future<void> _scheduleNextBatch() async {
    // This will be handled by WorkManager scheduling
    await _updateQueueProgress('scheduled', {
      'nextBatchScheduled': DateTime.now().add(batchDelay).toIso8601String(),
      'isActive': false,
    });
  }

  // Complete queue processing
  static Future<void> _completeQueue() async {
    final prefs = await SharedPreferences.getInstance();

    await _updateQueueProgress('completed', {
      'completedAt': DateTime.now().toIso8601String(),
      'isActive': false,
    });

    // Get final stats
    final statsJson = prefs.getString(_queueStatsKey);
    if (statsJson != null) {
      final stats = jsonDecode(statsJson);
      print('🎊 Queue completed!');
      print(
          '📊 Final stats: ${stats['completedCompanies']} successful, ${stats['failedCompanies']} failed');
    }
  }

  // Get queue status
  static Future<Map<String, dynamic>> getQueueStatus() async {
    final prefs = await SharedPreferences.getInstance();

    final status = prefs.getString('queue_status') ?? 'idle';
    final progressJson = prefs.getString('queue_progress');
    final statsJson = prefs.getString(_queueStatsKey);

    return {
      'status': status,
      'progress': progressJson != null ? jsonDecode(progressJson) : {},
      'stats': statsJson != null ? jsonDecode(statsJson) : {},
    };
  }

  // Clear queue
  static Future<void> clearQueue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_queueKey);
    await prefs.remove(_currentBatchKey);
    await prefs.remove(_queueStatsKey);
    await prefs.remove('queue_status');
    await prefs.remove('queue_progress');

    print('🧹 Queue cleared');
  }

  // Resume failed items
  static Future<void> resumeFailedItems() async {
    final prefs = await SharedPreferences.getInstance();
    final queueJson = prefs.getString(_queueKey);

    if (queueJson == null) return;

    final queue = List<List<dynamic>>.from(jsonDecode(queueJson));
    bool hasFailedItems = false;

    // Reset failed items to pending
    for (final batch in queue) {
      for (final item in batch) {
        if (item['status'] == 'failed') {
          item['status'] = 'pending';
          hasFailedItems = true;
        }
      }
    }

    if (hasFailedItems) {
      await prefs.setString(_queueKey, jsonEncode(queue));
      await prefs.setInt(_currentBatchKey, 0); // Start from beginning
      print('🔄 Failed items reset for retry');
    }
  }
}
