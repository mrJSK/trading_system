// widgets/company_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/company_model.dart';
import '../providers/company_provider.dart';
import '../providers/fundamental_provider.dart';
import '../widgets/company_card.dart';
import '../widgets/empty_state.dart';
import '../theme/app_theme.dart';

class CompanyList extends ConsumerStatefulWidget {
  const CompanyList({Key? key}) : super(key: key);

  @override
  ConsumerState<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends ConsumerState<CompanyList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Load initial companies when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final companiesNotifier = ref.read(companiesProvider.notifier);
      companiesNotifier.loadInitialCompanies();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.95) {
      // Load more companies when reaching 95% of scroll
      ref.read(companiesProvider.notifier).loadMoreCompanies();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedFilter = ref.watch(selectedFundamentalProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final filterSettings = ref.watch(filterSettingsProvider);

    // Enhanced filter display with key points consideration
    if (selectedFilter != null) {
      return ref.watch(filteredCompaniesProvider).when(
            data: (companies) => _buildEnhancedCompanyList(
              companies,
              isFiltered: true,
              filterType: selectedFilter.toString(),
            ),
            loading: () =>
                _buildEnhancedLoadingState('Applying enhanced filters...'),
            error: (error, stack) => _buildEnhancedErrorState(error, () {
              ref.invalidate(filteredCompaniesProvider);
            }),
          );
    }

    // Enhanced search with sector/industry support
    if (searchQuery.isNotEmpty) {
      return ref.watch(companiesProvider).when(
            data: (companies) => _buildEnhancedCompanyList(
              companies,
              isSearchResult: true,
              searchTerm: searchQuery,
            ),
            loading: () => _buildEnhancedLoadingState(
                'Searching with enhanced criteria...'),
            error: (error, stack) => _buildEnhancedErrorState(error, () {
              ref.read(companiesProvider.notifier).searchCompanies(searchQuery);
            }),
          );
    }

    // Default: show all companies with enhanced pagination and quality sorting
    return ref.watch(companiesProvider).when(
          data: (companies) => _buildEnhancedCompanyList(
            companies,
            showLoadMore: true,
          ),
          loading: () => _buildEnhancedLoadingState(
              'Loading companies with enhanced data...'),
          error: (error, stack) => _buildEnhancedErrorState(error, () {
            ref.read(companiesProvider.notifier).refreshCompanies();
          }),
        );
  }

  // Enhanced company list with new features
  Widget _buildEnhancedCompanyList(
    List<CompanyModel> companies, {
    bool showLoadMore = false,
    bool isFiltered = false,
    bool isSearchResult = false,
    String? filterType,
    String? searchTerm,
  }) {
    if (companies.isEmpty) {
      return _buildEnhancedEmptyState(
        isFiltered: isFiltered,
        isSearchResult: isSearchResult,
        filterType: filterType,
        searchTerm: searchTerm,
      );
    }

    return Column(
      children: [
        // NEW: Enhanced header with insights
        _buildListHeader(companies, isFiltered, isSearchResult, searchTerm),

        // Main list
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              if (isFiltered) {
                ref.invalidate(filteredCompaniesProvider);
              } else if (isSearchResult) {
                final searchQuery = ref.read(searchQueryProvider);
                if (searchQuery.isNotEmpty) {
                  await ref
                      .read(companiesProvider.notifier)
                      .searchCompanies(searchQuery);
                }
              } else {
                await ref.read(companiesProvider.notifier).refreshCompanies();
              }
            },
            child: ListView.builder(
              controller: showLoadMore ? _scrollController : null,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: showLoadMore ? companies.length + 1 : companies.length,
              itemBuilder: (context, index) {
                // Show loading indicator at the end for pagination
                if (showLoadMore && index == companies.length) {
                  return _buildEnhancedLoadMoreIndicator();
                }

                final company = companies[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CompanyCard(
                    company: company,
                    // NEW: Add context for enhanced card display
                    key: ValueKey('${company.symbol}_enhanced'),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // NEW: Enhanced list header with insights
  Widget _buildListHeader(
    List<CompanyModel> companies,
    bool isFiltered,
    bool isSearchResult,
    String? searchTerm,
  ) {
    final insights = _calculateListInsights(companies);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isSearchResult
                    ? Icons.search
                    : isFiltered
                        ? Icons.filter_list
                        : Icons.business,
                size: 16,
                color: AppTheme.primaryGreen,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _getHeaderTitle(
                      isFiltered, isSearchResult, searchTerm, companies.length),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
              _buildQualityDistributionChip(insights),
            ],
          ),
          const SizedBox(height: 8),

          // Enhanced insights row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildInsightChip(
                  'Avg Quality',
                  '${insights['avgQuality']}/5',
                  Colors.blue,
                ),
                const SizedBox(width: 8),
                _buildInsightChip(
                  'Debt Free',
                  '${insights['debtFreeCount']}/${companies.length}',
                  Colors.green,
                ),
                const SizedBox(width: 8),
                _buildInsightChip(
                  'Dividend Paying',
                  '${insights['dividendCount']}/${companies.length}',
                  Colors.purple,
                ),
                const SizedBox(width: 8),
                _buildInsightChip(
                  'Quality Stocks',
                  '${insights['qualityCount']}/${companies.length}',
                  Colors.teal,
                ),
                if (insights['avgWorkingCapital'] > 0) ...[
                  const SizedBox(width: 8),
                  _buildInsightChip(
                    'Avg WC Days',
                    '${insights['avgWorkingCapital'].toStringAsFixed(0)}',
                    Colors.orange,
                  ),
                ],
                if (insights['sectorsCount'] > 0) ...[
                  const SizedBox(width: 8),
                  _buildInsightChip(
                    'Sectors',
                    '${insights['sectorsCount']}',
                    Colors.indigo,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to calculate list insights
  Map<String, dynamic> _calculateListInsights(List<CompanyModel> companies) {
    if (companies.isEmpty) {
      return {
        'avgQuality': 0.0,
        'debtFreeCount': 0,
        'dividendCount': 0,
        'qualityCount': 0,
        'avgWorkingCapital': 0.0,
        'sectorsCount': 0,
      };
    }

    double totalQuality = 0;
    int debtFreeCount = 0;
    int dividendCount = 0;
    int qualityCount = 0;
    double totalWorkingCapital = 0;
    int workingCapitalCount = 0;
    Set<String> sectors = {};

    for (final company in companies) {
      totalQuality += company.qualityScore;
      if (company.isDebtFree) debtFreeCount++;
      if (company.paysDividends) dividendCount++;
      if (company.isQualityStock) qualityCount++;

      if (company.workingCapitalDays != null) {
        totalWorkingCapital += company.workingCapitalDays!;
        workingCapitalCount++;
      }

      if (company.sector != null && company.sector!.isNotEmpty) {
        sectors.add(company.sector!);
      }
    }

    return {
      'avgQuality': (totalQuality / companies.length),
      'debtFreeCount': debtFreeCount,
      'dividendCount': dividendCount,
      'qualityCount': qualityCount,
      'avgWorkingCapital': workingCapitalCount > 0
          ? (totalWorkingCapital / workingCapitalCount)
          : 0.0,
      'sectorsCount': sectors.length,
    };
  }

  // Helper method for header title
  String _getHeaderTitle(
      bool isFiltered, bool isSearchResult, String? searchTerm, int count) {
    if (isSearchResult && searchTerm != null) {
      return 'Search Results for "$searchTerm" ($count)';
    } else if (isFiltered) {
      return 'Filtered Companies ($count)';
    } else {
      return 'All Companies ($count)';
    }
  }

  // Helper method for insight chips
  Widget _buildInsightChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for quality distribution
  Widget _buildQualityDistributionChip(Map<String, dynamic> insights) {
    final avgQuality = insights['avgQuality'] as double;
    Color qualityColor;

    if (avgQuality >= 4.0) {
      qualityColor = Colors.green;
    } else if (avgQuality >= 3.0) {
      qualityColor = Colors.blue;
    } else if (avgQuality >= 2.0) {
      qualityColor = Colors.orange;
    } else {
      qualityColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: qualityColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: qualityColor.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.star,
            size: 12,
            color: qualityColor,
          ),
          const SizedBox(width: 2),
          Text(
            avgQuality.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: qualityColor,
            ),
          ),
        ],
      ),
    );
  }

  // Enhanced empty state
  Widget _buildEnhancedEmptyState({
    required bool isFiltered,
    required bool isSearchResult,
    String? filterType,
    String? searchTerm,
  }) {
    String message;
    String subtitle;
    IconData icon;
    List<Widget> actionButtons = [];

    if (isSearchResult) {
      message = 'No companies found';
      subtitle = searchTerm != null
          ? 'No results for "$searchTerm". Try searching by symbol, name, sector, or industry.'
          : 'Try different search terms or browse all companies.';
      icon = Icons.search_off;

      actionButtons = [
        ElevatedButton.icon(
          onPressed: () {
            ref.read(searchQueryProvider.notifier).state = '';
            ref.read(companiesProvider.notifier).loadInitialCompanies();
          },
          icon: const Icon(Icons.clear_all),
          label: const Text('Clear Search'),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {
            ref.read(companiesProvider.notifier).loadQualityStocks();
          },
          icon: const Icon(Icons.star),
          label: const Text('Show Quality Stocks'),
        ),
      ];
    } else if (isFiltered) {
      message = 'No companies match filter';
      subtitle = filterType != null
          ? 'No companies found for $filterType filter. Try adjusting filter criteria or browse all companies.'
          : 'Try different filter criteria or browse all companies.';
      icon = Icons.filter_list_off;

      actionButtons = [
        ElevatedButton.icon(
          onPressed: () {
            ref.read(selectedFundamentalProvider.notifier).state = null;
            ref.read(companiesProvider.notifier).refreshCompanies();
          },
          icon: const Icon(Icons.clear_all),
          label: const Text('Clear Filters'),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {
            ref
                .read(companiesProvider.notifier)
                .loadCompaniesWithBusinessInsights();
          },
          icon: const Icon(Icons.business_center),
          label: const Text('Companies with Insights'),
        ),
      ];
    } else {
      message = 'No companies available';
      subtitle =
          'Unable to load company data. Please check your connection and try again.';
      icon = Icons.business_outlined;

      actionButtons = [
        ElevatedButton.icon(
          onPressed: () {
            ref.read(companiesProvider.notifier).refreshCompanies();
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Refresh'),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () {
            ref.read(companiesProvider.notifier).debugFetchRawCompanies();
          },
          icon: const Icon(Icons.bug_report),
          label: const Text('Debug'),
        ),
      ];
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                size: 64,
                color: AppTheme.primaryGreen.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Wrap(
              alignment: WrapAlignment.center,
              children: actionButtons,
            ),
          ],
        ),
      ),
    );
  }

  // Enhanced load more indicator
  Widget _buildEnhancedLoadMoreIndicator() {
    final companiesState = ref.read(companiesProvider.notifier).currentState;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppTheme.primaryGreen,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Loading more companies...',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (companiesState.companies.isNotEmpty)
            Text(
              '${companiesState.companies.length} companies loaded',
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.textSecondary.withOpacity(0.6),
              ),
            ),
        ],
      ),
    );
  }

  // Enhanced loading state
  Widget _buildEnhancedLoadingState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.05),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: AppTheme.primaryGreen,
                strokeWidth: 3,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Please wait while we fetch enhanced financial data...',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Enhanced error state
  Widget _buildEnhancedErrorState(Object error, VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.red.withOpacity(0.1),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Unable to Load Companies',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Error: ${error.toString()}',
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // Clear all filters and search
                    ref.read(selectedFundamentalProvider.notifier).state = null;
                    ref.read(searchQueryProvider.notifier).state = '';
                    ref.read(companiesProvider.notifier).loadInitialCompanies();
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear All'),
                ),
                TextButton.icon(
                  onPressed: () {
                    // Try loading quality stocks as fallback
                    ref.read(companiesProvider.notifier).loadQualityStocks();
                  },
                  icon: const Icon(Icons.star),
                  label: const Text('Load Quality Stocks'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// NEW: Enhanced empty state widget for better UX
class EnhancedEmptyState extends StatelessWidget {
  final String message;
  final String subtitle;
  final IconData icon;
  final List<Widget> actions;

  const EnhancedEmptyState({
    Key? key,
    required this.message,
    required this.subtitle,
    required this.icon,
    this.actions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                size: 64,
                color: AppTheme.primaryGreen.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            if (actions.isNotEmpty) ...[
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                children: actions,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
