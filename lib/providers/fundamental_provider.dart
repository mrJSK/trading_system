import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/company_model.dart';
import '../models/fundamental_filter.dart' as filter;

// ============================================================================
// ENHANCED STATE PROVIDERS
// ============================================================================

final selectedFundamentalProvider =
    StateProvider<filter.FundamentalFilter?>((ref) => null);

final selectedFilterCategoryProvider =
    StateProvider<filter.FilterCategory?>((ref) => null);

final searchQueryProvider = StateProvider<String>((ref) => '');

final filterSortModeProvider =
    StateProvider<FilterSortMode>((ref) => FilterSortMode.qualityScore);

final filterViewModeProvider =
    StateProvider<FilterViewMode>((ref) => FilterViewMode.grid);

enum FilterSortMode {
  qualityScore,
  marketCap,
  roe,
  workingCapital,
  recentPerformance,
  businessInsights
}

enum FilterViewMode { grid, list, detailed }

// ============================================================================
// ENHANCED COMPANIES STREAM PROVIDER WITH BUSINESS INSIGHTS
// ============================================================================

final fundamentalCompaniesProvider =
    StreamProvider.family<List<CompanyModel>, filter.FundamentalFilter?>(
  (ref, filterParam) {
    if (filterParam == null) return Stream.value([]);

    try {
      return _buildEnhancedFirestoreQuery(filterParam)
          .limit(200)
          .snapshots()
          .map((snapshot) {
        List<CompanyModel> companies = [];

        for (var doc in snapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);

            if (_matchesEnhancedComplexCriteria(company, filterParam)) {
              companies.add(company);
            }
          } catch (e) {
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }

        companies =
            _applyEnhancedSorting(companies, ref.read(filterSortModeProvider));

        print(
            'Found ${companies.length} enhanced companies for filter ${filterParam.type.name}');
        return companies;
      });
    } catch (e) {
      print('Error in enhanced fundamentalCompaniesProvider: $e');
      return Stream.value([]);
    }
  },
);

// ============================================================================
// ENHANCED FIRESTORE QUERY BUILDER WITH NEW QUALITY FIELDS
// ============================================================================

