import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/scraping_service.dart';

class ScrapingSettingsScreen extends ConsumerStatefulWidget {
  const ScrapingSettingsScreen({super.key});

  @override
  ConsumerState<ScrapingSettingsScreen> createState() =>
      _ScrapingSettingsScreenState();
}

class _ScrapingSettingsScreenState
    extends ConsumerState<ScrapingSettingsScreen> {
  bool _isTriggering = false;

  @override
  Widget build(BuildContext context) {
    final scrapingPrefs = ref.watch(scrapingPreferencesProvider);
    final scrapingNotifier = ref.read(scrapingPreferencesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scraping Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Manual Trigger Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manual Scraping',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Trigger data scraping immediately',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isTriggering
                          ? null
                          : () => _triggerManualScraping(scrapingNotifier),
                      icon: _isTriggering
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.play_arrow),
                      label: Text(_isTriggering
                          ? 'Triggering...'
                          : 'Start Scraping Now'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  if (scrapingPrefs.lastManualTrigger != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Last manual trigger: ${_formatDateTime(scrapingPrefs.lastManualTrigger!)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Automatic Scraping Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Automatic Scraping',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Auto scraping toggle
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Enable Auto Scraping'),
                    subtitle: const Text(
                        'Automatically scrape data based on schedule'),
                    value: scrapingPrefs.isAutoScrapingEnabled,
                    onChanged: (value) =>
                        scrapingNotifier.updateAutoScrapingEnabled(value),
                  ),

                  if (scrapingPrefs.isAutoScrapingEnabled) ...[
                    const Divider(),

                    // Time picker
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.access_time),
                      title: const Text('Scheduled Time'),
                      subtitle:
                          Text(scrapingPrefs.scheduledTime.format(context)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _selectTime(context, scrapingNotifier),
                    ),

                    const Divider(),

                    // Daily toggle
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Daily Scraping'),
                      subtitle: const Text('Run every day at scheduled time'),
                      value: scrapingPrefs.isDailyEnabled,
                      onChanged: (value) =>
                          scrapingNotifier.updateDailyEnabled(value),
                    ),

                    if (!scrapingPrefs.isDailyEnabled) ...[
                      const Divider(),
                      // Day selection
                      const Text('Select Days:'),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: List.generate(7, (index) {
                          final dayNumber = index + 1;
                          final dayNames = [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun'
                          ];
                          final isSelected =
                              scrapingPrefs.selectedDays.contains(dayNumber);

                          return FilterChip(
                            label: Text(dayNames[index]),
                            selected: isSelected,
                            onSelected: (selected) {
                              final newDays =
                                  List<int>.from(scrapingPrefs.selectedDays);
                              if (selected) {
                                newDays.add(dayNumber);
                              } else {
                                newDays.remove(dayNumber);
                              }
                              scrapingNotifier.updateSelectedDays(newDays);
                            },
                          );
                        }),
                      ),
                    ],

                    if (scrapingPrefs.lastAutoTrigger != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Last auto trigger: ${_formatDateTime(scrapingPrefs.lastAutoTrigger!)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Data Storage Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.cloud, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      Text(
                        'Data Storage',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                      'All scraped data is automatically stored in Firebase Firestore and synced to your app in real-time.'),
                  const SizedBox(height: 8),
                  const Text(
                      '• Company fundamentals\n• Stock prices\n• Market announcements\n• RSS feed updates'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _triggerManualScraping(
      ScrapingPreferencesNotifier notifier) async {
    setState(() {
      _isTriggering = true;
    });

    try {
      await notifier.triggerManualScraping();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Manual scraping triggered successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to trigger scraping: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isTriggering = false;
        });
      }
    }
  }

  Future<void> _selectTime(
      BuildContext context, ScrapingPreferencesNotifier notifier) async {
    final scrapingPrefs = ref.read(scrapingPreferencesProvider);

    final time = await showTimePicker(
      context: context,
      initialTime: scrapingPrefs.scheduledTime,
    );

    if (time != null) {
      await notifier.updateScheduledTime(time);
    }
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scraping Help'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Manual Scraping:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  '• Triggers immediate data collection from NSE sources\n• Use when you need fresh data right away\n'),
              Text('Automatic Scraping:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  '• Runs in the background at scheduled times\n• Collects data even when app is closed\n• Best for regular data updates\n'),
              Text('Data Storage:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                  '• All data is stored in Firebase Firestore\n• Available offline once downloaded\n• Syncs automatically when online'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
