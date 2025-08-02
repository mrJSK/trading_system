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

  // Enhanced debug methods for new financial fields including key points
  Future<void> debugFetchRawCompanies() async {
    print(
        '=== 🐛 DEBUG: Starting comprehensive raw companies fetch with key points ===');

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
          print('  - interest_coverage: ${rawData['interest_coverage']}');

          // Check quality and efficiency scores
          print('📈 Quality & efficiency fields:');
          print('  - quality_score: ${rawData['quality_score']}');
          print(
              '  - overall_quality_grade: ${rawData['overall_quality_grade']}');
          print(
              '  - working_capital_efficiency: ${rawData['working_capital_efficiency']}');
          print('  - liquidity_status: ${rawData['liquidity_status']}');
          print('  - debt_status: ${rawData['debt_status']}');
          print('  - risk_level: ${rawData['risk_level']}');

          // NEW: Check key points and company insights
          print('🏢 Key points & company insights:');
          print(
              '  - business_overview: ${rawData['business_overview']?.toString().substring(0, 100) ?? 'N/A'}...');
          print('  - sector: ${rawData['sector']}');
          print('  - industry: ${rawData['industry']}');
          print(
              '  - industry_classification: ${rawData['industry_classification']}');
          print('  - recent_performance: ${rawData['recent_performance']}');
          print(
              '  - key_milestones: ${rawData['key_milestones']?.length ?? 0} milestones');
          print(
              '  - investment_highlights: ${rawData['investment_highlights']?.length ?? 0} highlights');
          print(
              '  - financial_summary: ${rawData['financial_summary']?.length ?? 0} summary items');

          // Check historical data
          print('📊 Historical data:');
          print(
              '  - annual_data_history: ${rawData['annual_data_history']?.length ?? 0} years');
          print(
              '  - quarterly_data_history: ${rawData['quarterly_data_history']?.length ?? 0} quarters');

          // Check legacy vs new field mapping
          print('🔄 Field mapping check:');
          print('  - sales_growth_3y: ${rawData['sales_growth_3y']}');
          print('  - profit_growth_3y: ${rawData['profit_growth_3y']}');
          print(
              '  - Compounded Sales Growth (legacy): ${rawData['Compounded Sales Growth']}');
          print(
              '  - Compounded Profit Growth (legacy): ${rawData['Compounded Profit Growth']}');
        } catch (e) {
          print('❌ Error reading document data: $e');
        }
      }

      print('=== ✅ DEBUG: Comprehensive raw fetch completed successfully ===');
    } catch (error) {
      print('🐛 DEBUG: ❌ Error fetching raw companies: $error');
    }
  }

  Future<void> loadInitialCompanies() async {
    if (_isLoading) return;

    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      print('Loading initial companies with enhanced data and key points...');

      // Enhanced query with better filtering for quality data
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

          // Enhanced debug with key points data
          print('✅ ${company.symbol}: '
              'Quality=${company.overallQualityGrade}(${company.qualityScore}), '
              'WCDays=${company.workingCapitalDays}, '
              'DebtRatio=${company.debtToEquity}, '
              'Sector=${company.sector}, '
              'BusinessOverview=${company.businessOverview.isNotEmpty ? "✓" : "✗"}, '
              'Milestones=${company.keyMilestones.length}, '
              'Highlights=${company.investmentHighlights.length}');
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
          'Successfully loaded ${companies.length} companies with enhanced financial data and key points');
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

  // Enhanced search with sector/industry and key points consideration
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
      print('Enhanced search with key points for: $searchTerm');

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

      // NEW Strategy 4: Sector-based search
      if (searchResults.length < 15 && searchTerm.length >= 3) {
        final sectorQuery = FirebaseFirestore.instance
            .collection('companies')
            .where('sector', isGreaterThanOrEqualTo: searchTerm)
            .where('sector', isLessThanOrEqualTo: '$searchTerm\uf8ff')
            .orderBy('sector')
            .orderBy('market_cap', descending: true)
            .limit(20);

        try {
          final sectorSnapshot = await sectorQuery.get();
          for (var doc in sectorSnapshot.docs) {
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
        } catch (e) {
          print('Sector search failed (expected for missing indices): $e');
        }
      }

      // Strategy 5: Enhanced fuzzy search with quality prioritization
      if (searchResults.isEmpty && searchTerm.length >= 3) {
        print(
            'Trying enhanced fuzzy search with key points matching for: $searchTerm');
        final fuzzyQuery = FirebaseFirestore.instance
            .collection('companies')
            .where('market_cap', isGreaterThan: 500)
            .orderBy('market_cap', descending: true)
            .limit(300);

        final fuzzySnapshot = await fuzzyQuery.get();
        for (var doc in fuzzySnapshot.docs) {
          try {
            final company = CompanyModel.fromFirestore(doc);
            // Enhanced matching includes sector and industry
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

      // Enhanced sorting by quality score, then sector relevance, then market cap
      searchResults.sort((a, b) {
        // Primary: Quality score
        final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
        if (qualityComparison != 0) return qualityComparison;

        // Secondary: Sector match relevance
        final aHasSector =
            a.sector?.toLowerCase().contains(searchTerm.toLowerCase()) ?? false;
        final bHasSector =
            b.sector?.toLowerCase().contains(searchTerm.toLowerCase()) ?? false;
        if (aHasSector && !bHasSector) return -1;
        if (!aHasSector && bHasSector) return 1;

        // Tertiary: Market cap
        return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
      });

      _companies = searchResults;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print(
          'Enhanced search with key points completed. Found ${searchResults.length} companies for "$searchTerm"');
    } catch (error, stackTrace) {
      print('Search error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Enhanced fundamental filtering with new ratios and quality metrics
  Future<void> applyFundamentalFilter(
      filter.FundamentalFilter fundamentalFilter) async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      Query query = FirebaseFirestore.instance.collection('companies');

      // Apply enhanced database-level filters with new quality metrics
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
          // Enhanced quality filtering with multiple criteria
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

      // Enhanced sorting by quality score and efficiency metrics
      companies.sort((a, b) {
        final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
        if (qualityComparison != 0) return qualityComparison;

        // Secondary: Working capital efficiency for similar quality companies
        final aWCDays = a.workingCapitalDays ?? double.infinity;
        final bWCDays = b.workingCapitalDays ?? double.infinity;
        final wcComparison = aWCDays.compareTo(bWCDays); // Lower is better
        if (wcComparison != 0) return wcComparison;

        return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
      });

      _companies = companies;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print(
          'Applied enhanced filter ${fundamentalFilter.type.name}. Found ${companies.length} companies with quality scoring');
    } catch (error, stackTrace) {
      print('Filter error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Enhanced quality stocks loading with comprehensive quality assessment
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

          // Enhanced quality filtering with multiple criteria
          if (company.qualityScore >= minQualityScore) {
            companies.add(company);
          }
        } catch (e) {
          print('Error parsing company ${doc.id}: $e');
          continue;
        }
      }

      // Enhanced sorting by comprehensive quality metrics
      companies.sort((a, b) {
        // Primary: Quality score
        final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
        if (qualityComparison != 0) return qualityComparison;

        // Secondary: ROE
        final roeA = a.roe ?? 0;
        final roeB = b.roe ?? 0;
        final roeComparison = roeB.compareTo(roeA);
        if (roeComparison != 0) return roeComparison;

        // Tertiary: Working capital efficiency (lower days = better)
        final wcA = a.workingCapitalDays ?? double.infinity;
        final wcB = b.workingCapitalDays ?? double.infinity;
        final wcComparison = wcA.compareTo(wcB);
        if (wcComparison != 0) return wcComparison;

        // Quaternary: Debt level (lower = better)
        final debtA = a.debtToEquity ?? double.infinity;
        final debtB = b.debtToEquity ?? double.infinity;
        return debtA.compareTo(debtB);
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

  // Enhanced top performers with quality and sector consideration
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

      // Enhanced sorting considering performance, quality, and sector diversity
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

      print(
          'Loaded ${companies.length} enhanced top performers with quality metrics');
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

  // NEW: Load companies by sector
  Future<void> loadCompaniesBySector(String sector) async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      final query = FirebaseFirestore.instance
          .collection('companies')
          .where('sector', isEqualTo: sector)
          .where('market_cap', isGreaterThan: 500)
          .orderBy('market_cap', descending: true)
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

      // Sort by quality score within sector
      companies.sort((a, b) {
        final qualityComparison = b.qualityScore.compareTo(a.qualityScore);
        if (qualityComparison != 0) return qualityComparison;
        return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
      });

      _companies = companies;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print('Loaded ${companies.length} companies from $sector sector');
    } catch (error, stackTrace) {
      print('Sector filter error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // NEW: Load companies with comprehensive business overview
  Future<void> loadCompaniesWithBusinessInsights() async {
    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      final query = FirebaseFirestore.instance
          .collection('companies')
          .where('market_cap', isGreaterThan: 1000)
          .orderBy('market_cap', descending: true)
          .limit(100);

      final snapshot = await query.get();
      List<CompanyModel> companies = [];

      for (var doc in snapshot.docs) {
        try {
          final company = CompanyModel.fromFirestore(doc);
          // Only include companies with substantial business overview or key points
          if (company.businessOverview.isNotEmpty ||
              company.keyMilestones.isNotEmpty ||
              company.investmentHighlights.isNotEmpty) {
            companies.add(company);
          }
        } catch (e) {
          print('Error parsing company ${doc.id}: $e');
          continue;
        }
      }

      // Sort by completeness of business insights
      companies.sort((a, b) {
        final aInsightScore = _calculateInsightScore(a);
        final bInsightScore = _calculateInsightScore(b);
        final insightComparison = bInsightScore.compareTo(aInsightScore);
        if (insightComparison != 0) return insightComparison;
        return (b.marketCap ?? 0).compareTo(a.marketCap ?? 0);
      });

      _companies = companies;
      _hasMore = false;
      _isLoading = false;
      state = AsyncValue.data(_companies);

      print(
          'Loaded ${companies.length} companies with comprehensive business insights');
    } catch (error, stackTrace) {
      print('Business insights filter error: $error');
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Helper method to calculate insight completeness score
  int _calculateInsightScore(CompanyModel company) {
    int score = 0;
    if (company.businessOverview.isNotEmpty) score += 3;
    if (company.sector?.isNotEmpty == true) score += 1;
    if (company.industry?.isNotEmpty == true) score += 1;
    if (company.keyMilestones.isNotEmpty) score += 2;
    if (company.investmentHighlights.isNotEmpty) score += 2;
    if (company.financialSummary.isNotEmpty) score += 1;
    return score;
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
            '  Quality: quality_score=${data['quality_score']}, overall_quality_grade=${data['overall_quality_grade']}');
        print(
            '  Key Points: business_overview=${data['business_overview']?.toString().length ?? 0} chars, '
            'sector=${data['sector']}, milestones=${data['key_milestones']?.length ?? 0}');
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

// Enhanced filter settings with new financial ratio filters and key points
class FilterSettings {
  final RangeFilter marketCap;
  final RangeFilter peRatio;
  final RangeFilter roe;
  final RangeFilter debtToEquity;
  final RangeFilter dividendYield;
  final RangeFilter qualityScore;
  final RangeFilter currentRatio; // Enhanced liquidity filter
  final RangeFilter workingCapitalDays; // Enhanced efficiency filter
  final RangeFilter cashConversionCycle; // Enhanced efficiency filter
  final RangeFilter interestCoverage; // NEW: Solvency filter
  final List<String> selectedSectors;
  final List<String> selectedIndustries; // NEW: Industry-specific filtering
  final List<String> marketCapCategories;
  final List<String> qualityGrades; // NEW: A, B, C, D grade filtering
  final List<String> riskLevels; // NEW: Low, Medium, High risk filtering
  final bool onlyProfitable;
  final bool onlyDebtFree;
  final bool onlyDividendPaying;
  final bool onlyGrowthStocks;
  final bool onlyQualityStocks;
  final bool onlyWorkingCapitalEfficient; // Enhanced efficiency filter
  final bool onlyWithBusinessInsights; // NEW: Companies with key points
  final bool onlyWithMilestones; // NEW: Companies with milestones
  final bool onlyWithInvestmentHighlights; // NEW: Companies with highlights
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
    required this.interestCoverage,
    this.selectedSectors = const [],
    this.selectedIndustries = const [],
    this.marketCapCategories = const [],
    this.qualityGrades = const [],
    this.riskLevels = const [],
    this.onlyProfitable = false,
    this.onlyDebtFree = false,
    this.onlyDividendPaying = false,
    this.onlyGrowthStocks = false,
    this.onlyQualityStocks = false,
    this.onlyWorkingCapitalEfficient = false,
    this.onlyWithBusinessInsights = false,
    this.onlyWithMilestones = false,
    this.onlyWithInvestmentHighlights = false,
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
    RangeFilter? interestCoverage,
    List<String>? selectedSectors,
    List<String>? selectedIndustries,
    List<String>? marketCapCategories,
    List<String>? qualityGrades,
    List<String>? riskLevels,
    bool? onlyProfitable,
    bool? onlyDebtFree,
    bool? onlyDividendPaying,
    bool? onlyGrowthStocks,
    bool? onlyQualityStocks,
    bool? onlyWorkingCapitalEfficient,
    bool? onlyWithBusinessInsights,
    bool? onlyWithMilestones,
    bool? onlyWithInvestmentHighlights,
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
      interestCoverage: interestCoverage ?? this.interestCoverage,
      selectedSectors: selectedSectors ?? this.selectedSectors,
      selectedIndustries: selectedIndustries ?? this.selectedIndustries,
      marketCapCategories: marketCapCategories ?? this.marketCapCategories,
      qualityGrades: qualityGrades ?? this.qualityGrades,
      riskLevels: riskLevels ?? this.riskLevels,
      onlyProfitable: onlyProfitable ?? this.onlyProfitable,
      onlyDebtFree: onlyDebtFree ?? this.onlyDebtFree,
      onlyDividendPaying: onlyDividendPaying ?? this.onlyDividendPaying,
      onlyGrowthStocks: onlyGrowthStocks ?? this.onlyGrowthStocks,
      onlyQualityStocks: onlyQualityStocks ?? this.onlyQualityStocks,
      onlyWorkingCapitalEfficient:
          onlyWorkingCapitalEfficient ?? this.onlyWorkingCapitalEfficient,
      onlyWithBusinessInsights:
          onlyWithBusinessInsights ?? this.onlyWithBusinessInsights,
      onlyWithMilestones: onlyWithMilestones ?? this.onlyWithMilestones,
      onlyWithInvestmentHighlights:
          onlyWithInvestmentHighlights ?? this.onlyWithInvestmentHighlights,
      sortBy: sortBy ?? this.sortBy,
      sortDescending: sortDescending ?? this.sortDescending,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  // NEW: Check if company matches all selected filters including key points
  bool matchesAllFilters(CompanyModel company) {
    // Market cap range
    if (marketCap.isActive) {
      final cap = company.marketCap ?? 0;
      if (marketCap.min != null && cap < marketCap.min!) return false;
      if (marketCap.max != null && cap > marketCap.max!) return false;
    }

    // PE ratio range
    if (peRatio.isActive && company.stockPe != null) {
      final pe = company.stockPe!;
      if (peRatio.min != null && pe < peRatio.min!) return false;
      if (peRatio.max != null && pe > peRatio.max!) return false;
    }

    // ROE range
    if (roe.isActive && company.roe != null) {
      final roeValue = company.roe!;
      if (roe.min != null && roeValue < roe.min!) return false;
      if (roe.max != null && roeValue > roe.max!) return false;
    }

    // Debt to equity range
    if (debtToEquity.isActive && company.debtToEquity != null) {
      final debt = company.debtToEquity!;
      if (debtToEquity.min != null && debt < debtToEquity.min!) return false;
      if (debtToEquity.max != null && debt > debtToEquity.max!) return false;
    }

    // Working capital days range
    if (workingCapitalDays.isActive && company.workingCapitalDays != null) {
      final wcDays = company.workingCapitalDays!;
      if (workingCapitalDays.min != null && wcDays < workingCapitalDays.min!)
        return false;
      if (workingCapitalDays.max != null && wcDays > workingCapitalDays.max!)
        return false;
    }

    // Sector filtering
    if (selectedSectors.isNotEmpty) {
      if (company.sector == null || !selectedSectors.contains(company.sector))
        return false;
    }

    // Industry filtering
    if (selectedIndustries.isNotEmpty) {
      if (company.industry == null ||
          !selectedIndustries.contains(company.industry)) return false;
    }

    // Quality grade filtering
    if (qualityGrades.isNotEmpty) {
      if (!qualityGrades.contains(company.overallQualityGrade)) return false;
    }

    // Risk level filtering
    if (riskLevels.isNotEmpty) {
      if (!riskLevels.contains(company.riskLevel)) return false;
    }

    // Boolean filters
    if (onlyProfitable && !company.isProfitable) return false;
    if (onlyDebtFree && !company.isDebtFree) return false;
    if (onlyDividendPaying && !company.paysDividends) return false;
    if (onlyGrowthStocks && !company.isGrowthStock) return false;
    if (onlyQualityStocks && !company.isQualityStock) return false;
    if (onlyWorkingCapitalEfficient &&
        company.workingCapitalEfficiency == 'Poor') return false;

    // NEW: Key points filters
    if (onlyWithBusinessInsights && company.businessOverview.isEmpty)
      return false;
    if (onlyWithMilestones && company.keyMilestones.isEmpty) return false;
    if (onlyWithInvestmentHighlights && company.investmentHighlights.isEmpty)
      return false;

    return true;
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
    interestCoverage: RangeFilter(),
  );
});

// NEW: Sector and Industry providers for filtering options
final availableSectorsProvider = FutureProvider<List<String>>((ref) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('companies')
        .where('market_cap', isGreaterThan: 500)
        .limit(500)
        .get();

    final sectors = <String>{};
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final sector = data['sector'] as String?;
      if (sector != null && sector.isNotEmpty) {
        sectors.add(sector);
      }
    }

    final sortedSectors = sectors.toList()..sort();
    return sortedSectors;
  } catch (e) {
    print('Error loading sectors: $e');
    return [];
  }
});

final availableIndustriesProvider = FutureProvider<List<String>>((ref) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('companies')
        .where('market_cap', isGreaterThan: 500)
        .limit(500)
        .get();

    final industries = <String>{};
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final industry = data['industry'] as String?;
      if (industry != null && industry.isNotEmpty) {
        industries.add(industry);
      }
    }

    final sortedIndustries = industries.toList()..sort();
    return sortedIndustries;
  } catch (e) {
    print('Error loading industries: $e');
    return [];
  }
});