Query<Map<String, dynamic>> _buildEnhancedFirestoreQuery(
    filter.FundamentalFilter filterParam) {
  var query = FirebaseFirestore.instance.collection('companies');

  try {
    switch (filterParam.type) {
      // Enhanced Safety & Quality Filters
      case filter.FundamentalType.debtFree:
        return query
            .where('debt_to_equity', isLessThan: 0.1)
            .where('roe', isGreaterThan: 0)
            .where('quality_score', isGreaterThan: 2)
            .orderBy('debt_to_equity')
            .orderBy('roe', descending: true)
            .orderBy('quality_score', descending: true);

      case filter.FundamentalType.qualityStocks:
        return query
            .where('quality_score', isGreaterThan: 3)
            .where('current_ratio', isGreaterThan: 1.5)
            .where('roe', isGreaterThan: 15.0)
            .orderBy('quality_score', descending: true)
            .orderBy('current_ratio', descending: true)
            .orderBy('roe', descending: true);

      case filter.FundamentalType.strongBalance:
        return query
            .where('working_capital_days', isLessThan: 60)
            .where('current_ratio', isGreaterThan: 1.5)
            .where('debt_to_equity', isLessThan: 0.5)
            .orderBy('working_capital_days')
            .orderBy('current_ratio', descending: true)
            .orderBy('debt_to_equity');

      // Enhanced Profitability Filters
      case filter.FundamentalType.highROE:
        return query
            .where('roe', isGreaterThan: 15.0)
            .where('roe', isLessThan: 100)
            .where('quality_score', isGreaterThan: 2)
            .orderBy('roe', descending: true)
            .orderBy('quality_score', descending: true);

      case filter.FundamentalType.profitableStocks:
        return query
            .where('roe', isGreaterThan: 0)
            .where('current_ratio', isGreaterThan: 1.0)
            .where('overall_quality_grade', whereIn: ['A', 'B', 'C'])
            .orderBy('roe', descending: true)
            .orderBy('current_ratio', descending: true);

      case filter.FundamentalType.consistentProfits:
        return query
            .where('roe', isGreaterThan: 12.0)
            .where('roe', isLessThan: 100)
            .where('quality_score', isGreaterThan: 2)
            .orderBy('roe', descending: true)
            .orderBy('quality_score', descending: true);

      // Enhanced Growth Filters with new field names
      case filter.FundamentalType.growthStocks:
        return query
            .where('sales_growth_3y', isGreaterThan: 15.0)
            .where('sales_growth_3y', isLessThan: 200)
            .where('quality_score', isGreaterThan: 1)
            .orderBy('sales_growth_3y', descending: true)
            .orderBy('quality_score', descending: true);

      case filter.FundamentalType.highSalesGrowth:
        return query
            .where('sales_growth_3y', isGreaterThan: 20.0)
            .where('sales_growth_3y', isLessThan: 200)
            .orderBy('sales_growth_3y', descending: true);

      case filter.FundamentalType.momentumStocks:
        return query
            .where('profit_growth_3y', isGreaterThan: 20.0)
            .where('profit_growth_3y', isLessThan: 200)
            .where('recent_performance', isEqualTo: 'positive')
            .orderBy('profit_growth_3y', descending: true);

      // Enhanced Value Filters
      case filter.FundamentalType.lowPE:
        return query
            .where('stock_pe', isLessThan: 15.0)
            .where('stock_pe', isGreaterThan: 0)
            .where('roe', isGreaterThan: 10.0)
            .orderBy('stock_pe')
            .orderBy('roe', descending: true);

      case filter.FundamentalType.valueStocks:
        return query
            .where('stock_pe', isLessThan: 12.0)
            .where('stock_pe', isGreaterThan: 0)
            .where('quality_score', isGreaterThan: 2)
            .orderBy('stock_pe')
            .orderBy('quality_score', descending: true);

      case filter.FundamentalType.undervalued:
        return query
            .where('stock_pe', isLessThan: 10.0)
            .where('stock_pe', isGreaterThan: 0)
            .where('overall_quality_grade', whereIn: ['A', 'B'])
            .orderBy('stock_pe')
            .orderBy('overall_quality_grade');

      // Enhanced Dividend & Income Filters
      case filter.FundamentalType.dividendStocks:
        return query
            .where('dividend_yield', isGreaterThan: 1.0)
            .where('dividend_yield', isLessThan: 50)
            .where('debt_status', isEqualTo: 'Low Debt')
            .orderBy('dividend_yield', descending: true);

      case filter.FundamentalType.highDividendYield:
        return query
            .where('dividend_yield', isGreaterThan: 4.0)
            .where('dividend_yield', isLessThan: 50)
            .where('quality_score', isGreaterThan: 2)
            .orderBy('dividend_yield', descending: true)
            .orderBy('quality_score', descending: true);

      // Market Capitalization Filters
      case filter.FundamentalType.largeCap:
        return query
            .where('market_cap', isGreaterThan: 20000)
            .where('quality_score', isGreaterThan: 1)
            .orderBy('market_cap', descending: true)
            .orderBy('quality_score', descending: true);

      case filter.FundamentalType.midCap:
        return query
            .where('market_cap', isGreaterThan: 5000)
            .where('market_cap', isLessThanOrEqualTo: 20000)
            .where('quality_score', isGreaterThan: 1)
            .orderBy('market_cap', descending: true)
            .orderBy('quality_score', descending: true);

      case filter.FundamentalType.smallCap:
        return query
            .where('market_cap', isLessThan: 5000)
            .where('market_cap', isGreaterThan: 100)
            .where('quality_score', isGreaterThan: 1)
            .orderBy('market_cap', descending: true)
            .orderBy('quality_score', descending: true);

      // NEW: Enhanced Filters Using Business Insights
      case filter.FundamentalType.workingCapitalEfficient:
        return query
            .where('working_capital_efficiency', isEqualTo: 'Excellent')
            .where('working_capital_days', isLessThan: 45)
            .where('current_ratio', isGreaterThan: 1.5)
            .orderBy('working_capital_days')
            .orderBy('current_ratio', descending: true);

      case filter.FundamentalType.cashEfficientStocks:
        return query
            .where('cash_conversion_cycle', isLessThan: 60)
            .where('current_ratio', isGreaterThan: 1.2)
            .where('cash_cycle_efficiency', isEqualTo: 'Good')
            .orderBy('cash_conversion_cycle')
            .orderBy('current_ratio', descending: true);

      case filter.FundamentalType.businessInsightRich:
        return query
            .where('business_overview', isNotEqualTo: '')
            .where('investment_highlights', isGreaterThan: 0)
            .where('quality_score', isGreaterThan: 2)
            .orderBy('business_overview')
            .orderBy('investment_highlights', descending: true)
            .orderBy('quality_score', descending: true);

      case filter.FundamentalType.recentMilestones:
        return query
            .where('key_milestones', isGreaterThan: 0)
            .where('recent_performance', isEqualTo: 'positive')
            .orderBy('key_milestones', descending: true);

      // Enhanced Risk & Volatility Filters
      case filter.FundamentalType.lowVolatility:
        return query
            .where('risk_level', isEqualTo: 'Low')
            .where('roe', isGreaterThan: 10.0)
            .where('market_cap', isGreaterThan: 5000)
            .orderBy('roe', descending: true)
            .orderBy('market_cap', descending: true);

      case filter.FundamentalType.contrarian:
        return query
            .where('change_percent', isLessThan: -5.0)
            .where('change_percent', isGreaterThan: -50.0)
            .where('quality_score', isGreaterThan: 2)
            .orderBy('change_percent')
            .orderBy('quality_score', descending: true);

      default:
        return query
            .where('market_cap', isGreaterThan: 100)
            .where('quality_score', isGreaterThan: 0)
            .orderBy('market_cap', descending: true)
            .orderBy('quality_score', descending: true);
    }
  } catch (e) {
    print(
        'Error building enhanced Firestore query for ${filterParam.type.name}: $e');
    return query
        .where('market_cap', isGreaterThan: 100)
        .orderBy('market_cap', descending: true);
  }
}

