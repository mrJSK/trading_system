// lib/screens/filter/filter_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/company_provider.dart';
import '../../widgets/company_card.dart';
import '../../theme/app_theme.dart';
import '../models/company_model.dart';
import 'company_details_screen.dart';

class FilterCriteria {
  double? minPE;
  double? maxPE;
  double? minROE;
  double? maxROE;
  double? minMarketCap;
  double? maxMarketCap;
  double? minDebtToEquity;
  double? maxDebtToEquity;
  String? sector;
  bool? isDebtFree;
  bool? isProfitable;
  bool? paysDividends;

  FilterCriteria({
    this.minPE,
    this.maxPE,
    this.minROE,
    this.maxROE,
    this.minMarketCap,
    this.maxMarketCap,
    this.minDebtToEquity,
    this.maxDebtToEquity,
    this.sector,
    this.isDebtFree,
    this.isProfitable,
    this.paysDividends,
  });

  FilterCriteria copyWith({
    double? minPE,
    double? maxPE,
    double? minROE,
    double? maxROE,
    double? minMarketCap,
    double? maxMarketCap,
    double? minDebtToEquity,
    double? maxDebtToEquity,
    String? sector,
    bool? isDebtFree,
    bool? isProfitable,
    bool? paysDividends,
  }) {
    return FilterCriteria(
      minPE: minPE ?? this.minPE,
      maxPE: maxPE ?? this.maxPE,
      minROE: minROE ?? this.minROE,
      maxROE: maxROE ?? this.maxROE,
      minMarketCap: minMarketCap ?? this.minMarketCap,
      maxMarketCap: maxMarketCap ?? this.maxMarketCap,
      minDebtToEquity: minDebtToEquity ?? this.minDebtToEquity,
      maxDebtToEquity: maxDebtToEquity ?? this.maxDebtToEquity,
      sector: sector ?? this.sector,
      isDebtFree: isDebtFree ?? this.isDebtFree,
      isProfitable: isProfitable ?? this.isProfitable,
      paysDividends: paysDividends ?? this.paysDividends,
    );
  }

  void reset() {
    minPE = null;
    maxPE = null;
    minROE = null;
    maxROE = null;
    minMarketCap = null;
    maxMarketCap = null;
    minDebtToEquity = null;
    maxDebtToEquity = null;
    sector = null;
    isDebtFree = null;
    isProfitable = null;
    paysDividends = null;
  }
}

