// lib/core/services/scraping_service.dart
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../models/scraping/scraping_models.dart';
import 'logger_service.dart'; // Import logger service

// Custom exception classes for detailed error handling
class ScrapingException implements Exception {
  final String message;
  final String code;
  final dynamic originalError;

  ScrapingException(this.message, {this.code = 'UNKNOWN', this.originalError});

  @override
  String toString() => 'ScrapingException: $message (Code: $code)';
}

class NetworkException extends ScrapingException {
  NetworkException(String message, {dynamic originalError})
      : super(message, code: 'NETWORK_ERROR', originalError: originalError);
}

class ServerException extends ScrapingException {
  final int statusCode;

  ServerException(String message, this.statusCode, {dynamic originalError})
      : super(message, code: 'SERVER_ERROR', originalError: originalError);
}

class TimeoutException extends ScrapingException {
  TimeoutException(String message, {dynamic originalError})
      : super(message, code: 'TIMEOUT_ERROR', originalError: originalError);
}

// Advanced Scraping Service with comprehensive logging and error handling
class ScrapingService {
  static const String _baseUrl =
      'https://us-central1-trading-system-123.cloudfunctions.net';
  static const Duration _timeout = Duration(seconds: 30);
  static const Duration _cacheExpiry = Duration(minutes: 1);
  static const Duration _detailedCacheExpiry = Duration(minutes: 2);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final http.Client _httpClient;

  // Complex caching system
  QueueStatus? _cachedQueueStatus;
  DateTime? _lastCacheUpdate;
  DetailedProgress? _cachedDetailedProgress;
  DateTime? _lastDetailedCacheUpdate;

  // Real-time streams
  StreamController<QueueStatus>? _statusStreamController;
  StreamController<DetailedProgress>? _progressStreamController;
  Timer? _realTimeUpdateTimer;

  // State management
  bool _isServiceActive = false;
  final List<ScrapingEvent> _eventHistory = [];

  ScrapingService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client() {
    LoggerService.info('ScrapingService initialized');
    _initializeRealTimeUpdates();
  }

  void _initializeRealTimeUpdates() {
    LoggerService.info('Initializing real-time updates');
    _statusStreamController = StreamController<QueueStatus>.broadcast();
    _progressStreamController = StreamController<DetailedProgress>.broadcast();

    _realTimeUpdateTimer = Timer.periodic(Duration(seconds: 10), (_) {
      _updateRealTimeStreams();
    });

    _isServiceActive = true;
    LoggerService.info('Real-time updates initialized successfully');
  }

  Future<void> _updateRealTimeStreams() async {
    if (!_isServiceActive) return;

    LoggerService.debug('Updating real-time streams');
    try {
      // Update queue status stream
      final status = await getQueueStatus(forceRefresh: true);
      if (status != null) {
        _statusStreamController?.add(status);
        LoggerService.debug('Status stream updated: ${status.statusText}');
      }

      // Update detailed progress if active
      if (status?.isActive == true) {
        final progress = await getDetailedProgress(forceRefresh: true);
        if (progress != null) {
          _progressStreamController?.add(progress);
          LoggerService.debug('Progress stream updated');
        }
      }

      _logEvent('Real-time update completed', ScrapingEventType.info);
      LoggerService.debug('Real-time update completed successfully');
    } catch (e) {
      _logEvent('Real-time update failed: $e', ScrapingEventType.error);
      LoggerService.error('Real-time update failed', e);
    }
  }