// ============================================================================
// ENHANCED SORTING LOGIC WITH BUSINESS INSIGHTS
// ============================================================================

List<CompanyModel> _applyEnhancedSorting(
    List<CompanyModel> companies, FilterSortMode sortMode) {
  companies.sort((a, b) {
    switch (sortMode) {
      case FilterSortMode.qualityScore:
        final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
        if (qualityComparison != 0) return qualityComparison;

        final roeComparison = (b.roe ?? 0).compareTo(a.roe ?? 0);
        if (roeComparison != 0) return roeComparison;

        return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);

      case FilterSortMode.marketCap:
        final marketCapComparison =
            (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
        if (marketCapComparison != 0) return marketCapComparison;

        return b.qualityScore.compareTo(a.qualityScore);

      case FilterSortMode.roe:
        final roeComparison = (b.roe ?? 0).compareTo(a.roe ?? 0);
        if (roeComparison != 0) return roeComparison;

        return b.qualityScore.compareTo(a.qualityScore);

      case FilterSortMode.workingCapital:
        final wcA = a.workingCapitalDays ?? double.infinity;
        final wcB = b.workingCapitalDays ?? double.infinity;
        final wcComparison = wcA.compareTo(wcB);
        if (wcComparison != 0) return wcComparison;

        return b.qualityScore.compareTo(a.qualityScore);

      case FilterSortMode.recentPerformance:
        final changeComparison = b.changePercent.compareTo(a.changePercent);
        if (changeComparison.abs() > 1.0) return changeComparison;

        return b.qualityScore.compareTo(a.qualityScore);

      case FilterSortMode.businessInsights:
        final highlightsA = a.investmentHighlights.length;
        final highlightsB = b.investmentHighlights.length;
        final highlightsComparison = highlightsB.compareTo(highlightsA);
        if (highlightsComparison != 0) return highlightsComparison;

        final overviewA = a.businessOverview.isNotEmpty ? 1 : 0;
        final overviewB = b.businessOverview.isNotEmpty ? 1 : 0;
        final overviewComparison = overviewB.compareTo(overviewA);
        if (overviewComparison != 0) return overviewComparison;

        return b.qualityScore.compareTo(a.qualityScore);
    }
  });

  return companies;
}

// ============================================================================
// ENHANCED CLIENT-SIDE FILTERING WITH BUSINESS INSIGHTS
// ============================================================================

