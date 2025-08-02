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

  // Enhanced debug methods for new financial fields
  Future<void> debugFetchRawCompanies() async {
    print('=== 🐛 DEBUG: Starting enhanced raw companies fetch ===');

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

          // Check essential fields
          print('🔍 Basic fields check:');
          print('  - name: ${rawData['name']}');
          print('  - market_cap: ${rawData['market_cap']}');
          print('  - current_price: ${rawData['current_price']}');
          print('  - roe: ${rawData['roe']}');
          print('  - stock_pe: ${rawData['stock_pe']}');

          // Check enhanced ratios from updated scraper
          print('🎯 Enhanced ratio fields:');
          print('  - debt_to_equity: ${rawData['debt_to_equity']}');
          print('  - current_ratio: ${rawData['current_ratio']}');
          print('  - working_capital_days: ${rawData['working_capital_days']}');
          print('  - debtor_days: ${rawData['debtor_days']}');
          print('  - inventory_days: ${rawData['inventory_days']}');
          print(
              '  - cash_conversion_cycle: ${rawData['cash_conversion_cycle']}');

          // Check quality scores
          print('📈 Quality score fields:');
          print('  - piotroski_score: ${rawData['piotroski_score']}');
          print('  - quality_grade: ${rawData['quality_grade']}');
        } catch (e) {
          print('❌ Error reading document data: $e');
        }
      }

      print('=== ✅ DEBUG: Enhanced raw fetch completed successfully ===');
    } catch (error) {
      print('🐛 DEBUG: ❌ Error fetching raw companies: $error');
    }
  }

  Future<void> loadInitialCompanies() async {
    if (_isLoading) return;

    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      print('Loading initial companies with enhanced data...');

      // Enhanced query with better filtering
      Query query = FirebaseFirestore.instance
          .collection('companies')
          .where('market_cap', isGreaterThan: 100) // Filter micro companies
          .orderBy('market_cap', descending: true)
          .limit(50);

      final snapshot = await query.get();
      print('Fetched ${snapshot.docs.length} documents from Firestore');

      List<CompanyModel> companies = [];

      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);
          companies.add(company);

          // Debug enhanced data parsing
          print('✅ ${company.symbol}: Quality=${company.overallQualityGrade}, '
              'WCDays=${company.workingCapitalDays}, '
              'DebtRatio=${company.debtToEquity}');
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

      print(
          'Successfully loaded ${companies.length} companies with enhanced financial data');
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
          .where('market_cap', isGreaterThan: 100)
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
    }
  }

  // Enhanced search with quality score consideration
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
      print('Enhanced search for: $searchTerm');

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

      // Strategy 2: Symbol prefix search
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

      // Strategy 4: Enhanced fuzzy search with quality prioritization
      if (searchResults.isEmpty && searchTerm.length >= 3) {
        print('Trying enhanced fuzzy search for: $searchTerm');
        final fuzzyQuery = FirebaseFirestore.instance
            .collection('companies')
            .where('market_cap', isGreaterThan: 500)
            .orderBy('market_cap', descending: true)
            .limit(300);

        final fuzzySnapshot = await fuzzyQuery.get();
        for (var doc in fuzzySnapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);
            if (company.matchesSearchQuery(searchTerm)) {
              searchResults.add(company);
              if (searchResults.length >= 25) break;
            }
          } catch (e) {
            print('Error parsing company ${doc.id}: $e');
            continue;
          }
        }
      }

      // Enhanced sorting by quality score then market cap
      searchResults.sort((a, b) {
        final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
        if (qualityComparison != 0) return qualityComparison;
        return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
      });

      _companies = searchResults;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print(
          'Enhanced search completed. Found ${searchResults.length} companies for "$searchTerm"');
    } catch (error, stackTrace) {
      print('Search error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Enhanced fundamental filtering with new ratios
  Future<void> applyFundamentalFilter(
      filter.FundamentalFilter fundamentalFilter) async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      Query query = FirebaseFirestore.instance.collection('companies');

      // Apply enhanced database-level filters
      switch (fundamentalFilter.type) {
        case filter.FundamentalType.debtFree:
          query = query
              .where('debt_to_equity', isLessThan: 0.1)
              .where('roe', isGreaterThan: 0)
              .orderBy('debt_to_equity')
              .orderBy('roe', descending: true);
          break;
        case filter.FundamentalType.highROE:
          query = query
              .where('roe', isGreaterThan: 15.0)
              .orderBy('roe', descending: true);
          break;
        case filter.FundamentalType.lowPE:
          query = query
              .where('stock_pe', isLessThan: 20.0)
              .where('stock_pe', isGreaterThan: 0)
              .orderBy('stock_pe');
          break;
        case filter.FundamentalType.largeCap:
          query = query
              .where('market_cap', isGreaterThan: 20000)
              .orderBy('market_cap', descending: true);
          break;
        case filter.FundamentalType.midCap:
          query = query
              .where('market_cap', isGreaterThan: 5000)
              .where('market_cap', isLessThanOrEqualTo: 20000)
              .orderBy('market_cap', descending: true);
          break;
        case filter.FundamentalType.smallCap:
          query = query
              .where('market_cap', isLessThan: 5000)
              .where('market_cap', isGreaterThan: 100)
              .orderBy('market_cap', descending: true);
          break;
        case filter.FundamentalType.dividendStocks:
          query = query
              .where('dividend_yield', isGreaterThan: 1.0)
              .orderBy('dividend_yield', descending: true);
          break;
        case filter.FundamentalType.qualityStocks:
          // Use enhanced ratios for quality filtering
          query = query
              .where('current_ratio', isGreaterThan: 1.5)
              .where('roe', isGreaterThan: 12.0)
              .orderBy('current_ratio', descending: true)
              .orderBy('roe', descending: true);
          break;
        default:
          query = query.orderBy('market_cap', descending: true);
          break;
      }

      query = query.limit(200);
      final snapshot = await query.get();

      List<CompanyModel> companies = [];
      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);

          // Apply enhanced client-side filtering
          if (company.matchesFundamentalFilter(fundamentalFilter.type)) {
            companies.add(company);
          }
        } catch (e) {
          print('Error parsing company ${doc.id}: $e');
          continue;
        }
      }

      // Enhanced sorting by quality score
      companies.sort((a, b) {
        final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
        if (qualityComparison != 0) return qualityComparison;
        return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
      });

      _companies = companies;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print(
          'Applied filter ${fundamentalFilter.type.name}. Found ${companies.length} companies with enhanced scoring');
    } catch (error, stackTrace) {
      print('Filter error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Enhanced quality stocks loading with multiple criteria
  Future<void> loadQualityStocks({int minQualityScore = 3}) async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      // Enhanced query using multiple quality indicators
      var query = FirebaseFirestore.instance
          .collection('companies')
          .where('roe', isGreaterThan: 12.0)
          .where('current_ratio', isGreaterThan: 1.2)
          .orderBy('roe', descending: true)
          .orderBy('current_ratio', descending: true)
          .limit(150);

      var snapshot = await query.get();

      List<CompanyModel> companies = [];
      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);

          // Enhanced quality filtering
          if (company.qualityScore >= minQualityScore) {
            companies.add(company);
          }
        } catch (e) {
          print('Error parsing company ${doc.id}: $e');
          continue;
        }
      }

      // Enhanced sorting by multiple quality metrics
      companies.sort((a, b) {
        // Primary: Quality score
        final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
        if (qualityComparison != 0) return qualityComparison;

        // Secondary: ROE
        final roeA = a.roe ?? 0;
        final roeB = b.roe ?? 0;
        final roeComparison = roeB.compareTo(roeA);
        if (roeComparison != 0) return roeComparison;

        // Tertiary: Working capital efficiency
        final wcA = a.workingCapitalDays ?? double.infinity;
        final wcB = b.workingCapitalDays ?? double.infinity;
        return wcA.compareTo(wcB); // Lower is better
      });

      _companies = companies;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print(
          'Loaded ${companies.length} enhanced quality stocks with min score $minQualityScore');
    } catch (error, stackTrace) {
      print('Quality stocks error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Enhanced top performers with quality consideration
  Future<void> loadTopPerformers() async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      final query = FirebaseFirestore.instance
          .collection('companies')
          .where('change_percent', isGreaterThan: 1.0)
          .where('market_cap', isGreaterThan: 1000)
          .orderBy('change_percent', descending: true)
          .limit(100);

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

      // Enhanced sorting considering both performance and quality
      companies.sort((a, b) {
        // Primary: Change percent
        final changeComparison = b.changePercent.compareTo(a.changePercent);
        if (changeComparison.abs() > 1.0) return changeComparison;

        // Secondary: Quality score for similar performers
        final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
        if (qualityComparison != 0) return qualityComparison;

        // Tertiary: Market cap
        return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
      });

      _companies = companies;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print('Loaded ${companies.length} enhanced top performers');
    } catch (error, stackTrace) {
      print('Top performers error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Enhanced working capital efficient companies
  Future<void> loadWorkingCapitalEfficient() async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      final query = FirebaseFirestore.instance
          .collection('companies')
          .where('working_capital_days', isLessThan: 60)
          .where('current_ratio', isGreaterThan: 1.5)
          .orderBy('working_capital_days')
          .orderBy('current_ratio', descending: true)
          .limit(100);

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

      print('Loaded ${companies.length} working capital efficient companies');
    } catch (error, stackTrace) {
      print('Working capital efficient error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Enhanced state management methods
  CompaniesState get currentState {
    return CompaniesState(
      companies: _companies,
      isLoading: _isLoading,
      hasMore: _hasMore,
      lastDocument: _lastDocument,
    );
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

  Future<void> debugFirestoreData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('companies')
          .limit(5)
          .get();

      print(
          '=== Enhanced Debug: Total documents in collection: ${snapshot.size} ===');

      for (var doc in snapshot.docs) {
        final data = doc.data();
        print('Document ${doc.id}:');
        print(
            '  Basic: name=${data['name']}, market_cap=${data['market_cap']}');
        print(
            '  Enhanced: debt_to_equity=${data['debt_to_equity']}, working_capital_days=${data['working_capital_days']}');
        print(
            '  Quality: piotroski_score=${data['piotroski_score']}, quality_grade=${data['quality_grade']}');
      }
    } catch (e) {
      print('Enhanced debug error: $e');
    }
  }
}

// Enhanced state class
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

// Enhanced filter settings with new financial ratio filters
class FilterSettings {
  final RangeFilter marketCap;
  final RangeFilter peRatio;
  final RangeFilter roe;
  final RangeFilter debtToEquity;
  final RangeFilter dividendYield;
  final RangeFilter qualityScore;
  final RangeFilter currentRatio; // NEW
  final RangeFilter workingCapitalDays; // NEW
  final RangeFilter cashConversionCycle; // NEW
  final List<String> selectedSectors;
  final List<String> marketCapCategories;
  final bool onlyProfitable;
  final bool onlyDebtFree;
  final bool onlyDividendPaying;
  final bool onlyGrowthStocks;
  final bool onlyQualityStocks;
  final bool onlyWorkingCapitalEfficient; // NEW
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
    required this.currentRatio,
    required this.workingCapitalDays,
    required this.cashConversionCycle,
    this.selectedSectors = const [],
    this.marketCapCategories = const [],
    this.onlyProfitable = false,
    this.onlyDebtFree = false,
    this.onlyDividendPaying = false,
    this.onlyGrowthStocks = false,
    this.onlyQualityStocks = false,
    this.onlyWorkingCapitalEfficient = false,
    this.sortBy = 'qualityScore',
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
    RangeFilter? currentRatio,
    RangeFilter? workingCapitalDays,
    RangeFilter? cashConversionCycle,
    List<String>? selectedSectors,
    List<String>? marketCapCategories,
    bool? onlyProfitable,
    bool? onlyDebtFree,
    bool? onlyDividendPaying,
    bool? onlyGrowthStocks,
    bool? onlyQualityStocks,
    bool? onlyWorkingCapitalEfficient,
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
      currentRatio: currentRatio ?? this.currentRatio,
      workingCapitalDays: workingCapitalDays ?? this.workingCapitalDays,
      cashConversionCycle: cashConversionCycle ?? this.cashConversionCycle,
      selectedSectors: selectedSectors ?? this.selectedSectors,
      marketCapCategories: marketCapCategories ?? this.marketCapCategories,
      onlyProfitable: onlyProfitable ?? this.onlyProfitable,
      onlyDebtFree: onlyDebtFree ?? this.onlyDebtFree,
      onlyDividendPaying: onlyDividendPaying ?? this.onlyDividendPaying,
      onlyGrowthStocks: onlyGrowthStocks ?? this.onlyGrowthStocks,
      onlyQualityStocks: onlyQualityStocks ?? this.onlyQualityStocks,
      onlyWorkingCapitalEfficient:
          onlyWorkingCapitalEfficient ?? this.onlyWorkingCapitalEfficient,
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
    currentRatio: RangeFilter(),
    workingCapitalDays: RangeFilter(),
    cashConversionCycle: RangeFilter(),
  );
});
