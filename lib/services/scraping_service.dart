import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/scraping_models.dart';

class ScrapingService {
  static const String _baseUrl =
      'https://us-central1-trading-system-123.cloudfunctions.net';

  Future<String> startScraping(
      {int maxPages = 50, bool clearExisting = true}) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/queue_scraping_jobs'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'max_pages': maxPages,
              'clear_existing': clearExisting,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'] ?? 'Scraping started successfully';
      } else {
        throw Exception('Failed to start scraping: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error starting scraping: $e');
    }
  }

  Future<QueueStatus> getQueueStatus() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/get_queue_status_api'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          return QueueStatus.fromJson(data['queue_status']);
        }
        throw Exception(data['message'] ?? 'Failed to get queue status');
      } else {
        throw Exception('Failed to get queue status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting queue status: $e');
    }
  }

  Future<bool> isScrapingActive() async {
    try {
      final queueStatus = await getQueueStatus();
      return queueStatus.isActive;
    } catch (e) {
      return false;
    }
  }

  Future<void> stopScraping() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/stop_scraping'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        throw Exception('Failed to stop scraping: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error stopping scraping: $e');
    }
  }

  Future<void> clearQueue() async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/clear_queue'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode != 200) {
        throw Exception('Failed to clear queue: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error clearing queue: $e');
    }
  }
}