bool _matchesEnhancedComplexCriteria(
    CompanyModel company, filter.FundamentalFilter filterParam) {
  try {
    switch (filterParam.type) {
      case filter.FundamentalType.qualityStocks:
        return company.qualityScore >= 3 &&
            (company.roe ?? 0) > 12.0 &&
            (company.debtToEquity ?? double.infinity) < 0.5 &&
            (company.currentRatio ?? 0) > 1.5 &&
            company.overallQualityGrade != 'D';

      case filter.FundamentalType.strongBalance:
        return (company.currentRatio ?? 0) > 1.5 &&
            (company.debtToEquity ?? double.infinity) < 0.3 &&
            (company.interestCoverage ?? 0) > 5.0 &&
            (company.workingCapitalDays ?? double.infinity) < 60 &&
            company.qualityScore >= 2 &&
            company.liquidityStatus != 'Poor';

      case filter.FundamentalType.valueStocks:
        return (company.stockPe ?? double.infinity) < 12.0 &&
            (company.priceToBook ?? double.infinity) < 1.5 &&
            (company.roe ?? 0) > 10.0 &&
            (company.currentRatio ?? 0) > 1.0 &&
            company.qualityScore >= 2;

      case filter.FundamentalType.consistentProfits:
        return company.hasConsistentProfits &&
            (company.roe ?? 0) > 10.0 &&
            (company.roce ?? 0) > 10.0 &&
            (company.currentRatio ?? 0) > 1.2 &&
            company.qualityScore >= 2;

      case filter.FundamentalType.workingCapitalEfficient:
        return (company.workingCapitalDays ?? double.infinity) < 45 &&
            (company.currentRatio ?? 0) > 1.5 &&
            (company.cashConversionCycle ?? double.infinity) < 60 &&
            company.workingCapitalEfficiency == 'Excellent';

      case filter.FundamentalType.cashEfficientStocks:
        return (company.cashConversionCycle ?? double.infinity) < 60 &&
            (company.debtorDays ?? double.infinity) < 60 &&
            (company.inventoryDays ?? double.infinity) < 90 &&
            (company.currentRatio ?? 0) > 1.2 &&
            company.cashCycleEfficiency != 'Poor';

      case filter.FundamentalType.businessInsightRich:
        return company.businessOverview.isNotEmpty &&
            company.investmentHighlights.isNotEmpty &&
            company.qualityScore >= 2;

      case filter.FundamentalType.recentMilestones:
        return company.keyMilestones.isNotEmpty &&
            company.recentPerformance == 'positive' &&
            company.changePercent > 0;

      case filter.FundamentalType.contrarian:
        return company.changePercent < -5.0 &&
            company.changePercent > -50.0 &&
            (company.roe ?? 0) > 10.0 &&
            company.qualityScore >= 2 &&
            (company.currentRatio ?? 0) > 1.0 &&
            company.riskLevel != 'High';

      case filter.FundamentalType.debtFree:
        return company.isDebtFree ||
            (company.debtToEquity ?? double.infinity) < 0.1 ||
            company.debtStatus == 'Debt Free';

      case filter.FundamentalType.highROE:
        return (company.roe ?? 0) > 15.0 &&
            (company.roe ?? 0) < 100 &&
            (company.currentRatio ?? 0) > 1.0 &&
            company.qualityScore >= 2;

      case filter.FundamentalType.lowPE:
        return (company.stockPe ?? double.infinity) < 15.0 &&
            (company.stockPe ?? 0) > 0 &&
            (company.roe ?? 0) > 5.0;

      case filter.FundamentalType.profitableStocks:
        return company.isProfitable &&
            (company.roe ?? 0) > 0 &&
            (company.currentRatio ?? 0) > 1.0 &&
            company.overallQualityGrade != 'D';

      case filter.FundamentalType.growthStocks:
        return company.isGrowthStock ||
            ((company.salesGrowth3Y ?? 0) > 15.0 &&
                (company.profitGrowth3Y ?? 0) > 15.0);

      case filter.FundamentalType.dividendStocks:
        return company.paysDividends &&
            (company.dividendYield ?? 0) > 1.0 &&
            (company.currentRatio ?? 0) > 1.2 &&
            company.debtStatus != 'High Debt';

      case filter.FundamentalType.highDividendYield:
        return company.paysDividends &&
            (company.dividendYield ?? 0) > 4.0 &&
            (company.debtToEquity ?? double.infinity) < 0.6 &&
            company.qualityScore >= 2;

      case filter.FundamentalType.largeCap:
        return (company.marketCap ?? 0) > 20000;

      case filter.FundamentalType.midCap:
        return (company.marketCap ?? 0) > 5000 &&
            (company.marketCap ?? 0) <= 20000;

      case filter.FundamentalType.smallCap:
        return (company.marketCap ?? 0) < 5000 &&
            (company.marketCap ?? 0) > 100;

      case filter.FundamentalType.highSalesGrowth:
        return (company.salesGrowth3Y ?? 0) > 20.0 &&
            (company.salesGrowth3Y ?? 0) < 200;

      case filter.FundamentalType.momentumStocks:
        return (company.profitGrowth1Y ?? 0) > 20.0 ||
            (company.salesGrowth1Y ?? 0) > 20.0 ||
            company.recentPerformance == 'positive';

      case filter.FundamentalType.undervalued:
        return (company.stockPe ?? double.infinity) < 10.0 &&
            (company.stockPe ?? 0) > 0 &&
            (company.roe ?? 0) > 5.0 &&
            company.qualityScore >= 2 &&
            company.overallQualityGrade != 'D';

      case filter.FundamentalType.lowVolatility:
        return company.riskLevel == 'Low' &&
            (company.marketCap ?? 0) > 5000 &&
            company.qualityScore >= 2;

      default:
        return true;
    }
  } catch (e) {
    print(
        'Error in enhanced _matchesComplexCriteria for ${company.symbol}: $e');
    return false;
  }
}

