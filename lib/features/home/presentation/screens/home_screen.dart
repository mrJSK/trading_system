import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../models/company/company_model.dart';
import '../../../../models/company/filter_settings.dart';
import '../../../companies/presentation/providers/company_provider.dart';
import '../../../filters/presentation/widgets/fundamentals_filter_sheet.dart';
import '../../../filters/providers/filter_provider.dart';
import '../../../theme/presentation/providers/theme_provider.dart';
import '../widgets/market_summary_card.dart';
import '../widgets/stock_list_item.dart';
import '../widgets/search_bar.dart';
import '../widgets/status_indicator.dart';
import '../widgets/stock_detail_screen.dart';
import '../widgets/app_drawer.dart';
import 'scraping_settings_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final RefreshController _refreshController = RefreshController();
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Changed to 4 tabs

    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(companiesProvider.notifier).loadInitialCompanies();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _refreshController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    try {
      // Force check connectivity first
      await ref.read(connectivityProvider.notifier).forceCheck();

      // Then refresh company data
      await ref.read(companiesProvider.notifier).refreshCompanies();
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Refresh failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _onSearchChanged(String query) {
    setState(() => _searchQuery = query);
    ref.read(companiesProvider.notifier).searchCompanies(query);
  }

  void _showFiltersSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FundamentalsFilterSheet(),
    ).then((_) {
      // Refresh data when filters change
      ref.read(companiesProvider.notifier).applyFilters();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    final companiesState = ref.watch(companiesProvider);
    final filterSettings = ref.watch(filterSettingsProvider);
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;
    final connectivityStatus =
        ref.watch(connectivityProvider); // This returns ConnectivityStatus

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Trading Dashboard'),
            const SizedBox(width: 12),
            // Enhanced Status Indicator - Fixed
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color:
                    _getConnectivityColor(connectivityStatus).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getConnectivityColor(connectivityStatus),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (connectivityStatus == ConnectivityStatus.checking)
                    const SizedBox(
                      width: 12,
                      height: 12,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else
                    Icon(
                      _getConnectivityIcon(connectivityStatus),
                      size: 12,
                      color: _getConnectivityColor(connectivityStatus),
                    ),
                  const SizedBox(width: 4),
                  Text(
                    _getConnectivityText(connectivityStatus),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getConnectivityColor(connectivityStatus),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          // Connectivity refresh button - Fixed
          IconButton(
            icon: Icon(
              _getConnectivityIcon(connectivityStatus),
              color: _getConnectivityColor(connectivityStatus),
            ),
            onPressed: () async {
              await ref.read(connectivityProvider.notifier).forceCheck();
              if (mounted) {
                final status = ref.read(connectivityProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_getConnectivityMessage(status)),
                    backgroundColor: _getConnectivityColor(status),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            tooltip: 'Check connection',
          ),
          // ... rest of your actions
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(140),
          child: Column(
            children: [
              // Connection status banner (if offline) - Fixed
              if (connectivityStatus == ConnectivityStatus.offline)
                Container(
                  width: double.infinity,
                  color: Colors.red.withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off, color: Colors.red, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'No internet connection - Showing cached data',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                  ),
                )
              else if (connectivityStatus == ConnectivityStatus.checking)
                Container(
                  width: double.infinity,
                  color: Colors.orange.withOpacity(0.1),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Checking connection...',
                        style: TextStyle(color: Colors.orange, fontSize: 12),
                      ),
                    ],
                  ),
                ),

              // Search bar - Fixed
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchBarWidget(
                  // Changed from CustomSearchBar
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  hintText: 'Search by symbol or company name...',
                ),
              ),

              // Tab bar with 4 tabs
              TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(text: 'All Stocks'),
                  Tab(text: 'Gainers'),
                  Tab(text: 'Losers'),
                  Tab(text: 'Watchlist'),
                ],
              ),
            ],
          ),
        ),
      ),
      // ... rest of your body code

      // Enhanced Floating Action Button - Fixed
      floatingActionButton: connectivityStatus == ConnectivityStatus.online
          ? FloatingActionButton.extended(
              onPressed: _showQuickScrapingDialog,
              icon: const Icon(Icons.sync),
              label: const Text('Quick Sync'),
              tooltip: 'Trigger manual scraping',
              backgroundColor: Theme.of(context).primaryColor,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

// Helper methods for connectivity status
  Color _getConnectivityColor(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return Colors.green;
      case ConnectivityStatus.offline:
        return Colors.red;
      case ConnectivityStatus.checking:
        return Colors.orange;
    }
  }

  IconData _getConnectivityIcon(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return Icons.wifi;
      case ConnectivityStatus.offline:
        return Icons.wifi_off;
      case ConnectivityStatus.checking:
        return Icons.sync;
    }
  }

  String _getConnectivityText(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return 'Online';
      case ConnectivityStatus.offline:
        return 'Offline';
      case ConnectivityStatus.checking:
        return 'Checking...';
    }
  }

  String _getConnectivityMessage(ConnectivityStatus status) {
    switch (status) {
      case ConnectivityStatus.online:
        return 'Connected to internet';
      case ConnectivityStatus.offline:
        return 'No internet connection';
      case ConnectivityStatus.checking:
        return 'Checking connection...';
    }
  }

  void _showQuickScrapingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.sync, color: Theme.of(context).primaryColor),
            const SizedBox(width: 8),
            const Text('Quick Data Sync'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('This will trigger immediate comprehensive data scraping:'),
            SizedBox(height: 12),
            Text('📊 Latest stock prices'),
            Text('📈 Company fundamentals'),
            Text('📋 Financial statements'),
            Text('📰 Market announcements'),
            Text('🏭 Industry data'),
            SizedBox(height: 12),
            Text(
              'Note: This may take 2-5 minutes to complete all companies.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              _triggerQuickScraping();
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start Sync'),
          ),
        ],
      ),
    );
  }

  void _triggerQuickScraping() async {
    try {
      // Show loading indicator
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
              Text('Triggering comprehensive data sync...'),
            ],
          ),
          duration: Duration(seconds: 3),
        ),
      );

      // Trigger comprehensive scraping via Firebase Functions
      await ref.read(companiesProvider.notifier).triggerManualScraping();

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Text('Comprehensive data sync initiated successfully!'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Sync failed: $e')),
              ],
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }
}

