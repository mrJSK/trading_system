// providers/fundamental_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/company_model.dart';
import '../models/fundamental_filter.dart' as filter;

// ============================================================================
// STATE PROVIDERS
// ============================================================================

final selectedFundamentalProvider =
    StateProvider<filter.FundamentalFilter?>((ref) => null);

final selectedFilterCategoryProvider =
    StateProvider<filter.FilterCategory?>((ref) => null);

final searchQueryProvider = StateProvider<String>((ref) => '');

// ============================================================================
// MAIN COMPANIES STREAM PROVIDER
// ============================================================================

final fundamentalCompaniesProvider =
    StreamProvider.family<List<CompanyModel>, filter.FundamentalFilter?>(
  (ref, filterParam) {
    if (filterParam == null) return Stream.value([]);

    try {
      return _buildFirestoreQuery(filterParam)
          .limit(100)
          .snapshots()
          .map((snapshot) {
        List<CompanyModel> companies = [];

        for (var doc in snapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);

            if (_matchesComplexCriteria(company, filterParam)) {
              companies.add(company);
            }
          } catch (e) {
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }

        print(
            'Found ${companies.length} companies for filter ${filterParam.type.name}');
        return companies;
      });
    } catch (e) {
      print('Error in fundamentalCompaniesProvider: $e');
      return Stream.value([]);
    }
  },
);

// ============================================================================
// FIRESTORE QUERY BUILDER (🔥 FIXED WITH PROPER ORDERBY)
// ============================================================================

