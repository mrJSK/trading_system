// widgets/scraping_status_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/scraping_provider.dart';
import '../theme/app_theme.dart';

class ScrapingStatusBar extends ConsumerWidget {
  const ScrapingStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrapingStatus = ref.watch(scrapingStatusProvider);

    return scrapingStatus.when(
      data: (status) {
        if (!status.isActive) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Updating data... ${status.processedCount}/${status.totalCount} companies',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
              Text(
                '${((status.processedCount / status.totalCount) * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
