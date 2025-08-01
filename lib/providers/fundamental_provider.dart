// providers/fundamental_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/company_model.dart';
import '../models/fundamental_filter.dart' as filter;

// ============================================================================
// STATE PROVIDERS
// ============================================================================

/// Provider for the currently selected fundamental filter
/// Used by the UI to track which fundamental filter is active
final selectedFundamentalProvider =
    StateProvider<filter.FundamentalFilter?>((ref) => null);

/// Provider for the currently selected filter category (Quality, Growth, Value, etc.)
/// Used to group related filters together in the UI
final selectedFilterCategoryProvider =
    StateProvider<filter.FilterCategory?>((ref) => null);

/// Provider for the current search query string
/// Used by the search bar to filter companies by name/symbol
final searchQueryProvider = StateProvider<String>((ref) => '');

// ============================================================================
// MAIN COMPANIES STREAM PROVIDER
// ============================================================================

/// Stream provider that fetches companies based on a fundamental filter
/// Returns real-time updates from Firestore when the underlying data changes
///
/// Parameters:
/// - filterParam: The fundamental filter to apply (e.g., High ROE, Debt Free)
///
/// Returns:
/// - Stream<List<CompanyModel>>: Real-time list of filtered companies
final fundamentalCompaniesProvider =
    StreamProvider.family<List<CompanyModel>, filter.FundamentalFilter?>(
  (ref, filterParam) {
    // Return empty list if no filter is selected
    if (filterParam == null) return Stream.value([]);

    try {
      // Build and execute the Firestore query
      // FIXED: Use the query directly instead of passing it to .where()
      return _buildFirestoreQuery(filterParam)
          .limit(100) // Limit results for performance
          .snapshots() // Get real-time updates
          .map((snapshot) {
        List<CompanyModel> companies = [];

        // Parse each document with error handling
        for (var doc in snapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);

            // Apply client-side filtering for complex criteria
            // that can't be efficiently handled by Firestore queries
            if (_matchesComplexCriteria(company, filterParam)) {
              companies.add(company);
            }
          } catch (e) {
            // Log parsing errors but continue processing other documents
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }

        print(
            'Found ${companies.length} companies for filter ${filterParam.type.name}');
        return companies;
      });
    } catch (e) {
      // Return empty stream on error to prevent app crashes
      print('Error in fundamentalCompaniesProvider: $e');
      return Stream.value([]);
    }
  },
);

// ============================================================================
// FIRESTORE QUERY BUILDER
// ============================================================================

