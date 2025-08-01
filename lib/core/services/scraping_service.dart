// lib/core/services/scraping_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class ScrapingService {
  static const String _baseUrl =
      'https://us-central1-trading-system-123.cloudfunctions.net';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // REMOVED: All caching, logging, real-time streams, event history

  Future<String> startScraping({int maxPages = 50}) async {
    try {
      final response = await http
          .post(
            Uri.parse('$_baseUrl/queue_scraping_jobs'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'max_pages': maxPages, 'clear_existing': true}),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'] ?? 'Scraping started successfully';
      } else {
        throw Exception('Failed to start scraping');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // REMOVED: All other methods except essential ones
  Future<bool> isScrapingActive() async {
    try {
      final doc =
          await _firestore.collection('system_status').doc('scraping').get();
      return doc.exists ? (doc.data()?['is_active'] ?? false) : false;
    } catch (e) {
      return false;
    }
  }
}
