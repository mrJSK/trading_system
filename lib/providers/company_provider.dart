// providers/companies_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/company_model.dart';
import '../models/fundamental_filter.dart' as filter;

class CompaniesNotifier extends StateNotifier<AsyncValue<List<CompanyModel>>> {
  CompaniesNotifier(this._ref) : super(const AsyncValue.loading()) {
    _companies = [];
    _lastDocument = null;
    _hasMore = true;
    _isLoading = false;
  }

  final Ref _ref;
  List<CompanyModel> _companies = [];
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  bool _isLoading = false;

  // ✅ Your debug methods are excellent - keep them as is

  Future<void> debugFetchRawCompanies() async {
    print('=== 🐛 DEBUG: Starting raw companies fetch ===');

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('companies')
          .limit(10)
          .get();

      print('🐛 DEBUG: Query executed successfully');
      print('🐛 DEBUG: Found ${snapshot.docs.length} documents');

      if (snapshot.docs.isEmpty) {
        print('🐛 DEBUG: ❌ No documents found in companies collection');
        return;
      }

      for (int i = 0; i < snapshot.docs.length; i++) {
        final doc = snapshot.docs[i];
        print('--- Document ${i + 1} ---');
        print('📄 Document ID: ${doc.id}');

        try {
          final rawData = doc.data() as Map<String, dynamic>;
          print('📊 Available fields: ${rawData.keys.toList()}');

          // Check essential fields with correct snake_case names
          print('🔍 Fields check:');
          print('  - name: ${rawData['name']}');
          print('  - market_cap: ${rawData['market_cap']}');
          print('  - current_price: ${rawData['current_price']}');
          print('  - change_percent: ${rawData['change_percent']}');
          print('  - last_updated: ${rawData['last_updated']}');
          print('  - roe: ${rawData['roe']}');
          print('  - stock_pe: ${rawData['stock_pe']}');
        } catch (e) {
          print('❌ Error reading document data: $e');
        }
      }

      print('=== ✅ DEBUG: Raw fetch completed successfully ===');
    } catch (error) {
      print('🐛 DEBUG: ❌ Error fetching raw companies: $error');
    }
  }

  Future<void> loadInitialCompanies() async {
    if (_isLoading) return;

    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      print('Loading initial companies...');

      // ✅ Correct snake_case field name
      Query query = FirebaseFirestore.instance
          .collection('companies')
          .orderBy('market_cap', descending: true)
          .limit(50);

      final snapshot = await query.get();
      print('Fetched ${snapshot.docs.length} documents from Firestore');

      List<CompanyModel> companies = [];

      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);
          companies.add(company);
        } catch (e) {
          print('Error parsing company ${doc.id}: $e');
          // 🔥 ENHANCED: Continue instead of breaking the entire load
          continue;
        }
      }

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
      }

      _companies = companies;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print('Successfully loaded ${companies.length} companies');
    } catch (error, stackTrace) {
      print('Error loading initial companies: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadMoreCompanies() async {
    if (_isLoading || !_hasMore || _lastDocument == null) return;
    _isLoading = true;

    try {
      Query query = FirebaseFirestore.instance
          .collection('companies')
          .orderBy('market_cap', descending: true)
          .startAfterDocument(_lastDocument!)
          .limit(20);

      final snapshot = await query.get();

      if (snapshot.docs.isEmpty) {
        _hasMore = false;
      } else {
        List<CompanyModel> newCompanies = [];

        for (var doc in snapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);
            newCompanies.add(company);
          } catch (e) {
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }

        if (newCompanies.isNotEmpty) {
          _companies.addAll(newCompanies);
          _lastDocument = snapshot.docs.last;
          state = AsyncValue.data(_companies);
        }
      }
      _isLoading = false;
    } catch (error, stackTrace) {
      _isLoading = false;
      print('Error loading more companies: $error');
      // 🔥 FIXED: Don't set error state for pagination failures
      // state = AsyncValue.error(error, stackTrace);
    }
  }

  // 🔥 ENHANCED: Better search with multiple strategies
  Future<void> searchCompanies(String query) async {
    if (query.isEmpty || query.trim().isEmpty) {
      await loadInitialCompanies();
      return;
    }

    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      final searchTerm = query.trim();
      List<CompanyModel> searchResults = [];

      print('Searching for: $searchTerm');

      // Strategy 1: Exact symbol match
      var symbolQuery = FirebaseFirestore.instance
          .collection('companies')
          .where('symbol', isEqualTo: searchTerm.toUpperCase())
          .limit(10);

      var snapshot = await symbolQuery.get();

      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);
          searchResults.add(company);
        } catch (e) {
          print('Error parsing company ${doc.id}: $e');
          continue;
        }
      }

      // Strategy 2: Symbol prefix search (if no exact match)
      if (searchResults.isEmpty && searchTerm.length >= 2) {
        symbolQuery = FirebaseFirestore.instance
            .collection('companies')
            .where('symbol', isGreaterThanOrEqualTo: searchTerm.toUpperCase())
            .where('symbol',
                isLessThanOrEqualTo: '${searchTerm.toUpperCase()}\uf8ff')
            .orderBy('symbol')
            .limit(20);

        snapshot = await symbolQuery.get();

        for (var doc in snapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);
            if (!searchResults.any((c) => c.symbol == company.symbol)) {
              searchResults.add(company);
            }
          } catch (e) {
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }
      }

      // Strategy 3: Company name search
      if (searchResults.length < 10 && searchTerm.length >= 2) {
        final nameQuery = FirebaseFirestore.instance
            .collection('companies')
            .where('name', isGreaterThanOrEqualTo: searchTerm)
            .where('name', isLessThanOrEqualTo: '$searchTerm\uf8ff')
            .orderBy('name')
            .limit(20);

        final nameSnapshot = await nameQuery.get();

        for (var doc in nameSnapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);
            if (!searchResults.any((c) => c.symbol == company.symbol)) {
              searchResults.add(company);
            }
          } catch (e) {
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }
      }

      // Strategy 4: Fuzzy client-side search (last resort)
      if (searchResults.isEmpty && searchTerm.length >= 3) {
        print('Trying client-side fuzzy search for: $searchTerm');

        final fuzzyQuery = FirebaseFirestore.instance
            .collection('companies')
            .orderBy('market_cap', descending: true)
            .limit(200); // Increased limit for better fuzzy search

        final fuzzySnapshot = await fuzzyQuery.get();

        for (var doc in fuzzySnapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);
            if (company.matchesSearchQuery(searchTerm)) {
              searchResults.add(company);
              if (searchResults.length >= 20) break;
            }
          } catch (e) {
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }
      }

      _companies = searchResults;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print(
          'Search completed. Found ${searchResults.length} companies for "$searchTerm"');
    } catch (error, stackTrace) {
      print('Search error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // 🔥 ENHANCED: Better fundamental filtering with error handling
  Future<void> applyFundamentalFilter(
      filter.FundamentalFilter fundamentalFilter) async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      Query query = FirebaseFirestore.instance.collection('companies');

      // Apply database-level filters where possible
      switch (fundamentalFilter.type) {
        case filter.FundamentalType.highROE:
          query = query.where('roe', isGreaterThan: 15.0);
          break;
        case filter.FundamentalType.lowPE:
          query = query
              .where('stock_pe',
                  isLessThan: 20.0) // Increased threshold for better results
              .where('stock_pe', isGreaterThan: 0);
          break;
        case filter.FundamentalType.largeCap:
          query = query.where('market_cap', isGreaterThan: 20000);
          break;
        case filter.FundamentalType.midCap:
          query = query
              .where('market_cap', isGreaterThan: 5000)
              .where('market_cap', isLessThanOrEqualTo: 20000);
          break;
        case filter.FundamentalType.smallCap:
          query = query
              .where('market_cap', isLessThan: 5000)
              .where('market_cap', isGreaterThan: 100); // Exclude micro caps
          break;
        case filter.FundamentalType.dividendStocks:
          query = query.where('dividend_yield', isGreaterThan: 1.0);
          break;
        default:
          // For complex filters, rely on client-side filtering
          break;
      }

      // Always order by market cap for consistent results
      if (!query.toString().contains('orderBy')) {
        query = query.orderBy('market_cap', descending: true);
      }

      query = query.limit(200); // Increased for better filtering results

      final snapshot = await query.get();

      List<CompanyModel> companies = [];
      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);
          // Apply client-side filtering using calculated fields
          if (company.matchesFundamentalFilter(fundamentalFilter.type)) {
            companies.add(company);
          }
        } catch (e) {
          print('Error parsing company ${doc.id}: $e');
          continue;
        }
      }

      _companies = companies;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print(
          'Applied filter ${fundamentalFilter.type.name}. Found ${companies.length} companies');
    } catch (error, stackTrace) {
      print('Filter error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // 🔥 ENHANCED: Better quality stocks filtering
  Future<void> loadQualityStocks({int minQualityScore = 3}) async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      // Get companies with good financial metrics
      final query = FirebaseFirestore.instance
          .collection('companies')
          .where('roe', isGreaterThan: 12.0) // Slightly lower threshold
          .orderBy('roe', descending: true) // Order by ROE first
          .limit(150);

      final snapshot = await query.get();

      List<CompanyModel> companies = [];
      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);
          // Use calculated quality score from your CompanyModel
          if (company.qualityScore >= minQualityScore) {
            companies.add(company);
          }
        } catch (e) {
          print('Error parsing company ${doc.id}: $e');
          continue;
        }
      }

      // Sort by quality score descending
      companies.sort((a, b) => b.qualityScore.compareTo(a.qualityScore));

      _companies = companies;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print(
          'Loaded ${companies.length} quality stocks with min score $minQualityScore');
    } catch (error, stackTrace) {
      print('Quality stocks error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // 🔥 ENHANCED: Better top performers with error handling
  Future<void> loadTopPerformers() async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      final query = FirebaseFirestore.instance
          .collection('companies')
          .where('change_percent',
              isGreaterThan: 2.0) // Lower threshold for more results
          .orderBy('change_percent', descending: true)
          .limit(100); // Increased limit

      final snapshot = await query.get();

      List<CompanyModel> companies = [];
      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);
          companies.add(company);
        } catch (e) {
          print('Error parsing company ${doc.id}: $e');
          continue;
        }
      }

      _companies = companies;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print('Loaded ${companies.length} top performers');
    } catch (error, stackTrace) {
      print('Top performers error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // 🔥 NEW: Add method to get current state info
  CompaniesState get currentState {
    return CompaniesState(
      companies: _companies,
      isLoading: _isLoading,
      hasMore: _hasMore,
      lastDocument: _lastDocument,
    );
  }

  // ✅ Your existing utility methods are good - keep them
  Future<void> applyFilters() async {
    _reset();
    await loadInitialCompanies();
  }

  Future<void> refreshCompanies() async {
    _reset();
    await loadInitialCompanies();
  }

  void _reset() {
    _companies.clear();
    _lastDocument = null;
    _hasMore = true;
    _isLoading = false;
  }

  // ✅ Keep your debug methods as they are - they're excellent
  Future<void> debugFirestoreData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('companies')
          .limit(5)
          .get();

      print('Total documents in collection: ${snapshot.size}');

      for (var doc in snapshot.docs) {
        print('Document ${doc.id}: ${doc.data()}');
      }
    } catch (e) {
      print('Debug error: $e');
    }
  }
}

