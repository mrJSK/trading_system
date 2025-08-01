import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/company_model.dart';

class FirebaseService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> initialize() async {
    try {
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await _messaging.subscribeToTopic('job_status');
      }
    } catch (e) {
      // Silent fail
    }
  }

  static Future<List<CompanyModel>> getCompanies({int limit = 20}) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('companies')
          .orderBy('updatedAt', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return CompanyModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch companies: $e');
    }
  }

  static Future<CompanyModel?> getCompanyBySymbol(String symbol) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('companies').doc(symbol).get();

      if (doc.exists) {
        return CompanyModel.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<void> saveCompany(CompanyModel company) async {
    try {
      final docRef = _firestore.collection('companies').doc(company.symbol);
      final docSnapshot = await docRef.get();
      final now = DateTime.now();

      if (docSnapshot.exists) {
        await docRef.update({
          ...company.toFirestore(),
          'updatedAt': Timestamp.fromDate(now),
        });
      } else {
        await docRef.set({
          ...company.toFirestore(),
          'createdAt': Timestamp.fromDate(now),
          'updatedAt': Timestamp.fromDate(now),
        });
      }
    } catch (e) {
      throw Exception('Failed to save company: $e');
    }
  }

  static Future<void> saveCompanies(List<CompanyModel> companies) async {
    try {
      final batch = _firestore.batch();
      final now = DateTime.now();

      for (final company in companies) {
        final docRef = _firestore.collection('companies').doc(company.symbol);
        final docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          batch.update(docRef, {
            ...company.toFirestore(),
            'updatedAt': Timestamp.fromDate(now),
          });
        } else {
          batch.set(docRef, {
            ...company.toFirestore(),
            'createdAt': Timestamp.fromDate(now),
            'updatedAt': Timestamp.fromDate(now),
          });
        }
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to save companies: $e');
    }
  }

  static Stream<List<CompanyModel>> watchCompanies({int limit = 20}) {
    return _firestore
        .collection('companies')
        .orderBy('updatedAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CompanyModel.fromFirestore(doc))
            .toList());
  }

  static Stream<CompanyModel?> watchCompany(String symbol) {
    return _firestore
        .collection('companies')
        .doc(symbol)
        .snapshots()
        .map((doc) => doc.exists ? CompanyModel.fromFirestore(doc) : null);
  }
}
