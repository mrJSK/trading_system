// lib/providers/optimized_company_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/company_model.dart';

// Paginated company provider with Firebase optimization
final paginatedCompaniesProvider =
    StateNotifierProvider<PaginatedCompaniesNotifier, PaginatedCompaniesState>(
        (ref) {
  return PaginatedCompaniesNotifier();
});

class PaginatedCompaniesState {
  final List<CompanyModel> companies;
  final bool isLoading;
  final bool hasMore;
  final DocumentSnapshot? lastDocument;
  final String? error;

  const PaginatedCompaniesState({
    this.companies = const [],
    this.isLoading = false,
    this.hasMore = true,
    this.lastDocument,
    this.error,
  });

  PaginatedCompaniesState copyWith({
    List<CompanyModel>? companies,
    bool? isLoading,
    bool? hasMore,
    DocumentSnapshot? lastDocument,
    String? error,
  }) {
    return PaginatedCompaniesState(
      companies: companies ?? this.companies,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      lastDocument: lastDocument ?? this.lastDocument,
      error: error ?? this.error,
    );
  }
}

class PaginatedCompaniesNotifier
    extends StateNotifier<PaginatedCompaniesState> {
  PaginatedCompaniesNotifier() : super(const PaginatedCompaniesState()) {
    loadInitialCompanies();
  }

  static const int pageSize = 20;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> loadInitialCompanies() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final querySnapshot = await _firestore
          .collection('companies')
          .orderBy('marketCap', descending: true)
          .limit(pageSize)
          .get();

      final companies = querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();

      state = state.copyWith(
        companies: companies,
        isLoading: false,
        hasMore: querySnapshot.docs.length == pageSize,
        lastDocument:
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMoreCompanies() async {
    if (state.isLoading || !state.hasMore || state.lastDocument == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final querySnapshot = await _firestore
          .collection('companies')
          .orderBy('marketCap', descending: true)
          .startAfterDocument(state.lastDocument!)
          .limit(pageSize)
          .get();

      final newCompanies = querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();

      state = state.copyWith(
        companies: [...state.companies, ...newCompanies],
        isLoading: false,
        hasMore: querySnapshot.docs.length == pageSize,
        lastDocument: querySnapshot.docs.isNotEmpty
            ? querySnapshot.docs.last
            : state.lastDocument,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = const PaginatedCompaniesState();
    await loadInitialCompanies();
  }
}

// Cached individual company provider to minimize reads
final cachedCompanyProvider =
    FutureProvider.family<CompanyModel?, String>((ref, symbol) async {
  final cache = ref.watch(companyCacheProvider);

  // Return from cache if available and recent
  if (cache.containsKey(symbol)) {
    final cachedData = cache[symbol]!;
    final now = DateTime.now();
    if (now.difference(cachedData.timestamp).inMinutes < 30) {
      return cachedData.company;
    }
  }

  // Fetch from Firebase
  try {
    final doc = await FirebaseFirestore.instance
        .collection('companies')
        .doc(symbol)
        .get();

    if (doc.exists) {
      final company = CompanyModel.fromFirestore(doc);

      // Update cache
      ref.read(companyCacheProvider.notifier).state = {
        ...cache,
        symbol: CachedCompany(company: company, timestamp: DateTime.now()),
      };

      return company;
    }
    return null;
  } catch (e) {
    throw Exception('Failed to load company: $e');
  }
});

class CachedCompany {
  final CompanyModel company;
  final DateTime timestamp;

  CachedCompany({required this.company, required this.timestamp});
}

final companyCacheProvider =
    StateProvider<Map<String, CachedCompany>>((ref) => {});
