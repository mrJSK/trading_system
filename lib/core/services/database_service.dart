import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/company/company_model.dart';

// Firebase service provider
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

// Company Repository
final companyRepositoryProvider = Provider<CompanyRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return CompanyRepository(databaseService);
});

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _companiesCollection = 'companies';
  final String _pricesCollection = 'stock_prices';
  final String _watchlistCollection = 'watchlist';

  FirebaseFirestore get firestore => _firestore;

  // Cache management
  static const String _cachePrefix = 'trading_cache_';

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(_cachePrefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }

  Future<void> setCacheData(String key, String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_cachePrefix$key', data);
    await prefs.setInt('${_cachePrefix}${key}_timestamp',
        DateTime.now().millisecondsSinceEpoch);
  }

  Future<String?> getCacheData(String key,
      {Duration maxAge = const Duration(minutes: 5)}) async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt('${_cachePrefix}${key}_timestamp');

    if (timestamp != null) {
      final cacheAge = DateTime.now().millisecondsSinceEpoch - timestamp;
      if (cacheAge < maxAge.inMilliseconds) {
        return prefs.getString('$_cachePrefix$key');
      }
    }
    return null;
  }
}

class CompanyRepository {
  final DatabaseService _db;

  CompanyRepository(this._db);

  // Get all companies with caching
  Future<List<CompanyModel>> getAllCompanies(
      {bool forceRefresh = false}) async {
    try {
      // Check cache first
      if (!forceRefresh) {
        final cachedData = await _db.getCacheData('companies');
        if (cachedData != null) {
          // Parse cached data - implement JSON parsing for list
          // For now, skip cache for simplicity
        }
      }

      final querySnapshot = await _db.firestore
          .collection(_db._companiesCollection)
          .orderBy('marketCap', descending: true)
          .get();

      final companies = querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();

      return companies;
    } catch (e) {
      throw Exception('Failed to fetch companies: $e');
    }
  }

  // Get companies stream for real-time updates
  Stream<List<CompanyModel>> watchAllCompanies() {
    return _db.firestore
        .collection(_db._companiesCollection)
        .orderBy('lastUpdated', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CompanyModel.fromFirestore(doc))
            .toList());
  }

  // Get company by symbol
  Future<CompanyModel?> getCompanyBySymbol(String symbol) async {
    try {
      final doc = await _db.firestore
          .collection(_db._companiesCollection)
          .doc(symbol)
          .get();

      if (doc.exists) {
        return CompanyModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch company $symbol: $e');
    }
  }

  // Search companies
  Future<List<CompanyModel>> searchCompanies(String query) async {
    try {
      // Firebase doesn't support full-text search, so we'll use array-contains for basic search
      final nameQuery = _db.firestore
          .collection(_db._companiesCollection)
          .where('name', isGreaterThanOrEqualTo: query.toUpperCase())
          .where('name', isLessThanOrEqualTo: '${query.toUpperCase()}\uf8ff')
          .limit(20);

      final symbolQuery = _db.firestore
          .collection(_db._companiesCollection)
          .where('symbol', isGreaterThanOrEqualTo: query.toUpperCase())
          .where('symbol', isLessThanOrEqualTo: '${query.toUpperCase()}\uf8ff')
          .limit(20);

      final [nameResults, symbolResults] = await Future.wait([
        nameQuery.get(),
        symbolQuery.get(),
      ]);

      final companies = <CompanyModel>[];
      final addedSymbols = <String>{};

      // Add results from name search
      for (final doc in nameResults.docs) {
        final company = CompanyModel.fromFirestore(doc);
        companies.add(company);
        addedSymbols.add(company.symbol);
      }

      // Add results from symbol search (avoid duplicates)
      for (final doc in symbolResults.docs) {
        final company = CompanyModel.fromFirestore(doc);
        if (!addedSymbols.contains(company.symbol)) {
          companies.add(company);
        }
      }

      return companies;
    } catch (e) {
      throw Exception('Failed to search companies: $e');
    }
  }

  // Get top gainers
  Future<List<CompanyModel>> getTopGainers({int limit = 20}) async {
    try {
      final querySnapshot = await _db.firestore
          .collection(_db._companiesCollection)
          .where('changePercent', isGreaterThan: 0)
          .orderBy('changePercent', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch top gainers: $e');
    }
  }

  // Get top losers
  Future<List<CompanyModel>> getTopLosers({int limit = 20}) async {
    try {
      final querySnapshot = await _db.firestore
          .collection(_db._companiesCollection)
          .where('changePercent', isLessThan: 0)
          .orderBy('changePercent')
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch top losers: $e');
    }
  }

  // Get companies by market cap
  Future<List<CompanyModel>> getCompaniesByMarketCap({int limit = 50}) async {
    try {
      final querySnapshot = await _db.firestore
          .collection(_db._companiesCollection)
          .orderBy('marketCap', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch companies by market cap: $e');
    }
  }

  // Watchlist operations
  Future<List<WatchlistItem>> getUserWatchlist(String userId) async {
    try {
      final querySnapshot = await _db.firestore
          .collection(_db._watchlistCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => WatchlistItem.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch watchlist: $e');
    }
  }

  Future<void> addToWatchlist(WatchlistItem item) async {
    try {
      await _db.firestore
          .collection(_db._watchlistCollection)
          .add(item.toFirestore());
    } catch (e) {
      throw Exception('Failed to add to watchlist: $e');
    }
  }

  Future<void> removeFromWatchlist(String itemId) async {
    try {
      await _db.firestore
          .collection(_db._watchlistCollection)
          .doc(itemId)
          .delete();
    } catch (e) {
      throw Exception('Failed to remove from watchlist: $e');
    }
  }

  // Get system status
  Future<Map<String, dynamic>> getSystemStatus() async {
    try {
      final doc =
          await _db.firestore.collection('system_status').doc('scraping').get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      throw Exception('Failed to fetch system status: $e');
    }
  }

  // Manual trigger scraping
  Future<void> triggerManualScraping() async {
    try {
      await _db.firestore.collection('manual_triggers').add({
        'type': 'scraping',
        'timestamp': FieldValue.serverTimestamp(),
        'triggered_by': 'mobile_app',
      });
    } catch (e) {
      throw Exception('Failed to trigger manual scraping: $e');
    }
  }
}
