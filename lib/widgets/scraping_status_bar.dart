// widgets/scraping_status_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/scraping_models.dart';
import '../providers/scraping_provider.dart';
import '../services/scraping_service.dart';
import '../theme/app_theme.dart';

class ScrapingStatusBar extends ConsumerWidget {
  const ScrapingStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrapingStatus = ref.watch(scrapingStatusProvider);
    final queueStatus = ref.watch(queueStatusProvider);

    return scrapingStatus.when(
      data: (status) => _buildStatusBar(context, ref, status),
      loading: () => _buildLoadingBar(context),
      error: (error, stack) => _buildErrorBar(context, ref, error.toString()),
    );
  }

  Widget _buildStatusBar(
      BuildContext context, WidgetRef ref, ScrapingStatus status) {
    if (status.isActive) {
      return _buildActiveStatusBar(context, ref, status);
    } else if (status.hasErrors) {
      return _buildErrorStatusBar(context, ref, status);
    } else if (status.isCompleted && status.processedCount > 0) {
      return _buildCompletedStatusBar(context, ref, status);
    } else {
      return _buildIdleStatusBar(context, ref);
    }
  }

  Widget _buildActiveStatusBar(
      BuildContext context, WidgetRef ref, ScrapingStatus status) {
    final progress = status.totalCount > 0
        ? (status.processedCount / status.totalCount).clamp(0.0, 1.0)
        : 0.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // Progress row
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  value: progress > 0 ? progress : null,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryGreen),
                  backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      status.statusMessage.isNotEmpty
                          ? status.statusMessage
                          : 'Updating financial data...',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.getTextPrimary(context),
                      ),
                    ),
                    if (status.totalCount > 0) ...[
                      const SizedBox(height: 2),
                      Text(
                        '${status.processedCount}/${status.totalCount} companies processed',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.getTextSecondary(context),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ),
                  if (status.estimatedTimeRemaining > 0) ...[
                    const SizedBox(height: 4),
                    Text(
                      'ETA: ${_formatDuration(Duration(seconds: status.estimatedTimeRemaining))}',
                      style: TextStyle(
                        fontSize: 10,
                        color: AppTheme.getTextSecondary(context),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),

          // Progress bar
          if (status.totalCount > 0) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: AppTheme.getBorderColor(context),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
                minHeight: 6,
              ),
            ),
          ],

          // Action buttons
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _refreshStatus(ref),
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Refresh'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.getTextSecondary(context),
                    side: BorderSide(color: AppTheme.getBorderColor(context)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showStopScrapingDialog(context, ref),
                  icon: const Icon(Icons.stop, size: 16),
                  label: const Text('Stop'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.lossRed,
                    side: BorderSide(color: AppTheme.lossRed.withOpacity(0.3)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildErrorStatusBar(
      BuildContext context, WidgetRef ref, ScrapingStatus status) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lossRed.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.lossRed.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppTheme.lossRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.error_outline,
                    color: AppTheme.lossRed, size: 16),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scraping Issues Detected',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.getTextPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${status.failedCount} items failed to process',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.getTextSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.lossRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${status.failedCount}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lossRed,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _retryFailedItems(context, ref),
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Retry Failed'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.orange,
                    side: BorderSide(color: Colors.orange.withOpacity(0.3)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _clearFailedItems(context, ref),
                  icon: const Icon(Icons.clear_all, size: 16),
                  label: const Text('Clear Failed'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.lossRed,
                    side: BorderSide(color: AppTheme.lossRed.withOpacity(0.3)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedStatusBar(
      BuildContext context, WidgetRef ref, ScrapingStatus status) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.profitGreen.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.profitGreen.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.profitGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.check_circle_outline,
                color: AppTheme.profitGreen, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Update Completed',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${status.processedCount} companies successfully updated',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _dismissCompletedStatus(ref),
            icon: Icon(
              Icons.close,
              size: 18,
              color: AppTheme.getTextSecondary(context),
            ),
            style: IconButton.styleFrom(
              minimumSize: const Size(32, 32),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdleStatusBar(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.getBorderColor(context)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.getBorderColor(context).withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.cloud_off_outlined,
              color: AppTheme.getTextSecondary(context),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Data Scraping Idle',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Ready to update financial data',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _showManualScrapingDialog(context, ref),
            icon: const Icon(Icons.play_arrow, size: 16),
            label: const Text('Start'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.getCardBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.getBorderColor(context)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Loading scraping status...',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.getTextSecondary(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorBar(BuildContext context, WidgetRef ref, String error) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lossRed.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.lossRed.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppTheme.lossRed, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Connection Error',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextPrimary(context),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Failed to load scraping status',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.getTextSecondary(context),
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () => _refreshStatus(ref),
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('Retry'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.lossRed,
              side: BorderSide(color: AppTheme.lossRed.withOpacity(0.3)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          ),
        ],
      ),
    );
  }

  // All your existing action methods remain the same...
  void _refreshStatus(WidgetRef ref) {
    ref.invalidate(scrapingStatusProvider);
    ref.invalidate(queueStatusProvider);
  }

  void _showStopScrapingDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Stop Scraping'),
        content: const Text(
          'Are you sure you want to stop the current scraping process? '
          'This will pause data updates and can be resumed later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppTheme.getTextSecondary(context)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _stopScraping(context, ref);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lossRed,
              foregroundColor: Colors.white,
            ),
            child: const Text('Stop'),
          ),
        ],
      ),
    );
  }

  // Keep all your existing action methods (unchanged)...
  Future<void> _stopScraping(BuildContext context, WidgetRef ref) async {
    try {
      final scrapingService = ScrapingService();
      await scrapingService.stopScraping();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Scraping stopped successfully'),
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to stop scraping: ${e.toString()}'),
          backgroundColor: AppTheme.lossRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _retryFailedItems(BuildContext context, WidgetRef ref) async {
    try {
      final scrapingService = ScrapingService();
      await scrapingService.retryFailed();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Retrying failed items...'),
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );

      _refreshStatus(ref);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to retry: ${e.toString()}'),
          backgroundColor: AppTheme.lossRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _clearFailedItems(BuildContext context, WidgetRef ref) async {
    try {
      final scrapingService = ScrapingService();
      await scrapingService.clearFailed();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed items cleared'),
          backgroundColor: AppTheme.profitGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );

      _refreshStatus(ref);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to clear: ${e.toString()}'),
          backgroundColor: AppTheme.lossRed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showManualScrapingDialog(BuildContext context, WidgetRef ref) {
    int selectedPages = 10;
    bool clearExisting = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.cloud_download, color: AppTheme.primaryGreen),
              SizedBox(width: 8),
              Text('Start Data Scraping'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Configure scraping parameters:'),
              const SizedBox(height: 16),
              Text('Pages to scrape: $selectedPages'),
              Slider(
                value: selectedPages.toDouble(),
                min: 1,
                max: 50,
                divisions: 49,
                label: selectedPages.toString(),
                activeColor: AppTheme.primaryGreen,
                onChanged: (value) {
                  setState(() {
                    selectedPages = value.round();
                  });
                },
              ),
              Text(
                'Estimated companies: ${(selectedPages * 50).toString()}',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.getTextSecondary(context),
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Clear existing queue'),
                subtitle: const Text('Remove pending and failed items'),
                value: clearExisting,
                activeColor: AppTheme.primaryGreen,
                onChanged: (value) {
                  setState(() {
                    clearExisting = value ?? true;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: AppTheme.getTextSecondary(context)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _triggerManualScraping(
                    context, ref, selectedPages, clearExisting);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Start Scraping'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _triggerManualScraping(
    BuildContext context,
    WidgetRef ref,
    int maxPages,
    bool clearExisting,
  ) async {
    try {
      final scrapingService = ScrapingService();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Text('Starting scraper ($maxPages pages)...'),
            ],
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: AppTheme.primaryGreen,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );

      final result = await scrapingService.startScraping(
        maxPages: maxPages,
        clearExisting: clearExisting,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text('✅ $result')),
            ],
          ),
          backgroundColor: AppTheme.profitGreen,
          duration: const Duration(seconds: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );

      _refreshStatus(ref);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text('❌ Failed: ${error.toString()}')),
            ],
          ),
          backgroundColor: AppTheme.lossRed,
          duration: const Duration(seconds: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _dismissCompletedStatus(WidgetRef ref) {
    ref.invalidate(scrapingStatusProvider);
  }

  String _formatDuration(Duration duration) {
    if (duration.inMinutes < 1) {
      return '${duration.inSeconds}s';
    } else if (duration.inHours < 1) {
      return '${duration.inMinutes}m';
    } else {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    }
  }
}