// ============================================================================
// ENHANCED FILTERED COMPANIES PROVIDER
// ============================================================================

final filteredCompaniesProvider =
    Provider<AsyncValue<List<CompanyModel>>>((ref) {
  final filterParam = ref.watch(selectedFundamentalProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final sortMode = ref.watch(filterSortModeProvider);
  final companies = ref.watch(fundamentalCompaniesProvider(filterParam));

  return companies.when(
    data: (data) {
      try {
        var filteredData = data;

        if (searchQuery.isNotEmpty && searchQuery.trim().length >= 2) {
          filteredData = data
              .where(
                  (company) => company.matchesSearchQuery(searchQuery.trim()))
              .toList();
        }

        filteredData = _applyEnhancedSorting(filteredData, sortMode);

        return AsyncValue.data(filteredData);
      } catch (e) {
        print('Error in enhanced filteredCompaniesProvider: $e');
        return AsyncValue.error(e, StackTrace.current);
      }
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

// ============================================================================
// ENHANCED WATCHLIST MANAGEMENT WITH PERSISTENCE
// ============================================================================

final watchlistProvider =
    StateNotifierProvider<EnhancedWatchlistNotifier, List<String>>((ref) {
  return EnhancedWatchlistNotifier();
});

class EnhancedWatchlistNotifier extends StateNotifier<List<String>> {
  EnhancedWatchlistNotifier() : super([]) {
    _loadWatchlist();
  }

  static const String _watchlistKey = 'enhanced_watchlist';

  Future<void> _loadWatchlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final watchlistData = prefs.getStringList(_watchlistKey) ?? [];
      state = watchlistData.map((s) => s.toUpperCase()).toList();
    } catch (e) {
      print('Error loading enhanced watchlist: $e');
      state = [];
    }
  }

  Future<void> _saveWatchlist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_watchlistKey, state);
      print('Enhanced watchlist saved: ${state.length} items');
    } catch (e) {
      print('Error saving enhanced watchlist: $e');
    }
  }

  void addToWatchlist(String symbol) {
    final normalizedSymbol = symbol.trim().toUpperCase();
    if (!state.contains(normalizedSymbol) && state.length < 50) {
      state = [...state, normalizedSymbol];
      _saveWatchlist();
    }
  }

  void removeFromWatchlist(String symbol) {
    final normalizedSymbol = symbol.trim().toUpperCase();
    state = state.where((s) => s != normalizedSymbol).toList();
    _saveWatchlist();
  }

  bool isInWatchlist(String symbol) {
    return state.contains(symbol.trim().toUpperCase());
  }

  void toggleWatchlist(String symbol) {
    final normalizedSymbol = symbol.trim().toUpperCase();
    if (isInWatchlist(normalizedSymbol)) {
      removeFromWatchlist(normalizedSymbol);
    } else {
      addToWatchlist(normalizedSymbol);
    }
  }

  void clearWatchlist() {
    state = [];
    _saveWatchlist();
  }

  void reorderWatchlist(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) newIndex--;
    final item = state.removeAt(oldIndex);
    state = [...state]..insert(newIndex, item);
    _saveWatchlist();
  }

  Stream<List<CompanyModel>> getEnhancedWatchlistCompanies() {
    if (state.isEmpty) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('companies')
        .where('symbol', whereIn: state.take(10).toList())
        .snapshots()
        .map((snapshot) {
      List<CompanyModel> companies = [];
      for (var doc in snapshot.docs) {
        try {
          companies.add(CompanyModel.fromFirestore(doc));
        } catch (e) {
          print('Error parsing enhanced watchlist company ${doc.id}: $e');
        }
      }

      companies.sort((a, b) {
        final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
        if (qualityComparison != 0) return qualityComparison;

        final changeComparison = b.changePercent.compareTo(a.changePercent);
        if (changeComparison.abs() > 1.0) return changeComparison;

        return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
      });

      return companies;
    });
  }
}