/// Builds optimized Firestore queries for different fundamental filter types
/// Each filter type is designed to minimize Firestore reads while maximizing relevance
///
/// Parameters:
/// - filterParam: The fundamental filter containing type and criteria
///
/// Returns:
/// - Query<Map<String, dynamic>>: Configured Firestore query
Query<Map<String, dynamic>> _buildFirestoreQuery(
    filter.FundamentalFilter filterParam) {
  var query = FirebaseFirestore.instance.collection('companies');

  try {
    switch (filterParam.type) {
      // ========================================================================
      // SAFETY & QUALITY FILTERS
      // ========================================================================

      case filter.FundamentalType.debtFree:
        // Companies with minimal or no debt
        return query.where('isDebtFree', isEqualTo: true);

      case filter.FundamentalType.qualityStocks:
        // High-quality companies with good ROE and manageable debt
        return query
            .where('isQualityStock', isEqualTo: true)
            .where('roe', isGreaterThan: 12.0);

      case filter.FundamentalType.strongBalance:
        // Companies with strong balance sheets
        return query
            .where('currentRatio', isGreaterThan: 1.5)
            .where('debtToEquity', isLessThan: 0.3);

      // ========================================================================
      // PROFITABILITY FILTERS
      // ========================================================================

      case filter.FundamentalType.highROE:
        // Companies with high return on equity (>15%)
        return query
            .where('roe', isGreaterThan: 15.0)
            .where('roe', isLessThan: 100); // Exclude unrealistic values

      case filter.FundamentalType.profitableStocks:
        // Consistently profitable companies
        return query
            .where('isProfitable', isEqualTo: true)
            .where('roe', isGreaterThan: 0);

      case filter.FundamentalType.consistentProfits:
        // Companies with consistent profit track record
        return query
            .where('hasConsistentProfits', isEqualTo: true)
            .where('isProfitable', isEqualTo: true);

      // ========================================================================
      // GROWTH FILTERS
      // ========================================================================

      case filter.FundamentalType.growthStocks:
        // Fast-growing companies with strong sales and profit growth
        return query
            .where('isGrowthStock', isEqualTo: true)
            .where('salesGrowth3Y', isGreaterThan: 15.0);

      case filter.FundamentalType.highSalesGrowth:
        // Companies with exceptional sales growth (>20%)
        return query.where('salesGrowth3Y', isGreaterThan: 20.0).where(
            'salesGrowth3Y',
            isLessThan: 200); // Exclude unrealistic values

      case filter.FundamentalType.momentumStocks:
        // Companies with strong recent momentum in sales and profits
        return query
            .where('salesGrowth1Y', isGreaterThan: 20.0)
            .where('profitGrowth1Y', isGreaterThan: 20.0);

      // ========================================================================
      // VALUE FILTERS
      // ========================================================================

      case filter.FundamentalType.lowPE:
        // Companies trading at reasonable P/E ratios
        return query
            .where('stockPe', isLessThan: 15.0)
            .where('stockPe', isGreaterThan: 0); // Exclude negative P/E

      case filter.FundamentalType.valueStocks:
        // Undervalued companies with good fundamentals
        return query
            .where('isValueStock', isEqualTo: true)
            .where('stockPe', isLessThan: 12.0);

      case filter.FundamentalType.undervalued:
        // Deeply undervalued companies
        return query
            .where('stockPe', isLessThan: 10.0)
            .where('stockPe', isGreaterThan: 0)
            .where('priceToBook', isLessThan: 1.0);

      // ========================================================================
      // DIVIDEND & INCOME FILTERS
      // ========================================================================

      case filter.FundamentalType.dividendStocks:
        // Companies that pay regular dividends
        return query
            .where('paysDividends', isEqualTo: true)
            .where('dividendYield', isGreaterThan: 2.0);

      case filter.FundamentalType.highDividendYield:
        // Companies with high dividend yields (>4%)
        return query
            .where('dividendYield', isGreaterThan: 4.0)
            .where('paysDividends', isEqualTo: true);

      // ========================================================================
      // MARKET CAPITALIZATION FILTERS
      // ========================================================================

      case filter.FundamentalType.largeCap:
        // Large-cap companies (>20,000 Cr market cap)
        return query
            .where('marketCap', isGreaterThan: 20000)
            .orderBy('marketCap', descending: true);

      case filter.FundamentalType.midCap:
        // Mid-cap companies (5,000-20,000 Cr market cap)
        return query
            .where('marketCap', isGreaterThan: 5000)
            .where('marketCap', isLessThanOrEqualTo: 20000)
            .orderBy('marketCap', descending: true);

      case filter.FundamentalType.smallCap:
        // Small-cap companies (<5,000 Cr market cap)
        return query
            .where('marketCap', isLessThan: 5000)
            .where('marketCap', isGreaterThan: 0)
            .orderBy('marketCap', descending: true);

      // ========================================================================
      // RISK & VOLATILITY FILTERS
      // ========================================================================

      case filter.FundamentalType.lowVolatility:
        // Low-risk companies with beta < 1.0
        return query
            .where('betaValue', isLessThan: 1.0)
            .where('betaValue', isGreaterThan: 0);

      case filter.FundamentalType.contrarian:
        // Beaten-down quality companies (potential turnaround candidates)
        return query
            .where('changePercent', isLessThan: -10.0)
            .where('roe', isGreaterThan: 10.0);

      // ========================================================================
      // DEFAULT CASE
      // ========================================================================

      default:
        // Return all companies sorted by market cap if no specific filter
        return query.orderBy('marketCap', descending: true);
    }
  } catch (e) {
    // Fallback to basic query on error
    print('Error building Firestore query for ${filterParam.type.name}: $e');
    return query.orderBy('marketCap', descending: true);
  }
}

// ============================================================================
// CLIENT-SIDE FILTERING HELPER
// ============================================================================

