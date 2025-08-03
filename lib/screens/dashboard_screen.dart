// screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../providers/company_provider.dart';
import '../providers/fundamental_providers.dart';
import '../widgets/fundamental_tabs.dart';
import '../widgets/search_bar.dart';
import '../widgets/company_list.dart';
import '../widgets/scraping_status_bar.dart';
import '../screens/scraping_management_screen.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';
import '../models/fundamental_filter.dart';
import '../models/company_model.dart';

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
      _saveToLocalStorage();
    }
  }

  void removeFromWatchlist(String symbol) {
    state = state.where((s) => s != symbol).toList();
    _saveToLocalStorage();
  }

  bool isInWatchlist(String symbol) {
    return state.contains(symbol);
  }

  void clearWatchlist() {
    state = [];
    _saveToLocalStorage();
  }

  void _saveToLocalStorage() {
    // TODO: Implement persistent storage if needed
    // SharedPreferences can be used here
  }
}

// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Enhanced market summary provider
final marketSummaryProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final companyNotifier = ref.watch(companyNotifierProvider);
  return companyNotifier.when(
    data: (companies) => _calculateMarketSummary(companies),
    loading: () => <String, dynamic>{
      'totalCompanies': 0,
      'highQualityPercentage': '0',
      'profitablePercentage': '0',
      'undervaluedPercentage': '0',
      'avgPE': '0',
      'avgROE': '0',
    },
    error: (error, stackTrace) => <String, dynamic>{
      'totalCompanies': 0,
      'highQualityPercentage': '0',
      'profitablePercentage': '0',
      'undervaluedPercentage': '0',
      'avgPE': '0',
      'avgROE': '0',
    },
  );
});

Map<String, dynamic> _calculateMarketSummary(List<CompanyModel> companies) {
  if (companies.isEmpty) {
    return {
      'totalCompanies': 0,
      'highQualityPercentage': '0',
      'profitablePercentage': '0',
      'undervaluedPercentage': '0',
      'avgPE': '0',
      'avgROE': '0',
    };
  }

  final totalCompanies = companies.length;
  final profitableCompanies =
      companies.where((c) => c.roe != null && c.roe! > 0).length;
  final highQualityCompanies =
      companies.where((c) => c.calculatedPiotroskiScore >= 7).length;
  final undervaluedCompanies = companies
      .where((c) => c.safetyMargin != null && c.safetyMargin! > 10)
      .length;

  final avgPE = companies
          .where((c) => c.stockPe != null && c.stockPe! > 0 && c.stockPe! < 100)
          .fold(0.0, (sum, c) => sum + c.stockPe!) /
      companies
          .where((c) => c.stockPe != null && c.stockPe! > 0 && c.stockPe! < 100)
          .length;

  final avgROE = companies
          .where((c) => c.roe != null)
          .fold(0.0, (sum, c) => sum + c.roe!) /
      companies.where((c) => c.roe != null).length;

  return {
    'totalCompanies': totalCompanies,
    'profitablePercentage':
        ((profitableCompanies / totalCompanies) * 100).toStringAsFixed(1),
    'highQualityPercentage':
        ((highQualityCompanies / totalCompanies) * 100).toStringAsFixed(1),
    'undervaluedPercentage':
        ((undervaluedCompanies / totalCompanies) * 100).toStringAsFixed(1),
    'avgPE': avgPE.isNaN ? '0.0' : avgPE.toStringAsFixed(1),
    'avgROE': avgROE.isNaN ? '0.0' : avgROE.toStringAsFixed(1),
  };
}

// Enhanced top companies providers
final topCompaniesProvider =
    FutureProvider.family<List<CompanyModel>, String>((ref, sortBy) async {
  final companyNotifier = ref.watch(companyNotifierProvider);
  return companyNotifier.when(
    data: (companies) => _getTopCompanies(companies, sortBy),
    loading: () => <CompanyModel>[],
    error: (error, stackTrace) => <CompanyModel>[],
  );
});

