// lib/core/services/logger_service.dart
import 'dart:developer' as developer;
import 'package:logging/logging.dart';
import 'package:flutter/foundation.dart';

class LoggerService {
  static final Logger _logger = Logger('ScrapingApp');
  static final List<LogRecord> _logs = [];
  static const int _maxLogs = 500;

  static void initialize() {
    Logger.root.level = kDebugMode ? Level.ALL : Level.INFO;
    Logger.root.onRecord.listen((record) {
      // Add to internal log list
      _addToLogHistory(record);

      // Print to console in debug mode
      if (kDebugMode) {
        final message =
            '${record.level.name}: ${record.time}: ${record.message}';
        developer.log(
          record.message,
          time: record.time,
          level: record.level.value,
          name: record.loggerName,
        );
        print(message);
      }
    });
  }

  static void _addToLogHistory(LogRecord record) {
    _logs.add(record);
    if (_logs.length > _maxLogs) {
      _logs.removeAt(0);
    }
  }

  // Public logging methods
  static void info(String message) => _logger.info(message);
  static void warning(String message) => _logger.warning(message);
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe(message, error, stackTrace);
  }

  static void debug(String message) => _logger.fine(message);

  // Get log history for UI display
  static List<LogRecord> getLogs({int? limit}) {
    if (limit != null && limit < _logs.length) {
      return _logs.reversed.take(limit).toList();
    }
    return _logs.reversed.toList();
  }

  // Clear logs
  static void clearLogs() {
    _logs.clear();
  }

  // Get logs by level
  static List<LogRecord> getLogsByLevel(Level level) {
    return _logs.where((log) => log.level == level).toList();
  }
}