/// Applies complex filtering criteria that can't be efficiently handled by Firestore
/// This function runs on the client side after getting results from Firestore
///
/// Parameters:
/// - company: The company model to evaluate
/// - filterParam: The fundamental filter with criteria to check
///
/// Returns:
/// - bool: true if the company matches the complex criteria
bool _matchesComplexCriteria(
    CompanyModel company, filter.FundamentalFilter filterParam) {
  try {
    switch (filterParam.type) {
      // Complex multi-field quality assessment
      case filter.FundamentalType.qualityStocks:
        return company.qualityScore >= 3 &&
            (company.roe ?? 0) > 12.0 &&
            (company.debtToEquity ?? double.infinity) < 0.5;

      // Comprehensive balance sheet strength evaluation
      case filter.FundamentalType.strongBalance:
        return (company.currentRatio ?? 0) > 1.5 &&
            (company.debtToEquity ?? double.infinity) < 0.3 &&
            (company.interestCoverage ?? 0) > 5.0;

      // Multi-metric value assessment
      case filter.FundamentalType.valueStocks:
        return (company.stockPe ?? double.infinity) < 12.0 &&
            (company.priceToBook ?? double.infinity) < 1.5 &&
            (company.roe ?? 0) > 10.0;

      // Contrarian investment criteria (beaten down but quality)
      case filter.FundamentalType.contrarian:
        return company.changePercent < -10.0 &&
            (company.roe ?? 0) > 10.0 &&
            company.qualityScore >= 2;

      // Precise market cap categorization
      case filter.FundamentalType.midCap:
        return (company.marketCap ?? 0) > 5000 &&
            (company.marketCap ?? 0) <= 20000;

      // Low volatility with risk metrics
      case filter.FundamentalType.lowVolatility:
        return (company.volatility1Y ?? double.infinity) < 25.0 &&
            (company.betaValue ?? double.infinity) < 1.0;

      // Growth stock validation with multiple metrics
      case filter.FundamentalType.growthStocks:
        return company.isGrowthStock ||
            ((company.salesGrowth3Y ?? 0) > 15.0 &&
                (company.profitGrowth3Y ?? 0) > 15.0);

      // Dividend stock validation
      case filter.FundamentalType.dividendStocks:
        return company.paysDividends && (company.dividendYield ?? 0) > 2.0;

      // High dividend yield validation
      case filter.FundamentalType.highDividendYield:
        return company.paysDividends && (company.dividendYield ?? 0) > 4.0;

      // Debt-free company validation
      case filter.FundamentalType.debtFree:
        return company.isDebtFree ||
            (company.debtToEquity ?? double.infinity) < 0.1;

      // High ROE validation
      case filter.FundamentalType.highROE:
        return (company.roe ?? 0) > 15.0;

      // Low P/E validation with positive earnings
      case filter.FundamentalType.lowPE:
        return (company.stockPe ?? double.infinity) < 15.0 &&
            (company.stockPe ?? 0) > 0;

      // Profitable stocks validation
      case filter.FundamentalType.profitableStocks:
        return company.isProfitable && (company.roe ?? 0) > 0;

      // Large cap validation
      case filter.FundamentalType.largeCap:
        return (company.marketCap ?? 0) > 20000;

      // Small cap validation (exclude zero market cap)
      case filter.FundamentalType.smallCap:
        return (company.marketCap ?? 0) < 5000 && (company.marketCap ?? 0) > 0;

      // Default: accept all companies
      default:
        return true;
    }
  } catch (e) {
    // Log error but don't crash the filtering process
    print('Error in _matchesComplexCriteria for ${company.symbol}: $e');
    return false;
  }
}

// ============================================================================
// FILTERED COMPANIES PROVIDER
// ============================================================================