final filterCriteriaProvider =
    StateProvider<FilterCriteria>((ref) => FilterCriteria());

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Quick Filters', 'Custom Filter', 'Results'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Companies'),
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
          indicatorColor: AppTheme.primaryGreen,
          labelColor: AppTheme.primaryGreen,
          unselectedLabelColor: AppTheme.getTextSecondary(context),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildQuickFilters(),
          _buildCustomFilter(),
          _buildResults(),
        ],
      ),
    );
  }

  Widget _buildQuickFilters() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Filters',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          // Pre-defined filter cards
          _buildQuickFilterCard(
            'High Quality Stocks',
            'ROE > 15%, Debt-Free, Profitable',
            () => _applyQuickFilter('high_quality'),
          ),
          const SizedBox(height: 12),

          _buildQuickFilterCard(
            'Value Stocks',
            'P/E < 15, ROE > 10%, Profitable',
            () => _applyQuickFilter('value'),
          ),
          const SizedBox(height: 12),

          _buildQuickFilterCard(
            'Growth Stocks',
            'High Revenue Growth, Profitable',
            () => _applyQuickFilter('growth'),
          ),
          const SizedBox(height: 12),

          _buildQuickFilterCard(
            'Dividend Stocks',
            'Dividend Yield > 2%, Profitable',
            () => _applyQuickFilter('dividend'),
          ),
          const SizedBox(height: 12),

          _buildQuickFilterCard(
            'Large Cap Stocks',
            'Market Cap > 20,000 Cr',
            () => _applyQuickFilter('large_cap'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilterCard(
      String title, String description, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.getTextSecondary(context),
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppTheme.getTextSecondary(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomFilter() {
    final criteria = ref.watch(filterCriteriaProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Valuation Metrics
          _buildFilterSection(
            'Valuation Metrics',
            [
              _buildRangeFilter('P/E Ratio', criteria.minPE, criteria.maxPE,
                  (min, max) {
                ref.read(filterCriteriaProvider.notifier).state =
                    criteria.copyWith(minPE: min, maxPE: max);
              }),
              _buildRangeFilter('ROE (%)', criteria.minROE, criteria.maxROE,
                  (min, max) {
                ref.read(filterCriteriaProvider.notifier).state =
                    criteria.copyWith(minROE: min, maxROE: max);
              }),
            ],
          ),

          // Financial Health
          _buildFilterSection(
            'Financial Health',
            [
              _buildRangeFilter('Debt/Equity', criteria.minDebtToEquity,
                  criteria.maxDebtToEquity, (min, max) {
                ref.read(filterCriteriaProvider.notifier).state = criteria
                    .copyWith(minDebtToEquity: min, maxDebtToEquity: max);
              }),
            ],
          ),

          // Market Cap
          _buildFilterSection(
            'Market Cap',
            [
              _buildRangeFilter('Market Cap (Cr)', criteria.minMarketCap,
                  criteria.maxMarketCap, (min, max) {
                ref.read(filterCriteriaProvider.notifier).state =
                    criteria.copyWith(minMarketCap: min, maxMarketCap: max);
              }),
            ],
          ),

          // Boolean Filters
          _buildFilterSection(
            'Company Characteristics',
            [
              _buildBooleanFilter('Debt Free', criteria.isDebtFree, (value) {
                ref.read(filterCriteriaProvider.notifier).state =
                    criteria.copyWith(isDebtFree: value);
              }),
              _buildBooleanFilter('Profitable', criteria.isProfitable, (value) {
                ref.read(filterCriteriaProvider.notifier).state =
                    criteria.copyWith(isProfitable: value);
              }),
              _buildBooleanFilter('Pays Dividends', criteria.paysDividends,
                  (value) {
                ref.read(filterCriteriaProvider.notifier).state =
                    criteria.copyWith(paysDividends: value);
              }),
            ],
          ),

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ref.read(filterCriteriaProvider.notifier).state =
                        FilterCriteria();
                  },
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _tabController.animateTo(2);
                  },
                  child: const Text('Apply Filter'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        ...children,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildRangeFilter(
    String label,
    double? minValue,
    double? maxValue,
    Function(double?, double?) onChanged,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Min',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: minValue?.toString(),
                    onChanged: (value) {
                      final min = double.tryParse(value);
                      onChanged(min, maxValue);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Max',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    keyboardType: TextInputType.number,
                    initialValue: maxValue?.toString(),
                    onChanged: (value) {
                      final max = double.tryParse(value);
                      onChanged(minValue, max);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBooleanFilter(
    String label,
    bool? value,
    Function(bool?) onChanged,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            DropdownButton<bool?>(
              value: value,
              items: const [
                DropdownMenuItem(value: null, child: Text('Any')),
                DropdownMenuItem(value: true, child: Text('Yes')),
                DropdownMenuItem(value: false, child: Text('No')),
              ],
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    final criteria = ref.watch(filterCriteriaProvider);
    final companiesAsync = ref.watch(companyNotifierProvider);

    return companiesAsync.when(
      data: (companies) {
        final filteredCompanies = _applyFilters(companies, criteria);

        if (filteredCompanies.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: AppTheme.getTextSecondary(context),
                ),
                const SizedBox(height: 16),
                Text(
                  'No companies found',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your filter criteria',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.getTextSecondary(context),
                      ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Results header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    '${filteredCompanies.length} companies found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      ref.read(filterCriteriaProvider.notifier).state =
                          FilterCriteria();
                    },
                    child: const Text('Clear filters'),
                  ),
                ],
              ),
            ),

            // Results list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filteredCompanies.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return CompanyCard(
                    company: filteredCompanies[index],
                    showDetails: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompanyDetailsScreen(
                          symbol: filteredCompanies[index].symbol,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }

  List<CompanyModel> _applyFilters(
      List<CompanyModel> companies, FilterCriteria criteria) {
    return companies.where((company) {
      // P/E filter
      if (criteria.minPE != null &&
          (company.stockPe == null || company.stockPe! < criteria.minPE!)) {
        return false;
      }
      if (criteria.maxPE != null &&
          (company.stockPe == null || company.stockPe! > criteria.maxPE!)) {
        return false;
      }

      // ROE filter
      if (criteria.minROE != null &&
          (company.roe == null || company.roe! < criteria.minROE!)) {
        return false;
      }
      if (criteria.maxROE != null &&
          (company.roe == null || company.roe! > criteria.maxROE!)) {
        return false;
      }

      // Market Cap filter
      if (criteria.minMarketCap != null &&
          (company.marketCap == null ||
              company.marketCap! < criteria.minMarketCap!)) {
        return false;
      }
      if (criteria.maxMarketCap != null &&
          (company.marketCap == null ||
              company.marketCap! > criteria.maxMarketCap!)) {
        return false;
      }

      // Debt to Equity filter
      if (criteria.minDebtToEquity != null &&
          (company.debtToEquity == null ||
              company.debtToEquity! < criteria.minDebtToEquity!)) {
        return false;
      }
      if (criteria.maxDebtToEquity != null &&
          (company.debtToEquity == null ||
              company.debtToEquity! > criteria.maxDebtToEquity!)) {
        return false;
      }

      // Boolean filters
      if (criteria.isDebtFree != null &&
          company.isDebtFree != criteria.isDebtFree!) {
        return false;
      }
      if (criteria.isProfitable != null &&
          company.isProfitable != criteria.isProfitable!) {
        return false;
      }
      if (criteria.paysDividends != null &&
          company.paysDividends != criteria.paysDividends!) {
        return false;
      }

      return true;
    }).toList();
  }

  void _applyQuickFilter(String filterType) {
    FilterCriteria criteria = FilterCriteria();

    switch (filterType) {
      case 'high_quality':
        criteria = FilterCriteria(
          minROE: 15.0,
          isDebtFree: true,
          isProfitable: true,
        );
        break;
      case 'value':
        criteria = FilterCriteria(
          maxPE: 15.0,
          minROE: 10.0,
          isProfitable: true,
        );
        break;
      case 'growth':
        criteria = FilterCriteria(
          isProfitable: true,
        );
        break;
      case 'dividend':
        criteria = FilterCriteria(
          paysDividends: true,
          isProfitable: true,
        );
        break;
      case 'large_cap':
        criteria = FilterCriteria(
          minMarketCap: 20000.0,
        );
        break;
    }

    ref.read(filterCriteriaProvider.notifier).state = criteria;
    _tabController.animateTo(2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
