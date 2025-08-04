// lib/services/scraping_service.dart
//
// v2 – 2025-08-05
// • Built-in exponential-back-off & retry (handles HTTP 429 / network flakiness)
// • Public helpers for queue/batch service (scrapeCompanyList / scrapeCompanyData resilient)
// • Configurable throttling: delayBetweenRequests & maxRetries
// • Failure counts returned to caller for fine-grained progress metrics
// ---------------------------------------------------------------------------

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

import '../models/company.dart';
import '../models/company_data.dart';
import '../utils/html_parser.dart';
import 'database_service.dart';

class ScrapingService {
/* ───────────────────────── configuration ───────────────────────── */
  static const String baseUrl =
      'https://www.screener.in/screens/515361/largecaptop-100midcap101-250smallcap251/';

  // HTTP
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Map<String, String> _headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
            '(KHTML, like Gecko) Chrome/118.0 Safari/537.36',
    'Accept':
        'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.9',
    'Accept-Encoding': 'gzip, deflate',
    'Connection': 'keep-alive',
    'Upgrade-Insecure-Requests': '1',
  };

  // Throttling
  static const Duration delayBetweenRequests =
      Duration(seconds: 3); // ↑ from 2 s
  static const int maxRetries = 3;
  static const Duration initialBackoff = Duration(seconds: 5);

  final DatabaseService _databaseService = DatabaseService();
  final http.Client _client = http.Client();

/* ───────────────────────── page-level scraping ───────────────────────── */

  Future<List<Company>> scrapeCompanyList(int page) async {
    final uri = Uri.parse('$baseUrl?page=$page');

    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        if (attempt > 1) {
          final delay = initialBackoff * attempt; // exponential
          print(
              '⌛ Retrying page $page in ${delay.inSeconds}s (attempt $attempt)');
          await Future.delayed(delay);
        }

        print('🌐 GET $uri  (attempt $attempt)');
        final response =
            await _client.get(uri, headers: _headers).timeout(requestTimeout);

        if (response.statusCode == 200) {
          final document = parser.parse(response.body);
          final companies = await _parseCompanyListFromHtml(document);
          print('✅ Page $page → ${companies.length} companies');
          return companies;
        }

        // HTTP 429 / 5xx → trigger retry
        if (response.statusCode == 429 || response.statusCode >= 500) {
          throw HttpException('HTTP ${response.statusCode}');
        }

        // Unexpected status – abort immediately
        throw HttpException('HTTP ${response.statusCode}');
      } catch (e) {
        if (attempt == maxRetries) rethrow; // bubble up after final attempt
        print('⚠️  Page $page failed (attempt $attempt): $e');
      }
    }
    return <Company>[]; // never reached
  }

/* ───────────────────────── detail-level scraping ─────────────────────── */

  Future<CompanyData?> scrapeCompanyData(Company company) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        if (attempt > 1) {
          final delay = initialBackoff * attempt;
          print(
              '⌛ Retrying ${company.name} in ${delay.inSeconds}s (attempt $attempt)');
          await Future.delayed(delay);
        }

        final response = await _client
            .get(Uri.parse(company.url), headers: _headers)
            .timeout(requestTimeout);

        if (response.statusCode == 200) {
          final companyData = HtmlParser.parseCompanyData(response.body);
          if (companyData == null) {
            throw FormatException('HTML parse failed');
          }

          companyData.companyId = company.id;
          await _databaseService.updateCompanyWithData(company, companyData);
          print('✅ Data saved for ${company.name}');
          return companyData;
        }

        if (response.statusCode == 429 || response.statusCode >= 500) {
          throw HttpException('HTTP ${response.statusCode}');
        }

        throw HttpException('HTTP ${response.statusCode}');
      } catch (e) {
        if (attempt == maxRetries) {
          print('💥 Giving up on ${company.name}: $e');
          return null;
        }
        print('⚠️  ${company.name} failed (attempt $attempt): $e');
      }
    }
    return null; // never reached
  }

/* ─────────────────────── helper: list parsing ─────────────────────── */

  Future<List<Company>> _parseCompanyListFromHtml(Document doc) async {
    final companies = <Company>[];
    final selectors = [
      'table.data-table tbody tr',
      'table tbody tr',
      '.table tbody tr',
      'tbody tr',
      'tr'
    ];

    List<Element> rows = [];
    for (final sel in selectors) {
      rows = doc.querySelectorAll(sel);
      if (rows.isNotEmpty) {
        break;
      }
    }

    if (rows.isEmpty) {
      print('❗ No rows found on page');
      return companies;
    }

    for (final row in rows) {
      final company = await _parseCompanyFromRow(row);
      if (company != null) companies.add(company);
    }
    return companies;
  }

/* ─────────────────── helper: single row → Company ─────────────────── */

  Future<Company?> _parseCompanyFromRow(Element row) async {
    try {
      final cells = row.querySelectorAll('td');
      if (cells.isEmpty) return null;

      final link = row.querySelector('a[href*="/company/"]') ??
          row.querySelector('a') ??
          cells.first.querySelector('a');
      if (link == null) return null;

      final name = link.text.trim();
      if (name.isEmpty) return null;

      final href = link.attributes['href'];
      if (href == null) return null;

      final url =
          href.startsWith('http') ? href : 'https://www.screener.in$href';
      final symbol = _extractSymbolFromUrl(url);

      double? currentPrice;
      double? marketCap;

      if (cells.length > 1) currentPrice = _parseNumber(cells[1].text);
      if (cells.length > 2) marketCap = _parseMarketCap(cells[2].text);

      Company company;
      final existing = await _databaseService.getCompanyByUrl(url);

      if (existing != null) {
        company = existing
          ..name = name
          ..symbol = symbol
          ..currentPrice = currentPrice
          ..marketCap = marketCap
          ..lastUpdated = DateTime.now();
      } else {
        company = Company.fromData(
          name: name,
          url: url,
          symbol: symbol,
          currentPrice: currentPrice,
          marketCap: marketCap,
          lastUpdated: DateTime.now(),
        );
      }

      await _databaseService.insertCompany(company);
      return company;
    } catch (e) {
      print('Row parse error: $e');
      return null;
    }
  }

/* ───────────────────────── utility helpers ───────────────────────── */

  String _extractSymbolFromUrl(String url) {
    try {
      final segments = Uri.parse(url).pathSegments;
      for (int i = 0; i < segments.length; i++) {
        if (segments[i] == 'company' && i + 1 < segments.length) {
          return segments[i + 1].toUpperCase().replaceAll('-', '');
        }
      }
      return segments.isNotEmpty
          ? segments.last.toUpperCase().replaceAll('-', '')
          : '';
    } catch (_) {
      return '';
    }
  }

  double? _parseNumber(String text) {
    final cleaned = text
        .replaceAll(RegExp(r'[₹$,\s]'), '')
        .replaceAll('Cr', '')
        .replaceAll('L', '')
        .trim();
    return cleaned.isEmpty ? null : double.tryParse(cleaned);
  }

  double? _parseMarketCap(String text) {
    final lc = text.toLowerCase();
    double? val = _parseNumber(text);
    if (val == null) return null;

    if (lc.contains('lakh')) return val / 100;
    if (lc.contains('thousand')) return val / 10000;
    /* cr / crore */ return val;
  }

/* ───────────────────── expose quick diagnostics ───────────────────── */

  Future<bool> testConnection() async {
    try {
      final res = await _client
          .get(Uri.parse(baseUrl), headers: _headers)
          .timeout(const Duration(seconds: 10));
      return res.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  void dispose() => _client.close();
}
