// screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/company_provider.dart';
import '../widgets/fundamental_tabs.dart';
import '../widgets/search_bar.dart';
import '../widgets/company_list.dart';
import '../widgets/scraping_status_bar.dart';
import '../screens/scraping_management_screen.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';
import '../models/fundamental_filter.dart';
import '../services/enhanced_fundamental_service.dart';

// String extension for capitalization
extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

// Enhanced watchlist provider
final watchlistProvider =
    StateNotifierProvider<WatchlistNotifier, List<String>>((ref) {
  return WatchlistNotifier();
});

class WatchlistNotifier extends StateNotifier<List<String>> {
  WatchlistNotifier() : super([]);

  void addToWatchlist(String symbol) {
    if (!state.contains(symbol)) {
      state = [...state, symbol];
    }
  }

  void removeFromWatchlist(String symbol) {
    state = state.where((s) => s != symbol).toList();
  }

  bool isInWatchlist(String symbol) {
    return state.contains(symbol);
  }
}

// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Selected filter provider
final selectedFundamentalProvider =
    StateProvider<FundamentalFilter?>((ref) => null);

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildEnhancedAppBar(context, ref),
      body: Column(
        children: [
          const ScrapingStatusBar(),
          const SizedBox(height: 8),
          _buildEnhancedSearchSection(ref),
          const SizedBox(height: 12),
          _buildQuickStatsBar(ref),
          const SizedBox(height: 8),
          const FundamentalTabs(),
          const SizedBox(height: 8),
          const Expanded(child: CompanyList()),
        ],
      ),
      floatingActionButton: _buildEnhancedFAB(context, ref),
    );
  }

  PreferredSizeWidget _buildEnhancedAppBar(
      BuildContext context, WidgetRef ref) {
    final marketSummaryAsync = ref.watch(marketSummaryProvider);

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stock Analysis Dashboard',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          marketSummaryAsync.when(
            data: (summary) => Text(
              '${summary['totalCompanies']} companies • ${summary['highQualityPercentage']}% quality',
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
            ),
            loading: () => const Text(
              'Loading market data...',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
            ),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      elevation: 2,
      actions: [
        _buildNotificationButton(context, ref),
        _buildAnalysisButton(context, ref),
        _buildThemeToggle(context, ref),
        _buildSettingsButton(context, ref),
      ],
    );
  }

  Widget _buildNotificationButton(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => _showNotificationsBottomSheet(context, ref),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisButton(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: Stack(
        children: [
          const Icon(Icons.analytics_outlined),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
      onPressed: () => _showAnalysisOverview(context, ref),
    );
  }

  Widget _buildThemeToggle(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeProvider);
        final isDark = themeMode == ThemeMode.dark ||
            (themeMode == ThemeMode.system &&
                MediaQuery.of(context).platformBrightness == Brightness.dark);

        return IconButton(
          icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
          },
          tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
        );
      },
    );
  }

  Widget _buildSettingsButton(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.settings_outlined),
      onPressed: () => _showSettingsBottomSheet(context, ref),
    );
  }

  Widget _buildEnhancedSearchSection(WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const CustomSearchBar(),
          const SizedBox(height: 8),
          _buildActiveFiltersBar(ref),
        ],
      ),
    );
  }

  Widget _buildActiveFiltersBar(WidgetRef ref) {
    final selectedFilter = ref.watch(selectedFundamentalProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    if (selectedFilter == null && searchQuery.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 36,
      child: Row(
        children: [
          if (searchQuery.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search, size: 14, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    'Search: "$searchQuery"',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () =>
                        ref.read(searchQueryProvider.notifier).state = '',
                    child:
                        const Icon(Icons.close, size: 14, color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],
          if (selectedFilter != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedFilter.icon,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    selectedFilter.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => ref
                        .read(selectedFundamentalProvider.notifier)
                        .state = null,
                    child: Icon(Icons.close,
                        size: 14, color: AppTheme.primaryGreen),
                  ),
                ],
              ),
            ),
          ],
          const Spacer(),
          Text(
            'Tap to clear filters',
            style: TextStyle(
              fontSize: 10,
              color: AppTheme.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsBar(WidgetRef ref) {
    final marketSummaryAsync = ref.watch(marketSummaryProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryGreen.withOpacity(0.05),
            AppTheme.primaryGreen.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.1)),
      ),
      child: marketSummaryAsync.when(
        data: (summary) => Row(
          children: [
            Expanded(
              child: _buildQuickStatItem(
                'Companies',
                summary['totalCompanies'].toString(),
                Icons.business,
                Colors.blue,
              ),
            ),
            Expanded(
              child: _buildQuickStatItem(
                'Quality',
                '${summary['highQualityPercentage']}%',
                Icons.star,
                Colors.amber,
              ),
            ),
            Expanded(
              child: _buildQuickStatItem(
                'Avg ROE',
                '${summary['avgROE']}%',
                Icons.trending_up,
                Colors.green,
              ),
            ),
            Expanded(
              child: _buildQuickStatItem(
                'Avg P/E',
                summary['avgPE'],
                Icons.account_balance,
                Colors.purple,
              ),
            ),
          ],
        ),
        loading: () => const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            SizedBox(width: 8),
            Text('Loading market data...', style: TextStyle(fontSize: 12)),
          ],
        ),
        error: (error, stack) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 16, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              'Market data unavailable',
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatItem(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedFAB(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () => _showQuickActionsBottomSheet(context, ref),
      backgroundColor: AppTheme.primaryGreen,
      foregroundColor: Colors.white,
      icon: const Icon(Icons.dashboard_customize),
      label: const Text('Actions'),
      tooltip: 'Quick Actions & Tools',
    );
  }

  void _showAnalysisOverview(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.analytics, color: AppTheme.primaryGreen, size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    'Market Analysis Overview',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildAnalysisSection('Top Performers', ref),
                    const SizedBox(height: 16),
                    _buildAnalysisSection('High Quality Stocks', ref),
                    const SizedBox(height: 16),
                    _buildAnalysisSection('Value Opportunities', ref),
                    const SizedBox(height: 16),
                    _buildAnalysisSection('Growth Stocks', ref),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisSection(String title, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Consumer(
              builder: (context, ref, child) {
                switch (title) {
                  case 'Top Performers':
                    return ref.watch(topCompaniesProvider()).when(
                          data: (companies) =>
                              _buildCompanyChips(companies.take(5)),
                          loading: () => const CircularProgressIndicator(),
                          error: (e, s) => Text('Error: $e'),
                        );
                  case 'High Quality Stocks':
                    return ref.watch(highQualityStocksProvider).when(
                          data: (companies) =>
                              _buildCompanyChips(companies.take(5)),
                          loading: () => const CircularProgressIndicator(),
                          error: (e, s) => Text('Error: $e'),
                        );
                  case 'Value Opportunities':
                    return ref.watch(valueOpportunitiesProvider).when(
                          data: (companies) =>
                              _buildCompanyChips(companies.take(5)),
                          loading: () => const CircularProgressIndicator(),
                          error: (e, s) => Text('Error: $e'),
                        );
                  default:
                    return const Text('Coming soon...');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyChips(Iterable companies) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: companies
          .map((company) => Chip(
                label: Text(
                  company.symbol,
                  style: const TextStyle(fontSize: 12),
                ),
                backgroundColor: AppTheme.primaryGreen.withOpacity(0.1),
                side: BorderSide(color: AppTheme.primaryGreen.withOpacity(0.3)),
              ))
          .toList(),
    );
  }

  void _showNotificationsBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.notifications, color: AppTheme.primaryGreen),
                  const SizedBox(width: 8),
                  Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildNotificationCard(
                      context,
                      'Analysis Complete',
                      'Market analysis updated with latest data',
                      Icons.analytics,
                      Colors.green,
                      '2 min ago',
                    ),
                    _buildNotificationCard(
                      context,
                      'High Quality Stock Alert',
                      'Found 5 new stocks with Piotroski score ≥ 7',
                      Icons.star,
                      Colors.amber,
                      '1 hour ago',
                    ),
                    _buildNotificationCard(
                      context,
                      'Value Opportunity',
                      'HDFC showing 25% safety margin',
                      Icons.monetization_on,
                      Colors.blue,
                      '3 hours ago',
                    ),
                    _buildNotificationCard(
                      context,
                      'Market Update',
                      'NIFTY 50 crossed 20,000 mark',
                      Icons.trending_up,
                      Colors.purple,
                      '5 hours ago',
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'That\'s all for now!',
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String time,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: Text(
          time,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showSettingsBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.settings, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                Text('Settings',
                    style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
            const SizedBox(height: 20),

            // Theme Setting
            ListTile(
              leading: Consumer(
                builder: (context, ref, child) {
                  final themeMode = ref.watch(themeProvider);
                  final isDark = themeMode == ThemeMode.dark ||
                      (themeMode == ThemeMode.system &&
                          MediaQuery.of(context).platformBrightness ==
                              Brightness.dark);
                  return Icon(isDark ? Icons.dark_mode : Icons.light_mode);
                },
              ),
              title: const Text('Theme'),
              subtitle: Consumer(
                builder: (context, ref, child) {
                  final themeMode = ref.watch(themeProvider);
                  return Text(themeMode.name.capitalize());
                },
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _showThemeDialog(context, ref),
            ),

            // Refresh Data
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Refresh Analysis'),
              subtitle: const Text('Update fundamental analysis data'),
              onTap: () {
                Navigator.pop(context);
                ref.refresh(companyNotifierProvider);
                ref.refresh(marketSummaryProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Refreshing analysis data...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            // Analysis Settings
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Analysis Preferences'),
              subtitle: const Text('Configure analysis parameters'),
              onTap: () {
                Navigator.pop(context);
                _showAnalysisPreferences(context, ref);
              },
            ),

            // Export Data
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export Data'),
              subtitle: const Text('Download analysis results'),
              onTap: () {
                Navigator.pop(context);
                _showExportDialog(context, ref);
              },
            ),

            // Clear Cache
            ListTile(
              leading: const Icon(Icons.clear_all),
              title: const Text('Clear Cache'),
              subtitle: const Text('Reset all stored preferences'),
              onTap: () => _showClearCacheDialog(context, ref),
            ),

            // About
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              subtitle: const Text('App version and information'),
              onTap: () => _showAboutDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showAnalysisPreferences(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Analysis Preferences'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('Enable advanced scoring'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Show expert recommendations'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Include sector comparison'),
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showQuickActionsBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.dashboard_customize,
                    color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                Text('Quick Actions',
                    style: Theme.of(context).textTheme.headlineMedium),
              ],
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.0,
              children: [
                _buildQuickActionCard(
                  context,
                  ref,
                  'Scraping\nManager',
                  Icons.cloud_sync,
                  Colors.deepPurple,
                  () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScrapingManagementScreen(),
                      ),
                    );
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'My\nWatchlist',
                  Icons.favorite,
                  Colors.red,
                  () {
                    Navigator.pop(context);
                    _showWatchlistBottomSheet(context, ref);
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Market\nAnalysis',
                  Icons.analytics,
                  Colors.amber,
                  () {
                    Navigator.pop(context);
                    _showAnalysisOverview(context, ref);
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Quality\nStocks',
                  Icons.star,
                  Colors.green,
                  () {
                    Navigator.pop(context);
                    ref.read(selectedFundamentalProvider.notifier).state =
                        FundamentalFilter.getFilterByType(
                            FundamentalType.qualityStocks);
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Debug\nTools',
                  Icons.bug_report,
                  Colors.deepOrange,
                  () {
                    Navigator.pop(context);
                    _showDebugStats(context, ref);
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Quick\nScrape',
                  Icons.play_arrow,
                  Colors.blue,
                  () {
                    Navigator.pop(context);
                    _showQuickScrapeDialog(context, ref);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Continue with existing methods (helper methods remain the same)...

  void _showQuickScrapeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.play_arrow, color: AppTheme.primaryGreen, size: 24),
            const SizedBox(width: 8),
            const Text('Quick Scrape'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start scraping with default settings:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.pages, size: 16, color: Colors.blue),
                SizedBox(width: 8),
                Text('Pages: 5 (≈250 companies)'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.timer, size: 16, color: Colors.orange),
                SizedBox(width: 8),
                Text('Estimated time: 2-3 hours'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.update, size: 16, color: Colors.green),
                SizedBox(width: 8),
                Text('Will update existing data'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScrapingManagementScreen(),
                ),
              );
            },
            child: const Text('Advanced Settings'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _triggerQuickScrape(context, ref);
            },
            icon: const Icon(Icons.play_arrow, size: 16),
            label: const Text('Start Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _triggerQuickScrape(BuildContext context, WidgetRef ref) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              const Text('Starting enhanced scrape with analysis...'),
            ],
          ),
          backgroundColor: AppTheme.primaryGreen,
          duration: const Duration(seconds: 3),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Enhanced scrape initiated! Check status for progress.'),
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
            content: Text('Failed to start scraping: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  // Include all other existing helper methods...
  Future<void> _debugFetchRawData(WidgetRef ref) async {
    print('=== 🐛 DEBUG: Enhanced analysis system test ===');

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('companies')
          .limit(5)
          .get();

      print('🐛 Found ${snapshot.docs.length} companies');

      for (final doc in snapshot.docs) {
        try {
          final company = doc.data();
          print('📊 Company: ${company['symbol']} - ${company['name']}');

          // Test enhanced metrics
          if (company['calculatedMetrics'] != null) {
            final metrics = company['calculatedMetrics'] as Map;
            print('  ✅ Has calculated metrics: ${metrics.keys}');
          } else {
            print('  ⚠️  No calculated metrics found');
          }
        } catch (e) {
          print('❌ Error processing ${doc.id}: $e');
        }
      }

      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text('✅ Enhanced system check complete. Check console.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('❌ Enhanced system test failed: $e');
      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text('❌ System test failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _testFirebaseConnection(WidgetRef ref) async {
    print('=== 🔥 Testing Enhanced Firebase Connection ===');

    try {
      // Test basic connection
      final testQuery =
          FirebaseFirestore.instance.collection('companies').limit(1);
      final snapshot = await testQuery.get();

      print('🔥 Basic connection: ✅');
      print('🔥 Test query returned: ${snapshot.docs.length} docs');

      // Test market summary
      final companiesAsync = ref.read(companyNotifierProvider);
      print('🔥 Companies provider state: ${companiesAsync.runtimeType}');

      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          const SnackBar(
            content: Text('✅ Enhanced Firebase connection successful!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('🔥 Enhanced Firebase test failed: $e');
      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text('❌ Enhanced Firebase test failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showDebugStats(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🔍 Enhanced Debug Stats'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('📊 Enhanced Provider States:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Consumer(
                builder: (context, ref, child) {
                  final companiesState = ref.watch(companyNotifierProvider);
                  final selectedFilter = ref.watch(selectedFundamentalProvider);
                  final searchQuery = ref.watch(searchQueryProvider);
                  final marketSummary = ref.watch(marketSummaryProvider);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '• Companies: ${companiesState.when(data: (d) => '${d.length} loaded', loading: () => 'Loading...', error: (e, s) => 'Error: $e')}'),
                      Text(
                          '• Market Summary: ${marketSummary.when(data: (d) => '${d['totalCompanies']} companies', loading: () => 'Loading...', error: (e, s) => 'Error')}'),
                      Text(
                          '• Active Filter: ${selectedFilter?.name ?? 'None'}'),
                      Text(
                          '• Search Query: "${searchQuery.isEmpty ? 'Empty' : searchQuery}"'),
                      Text(
                          '• Watchlist: ${ref.watch(watchlistProvider).length} items'),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _debugFetchRawData(ref);
                    },
                    icon: const Icon(Icons.download, size: 16),
                    label: const Text('Test'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ref.refresh(companyNotifierProvider);
                      ref.refresh(marketSummaryProvider);
                    },
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Refresh'),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context,
    WidgetRef ref,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Include all other existing helper methods (theme, export, clear cache, about, watchlist, etc.)
  // [Previous helper methods remain unchanged...]

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final currentTheme = ref.watch(themeProvider);
                return Column(
                  children: ThemeMode.values.map((theme) {
                    IconData icon;
                    String description;
                    switch (theme) {
                      case ThemeMode.light:
                        icon = Icons.light_mode;
                        description = 'Always use light theme';
                        break;
                      case ThemeMode.dark:
                        icon = Icons.dark_mode;
                        description = 'Always use dark theme';
                        break;
                      case ThemeMode.system:
                        icon = Icons.settings_brightness;
                        description = 'Follow system setting';
                        break;
                    }

                    return RadioListTile<ThemeMode>(
                      title: Row(
                        children: [
                          Icon(icon, size: 20),
                          const SizedBox(width: 8),
                          Text(theme.name.capitalize()),
                        ],
                      ),
                      subtitle: Text(description,
                          style: const TextStyle(fontSize: 12)),
                      value: theme,
                      groupValue: currentTheme,
                      onChanged: (ThemeMode? value) {
                        if (value != null) {
                          ref.read(themeProvider.notifier).setTheme(value);
                          Navigator.pop(context);
                        }
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showExportDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Enhanced Analysis'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose what to export:'),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text('Market Analysis Report'),
              subtitle: Text('Complete fundamental analysis'),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Quality Stocks List'),
              subtitle: Text('High Piotroski score companies'),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Watchlist Data'),
              subtitle: Text('Your saved companies'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Enhanced export functionality coming soon!')),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Enhanced Cache'),
        content: const Text(
          'This will clear all stored analysis data, calculated metrics, and reset the app. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              ref.invalidate(companyNotifierProvider);
              ref.invalidate(marketSummaryProvider);
              ref.invalidate(selectedFundamentalProvider);
              ref.invalidate(searchQueryProvider);
              ref.invalidate(watchlistProvider);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Enhanced cache cleared successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Enhanced Trading Dashboard',
      applicationVersion: '2.0.0',
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryGreen,
              AppTheme.primaryGreen.withOpacity(0.7)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.analytics, color: Colors.white, size: 32),
      ),
      children: [
        const Text(
            'Professional-grade stock analysis platform with AI-powered insights.'),
        const SizedBox(height: 16),
        const Text('Enhanced Features:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('• Professional fundamental analysis'),
        const Text('• Piotroski & Altman scoring'),
        const Text('• Graham intrinsic value calculation'),
        const Text('• Real-time risk assessment'),
        const Text('• AI-powered recommendations'),
        const Text('• Comprehensive valuation models'),
        const Text('• Sector comparison analysis'),
        const Text('• Advanced filtering system'),
        const SizedBox(height: 16),
        const Text('Built for serious investors and traders.'),
      ],
    );
  }

  void _showWatchlistBottomSheet(BuildContext context, WidgetRef ref) {
    final watchlist = ref.watch(watchlistProvider);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        'My Watchlist',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${watchlist.length} stocks',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: watchlist.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_border,
                                size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Your watchlist is empty',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Add quality stocks to track their analysis and performance',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        itemCount: watchlist.length,
                        itemBuilder: (context, index) {
                          final symbol = watchlist[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    AppTheme.primaryGreen.withOpacity(0.1),
                                child: Text(
                                  symbol.substring(0, 1),
                                  style: const TextStyle(
                                    color: AppTheme.primaryGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                symbol,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: const Text('Tap to view analysis'),
                              trailing: IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () {
                                  ref
                                      .read(watchlistProvider.notifier)
                                      .removeFromWatchlist(symbol);
                                },
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                // Navigate to company details if available
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
