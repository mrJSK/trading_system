// screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/company_provider.dart';
import '../widgets/fundamental_tabs.dart';
import '../widgets/search_bar.dart';
import '../widgets/company_list.dart';
import '../widgets/scraping_status_bar.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';
import '../providers/fundamental_provider.dart';

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
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: [
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
                _buildQuickActionCard(
                  context,
                  ref,
                  'Debug Raw',
                  Icons.bug_report,
                  Colors.deepOrange,
                  () {
                    Navigator.pop(context);
                    _debugFetchRawData(ref);
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Test Firebase',
                  Icons.cloud,
                  Colors.indigo,
                  () {
                    Navigator.pop(context);
                    _testFirebaseConnection(ref);
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Show Stats',
                  Icons.analytics,
                  Colors.amber,
                  () {
                    Navigator.pop(context);
                    _showDebugStats(context, ref);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _debugFetchRawData(WidgetRef ref) async {
    print('=== 🐛 DEBUG: Starting raw companies fetch ===');

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('companies')
          .limit(10)
          .get();

      print('🐛 DEBUG: Query executed successfully');
      print('🐛 DEBUG: Found ${snapshot.docs.length} documents');
      print('🐛 DEBUG: Collection exists: ${snapshot.docs.isNotEmpty}');

      if (snapshot.docs.isEmpty) {
        print('🐛 DEBUG: ❌ No documents found in companies collection');
        print('🐛 DEBUG: Check if collection name is correct and has data');
        return;
      }

      for (int i = 0; i < snapshot.docs.length; i++) {
        final doc = snapshot.docs[i];
        print('--- Document ${i + 1} ---');
        print('📄 Document ID: ${doc.id}');
        print('📄 Document exists: ${doc.exists}');

        try {
          final rawData = doc.data();
          print('📊 Raw data keys: ${rawData.keys.toList()}');

          print('🔍 Fields check:');
          print(
              '  - name: ${rawData['name']} (${rawData['name'].runtimeType})');
          print(
              '  - symbol: ${rawData['symbol']} (${rawData['symbol'].runtimeType})');
          print(
              '  - marketCap: ${rawData['marketCap']} (${rawData['marketCap'].runtimeType})');
          print(
              '  - currentPrice: ${rawData['currentPrice']} (${rawData['currentPrice'].runtimeType})');
          print(
              '  - lastUpdated: ${rawData['lastUpdated']} (${rawData['lastUpdated'].runtimeType})');
          print(
              '  - changePercent: ${rawData['changePercent']} (${rawData['changePercent'].runtimeType})');

          print('🔍 Boolean fields:');
          print(
              '  - isDebtFree: ${rawData['isDebtFree']} (${rawData['isDebtFree'].runtimeType})');
          print(
              '  - isProfitable: ${rawData['isProfitable']} (${rawData['isProfitable'].runtimeType})');
          print(
              '  - paysDividends: ${rawData['paysDividends']} (${rawData['paysDividends'].runtimeType})');
        } catch (e) {
          print('❌ Error reading document data: $e');
        }
        print('');
      }

      print('=== ✅ DEBUG: Raw fetch completed successfully ===');

      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text(
                '✅ Debug: Found ${snapshot.docs.length} companies. Check console for details.'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (error) {
      print('🐛 DEBUG: ❌ Error fetching raw companies: $error');
      print('🐛 DEBUG: Error type: ${error.runtimeType}');

      if (error.toString().contains('permission')) {
        print('🐛 DEBUG: ⚠️  This looks like a permissions issue');
        print('🐛 DEBUG: Check your Firestore security rules');
      }

      if (error.toString().contains('network')) {
        print('🐛 DEBUG: ⚠️  This looks like a network issue');
        print('🐛 DEBUG: Check your internet connection and Firebase config');
      }

      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content:
                Text('❌ Debug failed: ${error.toString().substring(0, 50)}...'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  Future<void> _testFirebaseConnection(WidgetRef ref) async {
    print('=== 🔥 DEBUG: Testing Firebase Connection ===');

    try {
      final testQuery =
          FirebaseFirestore.instance.collection('companies').limit(1);

      final snapshot = await testQuery.get();

      print('🔥 DEBUG: ✅ Firebase connection working');
      print('🔥 DEBUG: Can access Firestore instance');
      print('🔥 DEBUG: Test query returned ${snapshot.docs.length} docs');

      print('🔥 DEBUG: Snapshot metadata:');
      print('  - fromCache: ${snapshot.metadata.isFromCache}');
      print('  - hasPendingWrites: ${snapshot.metadata.hasPendingWrites}');

      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          const SnackBar(
            content: Text('✅ Firebase connection successful!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('🔥 DEBUG: ❌ Firebase connection failed: $error');

      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text(
                '❌ Firebase error: ${error.toString().substring(0, 50)}...'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  void _showDebugStats(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🔍 Debug Statistics'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('📊 Provider States:',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Consumer(
                builder: (context, ref, child) {
                  final companiesState = ref.watch(companiesProvider);
                  final selectedFilter = ref.watch(selectedFundamentalProvider);
                  final searchQuery = ref.watch(searchQueryProvider);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '• Companies Provider: ${companiesState.when(data: (d) => '${d.length} companies', loading: () => 'Loading...', error: (e, s) => 'Error')}'),
                      Text(
                          '• Selected Filter: ${selectedFilter?.type.name ?? 'None'}'),
                      Text(
                          '• Search Query: "${searchQuery.isEmpty ? 'Empty' : searchQuery}"'),
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
                    label: const Text('Fetch Raw'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ref
                          .read(companiesProvider.notifier)
                          .loadInitialCompanies();
                    },
                    icon: const Icon(Icons.refresh, size: 16),
                    label: const Text('Reload'),
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
            Icon(icon, color: color, size: 36),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

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
        title: const Text('Export Data'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose what to export:'),
            SizedBox(height: 16),
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
              Navigator.pop(context);
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