class _StockListView extends ConsumerWidget {
  final List<CompanyModel> companies;
  final String emptyMessage;
  final bool isLoading;
  final String? error;

  const _StockListView({
    required this.companies,
    required this.emptyMessage,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatus = ref.watch(connectivityProvider);

    if (isLoading && companies.isEmpty) {
      return _buildLoadingState(context);
    }

    if (error != null && companies.isEmpty) {
      return _buildErrorState(context, ref, error!);
    }

    if (companies.isEmpty) {
      return _buildEmptyState(context, connectivityStatus as AsyncValue<bool>);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: companies.length,
      itemBuilder: (context, index) {
        final company = companies[index];
        return StockListItem(
          company: company,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => StockDetailScreen(company: company),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading comprehensive market data...'),
          SizedBox(height: 8),
          Text(
            'Fetching latest fundamentals and prices',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading data',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () =>
                      ref.read(companiesProvider.notifier).refreshCompanies(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () =>
                      ref.read(connectivityProvider.notifier).forceCheck(),
                  icon: const Icon(Icons.wifi),
                  label: const Text('Check Connection'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(
      BuildContext context, AsyncValue<bool> connectivityStatus) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              connectivityStatus.when(
                data: (isConnected) =>
                    !isConnected ? Icons.cloud_off : Icons.inbox,
                loading: () => Icons.sync,
                error: (_, __) => Icons.error,
              ),
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              connectivityStatus.when(
                data: (isConnected) => !isConnected
                    ? 'No internet connection available'
                    : 'Pull down to refresh or check your data source',
                loading: () => 'Checking connection...',
                error: (_, __) => 'Connection error occurred',
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            connectivityStatus.when(
              data: (isConnected) => !isConnected
                  ? Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Some cached data may still be available in other tabs',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
