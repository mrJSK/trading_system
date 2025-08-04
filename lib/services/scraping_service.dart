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
  static const String baseUrl =
      'https://www.screener.in/screens/515361/largecaptop-100midcap101-250smallcap251/';
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Duration delayBetweenRequests = Duration(seconds: 2);

  final DatabaseService _databaseService = DatabaseService();
  final http.Client _client = http.Client();

  // Request headers to avoid being blocked
  static const Map<String, String> _headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
    'Accept':
        'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    'Accept-Language': 'en-US,en;q=0.5',
    'Accept-Encoding': 'gzip, deflate',
    'Connection': 'keep-alive',
    'Upgrade-Insecure-Requests': '1',
  };

  /// Scrape companies from a specific page
  Future<List<Company>> scrapeCompanyList(int page) async {
    try {
      print('Scraping company list from page $page...');

      final uri = Uri.parse('$baseUrl?page=$page');
      final response =
          await _client.get(uri, headers: _headers).timeout(requestTimeout);

      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        final companies = await _parseCompanyListFromHtml(document);

        print('Found ${companies.length} companies on page $page');
        return companies;
      } else {
        throw HttpException(
            'HTTP ${response.statusCode}: Failed to load page $page');
      }
    } on SocketException catch (e) {
      throw Exception('Network error on page $page: ${e.message}');
    } on HttpException catch (e) {
      throw Exception('HTTP error on page $page: $e');
    } on FormatException catch (e) {
      throw Exception('Format error on page $page: $e');
    } catch (e) {
      throw Exception('Unexpected error scraping page $page: $e');
    }
  }

  /// Parse company list from HTML document
  Future<List<Company>> _parseCompanyListFromHtml(Document document) async {
    final companies = <Company>[];

    try {
      // Look for different possible table selectors
      final tableSelectors = [
        'table.data-table tbody tr',
        'table tbody tr',
        '.table tbody tr',
        'tbody tr',
        'tr'
      ];

      List<Element> rows = [];
      for (final selector in tableSelectors) {
        rows = document.querySelectorAll(selector);
        if (rows.isNotEmpty) {
          print('Found ${rows.length} rows using selector: $selector');
          break;
        }
      }

      if (rows.isEmpty) {
        print('No table rows found. Available content:');
        print(document.body?.text?.substring(0, 500) ?? 'No body content');
        return companies;
      }

      for (final row in rows) {
        try {
          final company = await _parseCompanyFromRow(row);
          if (company != null) {
            companies.add(company);
          }
        } catch (e) {
          print('Error parsing row: $e');
          continue; // Skip this row and continue with others
        }
      }
    } catch (e) {
      print('Error parsing company list: $e');
    }

    return companies;
  }

  /// Parse individual company from table row
  Future<Company?> _parseCompanyFromRow(Element row) async {
    try {
      final cells = row.querySelectorAll('td');
      if (cells.isEmpty) return null;

      // Try to find company name and URL
      final nameLink = row.querySelector('a[href*="/company/"]') ??
          row.querySelector('a') ??
          cells.first.querySelector('a');

      if (nameLink == null) return null;

      final name = nameLink.text.trim();
      if (name.isEmpty) return null;

      final href = nameLink.attributes['href'];
      if (href == null) return null;

      final url =
          href.startsWith('http') ? href : 'https://www.screener.in$href';
      final symbol = _extractSymbolFromUrl(url);

      // Extract financial data from other cells
      double? currentPrice;
      double? marketCap;

      // Try to parse price from second column
      if (cells.length > 1) {
        currentPrice = _parseNumber(cells[1].text);
      }

      // Try to parse market cap from third column
      if (cells.length > 2) {
        marketCap = _parseMarketCap(cells[2].text);
      }

      // Check if company already exists in database
      final existingCompany = await _databaseService.getCompanyByUrl(url);

      Company company;
      if (existingCompany != null) {
        // Update existing company
        company = existingCompany;
        company.name = name;
        company.symbol = symbol;
        company.currentPrice = currentPrice;
        company.marketCap = marketCap;
        company.lastUpdated = DateTime.now();
      } else {
        // Create new company
        company = Company.fromData(
          name: name,
          url: url,
          symbol: symbol,
          currentPrice: currentPrice,
          marketCap: marketCap,
          lastUpdated: DateTime.now(),
        );
      }

      // Save to database
      await _databaseService.insertCompany(company);
      return company;
    } catch (e) {
      print('Error parsing company from row: $e');
      return null;
    }
  }

  /// Scrape detailed data for a specific company
  Future<CompanyData?> scrapeCompanyData(Company company) async {
    try {
      print('Scraping data for ${company.name} from ${company.url}');

      final response = await _client
          .get(Uri.parse(company.url), headers: _headers)
          .timeout(requestTimeout);

      if (response.statusCode == 200) {
        final document = parser.parse(response.body);
        final companyData = HtmlParser.parseCompanyData(document as String);

        if (companyData != null) {
          // Set the company ID
          companyData.companyId = company.id;

          // Save to database
          await _databaseService.updateCompanyWithData(company, companyData);

          print('Successfully scraped data for ${company.name}');
          return companyData;
        } else {
          print('Failed to parse data for ${company.name}');
        }
      } else {
        throw HttpException(
            'HTTP ${response.statusCode}: Failed to load ${company.url}');
      }
    } on SocketException catch (e) {
      print('Network error for ${company.name}: ${e.message}');
    } on HttpException catch (e) {
      print('HTTP error for ${company.name}: $e');
    } catch (e) {
      print('Error scraping ${company.name}: $e');
    }

    return null;
  }

  /// Scrape multiple pages with progress callback
  Future<List<Company>> scrapeMultiplePages({
    required int startPage,
    required int endPage,
    Function(int currentPage, int totalPages, List<Company> companies)?
        onProgress,
    Function(String message)? onLog,
  }) async {
    final allCompanies = <Company>[];
    final totalPages = endPage - startPage + 1;

    onLog?.call('Starting to scrape pages $startPage to $endPage...');

    for (int page = startPage; page <= endPage; page++) {
      try {
        onLog?.call('Scraping page $page of $endPage...');

        final companies = await scrapeCompanyList(page);
        allCompanies.addAll(companies);

        onProgress?.call(page, totalPages, companies);
        onLog
            ?.call('Page $page completed: ${companies.length} companies found');

        // Add delay between requests to avoid being rate limited
        if (page < endPage) {
          await Future.delayed(delayBetweenRequests);
        }
      } catch (e) {
        onLog?.call('Error on page $page: $e');
        // Continue with next page
      }
    }

    onLog?.call('Scraping completed. Total companies: ${allCompanies.length}');
    return allCompanies;
  }

  /// Scrape data for multiple companies with progress callback
  Future<List<CompanyData>> scrapeMultipleCompaniesData({
    required List<Company> companies,
    Function(int current, int total, Company company, CompanyData? data)?
        onProgress,
    Function(String message)? onLog,
  }) async {
    final allData = <CompanyData>[];

    onLog?.call('Starting to scrape data for ${companies.length} companies...');

    for (int i = 0; i < companies.length; i++) {
      final company = companies[i];
      try {
        onLog?.call(
            'Scraping data for ${company.name} (${i + 1}/${companies.length})...');

        final data = await scrapeCompanyData(company);
        if (data != null) {
          allData.add(data);
        }

        onProgress?.call(i + 1, companies.length, company, data);

        // Add delay between requests
        if (i < companies.length - 1) {
          await Future.delayed(delayBetweenRequests);
        }
      } catch (e) {
        onLog?.call('Error scraping ${company.name}: $e');
        onProgress?.call(i + 1, companies.length, company, null);
        // Continue with next company
      }
    }

    onLog?.call(
        'Data scraping completed. Successfully scraped: ${allData.length}/${companies.length}');
    return allData;
  }

  /// Extract company symbol from URL
  String _extractSymbolFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;

      // Look for company segment
      for (int i = 0; i < segments.length; i++) {
        if (segments[i] == 'company' && i + 1 < segments.length) {
          return segments[i + 1].toUpperCase().replaceAll('-', '');
        }
      }

      // Fallback: use last segment
      if (segments.isNotEmpty) {
        return segments.last.toUpperCase().replaceAll('-', '');
      }

      return '';
    } catch (e) {
      print('Error extracting symbol from URL $url: $e');
      return '';
    }
  }

  /// Parse number from text
  double? _parseNumber(String text) {
    try {
      if (text.trim().isEmpty) return null;

      // Remove common non-numeric characters
      String cleanText = text
          .replaceAll(RegExp(r'[₹$,\s]'), '')
          .replaceAll('Cr', '')
          .replaceAll('L', '')
          .trim();

      if (cleanText.isEmpty) return null;

      return double.tryParse(cleanText);
    } catch (e) {
      return null;
    }
  }

  /// Parse market cap with unit conversion
  double? _parseMarketCap(String text) {
    try {
      if (text.trim().isEmpty) return null;

      final originalText = text.toLowerCase();
      double? value = _parseNumber(text);

      if (value == null) return null;

      // Convert based on unit
      if (originalText.contains('cr') || originalText.contains('crore')) {
        return value; // Already in crores
      } else if (originalText.contains('l') || originalText.contains('lakh')) {
        return value / 100; // Convert lakhs to crores
      } else if (originalText.contains('k') ||
          originalText.contains('thousand')) {
        return value / 10000; // Convert thousands to crores
      } else {
        return value; // Assume it's already in the correct unit
      }
    } catch (e) {
      return null;
    }
  }

  /// Test connection to the website
  Future<bool> testConnection() async {
    try {
      final response = await _client
          .get(
            Uri.parse(baseUrl),
            headers: _headers,
          )
          .timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }

  /// Get available pages count (attempts to determine total pages)
  Future<int> getAvailablePages() async {
    try {
      final response = await _client
          .get(
            Uri.parse(baseUrl),
            headers: _headers,
          )
          .timeout(requestTimeout);

      if (response.statusCode == 200) {
        final document = parser.parse(response.body);

        // Look for pagination elements
        final paginationSelectors = [
          '.pagination a',
          '.page-link',
          'a[href*="page="]',
        ];

        int maxPage = 1;
        for (final selector in paginationSelectors) {
          final links = document.querySelectorAll(selector);
          for (final link in links) {
            final href = link.attributes['href'] ?? '';
            final pageMatch = RegExp(r'page=(\d+)').firstMatch(href);
            if (pageMatch != null) {
              final pageNum = int.tryParse(pageMatch.group(1) ?? '');
              if (pageNum != null && pageNum > maxPage) {
                maxPage = pageNum;
              }
            }
          }
        }

        return maxPage > 1 ? maxPage : 5; // Default to 5 if can't determine
      }
    } catch (e) {
      print('Error determining page count: $e');
    }

    return 5; // Default fallback
  }

  /// Clean up resources
  void dispose() {
    _client.close();
  }

  /// Get scraping statistics
  Future<Map<String, dynamic>> getScrapingStats() async {
    try {
      final stats = await _databaseService.getCompanyStats();

      // Safe null checking for stats values
      final totalCompanies = stats['totalCompanies'] ?? 0;
      final companiesWithData = stats['companiesWithData'] ?? 0;

      // Calculate completion percentage safely
      final completionPercentage = totalCompanies > 0
          ? (companiesWithData.toDouble() / totalCompanies.toDouble() * 100)
              .toStringAsFixed(1)
          : '0.0';

      return {
        'totalCompanies': totalCompanies,
        'companiesWithData': companiesWithData,
        'lastUpdate': DateTime.now().toIso8601String(),
        'dataCompletion': completionPercentage,
      };
    } catch (e) {
      return {
        'totalCompanies': 0,
        'companiesWithData': 0,
        'lastUpdate': DateTime.now().toIso8601String(),
        'dataCompletion': '0.0',
        'error': e.toString(),
      };
    }
  }

  /// Validate scraped data
  bool _isValidCompanyData(Map<String, dynamic> data) {
    final requiredFields = ['name', 'url', 'symbol'];
    return requiredFields.every((field) =>
        data.containsKey(field) &&
        data[field] != null &&
        data[field].toString().trim().isNotEmpty);
  }

  /// Get sample data for testing
  Future<Map<String, dynamic>> getSampleData() async {
    try {
      final response = await _client
          .get(
            Uri.parse(baseUrl),
            headers: _headers,
          )
          .timeout(const Duration(seconds: 10));

      final contentLength = response.body.length;
      final previewLength = contentLength > 500 ? 500 : contentLength;

      return {
        'statusCode': response.statusCode,
        'contentLength': contentLength,
        'contentPreview': response.body.substring(0, previewLength),
        'hasTable': response.body.contains('<table'),
        'hasCompanyLinks': response.body.contains('/company/'),
      };
    } catch (e) {
      return {
        'error': e.toString(),
        'statusCode': 0,
        'contentLength': 0,
      };
    }
  }

  /// Get detailed scraping report
  Future<Map<String, dynamic>> getDetailedReport() async {
    try {
      final stats = await getScrapingStats();
      final connectionTest = await testConnection();
      final pageCount = await getAvailablePages();

      return {
        'connectionStatus': connectionTest,
        'estimatedPages': pageCount,
        'statistics': stats,
        'lastChecked': DateTime.now().toIso8601String(),
        'serviceStatus': 'operational',
      };
    } catch (e) {
      return {
        'connectionStatus': false,
        'estimatedPages': 0,
        'statistics': {},
        'lastChecked': DateTime.now().toIso8601String(),
        'serviceStatus': 'error',
        'error': e.toString(),
      };
    }
  }

  /// Batch scrape with automatic retry
  Future<List<Company>> batchScrapeWithRetry({
    required List<int> pages,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 5),
    Function(String message)? onLog,
  }) async {
    final allCompanies = <Company>[];
    final failedPages = <int>[];

    for (final page in pages) {
      bool success = false;
      int attempts = 0;

      while (!success && attempts < maxRetries) {
        try {
          attempts++;
          onLog?.call(
              'Attempting to scrape page $page (attempt $attempts/$maxRetries)');

          final companies = await scrapeCompanyList(page);
          allCompanies.addAll(companies);
          success = true;

          onLog?.call(
              'Successfully scraped page $page: ${companies.length} companies');
        } catch (e) {
          onLog?.call('Attempt $attempts failed for page $page: $e');

          if (attempts < maxRetries) {
            onLog?.call(
                'Retrying page $page in ${retryDelay.inSeconds} seconds...');
            await Future.delayed(retryDelay);
          } else {
            failedPages.add(page);
            onLog?.call(
                'Failed to scrape page $page after $maxRetries attempts');
          }
        }
      }

      // Add delay between pages
      if (page != pages.last) {
        await Future.delayed(delayBetweenRequests);
      }
    }

    if (failedPages.isNotEmpty) {
      onLog?.call(
          'Scraping completed with failures. Failed pages: $failedPages');
    } else {
      onLog?.call(
          'All pages scraped successfully. Total companies: ${allCompanies.length}');
    }

    return allCompanies;
  }
}
