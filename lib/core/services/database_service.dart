// lib/core/services/database_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/company/company_model.dart';

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

  // SIMPLIFIED - Only essential queries with pagination
  Future<List<CompanyModel>> getAllCompanies({
    int limit = 20,
    DocumentSnapshot? lastDoc,
  }) async {
    try {
      Query query = _db.firestore
          .collection(_db._companiesCollection)
          .orderBy('marketCap', descending: true)
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

  // FIXED SEARCH - Simple and efficient
  Future<List<CompanyModel>> searchCompanies(String query) async {
    if (query.isEmpty) return [];

    try {
      final querySnapshot = await _db.firestore
          .collection(_db._companiesCollection)
          .where('symbol', isGreaterThanOrEqualTo: query.toUpperCase())
          .where('symbol', isLessThanOrEqualTo: '${query.toUpperCase()}\uf8ff')
          .limit(20)
          .get();

      return querySnapshot.docs
          .map((doc) => CompanyModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to search companies: $e');
    }
  }

  // SYSTEM STATUS - Only for job completion notifications
  Future<Map<String, dynamic>> getSystemStatus() async {
    try {
      final doc =
          await _db.firestore.collection('system_status').doc('scraping').get();
      return doc.exists ? doc.data() as Map<String, dynamic> : {};
    } catch (e) {
      return {};
    }
  }
}
