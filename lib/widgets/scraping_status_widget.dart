// lib/features/home/presentation/widgets/scraping_status_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trading_dashboard/models/scraping_models.dart';
import '../providers/scraping_provider.dart';
import '../screens/scraping_settings_screen.dart';

class ScrapingStatusWidget extends ConsumerWidget {
  const ScrapingStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrapingState = ref.watch(scrapingNotifierProvider);
    final status = scrapingState.queueStatus;

    if (status == null || !status.isActive) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                value: status.progressPercentage / 100,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Data Scraping in Progress',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${status.progressPercentage.toStringAsFixed(1)}% complete (${status.completed}/${status.total})',
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScrapingSettingsScreen(),
                  ),
                );
              },
              child: const Text('View'),
            ),
          ],
        ),
      ),
    );
  }
}
