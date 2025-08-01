// lib/features/home/presentation/screens/scraping_settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/scraping/scraping_models.dart';
import '../providers/scraping_provider.dart';

class ScrapingSettingsScreen extends ConsumerStatefulWidget {
  const ScrapingSettingsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ScrapingSettingsScreen> createState() =>
      _ScrapingSettingsScreenState();
}

class _ScrapingSettingsScreenState extends ConsumerState<ScrapingSettingsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _progressAnimationController, curve: Curves.easeInOut),
    );

    // Initialize with Riverpod ref instead of context.read
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(scrapingNotifierProvider.notifier).refreshStatus();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  Future<void> _startScraping() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const _AdvancedScrapingConfigDialog(),
    );

    if (result == null) return;

    try {
      // Use ref.read instead of context.read
      final message =
          await ref.read(scrapingNotifierProvider.notifier).startScraping(
                maxPages: result['maxPages'] ?? 50,
                clearExisting: result['clearExisting'] ?? true,
                customConfig: result['customConfig'] as Map<String, dynamic>?,
              );

      _progressAnimationController.forward();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'View Progress',
              onPressed: () => _tabController.animateTo(1),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the provider state using ref.watch instead of Consumer
    final scrapingState = ref.watch(scrapingNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Data Scraping'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
            Tab(icon: Icon(Icons.analytics), text: 'Progress'),
            Tab(icon: Icon(Icons.settings), text: 'Management'),
            Tab(icon: Icon(Icons.history), text: 'Events'),
          ],
        ),
        actions: [
          // Health indicator
          Container(
            margin: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 8,
              backgroundColor: _getHealthColor(scrapingState),
            ),
          ),
          // Real-time toggle
          IconButton(
            icon:
                Icon(scrapingState.showDetails ? Icons.live_tv : Icons.tv_off),
            onPressed: () =>
                ref.read(scrapingNotifierProvider.notifier).toggleDetails(),
            tooltip: 'Toggle Real-time Updates',
          ),
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(scrapingNotifierProvider.notifier).refreshStatus(),
            tooltip: 'Force Refresh',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(scrapingState),
          _buildProgressTab(scrapingState),
          _buildManagementTab(scrapingState),
          _buildEventsTab(scrapingState),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(scrapingState),
    );
  }

  Color _getHealthColor(ScrapingState state) {
    if (state.queueStatus?.isActive ?? false) return Colors.orange;
    if (state.error != null) return Colors.red;
    return Colors.green;
  }

  Widget _buildOverviewTab(ScrapingState state) {
    return RefreshIndicator(
      onRefresh: () async =>
          ref.read(scrapingNotifierProvider.notifier).refreshStatus(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainStatusCard(state),
            const SizedBox(height: 16),
            _buildHealthStatusCard(state),
            const SizedBox(height: 16),
            _buildQuickStatsCard(state),
            const SizedBox(height: 16),
            _buildRecentActivityCard(state),
          ],
        ),
      ),
    );
  }

  Widget _buildMainStatusCard(ScrapingState state) {
    final status = state.queueStatus;

    return Card(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[50]!,
              Colors.blue[100]!,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Scraping Status',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Chip(
                    label: Text(
                      status?.statusText ?? 'Unknown',
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: _getStatusChipColor(state),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (status != null) ...[
                // Animated progress bar
                AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: (status.progressPercentage / 100) *
                          _progressAnimation.value,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        status.isCompleted ? Colors.green : Colors.blue,
                      ),
                      minHeight: 8,
                    );
                  },
                ),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${status.progressPercentage.toStringAsFixed(1)}% Complete',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      '${status.completed} / ${status.total}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Status indicators
                Row(
                  children: [
                    Expanded(
                      child: _buildStatusIndicator(
                        'Pending',
                        status.pending,
                        Colors.orange,
                        Icons.schedule,
                      ),
                    ),
                    Expanded(
                      child: _buildStatusIndicator(
                        'Processing',
                        status.processing,
                        Colors.blue,
                        Icons.sync,
                      ),
                    ),
                    Expanded(
                      child: _buildStatusIndicator(
                        'Completed',
                        status.completed,
                        Colors.green,
                        Icons.check_circle,
                      ),
                    ),
                    Expanded(
                      child: _buildStatusIndicator(
                        'Failed',
                        status.failed,
                        Colors.red,
                        Icons.error,
                      ),
                    ),
                  ],
                ),

                if (status.estimatedTimeRemaining != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'ETA: ${status.estimatedTimeRemaining}',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ] else if (state.isLoading) ...[
                const Center(child: CircularProgressIndicator()),
              ] else if (state.error != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[300]!),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(child: Text(state.error!)),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => ref
                            .read(scrapingNotifierProvider.notifier)
                            .clearError(),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusChipColor(ScrapingState state) {
    if (state.queueStatus?.isActive ?? false) return Colors.blue[100]!;
    if (state.queueStatus?.isCompleted ?? false) return Colors.green[100]!;
    if (state.error != null) return Colors.red[100]!;
    return Colors.grey[100]!;
  }

  Widget _buildStatusIndicator(
      String label, int count, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(height: 4),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildHealthStatusCard(ScrapingState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  state.error == null ? Icons.favorite : Icons.warning,
                  color: state.error == null ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 8),
                Text(
                  'System Health',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(state.error ?? 'System running normally'),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatsCard(ScrapingState state) {
    final status = state.queueStatus;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Stats',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickStat(
                  'Total Jobs',
                  '${status?.total ?? 0}',
                  Icons.work,
                ),
                _buildQuickStat(
                  'Success Rate',
                  status != null && status.total > 0
                      ? '${((status.completed / status.total) * 100).toStringAsFixed(1)}%'
                      : '0%',
                  Icons.trending_up,
                ),
                _buildQuickStat(
                  'Active',
                  status?.isActive == true ? 'Yes' : 'No',
                  Icons.power,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 24, color: Colors.blue),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildRecentActivityCard(ScrapingState state) {
    final recentCompanies = state.queueStatus?.recentCompleted ?? [];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            if (recentCompanies.isNotEmpty) ...[
              ...recentCompanies.take(3).map((company) => ListTile(
                    leading: CircleAvatar(
                      child: Text(
                          company.symbol.isNotEmpty ? company.symbol[0] : '?'),
                      backgroundColor: Colors.green,
                    ),
                    title: Text(company.symbol),
                    subtitle: Text(company.companyName),
                    trailing: Text(company.timeAgo),
                  )),
            ] else ...[
              const Center(
                child: Text(
                  'No recent activity',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTab(ScrapingState state) {
    return const Center(
      child: Text('Progress Tab - Implementation needed'),
    );
  }

  Widget _buildManagementTab(ScrapingState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (state.queueStatus?.failed != null &&
                          state.queueStatus!.failed > 0)
                        ElevatedButton.icon(
                          onPressed: () => _executeAction(() => ref
                              .read(scrapingNotifierProvider.notifier)
                              .retryFailed()),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Retry Failed'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsTab(ScrapingState state) {
    return const Center(
      child: Text('Events Tab - Implementation needed'),
    );
  }

  Widget? _buildFloatingActionButton(ScrapingState state) {
    if (state.queueStatus?.isActive == true) return null;

    return FloatingActionButton.extended(
      onPressed: state.isLoading ? null : _startScraping,
      icon: state.isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Icon(Icons.play_arrow),
      label: Text(state.isLoading ? 'Starting...' : 'Start Scraping'),
    );
  }

  Future<void> _executeAction(Future<String> Function() action) async {
    try {
      final message = await action();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
}

class _AdvancedScrapingConfigDialog extends StatefulWidget {
  const _AdvancedScrapingConfigDialog({Key? key}) : super(key: key);

  @override
  State<_AdvancedScrapingConfigDialog> createState() =>
      _AdvancedScrapingConfigDialogState();
}

class _AdvancedScrapingConfigDialogState
    extends State<_AdvancedScrapingConfigDialog> {
  int _maxPages = 50;
  bool _clearExisting = true;
  bool _enableNotifications = true;
  bool _prioritizeUpdates = false;
  String _concurrencyLevel = 'normal';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Advanced Scraping Configuration'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Configure comprehensive data scraping with ${_maxPages * 40} companies over 3-4 hours.'),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Pages: '),
                Expanded(
                  child: Slider(
                    value: _maxPages.toDouble(),
                    min: 5,
                    max: 100,
                    divisions: 19,
                    label: '$_maxPages pages (~${_maxPages * 40} companies)',
                    onChanged: (value) {
                      setState(() {
                        _maxPages = value.toInt();
                      });
                    },
                  ),
                ),
              ],
            ),
            CheckboxListTile(
              title: const Text('Clear existing queue'),
              subtitle: const Text('Remove pending items from previous runs'),
              value: _clearExisting,
              onChanged: (value) {
                setState(() {
                  _clearExisting = value ?? true;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Enable notifications'),
              subtitle: const Text('Receive progress updates'),
              value: _enableNotifications,
              onChanged: (value) {
                setState(() {
                  _enableNotifications = value ?? true;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Prioritize recent updates'),
              subtitle: const Text('Process recently updated companies first'),
              value: _prioritizeUpdates,
              onChanged: (value) {
                setState(() {
                  _prioritizeUpdates = value ?? false;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: _concurrencyLevel,
              decoration: const InputDecoration(
                labelText: 'Processing Speed',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'low', child: Text('Low (Safer)')),
                DropdownMenuItem(value: 'normal', child: Text('Normal')),
                DropdownMenuItem(value: 'high', child: Text('High (Faster)')),
              ],
              onChanged: (value) {
                setState(() {
                  _concurrencyLevel = value ?? 'normal';
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop({
            'maxPages': _maxPages,
            'clearExisting': _clearExisting,
            'customConfig': {
              'enable_notifications': _enableNotifications,
              'prioritize_updates': _prioritizeUpdates,
              'concurrency_level': _concurrencyLevel,
            },
          }),
          child: const Text('Start Advanced Scraping'),
        ),
      ],
    );
  }
}