/// Provider that combines fundamental filtering with search functionality
/// This is the main provider used by the UI to get the final filtered list
///
/// Features:
/// - Applies fundamental filters from Firestore
/// - Applies search queries client-side
/// - Sorts results by quality score and market cap
/// - Handles loading and error states
final filteredCompaniesProvider =
    Provider<AsyncValue<List<CompanyModel>>>((ref) {
  // Watch for changes in filter and search state
  final filterParam = ref.watch(selectedFundamentalProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final companies = ref.watch(fundamentalCompaniesProvider(filterParam));

  return companies.when(
    // Success case: we have data to process
    data: (data) {
      try {
        var filteredData = data;

        // Apply search filter using the enhanced search method from CompanyModel
        if (searchQuery.isNotEmpty) {
          filteredData = data
              .where((company) => company.matchesSearchQuery(searchQuery))
              .toList();
        }

        // Sort results for optimal user experience
        // Primary sort: Quality score (higher is better)
        // Secondary sort: Market cap (larger companies first)
        filteredData.sort((a, b) {
          final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
          if (qualityComparison != 0) return qualityComparison;

          final marketCapA = a.marketCap ?? 0;
          final marketCapB = b.marketCap ?? 0;
          return marketCapB.compareTo(marketCapA);
        });

        return AsyncValue.data(filteredData);
      } catch (e) {
        // Return error state if processing fails
        print('Error in filteredCompaniesProvider: $e');
        return AsyncValue.error(e, StackTrace.current);
      }
    },
    // Loading case: show loading indicator
    loading: () => const AsyncValue.loading(),
    // Error case: pass through the error
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

// ============================================================================
// CATEGORY-BASED COMPANIES PROVIDER
// ============================================================================

/// Stream provider that fetches companies for a specific filter category
/// Categories group related filters (e.g., Quality, Growth, Value)
///
/// Parameters:
/// - category: The filter category to fetch companies for
///
/// Returns:
/// - Stream<List<CompanyModel>>: Companies matching any filter in the category
final companiesByCategoryProvider =
    StreamProvider.family<List<CompanyModel>, filter.FilterCategory>(
  (ref, category) {
    try {
      // Get all filters for this category
      final filters = filter.FundamentalFilter.getFiltersByCategory(category);
      if (filters.isEmpty) return Stream.value([]);

      // Fetch a broader set of companies and filter client-side
      // This approach is more efficient than multiple Firestore queries
      return FirebaseFirestore.instance
          .collection('companies')
          .orderBy('marketCap', descending: true)
          .limit(200) // Reasonable limit for category browsing
          .snapshots()
          .map((snapshot) {
        List<CompanyModel> companies = [];

        // Parse each document with error handling
        for (var doc in snapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);

            // Check if company matches any filter in the category
            final matchesAnyFilter = filters.any((filterItem) {
              try {
                return company.matchesFundamentalFilter(filterItem.type) &&
                    _matchesComplexCriteria(company, filterItem);
              } catch (e) {
                print(
                    'Error matching filter ${filterItem.type.name} for ${company.symbol}: $e');
                return false;
              }
            });

            if (matchesAnyFilter) {
              companies.add(company);
            }
          } catch (e) {
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }

        return companies;
      });
    } catch (e) {
      print('Error in companiesByCategoryProvider: $e');
      return Stream.value([]);
    }
  },
);

// ============================================================================
// POPULAR STOCKS PROVIDER
// ============================================================================

/// Stream provider for popular/recommended stocks
/// Features high-quality companies with good market cap
/// Used for the "Popular" or "Recommended" section in the UI
final popularStocksProvider = StreamProvider<List<CompanyModel>>((ref) {
  return FirebaseFirestore.instance
      .collection('companies')
      .where('isQualityStock', isEqualTo: true) // Only quality stocks
      .where('marketCap', isGreaterThan: 1000) // Exclude very small companies
      .orderBy('marketCap', descending: true) // Order by size
      .limit(50) // Reasonable limit for popular stocks
      .snapshots()
      .map((snapshot) {
    List<CompanyModel> companies = [];

    // Parse documents with error handling
    for (var doc in snapshot.docs) {
      try {
        final company = CompanyModel.fromFirestore(doc);
        companies.add(company);
      } catch (e) {
        print('Error parsing popular stock ${doc.id}: $e');
        continue;
      }
    }

    // Sort by quality score first, then market cap
    // This ensures the best companies appear first
    companies.sort((a, b) {
      final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
      if (qualityComparison != 0) return qualityComparison;

      final marketCapA = a.marketCap ?? 0;
      final marketCapB = b.marketCap ?? 0;
      return marketCapB.compareTo(marketCapA);
    });

    return companies;
  });
});

// ============================================================================
// WATCHLIST MANAGEMENT
// ============================================================================

/// Provider for user's watchlist functionality
/// Manages a list of stock symbols that the user wants to track
final watchlistProvider =
    StateNotifierProvider<WatchlistNotifier, List<String>>((ref) {
  return WatchlistNotifier();
});

/// Notifier class that manages watchlist operations
/// Provides methods to add, remove, and check watchlist items
/// In a production app, this would persist to SharedPreferences or Firestore
class WatchlistNotifier extends StateNotifier<List<String>> {
  WatchlistNotifier() : super([]) {
    _loadWatchlist();
  }

  /// Load watchlist from persistent storage
  /// In a real app, this would load from SharedPreferences or Firestore
  Future<void> _loadWatchlist() async {
    try {
      // TODO: Implement actual persistence
      // final prefs = await SharedPreferences.getInstance();
      // final watchlistJson = prefs.getString('watchlist');
      // if (watchlistJson != null) {
      //   state = List<String>.from(jsonDecode(watchlistJson));
      // }
      state = [];
    } catch (e) {
      print('Error loading watchlist: $e');
      state = [];
    }
  }

  /// Save watchlist to persistent storage
  /// In a real app, this would save to SharedPreferences or Firestore
  Future<void> _saveWatchlist() async {
    try {
      // TODO: Implement actual persistence
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('watchlist', jsonEncode(state));
      print('Saving watchlist: $state');
    } catch (e) {
      print('Error saving watchlist: $e');
    }
  }

  /// Add a stock symbol to the watchlist
  /// Prevents duplicates and triggers persistence
  void addToWatchlist(String symbol) {
    if (!state.contains(symbol)) {
      state = [...state, symbol];
      _saveWatchlist();
    }
  }

  /// Remove a stock symbol from the watchlist
  /// Triggers persistence after removal
  void removeFromWatchlist(String symbol) {
    state = state.where((s) => s != symbol).toList();
    _saveWatchlist();
  }

  /// Check if a stock symbol is in the watchlist
  /// Used by UI to show/hide heart icons
  bool isInWatchlist(String symbol) {
    return state.contains(symbol);
  }

  /// Toggle a stock symbol in the watchlist
  /// Convenient method for heart icon tap handlers
  void toggleWatchlist(String symbol) {
    if (isInWatchlist(symbol)) {
      removeFromWatchlist(symbol);
    } else {
      addToWatchlist(symbol);
    }
  }

  /// Clear all items from the watchlist
  /// Used for reset functionality
  void clearWatchlist() {
    state = [];
    _saveWatchlist();
  }
}

// ============================================================================
// FILTER STATISTICS PROVIDER
// ============================================================================

/// Stream provider that calculates statistics for a given fundamental filter
/// Provides metrics like total count, average market cap, and average ROE
/// Used to show filter effectiveness in the UI
final filterStatsProvider =
    StreamProvider.family<FilterStats, filter.FundamentalFilter?>(
  (ref, filterParam) {
    if (filterParam == null) {
      return Stream.value(
          FilterStats(totalCount: 0, avgMarketCap: 0, avgROE: 0));
    }

    return FirebaseFirestore.instance
        .collection('companies')
        .limit(1000) // Limit for performance (don't process entire database)
        .snapshots()
        .map((snapshot) {
      try {
        List<CompanyModel> allCompanies = [];

        // Parse all companies with error handling
        for (var doc in snapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);
            allCompanies.add(company);
          } catch (e) {
            print('Error parsing company ${doc.id} for stats: $e');
            continue;
          }
        }

        // Filter companies that match the criteria
        final filteredCompanies = allCompanies.where((company) {
          try {
            return company.matchesFundamentalFilter(filterParam.type) &&
                _matchesComplexCriteria(company, filterParam);
          } catch (e) {
            print('Error filtering company ${company.symbol} for stats: $e');
            return false;
          }
        }).toList();

        final totalCount = filteredCompanies.length;

        // Calculate average market cap (excluding invalid values)
        final validMarketCaps = filteredCompanies
            .where((c) => c.marketCap != null && c.marketCap! > 0)
            .map((c) => c.marketCap!)
            .toList();

        final avgMarketCap = validMarketCaps.isEmpty
            ? 0.0
            : validMarketCaps.reduce((a, b) => a + b) / validMarketCaps.length;

        // Calculate average ROE (excluding invalid values)
        final validROEs = filteredCompanies
            .where((c) => c.roe != null && c.roe! > 0)
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
        // Return empty stats on error
        print('Error calculating filter stats: $e');
        return FilterStats(totalCount: 0, avgMarketCap: 0, avgROE: 0);
      }
    });
  },
);

// ============================================================================
// FILTER STATISTICS MODEL
// ============================================================================

/// Data model for filter statistics
/// Contains calculated metrics about companies matching a filter
class FilterStats {
  /// Total number of companies matching the filter
  final int totalCount;

  /// Average market capitalization of matching companies (in Cr)
  final double avgMarketCap;

  /// Average return on equity of matching companies (as percentage)
  final double avgROE;

  FilterStats({
    required this.totalCount,
    required this.avgMarketCap,
    required this.avgROE,
  });

  /// Format average market cap for display
  /// Converts to appropriate units (L Cr, K Cr, Cr)
  String get formattedAvgMarketCap {
    if (avgMarketCap >= 100000) {
      return '₹${(avgMarketCap / 100000).toStringAsFixed(1)}L Cr';
    } else if (avgMarketCap >= 1000) {
      return '₹${(avgMarketCap / 1000).toStringAsFixed(1)}K Cr';
    }
    return '₹${avgMarketCap.toStringAsFixed(0)} Cr';
  }

  /// Format average ROE for display
  /// Shows as percentage with one decimal place
  String get formattedAvgROE {
    return '${avgROE.toStringAsFixed(1)}%';
  }
}