Query<Map<String, dynamic>> _buildFirestoreQuery(
    filter.FundamentalFilter filterParam) {
  var query = FirebaseFirestore.instance.collection('companies');

  try {
    switch (filterParam.type) {
      // ========================================================================
      // SAFETY & QUALITY FILTERS
      // ========================================================================

      case filter.FundamentalType.debtFree:
        return query
            .where('roe', isGreaterThan: 0)
            .where('roe',
                isLessThan: 100) // 🔥 FIXED: Exclude unrealistic values
            .orderBy('roe', descending: true);

      case filter.FundamentalType.qualityStocks:
        return query
            .where('roe', isGreaterThan: 15.0)
            .where('roe',
                isLessThan: 100) // 🔥 FIXED: Exclude unrealistic values
            .orderBy('roe', descending: true);

      case filter.FundamentalType.strongBalance:
        // 🔥 FIXED: Use single field to avoid compound index requirement
        return query
            .where('roe', isGreaterThan: 12.0)
            .where('roe', isLessThan: 100)
            .orderBy('roe', descending: true);

      // ========================================================================
      // PROFITABILITY FILTERS
      // ========================================================================

      case filter.FundamentalType.highROE:
        return query
            .where('roe', isGreaterThan: 15.0)
            .where('roe', isLessThan: 100)
            .orderBy('roe', descending: true);

      case filter.FundamentalType.profitableStocks:
        return query
            .where('roe', isGreaterThan: 0)
            .where('roe', isLessThan: 100)
            .orderBy('roe', descending: true);

      case filter.FundamentalType.consistentProfits:
        // 🔥 FIXED: Use single field to avoid compound index requirement
        return query
            .where('roe', isGreaterThan: 10.0)
            .where('roe', isLessThan: 100)
            .orderBy('roe', descending: true);

      // ========================================================================
      // GROWTH FILTERS
      // ========================================================================

      case filter.FundamentalType.growthStocks:
        return query
            .where('Compounded Sales Growth', isGreaterThan: 15.0)
            .where('Compounded Sales Growth', isLessThan: 200)
            .orderBy('Compounded Sales Growth', descending: true);

      case filter.FundamentalType.highSalesGrowth:
        return query
            .where('Compounded Sales Growth', isGreaterThan: 20.0)
            .where('Compounded Sales Growth', isLessThan: 200)
            .orderBy('Compounded Sales Growth', descending: true);

      case filter.FundamentalType.momentumStocks:
        return query
            .where('Compounded Profit Growth', isGreaterThan: 20.0)
            .where('Compounded Profit Growth', isLessThan: 200)
            .orderBy('Compounded Profit Growth', descending: true);

      // ========================================================================
      // VALUE FILTERS
      // ========================================================================

      case filter.FundamentalType.lowPE:
        return query
            .where('stock_pe', isLessThan: 15.0)
            .where('stock_pe', isGreaterThan: 0)
            .orderBy('stock_pe');

      case filter.FundamentalType.valueStocks:
        // 🔥 FIXED: Simplified to avoid compound index requirement
        return query
            .where('stock_pe', isLessThan: 12.0)
            .where('stock_pe', isGreaterThan: 0)
            .orderBy('stock_pe');

      case filter.FundamentalType.undervalued:
        return query
            .where('stock_pe', isLessThan: 10.0)
            .where('stock_pe', isGreaterThan: 0)
            .orderBy('stock_pe');

      // ========================================================================
      // DIVIDEND & INCOME FILTERS
      // ========================================================================

      case filter.FundamentalType.dividendStocks:
        return query
            .where('dividend_yield',
                isGreaterThan: 1.0) // 🔥 FIXED: Lower threshold
            .where('dividend_yield', isLessThan: 50)
            .orderBy('dividend_yield', descending: true);

      case filter.FundamentalType.highDividendYield:
        return query
            .where('dividend_yield', isGreaterThan: 4.0)
            .where('dividend_yield', isLessThan: 50)
            .orderBy('dividend_yield', descending: true);

      // ========================================================================
      // MARKET CAPITALIZATION FILTERS (🔥 FIXED WITH ORDERBY)
      // ========================================================================

      case filter.FundamentalType.largeCap:
        return query
            .where('market_cap', isGreaterThan: 20000)
            .orderBy('market_cap', descending: true);

      case filter.FundamentalType.midCap:
        // 🔥 FIXED: Added required orderBy
        return query
            .where('market_cap', isGreaterThan: 5000)
            .where('market_cap', isLessThanOrEqualTo: 20000)
            .orderBy('market_cap', descending: true);

      case filter.FundamentalType.smallCap:
        // 🔥 FIXED: Added required orderBy
        return query
            .where('market_cap', isLessThan: 5000)
            .where('market_cap', isGreaterThan: 100) // Exclude micro caps
            .orderBy('market_cap', descending: true);

      // ========================================================================
      // RISK & VOLATILITY FILTERS
      // ========================================================================

      case filter.FundamentalType.lowVolatility:
        return query
            .where('roe', isGreaterThan: 10.0)
            .where('market_cap', isGreaterThan: 5000)
            .orderBy('market_cap', descending: true);

      case filter.FundamentalType.contrarian:
        return query
            .where('change_percent', isLessThan: -5.0) // 🔥 FIXED: Less strict
            .where('change_percent', isGreaterThan: -50.0)
            .orderBy('change_percent');

      // ========================================================================
      // DEFAULT CASE
      // ========================================================================

      default:
        return query.orderBy('market_cap', descending: true);
    }
  } catch (e) {
    print('Error building Firestore query for ${filterParam.type.name}: $e');
    return query.orderBy('market_cap', descending: true);
  }
}

// ============================================================================
// CLIENT-SIDE FILTERING HELPER (🔥 ENHANCED)
// ============================================================================