  /// Start scraping with detailed logging
  Future<String> startScraping({int maxPages = 50}) async {
    LoggerService.info('Starting scraping with maxPages: $maxPages');

    try {
      final requestBody = {
        'max_pages': maxPages,
        'clear_existing': true,
      };

      LoggerService.debug('Sending request to: $_baseUrl/queue_scraping_jobs');
      LoggerService.debug('Request body: ${json.encode(requestBody)}');

      final response = await http
          .post(
            Uri.parse('$_baseUrl/queue_scraping_jobs'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(requestBody),
          )
          .timeout(_timeout);

      LoggerService.debug('Response status: ${response.statusCode}');
      LoggerService.debug('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final message = data['message'] ?? 'Scraping started successfully!';

        // Clear cache after starting new scraping
        _invalidateAllCaches();

        LoggerService.info('Scraping started successfully: $message');
        _logEvent('Scraping started successfully', ScrapingEventType.success);

        return message;
      } else {
        LoggerService.error(
            'Failed to start scraping - HTTP ${response.statusCode}: ${response.body}');
        throw Exception('Failed to start scraping');
      }
    } catch (e) {
      LoggerService.error('Error starting scraping', e);
      _logEvent('Scraping start failed: $e', ScrapingEventType.error);
      throw Exception('Error: $e');
    }
  }

  /// Get queue status with detailed logging and advanced caching
  Future<QueueStatus?> getQueueStatus({bool forceRefresh = false}) async {
    LoggerService.debug('Getting queue status (forceRefresh: $forceRefresh)');

    // Return cached data if available and not expired
    if (!forceRefresh && _isCacheValid(_lastCacheUpdate, _cacheExpiry)) {
      LoggerService.debug('Returning cached queue status');
      _log('Returning cached queue status');
      return _cachedQueueStatus;
    }

    try {
      LoggerService.debug('Fetching fresh queue status from API');
      _log('Fetching fresh queue status');
      final response =
          await _makeRequest('GET', '$_baseUrl/get_queue_status_api');
      final queueStatus = _parseQueueStatus(response);

      // Update cache
      _cachedQueueStatus = queueStatus;
      _lastCacheUpdate = DateTime.now();

      LoggerService.info(
          'Queue status updated: ${queueStatus.detailedStatusText}');
      LoggerService.debug(
          'Queue stats - Pending: ${queueStatus.pending}, Processing: ${queueStatus.processing}, Completed: ${queueStatus.completed}, Failed: ${queueStatus.failed}');
      _log('Queue status updated: ${queueStatus.detailedStatusText}');

      // Save to Firestore for offline access
      try {
        await _saveToFirestore('queue_status', queueStatus.toJson());
        LoggerService.debug('Queue status saved to Firestore');
      } catch (e) {
        LoggerService.warning('Failed to save to Firestore: $e');
      }

      return queueStatus;
    } catch (e) {
      LoggerService.warning('Failed to fetch queue status from API: $e');
      _log('Failed to fetch queue status, trying cached/offline data: $e');

      // Try to get from Firestore cache
      try {
        final cachedData = await _getFromFirestore('queue_status');
        if (cachedData != null) {
          LoggerService.info('Retrieved queue status from Firestore cache');
          _log('Retrieved queue status from Firestore cache');
          return _parseQueueStatus(cachedData);
        }
      } catch (firestoreError) {
        LoggerService.warning(
            'Failed to get from Firestore cache: $firestoreError');
      }

      // If we have in-memory cache, return it even if expired
      if (_cachedQueueStatus != null) {
        LoggerService.info('Returning expired in-memory cache');
        _log('Returning expired in-memory cache');
        return _cachedQueueStatus;
      }

      LoggerService.error('No queue status available from any source');
      return null; // Return null instead of throwing
    }
  }

  /// Get detailed progress with caching and logging
  Future<DetailedProgress?> getDetailedProgress(
      {bool forceRefresh = false}) async {
    LoggerService.debug(
        'Getting detailed progress (forceRefresh: $forceRefresh)');

    if (!forceRefresh &&
        _isCacheValid(_lastDetailedCacheUpdate, _detailedCacheExpiry)) {
      LoggerService.debug('Returning cached detailed progress');
      return _cachedDetailedProgress;
    }

    try {
      LoggerService.debug('Fetching fresh detailed progress from API');
      final response =
          await _makeRequest('GET', '$_baseUrl/get_detailed_progress');
      final detailedProgress = _parseDetailedProgress(response);

      _cachedDetailedProgress = detailedProgress;
      _lastDetailedCacheUpdate = DateTime.now();

      LoggerService.info('Detailed progress updated successfully');
      LoggerService.debug(
          'Currently processing: ${detailedProgress.currentlyProcessing.length} items');
      LoggerService.debug(
          'Recent failures: ${detailedProgress.recentFailures.length} items');

      // Save to Firestore
      try {
        await _saveToFirestore('detailed_progress', response);
        LoggerService.debug('Detailed progress saved to Firestore');
      } catch (e) {
        LoggerService.warning(
            'Failed to save detailed progress to Firestore: $e');
      }

      return detailedProgress;
    } catch (e) {
      LoggerService.warning('Failed to fetch detailed progress from API: $e');

      // Try Firestore cache
      try {
        final cachedData = await _getFromFirestore('detailed_progress');
        if (cachedData != null) {
          LoggerService.info(
              'Retrieved detailed progress from Firestore cache');
          return _parseDetailedProgress(cachedData);
        }
      } catch (firestoreError) {
        LoggerService.warning(
            'Failed to get detailed progress from Firestore cache: $firestoreError');
      }

      if (_cachedDetailedProgress != null) {
        LoggerService.info('Returning expired detailed progress cache');
        return _cachedDetailedProgress;
      }

      LoggerService.error('No detailed progress available from any source');
      return null;
    }
  }

  /// Retry failed items with logging
  Future<String> retryFailed() async {
    LoggerService.info('Retrying failed items');

    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/manage_queue'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'action': 'retry_failed'}),
          )
          .timeout(_timeout);

      LoggerService.debug(
          'Retry failed response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        // Invalidate cache after queue management
        _invalidateAllCaches();

        LoggerService.info('Failed items successfully queued for retry');
        _logEvent('Failed items queued for retry', ScrapingEventType.success);
        return 'Failed items queued for retry';
      } else {
        LoggerService.error(
            'Failed to retry failed items - HTTP ${response.statusCode}');
        throw Exception('Failed to retry');
      }
    } catch (e) {
      LoggerService.error('Error retrying failed items', e);
      _logEvent('Retry failed operation failed: $e', ScrapingEventType.error);
      throw Exception('Error: $e');
    }
  }

  /// Manage queue actions with logging
  Future<String> manageQueue(String action) async {
    LoggerService.info('Managing queue with action: $action');

    final validActions = [
      'retry_failed',
      'clear_failed',
      'clear_completed',
      'pause',
      'resume',
      'reset_stalled',
      'prioritize',
    ];

    if (!validActions.contains(action)) {
      final errorMessage =
          'Invalid action: $action. Valid actions: ${validActions.join(', ')}';
      LoggerService.error(errorMessage);
      throw ScrapingException(errorMessage);
    }

    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/manage_queue'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'action': action}),
          )
          .timeout(_timeout);

      LoggerService.debug(
          'Queue management response: ${response.statusCode} - ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final message = data['message'] ?? 'Action completed successfully';

        // Invalidate cache after queue management
        _invalidateAllCaches();

        LoggerService.info('Queue management completed: $action - $message');
        _logEvent(
            'Queue management completed: $action', ScrapingEventType.success);
        return message;
      } else {
        LoggerService.error(
            'Failed to manage queue - HTTP ${response.statusCode}');
        throw Exception('Failed to manage queue');
      }
    } catch (e) {
      LoggerService.error('Error managing queue with action: $action', e);
      _logEvent(
          'Queue management failed: $action - $e', ScrapingEventType.error);
      throw Exception('Error: $e');
    }
  }

  /// Real-time status stream
  Stream<QueueStatus> get statusStream => _statusStreamController!.stream;

  /// Real-time progress stream
  Stream<DetailedProgress> get progressStream =>
      _progressStreamController!.stream;

  /// Watch queue status changes via Firestore
  Stream<QueueStatus> watchQueueStatusFirestore() {
    LoggerService.debug('Starting Firestore queue status stream');
    return _firestore
        .collection('system')
        .doc('queue_status')
        .snapshots()
        .map((doc) {
      if (doc.exists && doc.data() != null) {
        LoggerService.debug('Received queue status update from Firestore');
        return _parseQueueStatus(doc.data()!);
      }
      LoggerService.warning('No queue status data available in Firestore');
      throw ScrapingException('No queue status data available');
    }).handleError((error) {
      _log('Error in Firestore queue status stream: $error');
      _logEvent('Firestore stream error: $error', ScrapingEventType.error);
      LoggerService.error('Firestore stream error', error);
    });
  }

  /// Get comprehensive health status
  Future<Map<String, dynamic>> getHealthStatus() async {
    LoggerService.debug('Getting comprehensive health status');
    try {
      final status = await getQueueStatus();
      final detailed = await getDetailedProgress();

      if (status == null) {
        LoggerService.warning(
            'Cannot determine health status - queue status is null');
        return {
          'is_healthy': false,
          'error': 'Queue status unavailable',
          'last_update': DateTime.now().toIso8601String(),
        };
      }

      final healthData = {
        'is_healthy': status.isHealthy && !status.isStalled,
        'is_active': status.isActive,
        'is_stalled': status.isStalled,
        'error_rate': status.total > 0 ? (status.failed / status.total) : 0.0,
        'stuck_items': detailed?.stuckItemsCount ?? 0,
        'retryable_failures': detailed?.retryableFailuresCount ?? 0,
        'completion_rate': status.completionRate,
        'estimated_completion':
            status.estimatedTimeRemainingDuration?.inMinutes,
        'last_update': DateTime.now().toIso8601String(),
      };

      LoggerService.info(
          'Health check completed - Healthy: ${healthData['is_healthy']}');
      _logEvent('Health check completed', ScrapingEventType.info);
      return healthData;
    } catch (e) {
      LoggerService.error('Health check failed', e);
      _logEvent('Health check failed: $e', ScrapingEventType.error);
      return {
        'is_healthy': false,
        'error': e.toString(),
        'last_update': DateTime.now().toIso8601String(),
      };
    }
  }

  /// Check if scraping is active
  Future<bool> isScrapingActive() async {
    LoggerService.debug('Checking if scraping is active');
    try {
      final status = await getQueueStatus();
      final isActive = status?.isActive ?? false;
      LoggerService.debug('Scraping active status: $isActive');
      return isActive;
    } catch (e) {
      LoggerService.error('Failed to check scraping active status', e);
      return false;
    }
  }

  /// Get event history
  List<ScrapingEvent> getEventHistory({int limit = 50}) {
    LoggerService.debug('Getting event history (limit: $limit)');
    return _eventHistory.reversed.take(limit).toList();
  }

  /// Clear event history
  void clearEventHistory() {
    LoggerService.info('Clearing event history');
    _eventHistory.clear();
  }

  // Helper method to parse API response into Freezed QueueStatus
  QueueStatus _parseQueueStatus(Map<String, dynamic> data) {
    try {
      LoggerService.debug('Parsing queue status from API response');
      final queueData = data['queue_status'] as Map<String, dynamic>? ?? {};
      final recentList = data['recent_completed'] as List<dynamic>? ?? [];

      final queueStatus = QueueStatus(
        pending: queueData['pending'] ?? 0,
        processing: queueData['processing'] ?? 0,
        completed: queueData['completed'] ?? 0,
        failed: queueData['failed'] ?? 0,
        total: queueData['total'] ?? 0,
        timestamp: DateTime.parse(
            data['timestamp'] ?? DateTime.now().toIso8601String()),
        estimatedTimeRemaining: data['estimated_remaining_time'] as String?,
        completionRate: (data['completion_rate'] as num?)?.toDouble(),
        recentCompleted: recentList
            .map((item) => RecentCompany(
                  symbol: item['symbol'] ?? '',
                  companyName: item['company_name'] ?? '',
                  completedAt: DateTime.parse(
                      item['completed_at'] ?? DateTime.now().toIso8601String()),
                ))
            .toList(),
      );

      LoggerService.debug('Queue status parsed successfully');
      return queueStatus;
    } catch (e) {
      LoggerService.error('Failed to parse queue status', e);
      rethrow;
    }
  }

  // Helper method to parse detailed progress
  DetailedProgress _parseDetailedProgress(Map<String, dynamic> data) {
    try {
      LoggerService.debug('Parsing detailed progress from API response');
      final queueStatus = _parseQueueStatus(data);
      final processingList =
          data['currently_processing'] as List<dynamic>? ?? [];
      final failuresList = data['recent_failures'] as List<dynamic>? ?? [];

      final detailedProgress = DetailedProgress(
        queueStatus: queueStatus,
        currentlyProcessing: processingList
            .map((item) => ProcessingItem(
                  url: item['url'] ?? '',
                  symbol: item['symbol'] ?? 'Unknown',
                  startedAt: DateTime.parse(
                      item['started_at'] ?? DateTime.now().toIso8601String()),
                  processingDuration:
                      (item['processing_duration'] ?? 0.0).toDouble(),
                ))
            .toList(),
        recentFailures: failuresList
            .map((item) => FailedItem(
                  url: item['url'] ?? '',
                  error: item['error'] ?? 'Unknown error',
                  failedAt: DateTime.parse(
                      item['failed_at'] ?? DateTime.now().toIso8601String()),
                  retryCount: item['retry_count'] ?? 0,
                ))
            .toList(),
        estimatedCompletion: data['estimated_completion'] != null
            ? DateTime.parse(data['estimated_completion'])
            : null,
        estimatedRemainingTime: data['estimated_remaining_time'] as String?,
        performanceMetrics:
            data['performance_metrics'] as Map<String, dynamic>?,
      );

      LoggerService.debug('Detailed progress parsed successfully');
      return detailedProgress;
    } catch (e) {
      LoggerService.error('Failed to parse detailed progress', e);
      rethrow;
    }
  }

  // Private helper methods
  Future<Map<String, dynamic>> _makeRequest(
    String method,
    String url, {
    Map<String, dynamic>? body,
  }) async {
    LoggerService.debug('Making $method request to: $url');
    if (body != null) {
      LoggerService.debug('Request body: ${json.encode(body)}');
    }

    try {
      late http.Response response;
      final headers = {'Content-Type': 'application/json'};

      switch (method.toUpperCase()) {
        case 'GET':
          response = await _httpClient
              .get(Uri.parse(url), headers: headers)
              .timeout(_timeout);
          break;
        case 'POST':
          response = await _httpClient
              .post(
                Uri.parse(url),
                headers: headers,
                body: body != null ? json.encode(body) : null,
              )
              .timeout(_timeout);
          break;
        default:
          throw ScrapingException('Unsupported HTTP method: $method');
      }

      LoggerService.debug('Response received: ${response.statusCode}');
      return _handleResponse(response);
    } on SocketException catch (e) {
      LoggerService.error('Network error - no internet connection', e);
      throw NetworkException('No internet connection', originalError: e);
    } on http.ClientException catch (e) {
      LoggerService.error('HTTP client error', e);
      throw NetworkException('Network error', originalError: e);
    } on TimeoutException catch (e) {
      LoggerService.error('Request timeout', e);
      throw TimeoutException('Request timeout', originalError: e);
    } on FormatException catch (e) {
      LoggerService.error('Invalid response format', e);
      throw ScrapingException('Invalid response format',
          code: 'FORMAT_ERROR', originalError: e);
    } catch (e) {
      if (e is ScrapingException) rethrow;
      LoggerService.error('Unexpected error in request', e);
      throw ScrapingException('Unexpected error: $e', originalError: e);
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    LoggerService.debug('Handling response: ${response.statusCode}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        final decoded = json.decode(response.body) as Map<String, dynamic>;
        LoggerService.debug('Response parsed successfully');
        return decoded;
      } catch (e) {
        LoggerService.error('Failed to parse JSON response', e);
        throw ScrapingException('Invalid JSON response',
            code: 'PARSE_ERROR', originalError: e);
      }
    } else {
      String errorMessage = 'HTTP ${response.statusCode}';
      try {
        final errorData = json.decode(response.body);
        errorMessage = errorData['message'] ?? errorMessage;
      } catch (e) {
        // Use default error message if JSON parsing fails
      }

      LoggerService.error('HTTP error response: $errorMessage');
      throw ServerException(errorMessage, response.statusCode);
    }
  }

  bool _isCacheValid(DateTime? cacheTime, Duration expiry) {
    if (cacheTime == null) return false;
    final isValid = DateTime.now().difference(cacheTime) < expiry;
    LoggerService.debug('Cache validity check: $isValid');
    return isValid;
  }

  void _invalidateAllCaches() {
    LoggerService.debug('Invalidating all caches');
    _cachedQueueStatus = null;
    _lastCacheUpdate = null;
    _cachedDetailedProgress = null;
    _lastDetailedCacheUpdate = null;
  }

  Future<void> _saveToFirestore(String docId, Map<String, dynamic> data) async {
    try {
      LoggerService.debug('Saving $docId to Firestore');
      await _firestore.collection('system').doc(docId).set({
        ...data,
        'cached_at': FieldValue.serverTimestamp(),
      });
      LoggerService.debug('Successfully saved $docId to Firestore');
    } catch (e) {
      LoggerService.warning('Failed to save $docId to Firestore: $e');
      _log('Failed to save to Firestore: $e');
    }
  }

  Future<Map<String, dynamic>?> _getFromFirestore(String docId) async {
    try {
      LoggerService.debug('Getting $docId from Firestore');
      final doc = await _firestore.collection('system').doc(docId).get();
      if (doc.exists && doc.data() != null) {
        LoggerService.debug('Successfully retrieved $docId from Firestore');
        return doc.data();
      } else {
        LoggerService.debug('Document $docId not found in Firestore');
        return null;
      }
    } catch (e) {
      LoggerService.warning('Failed to get $docId from Firestore: $e');
      _log('Failed to get from Firestore: $e');
      return null;
    }
  }

  void _log(String message) {
    if (kDebugMode) {
      print('[ScrapingService] $message');
    }
  }

  void _logEvent(String message, ScrapingEventType type) {
    final event = ScrapingEvent(
      message: message,
      type: type,
      timestamp: DateTime.now(),
    );

    _eventHistory.add(event);

    // Keep only last 100 events
    if (_eventHistory.length > 100) {
      _eventHistory.removeAt(0);
    }

    LoggerService.debug('Event logged: $message (${type.name})');
  }

  void dispose() {
    LoggerService.info('Disposing ScrapingService');
    _isServiceActive = false;
    _realTimeUpdateTimer?.cancel();
    _statusStreamController?.close();
    _progressStreamController?.close();
    _httpClient.close();
    LoggerService.info('ScrapingService disposed successfully');
  }
}
