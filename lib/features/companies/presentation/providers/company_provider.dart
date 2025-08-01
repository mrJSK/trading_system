import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../models/company/company_model.dart';
import '../../../../models/company/filter_settings.dart';
import '../../../filters/providers/filter_provider.dart';

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

  // REMOVED: _filteredCompanies, _currentSearchQuery - doing client-side filtering was wasteful
  // REMOVED: All print statements and logging

  Future<void> loadInitialCompanies() async {
    if (_isLoading) return;

    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      final filterSettings = _ref.read(filterSettingsProvider);

      // OPTIMIZED: Single efficient query
      final companies = await _fetchCompaniesFromFirestore(
        limit: filterSettings.pageSize,
        filters: filterSettings,
      );

      _companies = companies;
      _isLoading = false;
      state = AsyncValue.data(_companies);
    } catch (error, stackTrace) {
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadMoreCompanies() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;

    try {
      final filterSettings = _ref.read(filterSettingsProvider);
      final newCompanies = await _fetchCompaniesFromFirestore(
        limit: filterSettings.pageSize,
        filters: filterSettings,
        startAfter: _lastDocument,
      );

      if (newCompanies.isEmpty) {
        _hasMore = false;
      } else {
        _companies.addAll(newCompanies);
        state = AsyncValue.data(_companies);
      }
      _isLoading = false;
    } catch (error, stackTrace) {
      _isLoading = false;
      // REMOVED: print statement - no logging
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // OPTIMIZED: Efficient Firestore query with proper indexing
  Future<List<CompanyModel>> _fetchCompaniesFromFirestore({
    required int limit,
    required FilterSettings filters,
    DocumentSnapshot? startAfter,
  }) async {
    try {
      Query query = FirebaseFirestore.instance.collection('companies');

      // SIMPLIFIED: Only apply essential filters to reduce query complexity
      if (filters.marketCap.isActive && filters.marketCap.min != null) {
        query = query.where('market_cap',
            isGreaterThanOrEqualTo: filters.marketCap.min! * 100);
      }

      // OPTIMIZED: Simple sorting - avoid complex multi-field queries
      query = query.orderBy('market_cap', descending: true);

      if (startAfter != null) {
        query = query.startAfterDocument(startAfter);
      }

      // CRITICAL: Limit to prevent excessive reads
      query = query.limit(limit);

      final snapshot = await query.get();

      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
      }

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CompanyModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch companies');
    }
  }

  // SIMPLIFIED: Server-side search to reduce reads
  Future<void> searchCompanies(String query) async {
    if (query.isEmpty) {
      await loadInitialCompanies();
      return;
    }

    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      // OPTIMIZED: Direct Firestore search query
      final searchQuery = FirebaseFirestore.instance
          .collection('companies')
          .where('symbol', isGreaterThanOrEqualTo: query.toUpperCase())
          .where('symbol', isLessThanOrEqualTo: '${query.toUpperCase()}\uf8ff')
          .orderBy('symbol')
          .limit(20); // Limit search results

      final snapshot = await searchQuery.get();

      final searchResults = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CompanyModel.fromJson(data);
      }).toList();

      _companies = searchResults;
      _hasMore = false; // No pagination for search
      _isLoading = false;
      state = AsyncValue.data(_companies);
    } catch (error, stackTrace) {
      _isLoading = false;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> applyFilters() async {
    // OPTIMIZED: Reset and reload efficiently
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

  // REMOVED: Manual scraping trigger - not needed for core functionality
  // REMOVED: FirebaseService dependency
}

final companiesProvider =
    StateNotifierProvider<CompaniesNotifier, AsyncValue<List<CompanyModel>>>(
  (ref) => CompaniesNotifier(ref),
);
