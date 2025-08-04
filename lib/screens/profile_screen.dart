import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_service.dart';
import '../services/database_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DatabaseService _databaseService = DatabaseService();
  Map<String, int> _stats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      final stats = await _databaseService.getCompanyStats();
      setState(() {
        _stats = stats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Theme Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appearance',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                themeService.isDarkMode
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Dark Mode',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              Switch(
                                value: themeService.isDarkMode,
                                onChanged: (value) {
                                  themeService.toggleTheme();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Statistics Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Statistics',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          _buildStatRow(
                            'Total Companies',
                            _stats['totalCompanies']?.toString() ?? '0',
                            Icons.business,
                          ),
                          _buildStatRow(
                            'Companies with Data',
                            _stats['companiesWithData']?.toString() ?? '0',
                            Icons.data_usage,
                          ),
                          _buildStatRow(
                            'Total Watchlists',
                            _stats['totalWatchlists']?.toString() ?? '0',
                            Icons.bookmark,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Actions Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Actions',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          ListTile(
                            leading: const Icon(Icons.refresh),
                            title: const Text('Refresh Statistics'),
                            onTap: _loadStats,
                            contentPadding: EdgeInsets.zero,
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete_sweep,
                                color: Colors.red),
                            title: const Text('Clear All Data'),
                            textColor: Colors.red,
                            onTap: _clearAllData,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // About Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Stock Screener App\nVersion 1.0.0\n\nA simple and efficient way to scrape, filter, and track stock market data.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _clearAllData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text(
          'This will delete all companies, watchlists, and saved filters. '
          'This action cannot be undone. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _databaseService.clearAllData();
        await _loadStats();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('All data cleared successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error clearing data: $e')),
        );
      }
    }
  }
}
