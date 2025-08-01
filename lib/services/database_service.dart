// lib/services/database_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/company_model.dart';

final databaseServiceProvider = Provider((ref) => DatabaseService());
final companyRepositoryProvider = Provider((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return CompanyRepository(databaseService);
});

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _companiesCollection = 'companies';

  FirebaseFirestore get firestore => _firestore;
}

class CompanyRepository {
  final DatabaseService _db;
  CompanyRepository(this._db);

  // Get all companies with pagination (ordered by updatedAt for freshness)
  Future<List<CompanyModel>> getAllCompanies({
    int limit = 20,
    DocumentSnapshot? lastDoc,
  }) async {
    try {
      Query query = _db.firestore
          .collection(_db._companiesCollection)
          .orderBy('updatedAt',
              descending: true) // Changed to updatedAt for data freshness
          .limit(limit);

      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch companies: $e');
    }
  }

  // Get companies ordered by market cap
  Future<List<CompanyModel>> getCompaniesByMarketCap({
    int limit = 20,
    DocumentSnapshot? lastDoc,
    bool descending = true,
  }) async {
    try {
      Query query = _db.firestore
          .collection(_db._companiesCollection)
          .orderBy('marketCap', descending: descending)
          .limit(limit);

      if (lastDoc != null) {
        query = query.startAfterDocument(lastDoc);
      }

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch companies by market cap: $e');
    }
  }

  // Enhanced search - symbol and name
  Future<List<CompanyModel>> searchCompanies(String query) async {
    if (query.isEmpty) return [];

    try {
      final upperQuery = query.toUpperCase();

      // Search by symbol first (most accurate)
      final symbolQuery = await _db.firestore
          .collection(_db._companiesCollection)
          .where('symbol', isGreaterThanOrEqualTo: upperQuery)
          .where('symbol', isLessThanOrEqualTo: '${upperQuery}\uf8ff')
          .limit(20)
          .get();

      List<CompanyModel> results = symbolQuery.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();

      // If not enough results, search by display name
      if (results.length < 10) {
        final nameQuery = await _db.firestore
            .collection(_db._companiesCollection)
            .where('displayName', isGreaterThanOrEqualTo: query)
            .where('displayName', isLessThanOrEqualTo: '${query}\uf8ff')
            .limit(20 - results.length)
            .get();

        final nameResults = nameQuery.docs
            .map((doc) => CompanyModel.fromFirestore(doc))
            .where((company) =>
                !results.any((existing) => existing.symbol == company.symbol))
            .toList();

        results.addAll(nameResults);
      }

      return results;
    } catch (e) {
      throw Exception('Failed to search companies: $e');
    }
  }

  // Get single company by symbol
  Future<CompanyModel?> getCompanyBySymbol(String symbol) async {
    try {
      final doc = await _db.firestore
          .collection(_db._companiesCollection)
          .doc(symbol.toUpperCase())
          .get();

      if (doc.exists) {
        return CompanyModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Watch companies for real-time updates
  Stream<List<CompanyModel>> watchCompanies({int limit = 20}) {
    return _db.firestore
        .collection(_db._companiesCollection)
        .orderBy('updatedAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CompanyModel.fromFirestore(doc))
            .toList());
  }

  // Watch single company
  Stream<CompanyModel?> watchCompany(String symbol) {
    return _db.firestore
        .collection(_db._companiesCollection)
        .doc(symbol.toUpperCase())
        .snapshots()
        .map((doc) => doc.exists ? CompanyModel.fromFirestore(doc) : null);
  }

  // Get companies by industry classification
  Future<List<CompanyModel>> getCompaniesByIndustry(String industry,
      {int limit = 20}) async {
    try {
      final querySnapshot = await _db.firestore
          .collection(_db._companiesCollection)
          .where('industryClassification', arrayContains: industry)
          .orderBy('marketCap', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch companies by industry: $e');
    }
  }

  // Get companies with filters (P/E, ROE, etc.)
  Future<List<CompanyModel>> getFilteredCompanies({
    int limit = 20,
    double? minPE,
    double? maxPE,
    double? minROE,
    double? maxROE,
    double? minMarketCap,
    double? maxMarketCap,
  }) async {
    try {
      Query query = _db.firestore.collection(_db._companiesCollection);

      // Apply filters
      if (minPE != null) {
        query = query.where('stockPe', isGreaterThanOrEqualTo: minPE);
      }
      if (maxPE != null) {
        query = query.where('stockPe', isLessThanOrEqualTo: maxPE);
      }
      if (minROE != null) {
        query = query.where('roe', isGreaterThanOrEqualTo: minROE);
      }
      if (maxROE != null) {
        query = query.where('roe', isLessThanOrEqualTo: maxROE);
      }
      if (minMarketCap != null) {
        query = query.where('marketCap', isGreaterThanOrEqualTo: minMarketCap);
      }
      if (maxMarketCap != null) {
        query = query.where('marketCap', isLessThanOrEqualTo: maxMarketCap);
      }

      query = query.orderBy('marketCap', descending: true).limit(limit);

      final querySnapshot = await query.get();
      return querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch filtered companies: $e');
    }
  }

  // Check data freshness - get companies that need updates
  Future<List<CompanyModel>> getStaleCompanies(
      {int hoursThreshold = 24}) async {
    try {
      final cutoffTime =
          DateTime.now().subtract(Duration(hours: hoursThreshold));

      final querySnapshot = await _db.firestore
          .collection(_db._companiesCollection)
          .where('updatedAt', isLessThan: Timestamp.fromDate(cutoffTime))
          .orderBy('updatedAt')
          .limit(50)
          .get();

      return querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch stale companies: $e');
    }
  }

  // Get system status for scraping notifications
  Future<Map<String, dynamic>> getSystemStatus() async {
    try {
      final doc =
          await _db.firestore.collection('system_status').doc('scraping').get();
      return doc.exists ? doc.data() as Map<String, dynamic> : {};
    } catch (e) {
      return {};
    }
  }

  // Watch system status for real-time updates
  Stream<Map<String, dynamic>> watchSystemStatus() {
    return _db.firestore
        .collection('system_status')
        .doc('scraping')
        .snapshots()
        .map((doc) => doc.exists ? doc.data() as Map<String, dynamic> : {});
  }
}