// ============================================================================
// ENHANCED CATEGORY PROVIDER WITH BUSINESS INSIGHTS
// ============================================================================

final companiesByCategoryProvider =
    StreamProvider.family<List<CompanyModel>, filter.FilterCategory>(
  (ref, category) {
    try {
      final filters = filter.FundamentalFilter.getFiltersByCategory(category);
      if (filters.isEmpty) return Stream.value([]);

      return FirebaseFirestore.instance
          .collection('companies')
          .where('market_cap', isGreaterThan: 500)
          .where('quality_score', isGreaterThan: 1)
          .orderBy('market_cap', descending: true)
          .orderBy('quality_score', descending: true)
          .limit(500)
          .snapshots()
          .map((snapshot) {
        List<CompanyModel> companies = [];

        for (var doc in snapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);

            final matchesAnyFilter = filters.any((filterItem) {
              try {
                return company.matchesFundamentalFilter(filterItem.type) &&
                    _matchesEnhancedComplexCriteria(company, filterItem);
              } catch (e) {
                return false;
              }
            });

            if (matchesAnyFilter) {
              companies.add(company);
            }
          } catch (e) {
            continue;
          }
        }

        companies =
            _applyEnhancedSorting(companies, FilterSortMode.qualityScore);
        return companies.take(80).toList();
      });
    } catch (e) {
      print('Error in enhanced companiesByCategoryProvider: $e');
      return Stream.value([]);
    }
  },
);

// ============================================================================
// ENHANCED POPULAR STOCKS WITH BUSINESS INSIGHTS
// ============================================================================

final popularStocksProvider = StreamProvider<List<CompanyModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('companies')
      .where('quality_score', isGreaterThan: 3)
      .where('roe', isGreaterThan: 15.0)
      .where('roe', isLessThan: 100)
      .where('current_ratio', isGreaterThan: 1.5)
      .orderBy('quality_score', descending: true)
      .orderBy('roe', descending: true)
      .orderBy('current_ratio', descending: true)
      .limit(150)
      .snapshots()
      .map((snapshot) {
    List<CompanyModel> companies = [];

    for (var doc in snapshot.docs) {
      try {
        final company = CompanyModel.fromFirestore(doc);
        if (company.qualityScore >= 3 &&
            company.overallQualityGrade != 'D' &&
            company.riskLevel != 'High') {
          companies.add(company);
        }
      } catch (e) {
        continue;
      }
    }

    companies.sort((a, b) {
      final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
      if (qualityComparison != 0) return qualityComparison;

      final highlightsComparison = b.investmentHighlights.length
          .compareTo(a.investmentHighlights.length);
      if (highlightsComparison != 0) return highlightsComparison;

      final roeComparison = (b.roe ?? 0).compareTo(a.roe ?? 0);
      if (roeComparison != 0) return roeComparison;

      return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
    });

    return companies.take(50).toList();
  });
});

// ============================================================================
// ENHANCED FILTER STATS WITH BUSINESS INSIGHTS METRICS
// ============================================================================