bool _matchesComplexCriteria(
    CompanyModel company, filter.FundamentalFilter filterParam) {
  try {
    switch (filterParam.type) {
      case filter.FundamentalType.qualityStocks:
        return company.qualityScore >= 3 &&
            (company.roe ?? 0) > 12.0 &&
            (company.debtToEquity ?? double.infinity) < 0.5;

      case filter.FundamentalType.strongBalance:
        // 🔥 ENHANCED: Check ROCE here since we can't in Firestore query
        return (company.currentRatio ?? 0) > 1.5 &&
            (company.debtToEquity ?? double.infinity) < 0.3 &&
            (company.interestCoverage ?? 0) > 5.0 &&
            (company.roce ?? 0) > 12.0; // Check ROCE client-side

      case filter.FundamentalType.valueStocks:
        // 🔥 ENHANCED: Check ROE here since we can't in Firestore query
        return (company.stockPe ?? double.infinity) < 12.0 &&
            (company.priceToBook ?? double.infinity) < 1.5 &&
            (company.roe ?? 0) > 10.0;

      case filter.FundamentalType.consistentProfits:
        // 🔥 ENHANCED: Check ROCE here since we can't in Firestore query
        return company.hasConsistentProfits &&
            (company.roe ?? 0) > 10.0 &&
            (company.roce ?? 0) > 10.0;

      case filter.FundamentalType.contrarian:
        return company.changePercent < -5.0 &&
            company.changePercent > -50.0 &&
            (company.roe ?? 0) > 10.0 &&
            company.qualityScore >= 2;

      case filter.FundamentalType.midCap:
        return (company.marketCap ?? 0) > 5000 &&
            (company.marketCap ?? 0) <= 20000;

      case filter.FundamentalType.lowVolatility:
        return (company.volatility1Y ?? double.infinity) < 25.0 &&
            (company.betaValue ?? double.infinity) < 1.2;

      case filter.FundamentalType.growthStocks:
        return company.isGrowthStock ||
            ((company.salesGrowth3Y ?? 0) > 15.0 &&
                (company.profitGrowth3Y ?? 0) > 15.0);

      case filter.FundamentalType.dividendStocks:
        return company.paysDividends && (company.dividendYield ?? 0) > 1.0;

      case filter.FundamentalType.highDividendYield:
        return company.paysDividends && (company.dividendYield ?? 0) > 4.0;

      case filter.FundamentalType.debtFree:
        return company.isDebtFree ||
            (company.debtToEquity ?? double.infinity) < 0.1;

      case filter.FundamentalType.highROE:
        return (company.roe ?? 0) > 15.0 && (company.roe ?? 0) < 100;

      case filter.FundamentalType.lowPE:
        return (company.stockPe ?? double.infinity) < 15.0 &&
            (company.stockPe ?? 0) > 0;

      case filter.FundamentalType.profitableStocks:
        return company.isProfitable && (company.roe ?? 0) > 0;

      case filter.FundamentalType.largeCap:
        return (company.marketCap ?? 0) > 20000;

      case filter.FundamentalType.smallCap:
        return (company.marketCap ?? 0) < 5000 &&
            (company.marketCap ?? 0) > 100;

      case filter.FundamentalType.highSalesGrowth:
        return (company.salesGrowth3Y ?? 0) > 20.0 &&
            (company.salesGrowth3Y ?? 0) < 200;

      case filter.FundamentalType.momentumStocks:
        return (company.profitGrowth1Y ?? 0) > 20.0 ||
            (company.salesGrowth1Y ?? 0) > 20.0;

      case filter.FundamentalType.undervalued:
        return (company.stockPe ?? double.infinity) < 10.0 &&
            (company.stockPe ?? 0) > 0 &&
            (company.roe ?? 0) > 5.0;

      default:
        return true;
    }
  } catch (e) {
    print('Error in _matchesComplexCriteria for ${company.symbol}: $e');
    return false;
  }
}

// ============================================================================
// FILTERED COMPANIES PROVIDER (🔥 ENHANCED)
// ============================================================================