// 🔥 NEW: Add state class for better state management
class CompaniesState {
  final List<CompanyModel> companies;
  final bool isLoading;
  final bool hasMore;
  final DocumentSnapshot? lastDocument;

  CompaniesState({
    required this.companies,
    required this.isLoading,
    required this.hasMore,
    this.lastDocument,
  });
}

final companiesProvider =
    StateNotifierProvider<CompaniesNotifier, AsyncValue<List<CompanyModel>>>(
  (ref) => CompaniesNotifier(ref),
);

// ✅ Your FilterSettings and RangeFilter classes are perfect - keep them as is
class FilterSettings {
  final RangeFilter marketCap;
  final RangeFilter peRatio;
  final RangeFilter roe;
  final RangeFilter debtToEquity;
  final RangeFilter dividendYield;
  final RangeFilter qualityScore;
  final List<String> selectedSectors;
  final List<String> marketCapCategories;
  final bool onlyProfitable;
  final bool onlyDebtFree;
  final bool onlyDividendPaying;
  final bool onlyGrowthStocks;
  final bool onlyQualityStocks;
  final String sortBy;
  final bool sortDescending;
  final int pageSize;

  FilterSettings({
    required this.marketCap,
    required this.peRatio,
    required this.roe,
    required this.debtToEquity,
    required this.dividendYield,
    required this.qualityScore,
    this.selectedSectors = const [],
    this.marketCapCategories = const [],
    this.onlyProfitable = false,
    this.onlyDebtFree = false,
    this.onlyDividendPaying = false,
    this.onlyGrowthStocks = false,
    this.onlyQualityStocks = false,
    this.sortBy = 'marketCap',
    this.sortDescending = true,
    this.pageSize = 20,
  });

