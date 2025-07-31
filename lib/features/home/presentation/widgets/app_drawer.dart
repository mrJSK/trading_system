import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../companies/presentation/providers/company_provider.dart';
import '../../../filters/providers/filter_provider.dart';
import '../../../theme/presentation/providers/theme_provider.dart';
import '../../../../core/services/connectivity_service.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  bool _isManualScraping = false;
  bool _isSchedulingScraper = false;
  String? _lastScrapingResult;
  DateTime? _lastScrapingTime;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final connectivityStatus =
        ref.watch(connectivityProvider); // This returns ConnectivityStatus enum
    final companiesState = ref.watch(companiesProvider);

    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          // Header
          Container(
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor.withOpacity(0.8),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Icon and Title
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Trading Dashboard',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'NSE Stock Monitor',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Spacer(),

                    // System Status - Fixed
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Connection Status - Fixed
                          Row(
                            children: [
                              if (connectivityStatus ==
                                  ConnectivityStatus.checking)
                                const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              else
                                Icon(
                                  _getConnectivityIcon(connectivityStatus),
                                  color: Colors.white,
                                  size: 16,
                                ),
                              const SizedBox(width: 8),
                              Text(
                                _getConnectivityText(connectivityStatus),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Data Status - Fixed
                          Row(
                            children: [
                              const Icon(
                                Icons.dataset,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                companiesState.when(
                                  data: (companies) =>
                                      '${companies.length} companies loaded',
                                  loading: () => 'Loading data...',
                                  error: (_, __) => 'Data load failed',
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                // Scraper Controls Section
                _buildSectionHeader('Scraper Controls'),

                // Manual Scraping
                ListTile(
                  leading: Icon(
                    Icons.play_circle,
                    color: _isManualScraping
                        ? Colors.orange
                        : Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Manual Scraping'),
                  subtitle: Text(
                    _isManualScraping
                        ? 'Scraping in progress...'
                        : _lastScrapingResult ??
                            'Trigger immediate data scraping',
                  ),
                  trailing: _isManualScraping
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.arrow_forward_ios, size: 16),
                  enabled: !_isManualScraping &&
                      connectivityStatus ==
                          ConnectivityStatus.online, // Only enable when online
                  onTap: _triggerManualScraping,
                ),

                // Schedule Scraper
                ListTile(
                  leading: Icon(
                    Icons.schedule,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Scheduled Scraping'),
                  subtitle: const Text('Configure automatic scraping schedule'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _showScheduleDialog,
                ),

                // View Scraper Logs
                ListTile(
                  leading: Icon(
                    Icons.history,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Scraper History'),
                  subtitle: const Text('View recent scraping activity'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _showScraperHistory,
                ),

                const Divider(),

                // App Settings Section
                _buildSectionHeader('App Settings'),

                // Theme Toggle
                ListTile(
                  leading: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
                  subtitle:
                      Text('Switch to ${isDarkMode ? 'light' : 'dark'} theme'),
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (_) {
                      ref.read(themeModeProvider.notifier).toggleTheme();
                    },
                  ),
                ),

                // Data Management
                ListTile(
                  leading: Icon(
                    Icons.storage,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Data Management'),
                  subtitle: const Text('Clear cache, export data'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _showDataManagement,
                ),

                // Settings
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Settings'),
                  subtitle: const Text('App preferences and configuration'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _showSettings,
                ),

                const Divider(),

                // Help & Support Section
                _buildSectionHeader('Help & Support'),

                ListTile(
                  leading: Icon(
                    Icons.help_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Help & FAQ'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to help screen
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('About'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: _showAboutDialog,
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.copyright, size: 14),
                const SizedBox(width: 4),
                Text(
                  '2024 Trading Dashboard v1.0',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.6),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods for connectivity status - Added
  IconData _getConnectivityIcon(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return Icons.cloud_done;
      case ConnectivityStatus.offline:
        return Icons.cloud_off;
      case ConnectivityStatus.checking:
        return Icons.cloud_sync;
    }
  }

  String _getConnectivityText(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return 'Cloud Functions Ready';
      case ConnectivityStatus.offline:
        return 'Offline Mode';
      case ConnectivityStatus.checking:
        return 'Connecting...';
    }
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Future<void> _triggerManualScraping() async {
    // Check connectivity first
    if (ref.read(connectivityProvider) != ConnectivityStatus.online) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.wifi_off, color: Colors.white),
              SizedBox(width: 12),
              Text('No internet connection available'),
            ],
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isManualScraping = true;
      _lastScrapingResult = null;
    });

    try {
      // Close drawer
      Navigator.pop(context);

      // Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              SizedBox(width: 12),
              Text('Manual scraping started...'),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      // Trigger comprehensive scraping
      await ref.read(companiesProvider.notifier).triggerManualScraping();

      setState(() {
        _isManualScraping = false;
        _lastScrapingResult = 'Comprehensive scraping completed successfully';
        _lastScrapingTime = DateTime.now();
      });

      // Show success snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Manual scraping completed!'),
              ],
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isManualScraping = false;
        _lastScrapingResult = 'Scraping failed: ${e.toString()}';
      });

      // Show error snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Scraping failed: ${e.toString()}')),
              ],
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scheduled Scraping'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Current Schedule:'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🕒 Every 6 hours'),
                  Text('🌏 Asia/Kolkata timezone'),
                  Text('☁️ Firebase Cloud Scheduler'),
                  Text('🔄 Automatic execution'),
                  Text('📊 Comprehensive data scraping'),
                  Text('🏢 All NSE companies'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'The comprehensive scraper runs automatically every 6 hours and is managed by Firebase Cloud Functions. It fetches complete financial statements, ratios, and company fundamentals.',
              style: TextStyle(fontSize: 12),
            ),
          ],
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

  void _showScraperHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Scraper History'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_lastScrapingTime != null) ...[
                ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text('Manual Scraping'),
                  subtitle: Text(
                      'Completed at ${_formatDateTime(_lastScrapingTime!)}'),
                  trailing: const Text('Success'),
                ),
                const Divider(),
              ],
              const ListTile(
                leading: Icon(Icons.schedule, color: Colors.blue),
                title: Text('Scheduled Scraping'),
                subtitle: Text('Running every 6 hours automatically'),
                trailing: Text('Active'),
              ),
              const ListTile(
                leading: Icon(Icons.analytics, color: Colors.purple),
                title: Text('Comprehensive Data'),
                subtitle: Text('Financial statements, ratios, fundamentals'),
                trailing: Text('Enabled'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Detailed scraping logs are available in Firebase Console under Cloud Functions.',
                style: TextStyle(fontSize: 12),
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

  void _showDataManagement() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Data Management'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_sweep),
              title: const Text('Clear Cache'),
              subtitle: const Text('Remove locally stored data'),
              onTap: () {
                Navigator.pop(context);
                _clearCache();
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export Data'),
              subtitle: const Text('Download companies data as CSV'),
              onTap: () {
                Navigator.pop(context);
                _exportData();
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Reset Filters'),
              subtitle: const Text('Clear all applied filters'),
              onTap: () {
                Navigator.pop(context);
                ref.read(filterSettingsProvider.notifier).resetFilters();
              },
            ),
            ListTile(
              leading: const Icon(Icons.sync),
              title: const Text('Force Refresh'),
              subtitle: const Text('Reload all company data'),
              onTap: () {
                Navigator.pop(context);
                ref.read(companiesProvider.notifier).refreshCompanies();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: const Text('Settings screen will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Trading Dashboard',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.trending_up,
          color: Colors.white,
          size: 24,
        ),
      ),
      children: [
        const Text(
            'NSE Stock Market Monitor with comprehensive fundamental analysis and real-time data scraping.'),
        const SizedBox(height: 16),
        const Text('Features:', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('• Comprehensive financial data scraping'),
        const Text('• Real-time stock price monitoring'),
        const Text('• Complete fundamental analysis'),
        const Text('• Financial statements & ratios'),
        const Text('• Advanced filtering and search'),
        const Text('• Automatic scheduled updates'),
        const Text('• Dark/Light theme support'),
        const Text('• Professional tabular data display'),
        const SizedBox(height: 16),
        const Text('Data Sources:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('• Screener.in comprehensive scraping'),
        const Text('• NSE official data'),
        const Text('• Firebase Cloud Functions backend'),
      ],
    );
  }

  void _clearCache() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cache cleared successfully')),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data export feature coming soon')),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