final filteredCompaniesProvider =
    Provider<AsyncValue<List<CompanyModel>>>((ref) {
  final filterParam = ref.watch(selectedFundamentalProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final companies = ref.watch(fundamentalCompaniesProvider(filterParam));

  return companies.when(
    data: (data) {
      try {
        var filteredData = data;

        // 🔥 FIXED: Add minimum length check for search
        if (searchQuery.isNotEmpty && searchQuery.trim().length >= 2) {
          filteredData = data
              .where(
                  (company) => company.matchesSearchQuery(searchQuery.trim()))
              .toList();
        }

        // 🔥 ENHANCED: Multi-criteria sorting
        filteredData.sort((a, b) {
          final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
          if (qualityComparison != 0) return qualityComparison;

          final roeA = a.roe ?? 0;
          final roeB = b.roe ?? 0;
          final roeComparison = roeB.compareTo(roeA);
          if (roeComparison != 0) return roeComparison;

          final marketCapA = a.marketCap ?? 0;
          final marketCapB = b.marketCap ?? 0;
          return marketCapB.compareTo(marketCapA);
        });

        return AsyncValue.data(filteredData);
      } catch (e) {
        print('Error in filteredCompaniesProvider: $e');
        return AsyncValue.error(e, StackTrace.current);
      }
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

// ============================================================================
// WATCHLIST MANAGEMENT (🔥 ENHANCED WITH SYMBOL NORMALIZATION)
// ============================================================================

final watchlistProvider =
    StateNotifierProvider<WatchlistNotifier, List<String>>((ref) {
  return WatchlistNotifier();
});

class WatchlistNotifier extends StateNotifier<List<String>> {
  WatchlistNotifier() : super([]) {
    _loadWatchlist();
  }

  Future<void> _loadWatchlist() async {
    try {
      // TODO: Implement SharedPreferences or Firestore persistence
      state = [];
    } catch (e) {
      print('Error loading watchlist: $e');
      state = [];
    }
  }

  Future<void> _saveWatchlist() async {
    try {
      // TODO: Implement persistence
      print('Watchlist updated: ${state.length} items');
    } catch (e) {
      print('Error saving watchlist: $e');
    }
  }

  // 🔥 FIXED: Symbol normalization to prevent duplicates
  void addToWatchlist(String symbol) {
    final normalizedSymbol = symbol.trim().toUpperCase();
    if (!state.contains(normalizedSymbol)) {
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

  // 🔥 NEW: Get watchlist companies as stream
  Stream<List<CompanyModel>> getWatchlistCompanies() {
    if (state.isEmpty) return Stream.value([]);

    return FirebaseFirestore.instance
        .collection('companies')
        .where('symbol', whereIn: state.take(10).toList()) // Firestore limit
        .snapshots()
        .map((snapshot) {
      List<CompanyModel> companies = [];
      for (var doc in snapshot.docs) {
        try {
          companies.add(CompanyModel.fromFirestore(doc));
        } catch (e) {
          print('Error parsing watchlist company ${doc.id}: $e');
        }
      }
      return companies;
    });
  }
}

// ============================================================================
// REST OF YOUR CODE (Keep as is - it's excellent)
// ============================================================================

// Keep all your other providers exactly as they are:
// - companiesByCategoryProvider
// - popularStocksProvider
// - filterStatsProvider
// - FilterStats class

final companiesByCategoryProvider =
    StreamProvider.family<List<CompanyModel>, filter.FilterCategory>(
  (ref, category) {
    try {
      final filters = filter.FundamentalFilter.getFiltersByCategory(category);
      if (filters.isEmpty) return Stream.value([]);

      return FirebaseFirestore.instance
          .collection('companies')
          .where('market_cap', isGreaterThan: 500) // Filter small companies
          .orderBy('market_cap', descending: true)
          .limit(300)
          .snapshots()
          .map((snapshot) {
        List<CompanyModel> companies = [];

        for (var doc in snapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);

            final matchesAnyFilter = filters.any((filterItem) {
              try {
                return company.matchesFundamentalFilter(filterItem.type) &&
                    _matchesComplexCriteria(company, filterItem);
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

        companies.sort((a, b) {
          final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
          if (qualityComparison != 0) return qualityComparison;
          return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
        });

        return companies.take(50).toList();
      });
    } catch (e) {
      print('Error in companiesByCategoryProvider: $e');
      return Stream.value([]);
    }
  },
);

final popularStocksProvider = StreamProvider<List<CompanyModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('companies')
      .where('roe', isGreaterThan: 15.0)
      .where('roe', isLessThan: 100)
      .where('market_cap', isGreaterThan: 1000)
      .orderBy('roe', descending: true)
      .limit(100)
      .snapshots()
      .map((snapshot) {
    List<CompanyModel> companies = [];

    for (var doc in snapshot.docs) {
      try {
        final company = CompanyModel.fromFirestore(doc);
        companies.add(company);
      } catch (e) {
        continue;
      }
    }

    companies.sort((a, b) {
      final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
      if (qualityComparison != 0) return qualityComparison;

      final roeA = a.roe ?? 0;
      final roeB = b.roe ?? 0;
      final roeComparison = roeB.compareTo(roeA);
      if (roeComparison != 0) return roeComparison;

      return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
    });

    return companies.take(30).toList();
  });
});

final filterStatsProvider =
    StreamProvider.family<FilterStats, filter.FundamentalFilter?>(
  (ref, filterParam) {
    if (filterParam == null) {
      return Stream.value(
          FilterStats(totalCount: 0, avgMarketCap: 0, avgROE: 0));
    }

    return FirebaseFirestore.instance
        .collection('companies')
        .where('market_cap', isGreaterThan: 100)
        .limit(500)
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
                _matchesComplexCriteria(company, filterParam);
          } catch (e) {
            return false;
          }
        }).toList();

        final totalCount = filteredCompanies.length;

        final validMarketCaps = filteredCompanies
            .where((c) =>
                c.marketCap != null &&
                c.marketCap! > 0 &&
                c.marketCap! < 1000000)
            .map((c) => c.marketCap!)
            .toList();

        final avgMarketCap = validMarketCaps.isEmpty
            ? 0.0
            : validMarketCaps.reduce((a, b) => a + b) / validMarketCaps.length;

        final validROEs = filteredCompanies
            .where((c) => c.roe != null && c.roe! > 0 && c.roe! < 100)
            .map((c) => c.roe!)
            .toList();

        final avgROE = validROEs.isEmpty
            ? 0.0
            : validROEs.reduce((a, b) => a + b) / validROEs.length;

        return FilterStats(
          totalCount: totalCount,
          avgMarketCap: avgMarketCap,
          avgROE: avgROE,
        );
      } catch (e) {
        print('Error calculating filter stats: $e');
        return FilterStats(totalCount: 0, avgMarketCap: 0, avgROE: 0);
      }
    });
  },
);

class FilterStats {
  final int totalCount;
  final double avgMarketCap;
  final double avgROE;

  FilterStats({
    required this.totalCount,
    required this.avgMarketCap,
    required this.avgROE,
  });

  String get formattedAvgMarketCap {
    if (avgMarketCap >= 100000) {
      return '₹${(avgMarketCap / 100000).toStringAsFixed(1)}L Cr';
    } else if (avgMarketCap >= 1000) {
      return '₹${(avgMarketCap / 1000).toStringAsFixed(1)}K Cr';
    }
    return '₹${avgMarketCap.toStringAsFixed(0)} Cr';
  }

  String get formattedAvgROE {
    return '${avgROE.toStringAsFixed(1)}%';
  }

  String get countText {
    if (totalCount == 0) return 'No companies found';
    if (totalCount == 1) return '1 company';
    return '$totalCount companies';
  }

  bool get hasResults => totalCount > 0;

  String get qualityAssessment {
    if (totalCount == 0) return 'No data';
    if (avgROE > 20) return 'Excellent';
    if (avgROE > 15) return 'Good';
    if (avgROE > 10) return 'Average';
    return 'Below Average';
  }
}