  // ✅ Keep your copyWith method as is
  FilterSettings copyWith({
    RangeFilter? marketCap,
    RangeFilter? peRatio,
    RangeFilter? roe,
    RangeFilter? debtToEquity,
    RangeFilter? dividendYield,
    RangeFilter? qualityScore,
    List<String>? selectedSectors,
    List<String>? marketCapCategories,
    bool? onlyProfitable,
    bool? onlyDebtFree,
    bool? onlyDividendPaying,
    bool? onlyGrowthStocks,
    bool? onlyQualityStocks,
    String? sortBy,
    bool? sortDescending,
    int? pageSize,
  }) {
    return FilterSettings(
      marketCap: marketCap ?? this.marketCap,
      peRatio: peRatio ?? this.peRatio,
      roe: roe ?? this.roe,
      debtToEquity: debtToEquity ?? this.debtToEquity,
      dividendYield: dividendYield ?? this.dividendYield,
      qualityScore: qualityScore ?? this.qualityScore,
      selectedSectors: selectedSectors ?? this.selectedSectors,
      marketCapCategories: marketCapCategories ?? this.marketCapCategories,
      onlyProfitable: onlyProfitable ?? this.onlyProfitable,
      onlyDebtFree: onlyDebtFree ?? this.onlyDebtFree,
      onlyDividendPaying: onlyDividendPaying ?? this.onlyDividendPaying,
      onlyGrowthStocks: onlyGrowthStocks ?? this.onlyGrowthStocks,
      onlyQualityStocks: onlyQualityStocks ?? this.onlyQualityStocks,
      sortBy: sortBy ?? this.sortBy,
      sortDescending: sortDescending ?? this.sortDescending,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

// ✅ Keep RangeFilter as is
class RangeFilter {
  final bool isActive;
  final double? min;
  final double? max;

  RangeFilter({
    this.isActive = false,
    this.min,
    this.max,
  });

  RangeFilter copyWith({
    bool? isActive,
    double? min,
    double? max,
  }) {
    return RangeFilter(
      isActive: isActive ?? this.isActive,
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }
}

final filterSettingsProvider = StateProvider<FilterSettings>((ref) {
  return FilterSettings(
    marketCap: RangeFilter(),
    peRatio: RangeFilter(),
    roe: RangeFilter(),
    debtToEquity: RangeFilter(),
    dividendYield: RangeFilter(),
    qualityScore: RangeFilter(),
  );
});