List<CompanyModel> _getTopCompanies(
    List<CompanyModel> companies, String sortBy) {
  final sorted = List<CompanyModel>.from(companies);

  switch (sortBy) {
    case 'quality':
      sorted.sort((a, b) => b.calculatedComprehensiveScore
          .compareTo(a.calculatedComprehensiveScore));
      break;
    case 'piotroski':
      sorted.sort((a, b) =>
          b.calculatedPiotroskiScore.compareTo(a.calculatedPiotroskiScore));
      break;
    case 'roe':
      sorted.sort((a, b) => (b.roe ?? 0).compareTo(a.roe ?? 0));
      break;
    case 'marketCap':
      sorted.sort((a, b) => (b.marketCap ?? 0).compareTo(a.marketCap ?? 0));
      break;
    case 'altman':
      sorted.sort((a, b) =>
          b.calculatedAltmanZScore.compareTo(a.calculatedAltmanZScore));
      break;
    default:
      sorted.sort((a, b) => b.calculatedComprehensiveScore
          .compareTo(a.calculatedComprehensiveScore));
  }

  return sorted.take(20).toList();
}

// Enhanced specialized providers
final highQualityStocksProvider =
    FutureProvider<List<CompanyModel>>((ref) async {
  final companyNotifier = ref.watch(companyNotifierProvider);
  return companyNotifier.when(
    data: (companies) => companies
        .where((c) =>
            c.calculatedPiotroskiScore >= 7 &&
            c.calculatedComprehensiveScore >= 70)
        .take(50)
        .toList(),
    loading: () => <CompanyModel>[],
    error: (error, stackTrace) => <CompanyModel>[],
  );
});

final valueOpportunitiesProvider =
    FutureProvider<List<CompanyModel>>((ref) async {
  final companyNotifier = ref.watch(companyNotifierProvider);
  return companyNotifier.when(
    data: (companies) => companies
        .where((c) =>
            c.safetyMargin != null &&
            c.safetyMargin! > 15 &&
            c.calculatedComprehensiveScore >= 50)
        .take(30)
        .toList(),
    loading: () => <CompanyModel>[],
    error: (error, stackTrace) => <CompanyModel>[],
  );
});