final filterStatsProvider =
    StreamProvider.family<EnhancedFilterStats, filter.FundamentalFilter?>(
  (ref, filterParam) {
    if (filterParam == null) {
      return Stream.value(EnhancedFilterStats.empty());
    }

    return FirebaseFirestore.instance
        .collection('companies')
        .where('market_cap', isGreaterThan: 100)
        .limit(800)
        .snapshots()
        .map((snapshot) {
      try {
        List<CompanyModel> allCompanies = [];

        for (var doc in snapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);
            allCompanies.add(company);
          } catch (e) {
            continue;
          }
        }

        final filteredCompanies = allCompanies.where((company) {
          try {
            return company.matchesFundamentalFilter(filterParam.type) &&
                _matchesEnhancedComplexCriteria(company, filterParam);
          } catch (e) {
            return false;
          }
        }).toList();

        return EnhancedFilterStats.fromCompanies(filteredCompanies);
      } catch (e) {
        print('Error calculating enhanced filter stats: $e');
        return EnhancedFilterStats.empty();
      }
    });
  },
);

class EnhancedFilterStats {
  final int totalCount;
  final double avgMarketCap;
  final double avgROE;
  final double avgQualityScore;
  final double avgWorkingCapitalDays;
  final double avgCurrentRatio;
  final int qualityStocksCount;
  final int businessInsightRichCount;
  final int debtFreeCount;
  final int dividendPayingCount;
  final Map<String, int> riskDistribution;
  final Map<String, int> qualityGradeDistribution;

  EnhancedFilterStats({
    required this.totalCount,
    required this.avgMarketCap,
    required this.avgROE,
    required this.avgQualityScore,
    required this.avgWorkingCapitalDays,
    required this.avgCurrentRatio,
    required this.qualityStocksCount,
    required this.businessInsightRichCount,
    required this.debtFreeCount,
    required this.dividendPayingCount,
    required this.riskDistribution,
    required this.qualityGradeDistribution,
  });

  factory EnhancedFilterStats.empty() {
    return EnhancedFilterStats(
      totalCount: 0,
      avgMarketCap: 0,
      avgROE: 0,
      avgQualityScore: 0,
      avgWorkingCapitalDays: 0,
      avgCurrentRatio: 0,
      qualityStocksCount: 0,
      businessInsightRichCount: 0,
      debtFreeCount: 0,
      dividendPayingCount: 0,
      riskDistribution: {},
      qualityGradeDistribution: {},
    );
  }

  factory EnhancedFilterStats.fromCompanies(List<CompanyModel> companies) {
    if (companies.isEmpty) return EnhancedFilterStats.empty();

    final validMarketCaps = companies
        .where((c) =>
            c.marketCap != null && c.marketCap! > 0 && c.marketCap! < 1000000)
        .map((c) => c.marketCap!)
        .toList();

    final validROEs = companies
        .where((c) => c.roe != null && c.roe! > 0 && c.roe! < 100)
        .map((c) => c.roe!)
        .toList();

    final qualityScores =
        companies.map((c) => c.qualityScore.toDouble()).toList();

    final validWCDays = companies
        .where((c) => c.workingCapitalDays != null && c.workingCapitalDays! > 0)
        .map((c) => c.workingCapitalDays!)
        .toList();

    final validCurrentRatios = companies
        .where((c) => c.currentRatio != null && c.currentRatio! > 0)
        .map((c) => c.currentRatio!)
        .toList();

    final qualityStocksCount =
        companies.where((c) => c.qualityScore >= 3).length;
    final businessInsightRichCount = companies
        .where((c) =>
            c.businessOverview.isNotEmpty && c.investmentHighlights.isNotEmpty)
        .length;
    final debtFreeCount = companies.where((c) => c.isDebtFree).length;
    final dividendPayingCount = companies.where((c) => c.paysDividends).length;

    final riskDistribution = <String, int>{};
    final qualityGradeDistribution = <String, int>{};

    for (final company in companies) {
      riskDistribution[company.riskLevel] =
          (riskDistribution[company.riskLevel] ?? 0) + 1;
      qualityGradeDistribution[company.overallQualityGrade] =
          (qualityGradeDistribution[company.overallQualityGrade] ?? 0) + 1;
    }

    return EnhancedFilterStats(
      totalCount: companies.length,
      avgMarketCap: validMarketCaps.isEmpty
          ? 0.0
          : validMarketCaps.reduce((a, b) => a + b) / validMarketCaps.length,
      avgROE: validROEs.isEmpty
          ? 0.0
          : validROEs.reduce((a, b) => a + b) / validROEs.length,
      avgQualityScore: qualityScores.isEmpty
          ? 0.0
          : qualityScores.reduce((a, b) => a + b) / qualityScores.length,
      avgWorkingCapitalDays: validWCDays.isEmpty
          ? 0.0
          : validWCDays.reduce((a, b) => a + b) / validWCDays.length,
      avgCurrentRatio: validCurrentRatios.isEmpty
          ? 0.0
          : validCurrentRatios.reduce((a, b) => a + b) /
              validCurrentRatios.length,
      qualityStocksCount: qualityStocksCount,
      businessInsightRichCount: businessInsightRichCount,
      debtFreeCount: debtFreeCount,
      dividendPayingCount: dividendPayingCount,
      riskDistribution: riskDistribution,
      qualityGradeDistribution: qualityGradeDistribution,
    );
  }

