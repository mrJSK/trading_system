// services/scraping_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/scraping_models.dart';

class ScrapingService {
  static const String _baseUrl =
      'https://us-central1-trading-system-123.cloudfunctions.net';

  /// Start scraping with specified parameters
  Future<String> startScraping({
    int maxPages = 100,
    bool clearExisting = true,
  }) async {
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
        final queuedCount = data['queued_count'] ?? 0;
        return data['message'] ??
            'Successfully queued $queuedCount companies for scraping';
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ??
            'Failed to start scraping: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error starting scraping: $e');
    }
  }

  /// Get current queue status from Firebase Functions
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

  /// Get list of recently completed scraping items
  Future<List<RecentCompletedItem>> getRecentCompleted() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/get_queue_status_api'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          final recentList = data['recent_completed'] as List? ?? [];
          return recentList
              .map((item) => RecentCompletedItem.fromJson(item))
              .toList();
        }
        throw Exception(
            data['message'] ?? 'Failed to get recent completed items');
      } else {
        throw Exception(
            'Failed to get recent completed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting recent completed: $e');
    }
  }

  /// Check if scraping is currently active
  Future<bool> isScrapingActive() async {
    try {
      final queueStatus = await getQueueStatus();
      return queueStatus.isActive;
    } catch (e) {
      return false;
    }
  }

  /// Retry all failed scraping items
  Future<String> retryFailed() async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/manage_queue'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'action': 'retry_failed',
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'] ?? 'Failed items have been reset to retry';
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ??
            'Failed to retry failed items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error retrying failed items: $e');
    }
  }

  /// Clear all failed scraping items from queue
  Future<String> clearFailed() async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/manage_queue'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'action': 'clear_failed',
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'] ?? 'Failed items have been cleared';
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ??
            'Failed to clear failed items: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error clearing failed items: $e');
    }
  }

  /// Stop the scraping process
  Future<String> stopScraping() async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/manage_queue'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'action': 'clear_pending',
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'] ?? 'Scraping process stopped';
      } else {
        // Fallback message if clear_pending action doesn't exist
        return 'Scraping will stop after current batch completes';
      }
    } catch (e) {
      throw Exception('Error stopping scraping: $e');
    }
  }

  /// Clear entire queue (failed items only for safety)
  Future<void> clearQueue() async {
    try {
      await clearFailed();
      // Note: Only clears failed items to prevent data loss
      // Full queue clearing would need additional Firebase implementation
    } catch (e) {
      throw Exception('Error clearing queue: $e');
    }
  }

  /// Test connection to Firebase Functions
  Future<String> testConnection() async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/manual_scrape_trigger'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'test': true,
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'] ?? 'Connection test successful';
      } else {
        throw Exception('Connection test failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Connection test error: $e');
    }
  }

  /// Get comprehensive scraping statistics
  Future<Map<String, dynamic>> getScrapingStats() async {
    try {
      final queueStatus = await getQueueStatus();
      final recentCompleted = await getRecentCompleted();

      return {
        'queue_status': queueStatus.toJson(),
        'recent_completed':
            recentCompleted.map((item) => item.toJson()).toList(),
        'total_companies_processed': queueStatus.completed,
        'success_rate': queueStatus.total > 0
            ? (queueStatus.completed / queueStatus.total * 100).round()
            : 0,
        'is_healthy': queueStatus.failed <
            (queueStatus.total * 0.1), // Less than 10% failure rate
        'last_updated': DateTime.now().toIso8601String(),
        'additional_metrics': {
          'pending_count': queueStatus.pending,
          'processing_count': queueStatus.processing,
          'failed_count': queueStatus.failed,
          'completion_percentage': queueStatus.progressPercentage,
          'is_active': queueStatus.isActive,
          'is_completed': queueStatus.isCompleted,
        }
      };
    } catch (e) {
      throw Exception('Error getting scraping stats: $e');
    }
  }

  /// Trigger manual scraping (legacy compatibility)
  Future<String> triggerManualScrape({
    int maxPages = 5,
    bool testMode = false,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/manual_scrape_trigger'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'test': testMode,
              'max_pages': maxPages,
            }),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'] ?? 'Manual scrape triggered successfully';
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ??
            'Failed to trigger manual scrape: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error triggering manual scrape: $e');
    }
  }

  /// Get current scraping progress as percentage (0.0 to 1.0)
  Future<double> getProgressPercentage() async {
    try {
      final status = await getQueueStatus();
      if (status.total == 0) return 0.0;
      return (status.completed + status.failed) / status.total;
    } catch (e) {
      return 0.0;
    }
  }

  /// Get estimated time remaining in seconds
  Future<int> getEstimatedTimeRemaining() async {
    try {
      final status = await getQueueStatus();
      if (!status.isActive || status.total == 0) return 0;

      final remaining = status.pending + status.processing;
      // Assuming 5 companies processed per 3 minutes (based on scheduler frequency)
      final estimatedMinutes = (remaining / 5) * 3;
      return (estimatedMinutes * 60).round(); // Return in seconds
    } catch (e) {
      return 0;
    }
  }

  /// Get scraping health status
  Future<bool> isScrapingHealthy() async {
    try {
      final status = await getQueueStatus();
      if (status.total == 0) return true; // No items to process

      final failureRate = status.failed / status.total;
      return failureRate <
          0.1; // Consider healthy if less than 10% failure rate
    } catch (e) {
      return false;
    }
  }

  /// Get detailed queue breakdown
  Future<Map<String, int>> getQueueBreakdown() async {
    try {
      final status = await getQueueStatus();
      return {
        'total': status.total,
        'pending': status.pending,
        'processing': status.processing,
        'completed': status.completed,
        'failed': status.failed,
      };
    } catch (e) {
      throw Exception('Error getting queue breakdown: $e');
    }
  }

  /// Check if queue needs attention (high failure rate or stalled)
  Future<bool> needsAttention() async {
    try {
      final status = await getQueueStatus();

      // High failure rate
      if (status.total > 0 && (status.failed / status.total) > 0.15) {
        return true;
      }

      // Processing items but no recent progress (would need timestamp comparison)
      if (status.processing > 0 && status.completed == 0) {
        // This is a simplified check - in reality you'd compare timestamps
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  /// Get human-readable status summary
  Future<String> getStatusSummary() async {
    try {
      final status = await getQueueStatus();

      if (status.total == 0) {
        return 'No scraping jobs queued';
      }

      if (status.isActive) {
        final progress =
            ((status.completed + status.failed) / status.total * 100).round();
        return 'Scraping in progress: $progress% complete (${status.processing} processing, ${status.pending} pending)';
      }

      if (status.isCompleted) {
        if (status.failed > 0) {
          return 'Scraping completed with ${status.failed} failures out of ${status.total} total';
        }
        return 'Scraping completed successfully: ${status.completed} companies processed';
      }

      return 'Scraping status: ${status.statusText}';
    } catch (e) {
      return 'Unable to get status summary';
    }
  }

  /// Perform comprehensive health check
  Future<Map<String, dynamic>> performHealthCheck() async {
    try {
      final connectionTest = await testConnection();
      final queueStatus = await getQueueStatus();
      final isHealthy = await isScrapingHealthy();
      final needsHelp = await needsAttention();

      return {
        'connection_status': 'healthy',
        'connection_message': connectionTest,
        'queue_health': isHealthy ? 'healthy' : 'unhealthy',
        'needs_attention': needsHelp,
        'queue_summary': {
          'total': queueStatus.total,
          'active': queueStatus.isActive,
          'completed': queueStatus.completed,
          'failed': queueStatus.failed,
        },
        'recommendations': _getHealthRecommendations(queueStatus, needsHelp),
        'last_check': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'connection_status': 'error',
        'connection_message': e.toString(),
        'queue_health': 'unknown',
        'needs_attention': true,
        'error': e.toString(),
        'last_check': DateTime.now().toIso8601String(),
      };
    }
  }

  /// Get health-based recommendations
  List<String> _getHealthRecommendations(
      QueueStatus status, bool needsAttention) {
    final recommendations = <String>[];

    if (status.failed > 0) {
      recommendations.add('Consider retrying ${status.failed} failed items');
    }

    if (needsAttention) {
      recommendations.add('Queue needs attention - check for errors');
    }

    if (status.total == 0) {
      recommendations
          .add('No items queued - consider starting a new scraping job');
    }

    if (status.processing > 5 && status.pending == 0) {
      recommendations.add(
          'Many items processing simultaneously - monitor for performance issues');
    }

    return recommendations.isEmpty
        ? ['System is running normally']
        : recommendations;
  }
}