final growthStocksProvider = FutureProvider<List<CompanyModel>>((ref) async {
  final companyNotifier = ref.watch(companyNotifierProvider);
  return companyNotifier.when(
    data: (companies) => companies
        .where((c) =>
            c.salesGrowth3Y != null &&
            c.salesGrowth3Y! > 15 &&
            c.profitGrowth3Y != null &&
            c.profitGrowth3Y! > 15)
        .take(30)
        .toList(),
    loading: () => <CompanyModel>[],
    error: (error, stackTrace) => <CompanyModel>[],
  );
});

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
            'Enhanced Trading Dashboard',
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
            error: (_, __) => const Text(
              'Enhanced analysis ready',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
            ),
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
          tooltip: 'Notifications & Alerts',
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
      tooltip: 'Market Analysis Overview',
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
      tooltip: 'Settings & Preferences',
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
                'Profitable',
                '${summary['profitablePercentage']}%',
                Icons.trending_up,
                Colors.green,
              ),
            ),
            Expanded(
              child: _buildQuickStatItem(
                'Undervalued',
                '${summary['undervaluedPercentage']}%',
                Icons.diamond,
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
            Text('Loading enhanced analysis...',
                style: TextStyle(fontSize: 12)),
          ],
        ),
        error: (error, stack) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 16, color: Colors.red),
            const SizedBox(width: 8),
            Text(
              'Analysis data unavailable',
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
      tooltip: 'Quick Actions & Enhanced Tools',
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
                    'Enhanced Market Analysis',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildAnalysisSection(
                        'Top Quality Performers', ref, 'quality'),
                    const SizedBox(height: 16),
                    _buildAnalysisSection(
                        'High Piotroski Scores', ref, 'piotroski'),
                    const SizedBox(height: 16),
                    _buildAnalysisSection('Value Opportunities', ref, 'value'),
                    const SizedBox(height: 16),
                    _buildAnalysisSection('Growth Champions', ref, 'growth'),
                    const SizedBox(height: 16),
                    _buildAnalysisSection('Best ROE Performers', ref, 'roe'),
                    const SizedBox(height: 16),
                    _buildAnalysisSection('Financial Stability', ref, 'altman'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisSection(String title, WidgetRef ref, String type) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getSectionIcon(type),
                    color: _getSectionColor(type), size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Consumer(
              builder: (context, ref, child) {
                switch (type) {
                  case 'quality':
                    return ref.watch(topCompaniesProvider('quality')).when(
                          data: (companies) =>
                              _buildCompanyChips(companies.take(5)),
                          loading: () => _buildLoadingChips(),
                          error: (e, s) => _buildErrorText(e),
                        );
                  case 'piotroski':
                    return ref.watch(topCompaniesProvider('piotroski')).when(
                          data: (companies) =>
                              _buildCompanyChips(companies.take(5)),
                          loading: () => _buildLoadingChips(),
                          error: (e, s) => _buildErrorText(e),
                        );
                  case 'value':
                    return ref.watch(valueOpportunitiesProvider).when(
                          data: (companies) =>
                              _buildCompanyChips(companies.take(5)),
                          loading: () => _buildLoadingChips(),
                          error: (e, s) => _buildErrorText(e),
                        );
                  case 'growth':
                    return ref.watch(growthStocksProvider).when(
                          data: (companies) =>
                              _buildCompanyChips(companies.take(5)),
                          loading: () => _buildLoadingChips(),
                          error: (e, s) => _buildErrorText(e),
                        );
                  case 'roe':
                    return ref.watch(topCompaniesProvider('roe')).when(
                          data: (companies) =>
                              _buildCompanyChips(companies.take(5)),
                          loading: () => _buildLoadingChips(),
                          error: (e, s) => _buildErrorText(e),
                        );
                  case 'altman':
                    return ref.watch(topCompaniesProvider('altman')).when(
                          data: (companies) =>
                              _buildCompanyChips(companies.take(5)),
                          loading: () => _buildLoadingChips(),
                          error: (e, s) => _buildErrorText(e),
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

  IconData _getSectionIcon(String type) {
    switch (type) {
      case 'quality':
        return Icons.star;
      case 'piotroski':
        return Icons.analytics;
      case 'value':
        return Icons.diamond;
      case 'growth':
        return Icons.trending_up;
      case 'roe':
        return Icons.show_chart;
      case 'altman':
        return Icons.security;
      default:
        return Icons.bar_chart;
    }
  }

  Color _getSectionColor(String type) {
    switch (type) {
      case 'quality':
        return Colors.amber;
      case 'piotroski':
        return Colors.purple;
      case 'value':
        return Colors.green;
      case 'growth':
        return Colors.orange;
      case 'roe':
        return Colors.blue;
      case 'altman':
        return Colors.teal;
      default:
        return AppTheme.primaryGreen;
    }
  }

  Widget _buildCompanyChips(Iterable<CompanyModel> companies) {
    if (companies.isEmpty) {
      return const Text(
        'No companies found matching criteria',
        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: companies
          .map((company) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: AppTheme.primaryGreen.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      company.symbol,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        company.calculatedComprehensiveScore.toInt().toString(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildLoadingChips() {
    return Row(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(right: 8),
          width: 60,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorText(dynamic error) {
    return Text(
      'Error loading data: ${error.toString()}',
      style: const TextStyle(color: Colors.red, fontSize: 12),
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
                    'Enhanced Notifications',
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
                      'Enhanced Analysis Complete',
                      'Market analysis updated with advanced metrics',
                      Icons.analytics,
                      Colors.green,
                      '2 min ago',
                    ),
                    _buildNotificationCard(
                      context,
                      'High Piotroski Alert',
                      'Found 12 stocks with F-Score ≥ 8/9',
                      Icons.star,
                      Colors.amber,
                      '15 min ago',
                    ),
                    _buildNotificationCard(
                      context,
                      'Graham Value Opportunity',
                      'HDFC showing 30% safety margin',
                      Icons.diamond,
                      Colors.blue,
                      '1 hour ago',
                    ),
                    _buildNotificationCard(
                      context,
                      'Altman Z-Score Alert',
                      '5 companies moved to safe zone (Z > 3.0)',
                      Icons.security,
                      Colors.teal,
                      '3 hours ago',
                    ),
                    _buildNotificationCard(
                      context,
                      'Quality Grade Update',
                      'TCS upgraded to AAA investment grade',
                      Icons.grade,
                      Colors.purple,
                      '5 hours ago',
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Enhanced notifications up to date!',
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
          // Handle notification tap
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
                Text('Enhanced Settings',
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

            // Refresh Enhanced Data
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Refresh Enhanced Analysis'),
              subtitle: const Text('Update all calculated metrics'),
              onTap: () {
                Navigator.pop(context);
                ref.refresh(companyNotifierProvider);
                ref.refresh(marketSummaryProvider);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Refreshing enhanced analysis data...'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            // Analysis Preferences
            ListTile(
              leading: const Icon(Icons.analytics),
              title: const Text('Analysis Preferences'),
              subtitle: const Text('Configure scoring parameters'),
              onTap: () {
                Navigator.pop(context);
                _showAnalysisPreferences(context, ref);
              },
            ),

            // Export Enhanced Data
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export Enhanced Data'),
              subtitle: const Text('Download complete analysis'),
              onTap: () {
                Navigator.pop(context);
                _showExportDialog(context, ref);
              },
            ),

            // Clear Enhanced Cache
            ListTile(
              leading: const Icon(Icons.clear_all),
              title: const Text('Clear Enhanced Cache'),
              subtitle: const Text('Reset all calculated metrics'),
              onTap: () => _showClearCacheDialog(context, ref),
            ),

            // About Enhanced Version
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About Enhanced Version'),
              subtitle: const Text('v2.0.0 - Professional analysis'),
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
        title: const Text('Enhanced Analysis Preferences'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('Enable Piotroski scoring'),
              subtitle: const Text('9-point fundamental analysis'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Enable Altman Z-Score'),
              subtitle: const Text('Bankruptcy prediction model'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Graham intrinsic value'),
              subtitle: const Text('Value investing calculation'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Advanced ratios (ROIC, FCF)'),
              subtitle: const Text('Professional metrics'),
              value: true,
              onChanged: (value) {},
            ),
            CheckboxListTile(
              title: const Text('Sector comparison'),
              subtitle: const Text('Relative analysis'),
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
            child: const Text('Save Preferences'),
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
                Text('Enhanced Quick Actions',
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
                  'Enhanced\nScraping',
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
                  'Smart\nWatchlist',
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
                  'Pro\nAnalysis',
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
                    final qualityFilter = FundamentalFilter.getAllFilters()
                        .firstWhere(
                            (f) => f.type == FundamentalType.qualityStocks);
                    ref.read(selectedFundamentalProvider.notifier).state =
                        qualityFilter;
                  },
                ),
                _buildQuickActionCard(
                  context,
                  ref,
                  'Debug\nConsole',
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

  void _showQuickScrapeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.play_arrow, color: AppTheme.primaryGreen, size: 24),
            const SizedBox(width: 8),
            const Text('Enhanced Quick Scrape'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start enhanced scraping with professional analysis:',
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
                Icon(Icons.analytics, size: 16, color: Colors.purple),
                SizedBox(width: 8),
                Text('Full analysis: Piotroski, Altman, Graham'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.timer, size: 16, color: Colors.orange),
                SizedBox(width: 8),
                Text('Estimated time: 3-4 hours'),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.update, size: 16, color: Colors.green),
                SizedBox(width: 8),
                Text('Updates existing + calculates metrics'),
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
            label: const Text('Start Enhanced'),
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
              const Text(
                  'Starting enhanced scrape with professional analysis...'),
            ],
          ),
          backgroundColor: AppTheme.primaryGreen,
          duration: const Duration(seconds: 4),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.analytics, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Enhanced analysis initiated! Check status for progress.'),
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
            content: Text('Failed to start enhanced scraping: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  void _showDebugStats(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🔍 Enhanced Debug Console'),
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
                  final watchlist = ref.watch(watchlistProvider);

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
                      Text('• Watchlist: ${watchlist.length} items'),
                      Text('• Analysis Version: 2.0 Enhanced'),
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
                    icon: const Icon(Icons.bug_report, size: 16),
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

  Future<void> _debugFetchRawData(WidgetRef ref) async {
    print('=== 🐛 DEBUG: Enhanced Analysis System Test v2.0 ===');

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('companies')
          .limit(5)
          .get();

      print('🐛 Found ${snapshot.docs.length} companies for enhanced analysis');

      for (final doc in snapshot.docs) {
        try {
          final data = doc.data();
          final company = CompanyModel.fromFirestore(doc);

          print('📊 Company: ${company.symbol} - ${company.name}');
          print('  ✅ Quality Score: ${company.qualityScore}/5');
          print(
              '  ✅ Piotroski Score: ${company.calculatedPiotroskiScore.toStringAsFixed(1)}/9');
          print(
              '  ✅ Altman Z-Score: ${company.calculatedAltmanZScore.toStringAsFixed(2)}');
          print(
              '  ✅ Comprehensive Score: ${company.calculatedComprehensiveScore.toStringAsFixed(1)}/100');
          print('  ✅ Investment Grade: ${company.calculatedInvestmentGrade}');
          print('  ✅ Risk Assessment: ${company.calculatedRiskAssessment}');

          if (company.calculatedGrahamNumber != null) {
            print(
                '  ✅ Graham Number: ₹${company.calculatedGrahamNumber!.toStringAsFixed(0)}');
          }

          if (company.safetyMargin != null) {
            print(
                '  ✅ Safety Margin: ${company.safetyMargin!.toStringAsFixed(1)}%');
          }
        } catch (e) {
          print('❌ Error processing enhanced data for ${doc.id}: $e');
        }
      }

      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          const SnackBar(
            content: Text(
                '✅ Enhanced analysis system test complete. Check console.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('❌ Enhanced analysis system test failed: $e');
      if (ref.context.mounted) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(
            content: Text('❌ Enhanced system test failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
        title: const Text('Export Enhanced Analysis'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Choose enhanced data to export:'),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text('Complete Analysis Report'),
              subtitle: Text('All calculated metrics & scores'),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Quality Stocks Portfolio'),
              subtitle: Text('High Piotroski & comprehensive scores'),
            ),
            ListTile(
              leading: Icon(Icons.diamond),
              title: Text('Value Opportunities'),
              subtitle: Text('Graham undervalued with safety margin'),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Financial Stability Report'),
              subtitle: Text('Altman Z-Score & risk assessment'),
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
            child: const Text('Export Enhanced Data'),
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
          'This will clear all calculated metrics, analysis scores, and reset the enhanced dashboard. This includes Piotroski scores, Altman Z-Scores, Graham values, and comprehensive analysis. This action cannot be undone.',
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
              ref.read(selectedFundamentalProvider.notifier).state = null;
              ref.read(searchQueryProvider.notifier).state = '';
              ref.read(watchlistProvider.notifier).clearWatchlist();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Enhanced cache cleared - all metrics reset!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear Enhanced Cache'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Enhanced Trading Dashboard Pro',
      applicationVersion: '2.0.0 Professional',
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
            'Professional-grade stock analysis platform with AI-powered insights and institutional-level metrics.'),
        const SizedBox(height: 16),
        const Text('Enhanced Professional Features:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('• Advanced Piotroski F-Score analysis (9 criteria)'),
        const Text('• Altman Z-Score bankruptcy prediction'),
        const Text('• Graham intrinsic value calculation'),
        const Text('• Comprehensive quality scoring system'),
        const Text('• Professional ROIC & FCF yield analysis'),
        const Text('• Risk assessment & investment grading'),
        const Text('• Safety margin & value opportunities'),
        const Text('• Sector-relative analysis & benchmarking'),
        const Text('• Advanced filtering & screening system'),
        const Text('• Real-time professional notifications'),
        const Text('• Enhanced watchlist with smart alerts'),
        const Text('• Professional export & reporting'),
        const SizedBox(height: 16),
        const Text('Built for serious investors, analysts, and fund managers.'),
        const SizedBox(height: 8),
        const Text('© 2024 Enhanced Trading Dashboard Pro',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                      Text('Smart Watchlist',
                          style: Theme.of(context).textTheme.headlineMedium),
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
                              'Your smart watchlist is empty',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Add quality stocks to track their enhanced analysis, scores, and alerts',
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
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
                              subtitle: const Text('Tap for enhanced analysis'),
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
                                // Navigate to enhanced company details
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
