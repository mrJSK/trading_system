import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../theme/app_theme.dart';
import '../models/company_model.dart';
import '../models/filter_settings.dart';
import '../providers/company_provider.dart';
import '../widgets/fundamentals_filter_sheet.dart';
import '../providers/filter_provider.dart';
import '../theme/theme_provider.dart';
import '../widgets/stock_list_item.dart';
import '../widgets/search_bar.dart';
import '../widgets/stock_detail_screen.dart';
import '../widgets/app_drawer.dart';

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
    _tabController =
        TabController(length: 2, vsync: this); // Simplified to 2 tabs

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
      ref.read(companiesProvider.notifier).applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    final companiesState = ref.watch(companiesProvider);
    final filterSettings = ref.watch(filterSettingsProvider);
    final isDarkMode = ref.watch(themeModeProvider) == ThemeMode.dark;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Trading Dashboard'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          // Filter button
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.filter_list),
                if (filterSettings.hasActiveFilters())
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: _showFiltersSheet,
            tooltip: 'Filters',
          ),
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(companiesProvider.notifier).refreshCompanies();
            },
            tooltip: 'Refresh data',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchBarWidget(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  hintText: 'Search by symbol or company name...',
                ),
              ),

              // Simplified tab bar - only essential tabs
              TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                indicatorColor: Colors.white,
                tabs: const [
                  Tab(text: 'All Companies'),
                  Tab(text: 'Filtered'),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All companies tab
          SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () async {
              await ref.read(companiesProvider.notifier).refreshCompanies();
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              await ref.read(companiesProvider.notifier).loadMoreCompanies();
              _refreshController.loadComplete();
            },
            child: companiesState.when(
              data: (companies) => _StockListView(
                companies: companies,
                emptyMessage: _searchQuery.isEmpty
                    ? 'No companies available'
                    : 'No companies found for "$_searchQuery"',
              ),
              loading: () => const _LoadingView(),
              error: (error, stack) => _ErrorView(error: error.toString()),
            ),
          ),

          // Filtered companies tab (with active filters applied)
          SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () async {
              await ref.read(companiesProvider.notifier).applyFilters();
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              await ref.read(companiesProvider.notifier).loadMoreCompanies();
              _refreshController.loadComplete();
            },
            child: companiesState.when(
              data: (companies) => _StockListView(
                companies: companies,
                emptyMessage: 'No companies match current filters',
              ),
              loading: () => const _LoadingView(),
              error: (error, stack) => _ErrorView(error: error.toString()),
            ),
          ),
        ],
      ),
    );
  }
}

// SIMPLIFIED Stock List View - removed all connectivity logic
class _StockListView extends ConsumerWidget {
  final List<CompanyModel> companies;
  final String emptyMessage;

  const _StockListView({
    required this.companies,
    required this.emptyMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (companies.isEmpty) {
      return _buildEmptyState(context);
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Pull down to refresh or adjust your filters',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

// SIMPLE Loading View
class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading companies...'),
        ],
      ),
    );
  }
}

// SIMPLE Error View
class _ErrorView extends ConsumerWidget {
  final String error;

  const _ErrorView({required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            ElevatedButton.icon(
              onPressed: () =>
                  ref.read(companiesProvider.notifier).refreshCompanies(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