  String get formattedAvgMarketCap {
    if (avgMarketCap >= 100000) {
      return '₹${(avgMarketCap / 100000).toStringAsFixed(1)}L Cr';
    } else if (avgMarketCap >= 1000) {
      return '₹${(avgMarketCap / 1000).toStringAsFixed(1)}K Cr';
    }
    return '₹${avgMarketCap.toStringAsFixed(0)} Cr';
  }

  String get formattedAvgROE => '${avgROE.toStringAsFixed(1)}%';
  String get formattedAvgQualityScore => avgQualityScore.toStringAsFixed(1);
  String get formattedAvgWorkingCapitalDays =>
      '${avgWorkingCapitalDays.toStringAsFixed(0)} days';
  String get formattedAvgCurrentRatio => avgCurrentRatio.toStringAsFixed(1);

  String get countText {
    if (totalCount == 0) return 'No companies found';
    if (totalCount == 1) return '1 company';
    return '$totalCount companies';
  }

  bool get hasResults => totalCount > 0;

  String get qualityAssessment {
    if (totalCount == 0) return 'No data';
    if (avgQualityScore >= 4) return 'Excellent';
    if (avgQualityScore >= 3) return 'Good';
    if (avgQualityScore >= 2) return 'Average';
    return 'Below Average';
  }

  String get workingCapitalEfficiency {
    if (avgWorkingCapitalDays == 0) return 'No data';
    if (avgWorkingCapitalDays < 30) return 'Excellent';
    if (avgWorkingCapitalDays < 60) return 'Good';
    if (avgWorkingCapitalDays < 90) return 'Average';
    return 'Needs Improvement';
  }

  String get businessInsightsRichness {
    if (totalCount == 0) return 'No data';
    final percentage = (businessInsightRichCount / totalCount) * 100;
    if (percentage >= 80) return 'Comprehensive';
    if (percentage >= 60) return 'Good';
    if (percentage >= 40) return 'Moderate';
    return 'Limited';
  }

  String get dominantRiskLevel {
    if (riskDistribution.isEmpty) return 'Unknown';
    return riskDistribution.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  String get dominantQualityGrade {
    if (qualityGradeDistribution.isEmpty) return 'Unknown';
    return qualityGradeDistribution.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }
}

// ============================================================================
// NEW: BUSINESS INSIGHTS PROVIDER
// ============================================================================

final companiesWithBusinessInsightsProvider =
    StreamProvider<List<CompanyModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('companies')
      .where('business_overview', isNotEqualTo: '')
      .where('investment_highlights', isGreaterThan: 0)
      .where('quality_score', isGreaterThan: 2)
      .orderBy('business_overview')
      .orderBy('investment_highlights', descending: true)
      .orderBy('quality_score', descending: true)
      .limit(100)
      .snapshots()
      .map((snapshot) {
    List<CompanyModel> companies = [];

    for (var doc in snapshot.docs) {
      try {
        final company = CompanyModel.fromFirestore(doc);
        if (company.businessOverview.isNotEmpty &&
            company.investmentHighlights.isNotEmpty) {
          companies.add(company);
        }
      } catch (e) {
        continue;
      }
    }

    companies.sort((a, b) {
      final highlightsComparison = b.investmentHighlights.length
          .compareTo(a.investmentHighlights.length);
      if (highlightsComparison != 0) return highlightsComparison;

      final milestonesComparison =
          b.keyMilestones.length.compareTo(a.keyMilestones.length);
      if (milestonesComparison != 0) return milestonesComparison;

      final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
      if (qualityComparison != 0) return qualityComparison;

      return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
    });

    return companies;
  });
});
