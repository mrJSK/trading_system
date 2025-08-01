// screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/company_provider.dart';
import '../widgets/fundamental_tabs.dart';
import '../widgets/search_bar.dart';
import '../widgets/company_list.dart';
import '../widgets/scraping_status_bar.dart';
import '../theme/app_theme.dart';
import '../providers/theme_provider.dart';
import '../providers/fundamental_provider.dart';
import '../models/fundamental_filter.dart'
    as fundamental; // Changed alias to 'fundamental'

// String extension for capitalization
extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stocks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showNotificationsBottomSheet(context, ref),
          ),
          Consumer(
            builder: (context, ref, child) {
              final themeMode = ref.watch(themeProvider);
              final isDark = themeMode == ThemeMode.dark ||
                  (themeMode == ThemeMode.system &&
                      MediaQuery.of(context).platformBrightness ==
                          Brightness.dark);

              return IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
                tooltip:
                    isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showSettingsBottomSheet(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          const ScrapingStatusBar(),
          const SizedBox(height: 8),
          const CustomSearchBar(),
          const SizedBox(height: 16),
          const FundamentalTabs(),
          const SizedBox(height: 16),
          const Expanded(child: CompanyList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showQuickActionsBottomSheet(context, ref),
        backgroundColor: AppTheme.primaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Quick Actions',
      ),
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
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Notifications',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildNotificationCard(
                      context,
                      'Data Update Complete',
                      'Latest financial data has been updated for all companies',
                      Icons.update,
                      Colors.green,
                      '5 min ago',
                    ),
                    _buildNotificationCard(
                      context,
                      'Market Alert',
                      'NIFTY 50 crossed 20,000 mark',
                      Icons.trending_up,
                      Colors.blue,
                      '1 hour ago',
                    ),
                    _buildNotificationCard(
                      context,
                      'Watchlist Update',
                      'RELIANCE is up 3.2% today',
                      Icons.favorite,
                      Colors.orange,
                      '2 hours ago',
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
          // Handle notification tap
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
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text('Settings', style: Theme.of(context).textTheme.headlineMedium),
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
              title: const Text('Refresh Data'),
              subtitle: const Text('Update company financial data'),
              onTap: () {
                Navigator.pop(context);
                ref.read(companiesProvider.notifier).refreshCompanies();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Refreshing company data...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            // Export Data
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export Data'),
              subtitle: const Text('Download watchlist and data'),
              onTap: () {
                Navigator.pop(context);
                _showExportDialog(context, ref);
              },
            ),

            // Clear Cache
            ListTile(
              leading: const Icon(Icons.clear_all),
              title: const Text('Clear Cache'),
              subtitle: const Text('Clear stored data and preferences'),
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
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text('Quick Actions',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),

            // Grid of quick actions
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildQuickActionCard(
                  context,
                  ref,
                  'Top Gainers',
                  Icons.trending_up,
                  Colors.green,
                  () {
                    Navigator.pop(context);
                    ref.read(companiesProvider.notifier).loadTopPerformers();
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Quality Stocks',
                  Icons.star,
                  Colors.blue,
                  () {
                    Navigator.pop(context);
                    ref.read(companiesProvider.notifier).loadQualityStocks();
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Debt Free',
                  Icons.shield,
                  Colors.purple,
                  () {
                    Navigator.pop(context);
                    // Fixed: Use 'fundamental' alias instead of 'filter'
                    final selectedFilter = fundamental
                        .FundamentalFilter.defaultFilters
                        .firstWhere((f) =>
                            f.type == fundamental.FundamentalType.debtFree);
                    ref.read(selectedFundamentalProvider.notifier).state =
                        selectedFilter;
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'High ROE',
                  Icons.grade,
                  Colors.orange,
                  () {
                    Navigator.pop(context);
                    // Fixed: Use 'fundamental' alias instead of 'filter'
                    final selectedFilter = fundamental
                        .FundamentalFilter.defaultFilters
                        .firstWhere((f) =>
                            f.type == fundamental.FundamentalType.highROE);
                    ref.read(selectedFundamentalProvider.notifier).state =
                        selectedFilter;
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Dividend',
                  Icons.account_balance_wallet,
                  Colors.teal,
                  () {
                    Navigator.pop(context);
                    // Fixed: Use 'fundamental' alias instead of 'filter'
                    final selectedFilter = fundamental
                        .FundamentalFilter.defaultFilters
                        .firstWhere((f) =>
                            f.type ==
                            fundamental.FundamentalType.dividendStocks);
                    ref.read(selectedFundamentalProvider.notifier).state =
                        selectedFilter;
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Watchlist',
                  Icons.favorite,
                  Colors.red,
                  () {
                    Navigator.pop(context);
                    _showWatchlistBottomSheet(context, ref);
                  },
                ),
              ],
            ),
          ],
        ),
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
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    Navigator.pop(context); // Close settings first
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
        title: const Text('Export Data'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose what to export:'),
            SizedBox(height: 16),
            // Add export options here
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
                    content: Text('Export functionality coming soon!')),
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
        title: const Text('Clear Cache'),
        content: const Text(
          'This will clear all stored data and reset the app to its default state. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Close settings
              // Clear all providers
              ref.invalidate(companiesProvider);
              ref.invalidate(selectedFundamentalProvider);
              ref.invalidate(searchQueryProvider);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Trading Dashboard',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.trending_up,
          color: Colors.white,
          size: 32,
        ),
      ),
      children: [
        const Text('A comprehensive stock analysis and tracking application.'),
        const SizedBox(height: 16),
        const Text('Features:'),
        const Text('• Real-time stock data'),
        const Text('• Fundamental analysis'),
        const Text('• Financial ratios'),
        const Text('• Watchlist management'),
        const Text('• Dark/Light theme'),
      ],
    );
  }

  void _showWatchlistBottomSheet(BuildContext context, WidgetRef ref) {
    final watchlist = ref.read(watchlistProvider);

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
              // Handle bar
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
                  Text(
                    'Watchlist',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    '${watchlist.length} stocks',
                    style: const TextStyle(color: Colors.grey),
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
                              'Add stocks to your watchlist by tapping the heart icon',
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
                              title: Text(symbol),
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
                                // Navigate to company details
                                Navigator.pop(context);
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
