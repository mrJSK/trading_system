// widgets/company_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/company_model.dart';
import '../providers/company_provider.dart';
import '../widgets/company_card.dart';
import '../widgets/empty_state.dart';
import '../theme/app_theme.dart';
import '../models/fundamental_filter.dart';

// Enhanced providers for the list functionality
final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedFundamentalProvider =
    StateProvider<FundamentalFilter?>((ref) => null);
final sortCriteriaProvider =
    StateProvider<String>((ref) => 'comprehensiveScore');
final showOnlyQualityProvider = StateProvider<bool>((ref) => false);

class CompanyList extends ConsumerStatefulWidget {
  const CompanyList({Key? key}) : super(key: key);

  @override
  ConsumerState<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends ConsumerState<CompanyList> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolledToEnd = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Load initial companies when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCompaniesData();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeCompaniesData() {
    final companiesNotifier = ref.read(companyNotifierProvider.notifier);
    companiesNotifier.refreshCompanies();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.95) {
      if (!_hasScrolledToEnd) {
        _hasScrolledToEnd = true;
        // Trigger load more if available
        _loadMoreCompanies();
      }
    } else {
      _hasScrolledToEnd = false;
    }
  }

  void _loadMoreCompanies() {
    // This can be implemented based on your pagination needs
    // For now, we'll just show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All companies loaded'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedFilter = ref.watch(selectedFundamentalProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final sortCriteria = ref.watch(sortCriteriaProvider);
    final showOnlyQuality = ref.watch(showOnlyQualityProvider);

    // Enhanced filtering logic
    if (selectedFilter != null) {
      return ref.watch(filteredCompaniesProvider([selectedFilter.type])).when(
            data: (companies) => _buildEnhancedCompanyList(
              _applyAdditionalFilters(companies, showOnlyQuality, sortCriteria),
              isFiltered: true,
              filterName: selectedFilter.name,
            ),
            loading: () => _buildEnhancedLoadingState(
                'Applying ${selectedFilter.name} filter...'),
            error: (error, stack) => _buildEnhancedErrorState(error, () {
              ref.invalidate(filteredCompaniesProvider([selectedFilter.type]));
            }),
          );
    }

    // Enhanced search functionality
    if (searchQuery.isNotEmpty) {
      return ref.watch(searchResultsProvider(searchQuery)).when(
            data: (companies) => _buildEnhancedCompanyList(
              _applyAdditionalFilters(companies, showOnlyQuality, sortCriteria),
              isSearchResult: true,
              searchTerm: searchQuery,
            ),
            loading: () =>
                _buildEnhancedLoadingState('Searching for "$searchQuery"...'),
            error: (error, stack) => _buildEnhancedErrorState(error, () {
              ref.invalidate(searchResultsProvider(searchQuery));
            }),
          );
    }

    // Default: show all companies with enhanced sorting and filtering
    return ref.watch(companyNotifierProvider).when(
          data: (companies) => _buildEnhancedCompanyList(
            _applyAdditionalFilters(companies, showOnlyQuality, sortCriteria),
            showLoadMore: false,
          ),
          loading: () =>
              _buildEnhancedLoadingState('Loading enhanced company data...'),
          error: (error, stack) => _buildEnhancedErrorState(error, () {
            ref.read(companyNotifierProvider.notifier).refreshCompanies();
          }),
        );
  }

  List<CompanyModel> _applyAdditionalFilters(
    List<CompanyModel> companies,
    bool showOnlyQuality,
    String sortCriteria,
  ) {
    var filteredCompanies = companies;

    // Apply quality filter if enabled
    if (showOnlyQuality) {
      filteredCompanies = filteredCompanies
          .where((company) => company.calculatedComprehensiveScore >= 70)
          .toList();
    }

    // Apply sorting
    switch (sortCriteria) {
      case 'comprehensiveScore':
        filteredCompanies.sort((a, b) => b.calculatedComprehensiveScore
            .compareTo(a.calculatedComprehensiveScore));
        break;
      case 'piotroskiScore':
        filteredCompanies.sort((a, b) =>
            b.calculatedPiotroskiScore.compareTo(a.calculatedPiotroskiScore));
        break;
      case 'marketCap':
        filteredCompanies
            .sort((a, b) => (b.marketCap ?? 0).compareTo(a.marketCap ?? 0));
        break;
      case 'roe':
        filteredCompanies.sort((a, b) => (b.roe ?? 0).compareTo(a.roe ?? 0));
        break;
      case 'safetyMargin':
        filteredCompanies.sort((a, b) =>
            (b.safetyMargin ?? -100).compareTo(a.safetyMargin ?? -100));
        break;
      case 'altmanZScore':
        filteredCompanies.sort((a, b) =>
            b.calculatedAltmanZScore.compareTo(a.calculatedAltmanZScore));
        break;
      case 'alphabetical':
        filteredCompanies.sort((a, b) => a.name.compareTo(b.name));
        break;
      default:
        // Keep original order
        break;
    }

    return filteredCompanies;
  }

  Widget _buildEnhancedCompanyList(
    List<CompanyModel> companies, {
    bool showLoadMore = false,
    bool isFiltered = false,
    bool isSearchResult = false,
    String? filterName,
    String? searchTerm,
  }) {
    if (companies.isEmpty) {
      return _buildEnhancedEmptyState(
        isFiltered: isFiltered,
        isSearchResult: isSearchResult,
        filterName: filterName,
        searchTerm: searchTerm,
      );
    }

    return Column(
      children: [
        // Enhanced header with professional insights
        _buildProfessionalListHeader(
            companies, isFiltered, isSearchResult, searchTerm, filterName),

        // Enhanced controls bar
        _buildControlsBar(),

        // Main list with enhanced features
        Expanded(
          child: RefreshIndicator(
            onRefresh: () =>
                _handleRefresh(isFiltered, isSearchResult, searchTerm),
            color: AppTheme.primaryGreen,
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: companies.length,
              itemBuilder: (context, index) {
                final company = companies[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Hero(
                    tag: 'company_${company.symbol}',
                    child: CompanyCard(
                      company: company,
                      key: ValueKey('${company.symbol}_enhanced_${index}'),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // Enhanced footer with statistics
        if (companies.isNotEmpty) _buildListFooter(companies),
      ],
    );
  }

  Widget _buildProfessionalListHeader(
    List<CompanyModel> companies,
    bool isFiltered,
    bool isSearchResult,
    String? searchTerm,
    String? filterName,
  ) {
    final insights = _calculateProfessionalInsights(companies);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryGreen.withOpacity(0.08),
            AppTheme.primaryGreen.withOpacity(0.03),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getHeaderIcon(isSearchResult, isFiltered),
                  size: 20,
                  color: AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getProfessionalHeaderTitle(isFiltered, isSearchResult,
                          searchTerm, filterName, companies.length),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getHeaderSubtitle(insights),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _buildQualityDistributionBadge(insights),
            ],
          ),
          const SizedBox(height: 16),

          // Professional insights row
          _buildProfessionalInsightsRow(insights),
        ],
      ),
    );
  }

  Widget _buildProfessionalInsightsRow(Map<String, dynamic> insights) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildProfessionalInsightChip(
            'Avg Score',
            '${insights['avgComprehensive'].toStringAsFixed(0)}/100',
            _getScoreColor(insights['avgComprehensive']),
            Icons.analytics,
          ),
          const SizedBox(width: 8),
          _buildProfessionalInsightChip(
            'High Quality',
            '${insights['highQualityCount']}/${insights['totalCount']}',
            Colors.green,
            Icons.star,
          ),
          const SizedBox(width: 8),
          _buildProfessionalInsightChip(
            'Debt Free',
            '${insights['debtFreeCount']}/${insights['totalCount']}',
            Colors.blue,
            Icons.shield,
          ),
          const SizedBox(width: 8),
          _buildProfessionalInsightChip(
            'Value Opps',
            '${insights['valueOpportunities']}',
            Colors.purple,
            Icons.trending_down,
          ),
          const SizedBox(width: 8),
          _buildProfessionalInsightChip(
            'Avg P/E',
            insights['avgPE'].toStringAsFixed(1),
            _getPEColor(insights['avgPE']),
            Icons.account_balance,
          ),
          const SizedBox(width: 8),
          _buildProfessionalInsightChip(
            'Sectors',
            '${insights['uniqueSectors']}',
            Colors.orange,
            Icons.business,
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalInsightChip(
      String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: color.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlsBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Sort dropdown
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
              ),
              child: DropdownButtonHideUnderline(
                child: Consumer(
                  builder: (context, ref, child) {
                    final sortCriteria = ref.watch(sortCriteriaProvider);
                    return DropdownButton<String>(
                      value: sortCriteria,
                      icon: const Icon(Icons.sort, size: 16),
                      isExpanded: true,
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.textPrimary),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          ref.read(sortCriteriaProvider.notifier).state =
                              newValue;
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                            value: 'comprehensiveScore',
                            child: Text('Overall Score')),
                        DropdownMenuItem(
                            value: 'piotroskiScore',
                            child: Text('Piotroski Score')),
                        DropdownMenuItem(
                            value: 'altmanZScore',
                            child: Text('Altman Z-Score')),
                        DropdownMenuItem(
                            value: 'safetyMargin',
                            child: Text('Safety Margin')),
                        DropdownMenuItem(value: 'roe', child: Text('ROE')),
                        DropdownMenuItem(
                            value: 'marketCap', child: Text('Market Cap')),
                        DropdownMenuItem(
                            value: 'alphabetical', child: Text('Alphabetical')),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Quality toggle
          Consumer(
            builder: (context, ref, child) {
              final showOnlyQuality = ref.watch(showOnlyQualityProvider);
              return Container(
                decoration: BoxDecoration(
                  color: showOnlyQuality
                      ? AppTheme.primaryGreen.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: showOnlyQuality
                        ? AppTheme.primaryGreen
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.star,
                    color:
                        showOnlyQuality ? AppTheme.primaryGreen : Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    ref.read(showOnlyQualityProvider.notifier).state =
                        !showOnlyQuality;
                  },
                  tooltip: showOnlyQuality
                      ? 'Show All Companies'
                      : 'Show Quality Only',
                ),
              );
            },
          ),
          const SizedBox(width: 8),

          // Refresh button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: IconButton(
              icon: const Icon(Icons.refresh,
                  color: AppTheme.primaryGreen, size: 20),
              onPressed: () {
                ref.read(companyNotifierProvider.notifier).refreshCompanies();
              },
              tooltip: 'Refresh Data',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListFooter(List<CompanyModel> companies) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.05),
        border: Border(
          top: BorderSide(
            color: AppTheme.primaryGreen.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Showing ${companies.length} companies',
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.update,
                size: 12,
                color: AppTheme.textSecondary.withOpacity(0.7),
              ),
              const SizedBox(width: 4),
              Text(
                'Last updated: ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                style: TextStyle(
                  fontSize: 10,
                  color: AppTheme.textSecondary.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _calculateProfessionalInsights(
      List<CompanyModel> companies) {
    if (companies.isEmpty) {
      return {
        'totalCount': 0,
        'avgComprehensive': 0.0,
        'avgPE': 0.0,
        'highQualityCount': 0,
        'debtFreeCount': 0,
        'valueOpportunities': 0,
        'uniqueSectors': 0,
      };
    }

    double totalComprehensive = 0;
    double totalPE = 0;
    int peCount = 0;
    int highQualityCount = 0;
    int debtFreeCount = 0;
    int valueOpportunities = 0;
    Set<String> sectors = {};

    for (final company in companies) {
      totalComprehensive += company.calculatedComprehensiveScore;

      if (company.stockPe != null &&
          company.stockPe! > 0 &&
          company.stockPe! < 100) {
        totalPE += company.stockPe!;
        peCount++;
      }

      if (company.calculatedComprehensiveScore >= 70) highQualityCount++;
      if (company.isDebtFree) debtFreeCount++;
      if (company.safetyMargin != null && company.safetyMargin! > 15)
        valueOpportunities++;
      if (company.sector != null) sectors.add(company.sector!);
    }

    return {
      'totalCount': companies.length,
      'avgComprehensive': totalComprehensive / companies.length,
      'avgPE': peCount > 0 ? totalPE / peCount : 0.0,
      'highQualityCount': highQualityCount,
      'debtFreeCount': debtFreeCount,
      'valueOpportunities': valueOpportunities,
      'uniqueSectors': sectors.length,
    };
  }

  Widget _buildQualityDistributionBadge(Map<String, dynamic> insights) {
    final avgScore = insights['avgComprehensive'] as double;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getScoreColor(avgScore).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _getScoreColor(avgScore).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.analytics,
            size: 14,
            color: _getScoreColor(avgScore),
          ),
          const SizedBox(width: 4),
          Text(
            avgScore.toStringAsFixed(0),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getScoreColor(avgScore),
            ),
          ),
        ],
      ),
    );
  }

  // Helper methods
  IconData _getHeaderIcon(bool isSearchResult, bool isFiltered) {
    if (isSearchResult) return Icons.search;
    if (isFiltered) return Icons.filter_list;
    return Icons.analytics;
  }

  String _getProfessionalHeaderTitle(bool isFiltered, bool isSearchResult,
      String? searchTerm, String? filterName, int count) {
    if (isSearchResult && searchTerm != null) {
      return 'Search: "$searchTerm" ($count)';
    } else if (isFiltered && filterName != null) {
      return '$filterName ($count)';
    } else {
      return 'Professional Analysis ($count)';
    }
  }

  String _getHeaderSubtitle(Map<String, dynamic> insights) {
    final highQuality = insights['highQualityCount'];
    final debtFree = insights['debtFreeCount'];
    final valueOpps = insights['valueOpportunities'];

    return '$highQuality quality • $debtFree debt-free • $valueOpps value opportunities';
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.blue;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }

  Color _getPEColor(double pe) {
    if (pe < 15) return Colors.green;
    if (pe < 25) return Colors.blue;
    if (pe < 35) return Colors.orange;
    return Colors.red;
  }

  Future<void> _handleRefresh(
      bool isFiltered, bool isSearchResult, String? searchTerm) async {
    if (isFiltered) {
      final selectedFilter = ref.read(selectedFundamentalProvider);
      if (selectedFilter != null) {
        ref.invalidate(filteredCompaniesProvider([selectedFilter.type]));
      }
    } else if (isSearchResult && searchTerm != null) {
      ref.invalidate(searchResultsProvider(searchTerm));
    } else {
      await ref.read(companyNotifierProvider.notifier).refreshCompanies();
    }
  }

  Widget _buildEnhancedEmptyState({
    required bool isFiltered,
    required bool isSearchResult,
    String? filterName,
    String? searchTerm,
  }) {
    String message;
    String subtitle;
    IconData icon;
    List<Widget> actionButtons = [];

    if (isSearchResult) {
      message = 'No Results Found';
      subtitle = searchTerm != null
          ? 'No companies match "$searchTerm". Try different keywords or browse categories.'
          : 'Try different search terms or explore our quality picks.';
      icon = Icons.search_off;

      actionButtons = [
        ElevatedButton.icon(
          onPressed: () {
            ref.read(searchQueryProvider.notifier).state = '';
          },
          icon: const Icon(Icons.clear_all, size: 16),
          label: const Text('Clear Search'),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: () {
            ref.read(showOnlyQualityProvider.notifier).state = true;
            ref.read(searchQueryProvider.notifier).state = '';
          },
          icon: const Icon(Icons.star, size: 16),
          label: const Text('Quality Picks'),
        ),
      ];
    } else if (isFiltered) {
      message = 'No Matches Found';
      subtitle = filterName != null
          ? 'No companies match the $filterName criteria. Try adjusting filters or explore other categories.'
          : 'Try different filter criteria or browse all companies.';
      icon = Icons.filter_list_off;

      actionButtons = [
        ElevatedButton.icon(
          onPressed: () {
            ref.read(selectedFundamentalProvider.notifier).state = null;
          },
          icon: const Icon(Icons.clear_all, size: 16),
          label: const Text('Clear Filter'),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: () {
            ref.read(selectedFundamentalProvider.notifier).state = null;
            ref.read(showOnlyQualityProvider.notifier).state = true;
          },
          icon: const Icon(Icons.auto_awesome, size: 16),
          label: const Text('Show Quality'),
        ),
      ];
    } else {
      message = 'No Data Available';
      subtitle =
          'Unable to load company data. Please check your connection and try refreshing.';
      icon = Icons.business_outlined;

      actionButtons = [
        ElevatedButton.icon(
          onPressed: () {
            ref.read(companyNotifierProvider.notifier).refreshCompanies();
          },
          icon: const Icon(Icons.refresh, size: 16),
          label: const Text('Refresh'),
        ),
        const SizedBox(width: 8),
        OutlinedButton.icon(
          onPressed: () {
            // Debug action
            ref.read(companyNotifierProvider.notifier).refreshCompanies();
          },
          icon: const Icon(Icons.bug_report, size: 16),
          label: const Text('Debug'),
        ),
      ];
    }

    return EnhancedEmptyState(
      message: message,
      subtitle: subtitle,
      icon: icon,
      actions: actionButtons,
    );
  }

  Widget _buildEnhancedLoadingState(String message) {
    return Center(
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
            child: const SizedBox(
              width: 48,
              height: 48,
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
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Analyzing fundamental data with AI insights...',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedErrorState(Object error, VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
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
            const SizedBox(height: 24),
            const Text(
              'Unable to Load Data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString().length > 100
                  ? '${error.toString().substring(0, 100)}...'
                  : error.toString(),
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh, size: 16),
                  label: const Text('Try Again'),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    ref.read(selectedFundamentalProvider.notifier).state = null;
                    ref.read(searchQueryProvider.notifier).state = '';
                    ref.read(showOnlyQualityProvider.notifier).state = false;
                  },
                  icon: const Icon(Icons.clear_all, size: 16),
                  label: const Text('Reset All'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Enhanced empty state widget
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
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppTheme.primaryGreen.withOpacity(0.1),
                    AppTheme.primaryGreen.withOpacity(0.05),
                  ],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryGreen.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                size: 64,
                color: AppTheme.primaryGreen.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              message,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 15,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
            if (actions.isNotEmpty) ...[
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: actions,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
