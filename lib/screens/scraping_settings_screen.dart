// lib/features/home/presentation/screens/scraping_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/scraping_provider.dart';

class ScrapingSettingsScreen extends ConsumerWidget {
  const ScrapingSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrapingState = ref.watch(scrapingNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Management'),
        // REMOVED: Refresh button since we don't check status anymore
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simple job card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Job Management',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    if (scrapingState.isLoading) ...[
                      const Row(
                        children: [
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 12),
                          Text('Starting job...'),
                        ],
                      ),
                    ] else if (scrapingState.error != null) ...[
                      Row(
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(child: Text(scrapingState.error!)),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => ref
                                .read(scrapingNotifierProvider.notifier)
                                .clearError(),
                          ),
                        ],
                      ),
                    ] else ...[
                      const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Ready to start jobs',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Tap the button below to start a data collection job.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // FCM Notification info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Push Notifications',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    const ListTile(
                      leading:
                          Icon(Icons.notifications_active, color: Colors.green),
                      title: Text('Job Completion Notifications'),
                      subtitle: Text(
                          'You will receive push notifications when jobs complete or fail'),
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info, color: Colors.blue, size: 16),
                              SizedBox(width: 8),
                              Text(
                                'How it works:',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text('• Start a job using the button below'),
                          Text('• Job runs in the background on cloud servers'),
                          Text(
                              '• You receive a push notification when complete'),
                          Text('• No need to keep the app open!'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Simple start job button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: scrapingState.isLoading
            ? null
            : () => _startSimpleJob(context, ref),
        icon: scrapingState.isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.play_arrow),
        label: Text(scrapingState.isLoading ? 'Starting...' : 'Start Data Job'),
      ),
    );
  }

  void _startSimpleJob(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.play_arrow, color: Colors.blue),
            SizedBox(width: 8),
            Text('Start Data Collection Job'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'This will start a comprehensive data collection job that includes:'),
            SizedBox(height: 12),
            Text('📊 Latest stock prices'),
            Text('📈 Company fundamentals'),
            Text('📋 Financial statements'),
            Text('📰 Market announcements'),
            SizedBox(height: 12),
            Text(
              'You will receive a push notification when the job completes or fails.',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Estimated time: 2-5 minutes for ~1,200 companies',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _executeStartJob(context, ref);
            },
            icon: const Icon(Icons.rocket_launch),
            label: const Text('Start Job'),
          ),
        ],
      ),
    );
  }

  void _executeStartJob(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(scrapingNotifierProvider.notifier).startScraping(
            maxPages: 50, // Simple default
          );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.rocket_launch, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Job started successfully! You will receive a push notification when it completes.',
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Failed to start job: $e')),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }
}
