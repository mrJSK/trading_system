// lib/features/home/presentation/screens/logs_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import '../../../../core/services/logger_service.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({Key? key}) : super(key: key);

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  Level? _selectedLevel;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final logs = _selectedLevel != null
        ? LoggerService.getLogsByLevel(_selectedLevel!)
        : LoggerService.getLogs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Function Logs'),
        actions: [
          // Filter dropdown
          PopupMenuButton<Level?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (level) {
              setState(() {
                _selectedLevel = level;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: null, child: Text('All Logs')),
              const PopupMenuItem(value: Level.INFO, child: Text('Info')),
              const PopupMenuItem(value: Level.WARNING, child: Text('Warning')),
              const PopupMenuItem(value: Level.SEVERE, child: Text('Error')),
              const PopupMenuItem(value: Level.FINE, child: Text('Debug')),
            ],
          ),
          // Clear logs
          IconButton(
            icon: const Icon(Icons.clear_all),
            onPressed: () {
              LoggerService.clearLogs();
              setState(() {});
            },
            tooltip: 'Clear Logs',
          ),
          // Export logs
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _exportLogs(logs),
            tooltip: 'Export Logs',
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats bar
          Container(
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatChip('Total', logs.length, Colors.blue),
                _buildStatChip(
                    'Errors',
                    logs.where((l) => l.level == Level.SEVERE).length,
                    Colors.red),
                _buildStatChip(
                    'Warnings',
                    logs.where((l) => l.level == Level.WARNING).length,
                    Colors.orange),
                _buildStatChip(
                    'Info',
                    logs.where((l) => l.level == Level.INFO).length,
                    Colors.green),
              ],
            ),
          ),

          // Logs list
          Expanded(
            child: logs.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.article_outlined,
                            size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No logs available'),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      return _buildLogTile(log);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {}); // Refresh logs
        },
        child: const Icon(Icons.refresh),
        tooltip: 'Refresh Logs',
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Chip(
      label: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 16,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
      backgroundColor: color.withOpacity(0.1),
    );
  }

  Widget _buildLogTile(LogRecord log) {
    final color = _getLogColor(log.level);
    final icon = _getLogIcon(log.level);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ExpansionTile(
        leading: Icon(icon, color: color),
        title: Text(
          log.message,
          style: TextStyle(
            color: color,
            fontWeight: log.level == Level.SEVERE ? FontWeight.bold : null,
          ),
        ),
        subtitle: Text(
          '${log.time.toString().substring(11, 19)} • ${log.level.name}',
          style: const TextStyle(fontSize: 12),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Time: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(log.time.toString()),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('Level: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(log.level.name),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text('Logger: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(log.loggerName),
                  ],
                ),
                if (log.error != null) ...[
                  const SizedBox(height: 8),
                  Text('Error: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(log.error.toString()),
                ],
                if (log.stackTrace != null) ...[
                  const SizedBox(height: 8),
                  Text('Stack Trace: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(log.stackTrace.toString()),
                ],
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () => _copyLogToClipboard(log),
                      icon: const Icon(Icons.copy, size: 16),
                      label: const Text('Copy'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getLogColor(Level level) {
    switch (level) {
      case Level.SEVERE:
        return Colors.red;
      case Level.WARNING:
        return Colors.orange;
      case Level.INFO:
        return Colors.green;
      case Level.FINE:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getLogIcon(Level level) {
    switch (level) {
      case Level.SEVERE:
        return Icons.error;
      case Level.WARNING:
        return Icons.warning;
      case Level.INFO:
        return Icons.info;
      case Level.FINE:
        return Icons.bug_report;
      default:
        return Icons.article;
    }
  }

  void _copyLogToClipboard(LogRecord log) {
    final logText = '''
Time: ${log.time}
Level: ${log.level.name}
Logger: ${log.loggerName}
Message: ${log.message}
${log.error != null ? 'Error: ${log.error}\n' : ''}
${log.stackTrace != null ? 'Stack Trace: ${log.stackTrace}\n' : ''}
''';

    Clipboard.setData(ClipboardData(text: logText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Log copied to clipboard')),
    );
  }

  void _exportLogs(List<LogRecord> logs) {
    final allLogs = logs.map((log) => '''
[${log.time}] ${log.level.name}: ${log.message}
${log.error != null ? 'Error: ${log.error}\n' : ''}
${log.stackTrace != null ? 'Stack Trace: ${log.stackTrace}\n' : ''}
''').join('\n---\n');

    Clipboard.setData(ClipboardData(text: allLogs));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All logs exported to clipboard')),
    );
  }
}
