// lib/core/services/firebase_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/company/company_model.dart';

class FirebaseService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> initialize() async {
    try {
      // ONLY job completion notifications
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await _messaging.subscribeToTopic('job_status'); // Only job status
        // Remove all other topic subscriptions
      }
    } catch (e) {
      // Silent fail - no logging
    }
  }

  static Future<List<CompanyModel>> getCompanies({int limit = 20}) async {
    try {
      QuerySnapshot snapshot =
          await _firestore.collection('companies').limit(limit).get();

      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return CompanyModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch companies: $e');
    }
  }
}
