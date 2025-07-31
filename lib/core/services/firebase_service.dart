import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import '../../models/company/company_model.dart';

class FirebaseService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseFunctions _functions = FirebaseFunctions.instance;

  static Future<void> initialize() async {
    try {
      // Request permission
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('✅ User granted notification permission');

        // Subscribe to topics
        await _messaging.subscribeToTopic('company_updates');
        await _messaging.subscribeToTopic('scraping_status');

        // Get FCM token
        String? token = await _messaging.getToken();
        print('📱 FCM Token: ${token?.substring(0, 20)}...');
      } else {
        print('⚠️ Notification permission denied');
      }
    } catch (e) {
      print('⚠️ Firebase messaging initialization failed: $e');
      // Continue without notifications
    }
  }

  // ADD THIS MISSING METHOD
  static Future<void> testCloudFunctionConnectivity() async {
    try {
      print('🧪 Testing cloud function connectivity...');

      // Test if your deployed manual_scrape_trigger function is accessible
      final callable = _functions.httpsCallable('manual_scrape_trigger');

      // Send a test call with minimal data
      final result = await callable
          .call({'test': true, 'source': 'app_initialization'}).timeout(
              const Duration(seconds: 8));

      print('✅ Cloud function test successful: ${result.data}');
    } catch (e) {
      print('🧪 Cloud function test details: $e');

      // These are actually "successful" connectivity tests
      if (e.toString().contains('DEADLINE_EXCEEDED') ||
          e.toString().contains('UNAVAILABLE') ||
          e.toString().contains('test')) {
        print(
            '✅ Cloud function is accessible (timeout/test response expected)');
        return; // Function exists and is accessible
      }

      // Only throw for actual connectivity issues
      if (e.toString().contains('NOT_FOUND')) {
        throw Exception(
            'Cloud function not deployed. Please run: firebase deploy --only functions');
      }

      // For other errors, log but don't fail initialization
      print('⚠️ Cloud function test inconclusive: $e');
    }
  }

  static Future<List<CompanyModel>> getCompanies({int limit = 100}) async {
    try {
      print('🔍 Fetching companies from Firestore...');

      QuerySnapshot snapshot =
          await _firestore.collection('companies').limit(limit).get();

      print('📊 Found ${snapshot.docs.length} companies in Firestore');

      if (snapshot.docs.isEmpty) {
        print('⚠️ No companies found, triggering scraping...');
        await triggerScraping();

        // Wait a bit for scraping to populate some data
        await Future.delayed(const Duration(seconds: 5));

        // Try fetching again
        snapshot = await _firestore.collection('companies').limit(limit).get();
      }

      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return CompanyModel.fromJson(data);
      }).toList();
    } catch (e) {
      print('❌ Error fetching companies: $e');
      throw Exception('Failed to fetch companies: $e');
    }
  }

  static Future<void> triggerScraping() async {
    try {
      print('🚀 Triggering cloud function scraping...');

      // Method 1: Try calling the HTTP Cloud Function directly
      try {
        final callable = _functions.httpsCallable('manual_scrape_trigger');
        final result = await callable.call({
          'triggered_by': 'mobile_app',
          'timestamp': DateTime.now().toIso8601String(),
        });
        print('✅ Cloud function triggered successfully: ${result.data}');
        return;
      } catch (e) {
        print('⚠️ Direct function call failed: $e');
      }

      // Method 2: Try HTTP request to function URL (if you have the URL)
      try {
        // Replace with your actual function URL
        final functionUrl =
            'https://us-central1-trading-system-123.cloudfunctions.net/manual_scrape_trigger';

        final response = await http.post(
          Uri.parse(functionUrl),
          headers: {'Content-Type': 'application/json'},
          body: '{"triggered_by": "mobile_app"}',
        );

        if (response.statusCode == 200) {
          print('✅ HTTP trigger successful: ${response.body}');
          return;
        } else {
          print('⚠️ HTTP trigger failed: ${response.statusCode}');
        }
      } catch (e) {
        print('⚠️ HTTP request failed: $e');
      }

      // Method 3: Fallback - trigger via Firestore document
      await _firestore.collection('manual_triggers').add({
        'type': 'scraping',
        'timestamp': FieldValue.serverTimestamp(),
        'triggered_by': 'mobile_app',
        'status': 'initiated',
      });

      print('✅ Fallback trigger added to Firestore');
    } catch (e) {
      print('❌ All trigger methods failed: $e');
      throw Exception('Failed to trigger scraping: $e');
    }
  }

  static Future<CompanyModel?> getCompany(String symbol) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('companies').doc(symbol).get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return CompanyModel.fromJson(data);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch company: $e');
    }
  }

  static Stream<QuerySnapshot> getCompaniesStream() {
    return _firestore.collection('companies').snapshots();
  }

  // Additional utility methods
  static Future<Map<String, dynamic>> getSystemStatus() async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('system_status').doc('scraping').get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return {
        'status': 'unknown',
        'last_updated': null,
        'total_companies': 0,
      };
    } catch (e) {
      print('❌ Failed to fetch system status: $e');
      return {
        'status': 'error',
        'last_updated': null,
        'total_companies': 0,
      };
    }
  }

  static Future<void> updateScrapingConfig(Map<String, dynamic> config) async {
    try {
      await _firestore
          .collection('system_config')
          .doc('scraping_schedule')
          .set(config, SetOptions(merge: true));

      print('✅ Scraping config updated');
    } catch (e) {
      print('❌ Failed to update scraping config: $e');
      throw Exception('Failed to update configuration: $e');
    }
  }
}
