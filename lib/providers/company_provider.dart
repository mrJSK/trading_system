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

  Future<void> loadInitialCompanies() async {
    if (_isLoading) return;

    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      print('Loading initial companies...');

      // Simplified initial query to avoid complex filtering issues
      Query query = FirebaseFirestore.instance
          .collection('companies')
          .orderBy('marketCap', descending: true)
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
    if (_isLoading || !_hasMore) return;
    _isLoading = true;

    try {
      Query query = FirebaseFirestore.instance
          .collection('companies')
          .orderBy('marketCap', descending: true)
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
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<List<CompanyModel>> _fetchCompaniesFromFirestore({
    required int limit,
    required FilterSettings filters,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query query = FirebaseFirestore.instance.collection('companies');

      // Apply filters only if they won't cause Firestore query complexity issues
      bool hasComplexFilters = false;

      // Market Cap filtering
      if (filters.marketCap.isActive) {
        if (filters.marketCap.min != null) {
          query = query.where('marketCap',
              isGreaterThanOrEqualTo: filters.marketCap.min! * 100);
          hasComplexFilters = true;
        }
        if (filters.marketCap.max != null) {
          query = query.where('marketCap',
              isLessThanOrEqualTo: filters.marketCap.max! * 100);
          hasComplexFilters = true;
        }
      }

      // Only apply one additional filter to avoid Firestore complexity limits
      if (!hasComplexFilters) {
        if (filters.onlyDebtFree) {
          query = query.where('isDebtFree', isEqualTo: true);
        } else if (filters.onlyProfitable) {
          query = query.where('isProfitable', isEqualTo: true);
        } else if (filters.onlyDividendPaying) {
          query = query.where('paysDividends', isEqualTo: true);
        } else if (filters.onlyGrowthStocks) {
          query = query.where('isGrowthStock', isEqualTo: true);
        } else if (filters.onlyQualityStocks) {
          query = query.where('isQualityStock', isEqualTo: true);
        }
      }

      // Simple sorting
      switch (filters.sortBy) {
        case 'marketCap':
          query =
              query.orderBy('marketCap', descending: filters.sortDescending);
          break;
        case 'changePercent':
          query = query.orderBy('changePercent',
              descending: filters.sortDescending);
          break;
        default:
          query = query.orderBy('marketCap', descending: true);
      }

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      query = query.limit(limit);
      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
      }

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

      return companies;
    } catch (e) {
      print('Firestore query error: $e');
      throw Exception('Failed to fetch companies: $e');
    }
  }

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

      // First, try exact symbol match
      var symbolQuery = FirebaseFirestore.instance
          .collection('companies')
          .where('symbol', isEqualTo: searchTerm.toUpperCase())
          .limit(10);

      var snapshot = await symbolQuery.get();

      // Safe parsing of search results
      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);
          searchResults.add(company);
        } catch (e) {
          print('Error parsing company ${doc.id}: $e');
          continue;
        }
      }

      // If no exact match, try prefix search for symbol
      if (searchResults.isEmpty) {
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
            searchResults.add(company);
          } catch (e) {
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }
      }

      // Also search by company name (case-insensitive approach)
      if (searchResults.length < 10) {
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
            // Check if already exists to avoid duplicates
            if (!searchResults.any((c) => c.symbol == company.symbol)) {
              searchResults.add(company);
            }
          } catch (e) {
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }
      }

      // If still no results, try case-insensitive fuzzy search
      if (searchResults.isEmpty && searchTerm.length >= 2) {
        print('Trying fuzzy search for: $searchTerm');

        final fuzzyQuery = FirebaseFirestore.instance
            .collection('companies')
            .limit(100); // Reduced limit for better performance

        final fuzzySnapshot = await fuzzyQuery.get();

        for (var doc in fuzzySnapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);

            // Use the enhanced search helper from CompanyModel
            if (company.matchesSearchQuery(searchTerm)) {
              searchResults.add(company);
              if (searchResults.length >= 20) break; // Limit results
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

  Future<void> applyFundamentalFilter(
      filter.FundamentalFilter fundamentalFilter) async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      Query query = FirebaseFirestore.instance.collection('companies');

      // Apply fundamental filter logic with error handling
      switch (fundamentalFilter.type) {
        case filter.FundamentalType.debtFree:
          query = query.where('isDebtFree', isEqualTo: true);
          break;
        case filter.FundamentalType.highROE:
          query = query.where('roe', isGreaterThan: 15.0);
          break;
        case filter.FundamentalType.lowPE:
          query = query
              .where('stockPe', isLessThan: 15.0)
              .where('stockPe', isGreaterThan: 0); // Exclude negative P/E
          break;
        case filter.FundamentalType.dividendStocks:
          query = query.where('paysDividends', isEqualTo: true);
          break;
        case filter.FundamentalType.growthStocks:
          query = query.where('isGrowthStock', isEqualTo: true);
          break;
        case filter.FundamentalType.qualityStocks:
          query = query.where('isQualityStock', isEqualTo: true);
          break;
        case filter.FundamentalType.largeCap:
          query = query.where('marketCap', isGreaterThan: 20000);
          break;
        case filter.FundamentalType.midCap:
          query = query
              .where('marketCap', isGreaterThan: 5000)
              .where('marketCap', isLessThanOrEqualTo: 20000);
          break;
        case filter.FundamentalType.smallCap:
          query = query.where('marketCap', isLessThan: 5000).where('marketCap',
              isGreaterThan: 0); // Exclude zero/negative market cap
          break;
        case filter.FundamentalType.profitableStocks:
          query = query.where('isProfitable', isEqualTo: true);
          break;
        case filter.FundamentalType.highSalesGrowth:
          query = query.where('salesGrowth3Y', isGreaterThan: 20.0);
          break;
        default:
          // Fallback to all companies
          break;
      }

      query = query.orderBy('marketCap', descending: true).limit(100);
      final snapshot = await query.get();

      List<CompanyModel> companies = [];
      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);
          // Double-check with the model's filter method
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

  Future<void> loadQualityStocks({int minQualityScore = 3}) async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      // Simple query to avoid complexity
      final query = FirebaseFirestore.instance
          .collection('companies')
          .where('isQualityStock', isEqualTo: true)
          .orderBy('marketCap', descending: true)
          .limit(50);

      final snapshot = await query.get();

      List<CompanyModel> companies = [];
      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);
          // Client-side filtering for quality score
          if (company.qualityScore >= minQualityScore) {
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
    } catch (error, stackTrace) {
      print('Quality stocks error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadTopPerformers() async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      final query = FirebaseFirestore.instance
          .collection('companies')
          .where('changePercent', isGreaterThan: 5.0)
          .orderBy('changePercent', descending: true)
          .limit(50);

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
    } catch (error, stackTrace) {
      print('Top performers error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Debug method to test database connection
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

final companiesProvider =
    StateNotifierProvider<CompaniesNotifier, AsyncValue<List<CompanyModel>>>(
  (ref) => CompaniesNotifier(ref),
);

// Enhanced FilterSettings class with better defaults
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
