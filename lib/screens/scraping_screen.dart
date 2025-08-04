// lib/screens/scraping/scraping_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/scraping_provider.dart';
import '../../theme/app_theme.dart';
import '../../models/scraping_models.dart';

class ScrapingScreen extends ConsumerWidget {
  const ScrapingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrapingState = ref.watch(scrapingStateProvider);
    final scrapingStatus = ref.watch(scrapingStatusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Scraping'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(scrapingStatusProvider);
              ref.invalidate(queueStatusProvider);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(scrapingStatusProvider);
          ref.invalidate(queueStatusProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Overview Card
              _buildStatusCard(context, ref, scrapingStatus),
              const SizedBox(height: 16),

              // Quick Actions
              _buildQuickActions(context, ref, scrapingState),
              const SizedBox(height: 16),

              // Queue Details
              _buildQueueDetails(context, ref),
              const SizedBox(height: 16),

              // Recent Activity
              _buildRecentActivity(context, ref),
              const SizedBox(height: 16),

              // Statistics
              _buildStatistics(context, ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, WidgetRef ref,
      AsyncValue<ScrapingStatus> scrapingStatus) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: scrapingStatus.when(
          data: (status) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildStatusIcon(
                      context, status), // Fixed: Added context parameter
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getStatusTitle(status),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          status.statusMessage,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.getTextSecondary(context),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (status.isActive) ...[
                const SizedBox(height: 16),
                _buildProgressBar(context, status),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${status.processedCount}/${status.totalCount} completed',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${(status.progress * 100).toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          loading: () => const Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading status...'),
            ],
          ),
          error: (error, stack) => Column(
            children: [
              Icon(
                Icons.error_outline,
                color: AppTheme.lossRed,
                size: 48,
              ),
              const SizedBox(height: 8),
              Text(
                'Error loading status',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.getTextSecondary(context),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(BuildContext context, ScrapingStatus status) {
    // Fixed: Added context parameter
    IconData icon;
    Color color;

    if (status.isActive) {
      icon = Icons.cloud_sync;
      color = AppTheme.infoBlue;
    } else if (status.isCompleted) {
      if (status.hasErrors) {
        icon = Icons.warning;
        color = AppTheme.warningOrange;
      } else {
        icon = Icons.check_circle;
        color = AppTheme.successGreen;
      }
    } else {
      icon = Icons.cloud_off;
      color = AppTheme.getTextSecondary(context);
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, ScrapingStatus status) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: status.progress,
          backgroundColor: AppTheme.getBorderColor(context),
          valueColor: AlwaysStoppedAnimation<Color>(
            status.hasErrors ? AppTheme.warningOrange : AppTheme.primaryGreen,
          ),
        ),
        if (status.estimatedTimeRemaining > 0) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.schedule,
                size: 16,
                color: AppTheme.getTextSecondary(context),
              ),
              const SizedBox(width: 4),
              Text(
                'ETA: ${_formatDuration(Duration(seconds: status.estimatedTimeRemaining))}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.getTextSecondary(context),
                    ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildQuickActions(
      BuildContext context, WidgetRef ref, ScrapingState state) {
    final isActive = state.scrapingStatus?.isActive ?? false;
    final isLoading = state.isTriggering;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildActionButton(
                  context: context,
                  label: isActive ? 'Stop Scraping' : 'Start Scraping',
                  icon: isActive ? Icons.stop : Icons.play_arrow,
                  color: isActive ? AppTheme.lossRed : AppTheme.primaryGreen,
                  isLoading: isLoading,
                  onPressed: isLoading
                      ? null
                      : () async {
                          if (isActive) {
                            await _stopScraping(ref);
                          } else {
                            await _showStartScrapingDialog(context, ref);
                          }
                        },
                ),
                _buildActionButton(
                  context: context,
                  label: 'Retry Failed',
                  icon: Icons.refresh,
                  color: AppTheme.warningOrange,
                  onPressed: () => _retryFailed(ref),
                ),
                _buildActionButton(
                  context: context,
                  label: 'Clear Failed',
                  icon: Icons.clear_all,
                  color: AppTheme.getTextSecondary(context),
                  onPressed: () => _clearFailed(ref),
                ),
                _buildActionButton(
                  context: context,
                  label: 'Test Connection',
                  icon: Icons.network_check,
                  color: AppTheme.infoBlue,
                  onPressed: () => _testConnection(ref),
                ),
              ],
            ),

            // Error Display
            if (state.error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.lossRed.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppTheme.lossRed.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: AppTheme.lossRed,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.error!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.lossRed,
                            ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      iconSize: 20,
                      onPressed: () =>
                          ref.read(scrapingStateProvider.notifier).clearError(),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    bool isLoading = false,
    VoidCallback? onPressed,
  }) {
    return SizedBox(
      height: 40,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(icon, size: 18),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: color.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }

  Widget _buildQueueDetails(BuildContext context, WidgetRef ref) {
    final queueStatus = ref.watch(queueStatusProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Queue Status',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            queueStatus.when(
              data: (queue) => Column(
                children: [
                  _buildQueueMetric(context, 'Total', queue.total, Icons.queue),
                  const SizedBox(height: 12),
                  _buildQueueMetric(
                      context, 'Pending', queue.pending, Icons.hourglass_empty,
                      color: AppTheme.warningOrange),
                  const SizedBox(height: 12),
                  _buildQueueMetric(
                      context, 'Processing', queue.processing, Icons.sync,
                      color: AppTheme.infoBlue),
                  const SizedBox(height: 12),
                  _buildQueueMetric(
                      context, 'Completed', queue.completed, Icons.check_circle,
                      color: AppTheme.successGreen),
                  const SizedBox(height: 12),
                  _buildQueueMetric(
                      context, 'Failed', queue.failed, Icons.error,
                      color: AppTheme.lossRed),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Error loading queue status',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.getTextSecondary(context),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueMetric(
      BuildContext context, String label, int value, IconData icon,
      {Color? color}) {
    final metricColor = color ?? AppTheme.getTextSecondary(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: metricColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: metricColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: metricColor,
              ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context, WidgetRef ref) {
    final recentCompleted = ref.watch(recentCompletedProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            recentCompleted.when(
              data: (items) => items.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Icon(
                              Icons.history,
                              size: 48,
                              color: AppTheme.getTextSecondary(context),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No recent activity',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppTheme.getTextSecondary(context),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: items
                          .take(5)
                          .map((item) => _buildActivityItem(context, item))
                          .toList(),
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Error loading recent activity',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.getTextSecondary(context),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, RecentCompletedItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.successGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              Icons.check,
              color: AppTheme.successGreen,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.symbol,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  item.companyName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.getTextSecondary(context),
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
            item.timeAgo,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.getTextSecondary(context),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics(BuildContext context, WidgetRef ref) {
    final scrapingStats = ref.watch(scrapingStatsProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistics',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 16),
            scrapingStats.when(
              data: (stats) => Column(
                children: [
                  _buildStatItem(context, 'Total Processed',
                      stats.totalCompaniesProcessed.toString()),
                  const SizedBox(height: 12),
                  _buildStatItem(
                      context, 'Success Rate', '${stats.successRate}%'),
                  const SizedBox(height: 12),
                  _buildStatItem(context, 'System Health', stats.healthStatus),
                  const SizedBox(height: 12),
                  _buildStatItem(context, 'Last Updated',
                      _formatDateTime(stats.lastUpdated)),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Error loading statistics',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.getTextSecondary(context),
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  // Helper Methods
  String _getStatusTitle(ScrapingStatus status) {
    if (status.isActive) return 'Scraping Active';
    if (status.isCompleted && !status.hasErrors) return 'Scraping Complete';
    if (status.isCompleted && status.hasErrors) return 'Completed with Issues';
    return 'Scraping Idle';
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';

    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  // Action Methods
  Future<void> _showStartScrapingDialog(
      BuildContext context, WidgetRef ref) async {
    int maxPages = 100;
    bool clearExisting = true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Start Scraping'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Max Pages',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => maxPages = int.tryParse(value) ?? 100,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Clear existing data'),
                value: clearExisting,
                onChanged: (value) =>
                    setState(() => clearExisting = value ?? true),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );

    if (result == true) {
      await ref.read(scrapingStateProvider.notifier).triggerScraping(
            maxPages: maxPages,
            clearExisting: clearExisting,
          );
    }
  }

  Future<void> _stopScraping(WidgetRef ref) async {
    await ref.read(scrapingStateProvider.notifier).stopScraping();
  }

  Future<void> _retryFailed(WidgetRef ref) async {
    await ref.read(scrapingStateProvider.notifier).retryFailed();
  }

  Future<void> _clearFailed(WidgetRef ref) async {
    await ref.read(scrapingStateProvider.notifier).clearFailed();
  }

  Future<void> _testConnection(WidgetRef ref) async {
    await ref.read(scrapingStateProvider.notifier).testConnection();
  }
}
