import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../models/company/company_model.dart';
import '../../../../models/company/filter_settings.dart';
import '../../../filters/providers/filter_provider.dart';

class CompaniesNotifier extends StateNotifier<AsyncValue<List<CompanyModel>>> {
  CompaniesNotifier(this._ref) : super(const AsyncValue.loading()) {
    _companies = [];
    _filteredCompanies = [];
    _lastDocument = null;
    _hasMore = true;
    _isLoading = false;
  }

  final Ref _ref;
  List<CompanyModel> _companies = [];
  List<CompanyModel> _filteredCompanies = [];
  DocumentSnapshot? _lastDocument;
  bool _hasMore = true;
  bool _isLoading = false;
  String _currentSearchQuery = '';

  Future<void> loadInitialCompanies() async {
    if (_isLoading) return;

    state = const AsyncValue.loading();
    _isLoading = true;

    try {
      final filterSettings = _ref.read(filterSettingsProvider);
      final companies = await _fetchCompaniesFromFirestore(
        limit: filterSettings.pageSize,
        filters: filterSettings,
      );

      _companies = companies;
      _applySearchAndFilters();
      _isLoading = false;

      state = AsyncValue.data(_filteredCompanies);
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
        _applySearchAndFilters();
        state = AsyncValue.data(_filteredCompanies);
      }

      _isLoading = false;
    } catch (error) {
      _isLoading = false;
      print('Error loading more companies: $error');
    }
  }

  Future<List<CompanyModel>> _fetchCompaniesFromFirestore({
    required int limit,
    required FilterSettings filters,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = FirebaseFirestore.instance.collection('companies');

    // Apply filters
    if (filters.marketCap.isActive) {
      if (filters.marketCap.min != null) {
        query = query.where('market_cap',
            isGreaterThanOrEqualTo:
                filters.marketCap.min! * 100); // Convert to lakhs
      }
      if (filters.marketCap.max != null) {
        query = query.where('market_cap',
            isLessThanOrEqualTo: filters.marketCap.max! * 100);
      }
    }

    if (filters.pe.isActive) {
      if (filters.pe.min != null) {
        query = query.where('stock_pe', isGreaterThanOrEqualTo: filters.pe.min);
      }
      if (filters.pe.max != null) {
        query = query.where('stock_pe', isLessThanOrEqualTo: filters.pe.max);
      }
    }

    // Apply sorting
    switch (filters.sortBy) {
      case 'market_cap':
        query = query.orderBy('market_cap', descending: filters.sortDescending);
        break;
      case 'current_price':
        query =
            query.orderBy('current_price', descending: filters.sortDescending);
        break;
      case 'change_percent':
        query =
            query.orderBy('change_percent', descending: filters.sortDescending);
        break;
      case 'stock_pe':
        query = query.orderBy('stock_pe', descending: filters.sortDescending);
        break;
      default:
        query = query.orderBy('market_cap', descending: true);
    }

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    query = query.limit(limit);

    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      _lastDocument = snapshot.docs.last;
    }

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return CompanyModel.fromJson(data);
    }).toList();
  }

  void searchCompanies(String query) {
    _currentSearchQuery = query.toLowerCase().trim();
    _applySearchAndFilters();
  }

  void _applySearchAndFilters() {
    _filteredCompanies = _companies.where((company) {
      if (_currentSearchQuery.isEmpty) return true;

      final symbol = company.symbol?.toLowerCase() ?? '';
      final name = company.name?.toLowerCase() ?? '';

      return symbol.contains(_currentSearchQuery) ||
          name.contains(_currentSearchQuery);
    }).toList();

    if (state is AsyncData) {
      state = AsyncValue.data(_filteredCompanies);
    }
  }

  Future<void> applyFilters() async {
    // Reset and reload with new filters
    _companies.clear();
    _filteredCompanies.clear();
    _lastDocument = null;
    _hasMore = true;
    await loadInitialCompanies();
  }

  Future<void> refreshCompanies() async {
    _companies.clear();
    _filteredCompanies.clear();
    _lastDocument = null;
    _hasMore = true;
    await loadInitialCompanies();
  }

  Future<void> triggerManualScraping() async {
    try {
      await FirebaseService.triggerScraping();
      // Wait a bit then refresh
      await Future.delayed(const Duration(seconds: 3));
      await refreshCompanies();
    } catch (e) {
      print('Error triggering manual scraping: $e');
    }
  }
}

final companiesProvider =
    StateNotifierProvider<CompaniesNotifier, AsyncValue<List<CompanyModel>>>(
  (ref) => CompaniesNotifier(ref),
);
