// screens/scraping_management_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/scraping_provider.dart';
import '../services/scraping_service.dart';
import '../theme/app_theme.dart';
import '../models/scraping_models.dart';

class ScrapingManagementScreen extends ConsumerStatefulWidget {
  const ScrapingManagementScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ScrapingManagementScreen> createState() =>
      _ScrapingManagementScreenState();
}

class _ScrapingManagementScreenState
    extends ConsumerState<ScrapingManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Scraping Management'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryGreen,
          unselectedLabelColor: AppTheme.getTextSecondary(context),
          indicatorColor: AppTheme.primaryGreen,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
            Tab(icon: Icon(Icons.settings), text: 'Controls'),
            Tab(icon: Icon(Icons.history), text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _OverviewTab(),
          _ControlsTab(),
          _HistoryTab(),
        ],
      ),
    );
  }
}

// Overview Tab
class _OverviewTab extends ConsumerWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrapingStatus = ref.watch(scrapingStatusProvider);
    final queueStatus = ref.watch(queueStatusProvider);
    final scrapingStats = ref.watch(scrapingStatsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Status Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Status',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  scrapingStatus.when(
                    data: (status) => _buildStatusOverview(context, status),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Text('Error: $error'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Queue Statistics
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Queue Statistics',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  queueStatus.when(
                    data: (queue) => _buildQueueStats(context, queue),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Text('Error: $error'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Performance Metrics
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Performance Metrics',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  scrapingStats.when(
                    data: (stats) => _buildPerformanceMetrics(context, stats),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Text('Error: $error'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusOverview(BuildContext context, ScrapingStatus status) {
    return Column(
      children: [
        // Progress indicator
        if (status.isActive) ...[
          CircularProgressIndicator(
            value: status.progress,
            backgroundColor: AppTheme.getBorderColor(context),
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppTheme.primaryGreen),
          ),
          const SizedBox(height: 16),
        ],

        // Status info
        _buildInfoRow('Status', status.statusMessage),
        if (status.totalCount > 0) ...[
          _buildInfoRow(
              'Progress', '${status.processedCount}/${status.totalCount}'),
          _buildInfoRow('Percentage', '${(status.progress * 100).toInt()}%'),
        ],
        if (status.estimatedTimeRemaining > 0)
          _buildInfoRow(
              'ETA',
              _formatDuration(
                  Duration(seconds: status.estimatedTimeRemaining))),
      ],
    );
  }

  Widget _buildQueueStats(BuildContext context, QueueStatus queue) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: _buildStatCard(
                    'Total', queue.total.toString(), Colors.blue)),
            const SizedBox(width: 8),
            Expanded(
                child: _buildStatCard(
                    'Pending', queue.pending.toString(), Colors.orange)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
                child: _buildStatCard('Completed', queue.completed.toString(),
                    AppTheme.profitGreen)),
            const SizedBox(width: 8),
            Expanded(
                child: _buildStatCard(
                    'Failed', queue.failed.toString(), AppTheme.lossRed)),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceMetrics(BuildContext context, ScrapingStats stats) {
    return Column(
      children: [
        _buildInfoRow('Success Rate', '${stats.successRate}%'),
        _buildInfoRow(
            'Health Status', stats.isHealthy ? 'Healthy' : 'Needs Attention'),
        _buildInfoRow(
            'Total Processed', stats.totalCompaniesProcessed.toString()),
        _buildInfoRow('Last Updated', _formatDateTime(stats.lastUpdated)),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
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

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }
}

// Controls Tab
class _ControlsTab extends ConsumerWidget {
  const _ControlsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Manual Scraping Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manual Scraping',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start a new scraping job with custom parameters',
                    style: TextStyle(color: AppTheme.getTextSecondary(context)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showManualScrapingDialog(context, ref),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Start Manual Scraping'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Queue Management Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Queue Management',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _retryFailedItems(context, ref),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry Failed'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.orange,
                            side: BorderSide(
                                color: Colors.orange.withOpacity(0.3)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _clearFailedItems(context, ref),
                          icon: const Icon(Icons.clear_all),
                          label: const Text('Clear Failed'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.lossRed,
                            side: BorderSide(
                                color: AppTheme.lossRed.withOpacity(0.3)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _stopScraping(context, ref),
                      icon: const Icon(Icons.stop),
                      label: const Text('Stop Current Scraping'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.lossRed,
                        side: BorderSide(
                            color: AppTheme.lossRed.withOpacity(0.3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // System Health Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'System Health',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _testConnection(context, ref),
                      icon: const Icon(Icons.network_check),
                      label: const Text('Test Connection'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryGreen,
                        side: BorderSide(
                            color: AppTheme.primaryGreen.withOpacity(0.3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Add all your existing action methods here...
  void _showManualScrapingDialog(BuildContext context, WidgetRef ref) {
    // Your existing manual scraping dialog code
  }

  Future<void> _retryFailedItems(BuildContext context, WidgetRef ref) async {
    // Your existing retry failed code
  }

  Future<void> _clearFailedItems(BuildContext context, WidgetRef ref) async {
    // Your existing clear failed code
  }

  Future<void> _stopScraping(BuildContext context, WidgetRef ref) async {
    // Your existing stop scraping code
  }

  Future<void> _testConnection(BuildContext context, WidgetRef ref) async {
    // Your existing test connection code
  }
}

// History Tab
class _HistoryTab extends ConsumerWidget {
  const _HistoryTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentCompleted = ref.watch(recentCompletedProvider);

    return recentCompleted.when(
      data: (items) => ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppTheme.profitGreen.withOpacity(0.1),
                child: Text(
                  item.symbol.isNotEmpty ? item.symbol[0] : '?',
                  style: const TextStyle(
                    color: AppTheme.profitGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(item.companyName),
              subtitle: Text('Symbol: ${item.symbol}'),
              trailing: Text(
                item.timeAgo,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.getTextSecondary(context),
                ),
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
