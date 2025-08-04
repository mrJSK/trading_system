// lib/utils/html_parser.dart
// Complete HTML parser for Screener.in with accurate sector/industry extraction

import 'dart:convert';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;
import '../models/company_data.dart';

class HtmlParser {
  static CompanyData? parseCompanyData(String htmlSource) {
    final document = html.parse(htmlSource);

    try {
      print('=== PARSING COMPANY DATA ===');

      final basicInfo = _parseBasicInfo(document);
      final mainRatios = _parseMainRatios(document);
      final keyPoints = _parseKeyPoints(document);
      final peerComparison = _parsePeerComparisonTable(document);
      final quarterlyResults = _parseQuarterlyResults(document);
      final profitLoss = _parseProfitLoss(document);
      final balanceSheet = _parseBalanceSheet(document);
      final cashFlows = _parseCashFlows(document);
      final ratios = _parseRatiosTable(document);

      print('Successfully parsed company data');

      return CompanyData.fromData(
        companyId: 0, // Will be set later

        // Basic company information
        companyName: basicInfo['name'],
        companyDescription: basicInfo['description'],
        sector: basicInfo['sector'],
        industry: basicInfo['industry'],
        subIndustry: basicInfo['subIndustry'],
        category: basicInfo['category'],

        // Key points
        pros: keyPoints,
        cons: null,

        // Financial ratios
        marketCap: mainRatios['marketCap'],
        currentPrice: mainRatios['currentPrice'],
        highLow: mainRatios['highLow'],
        pe: mainRatios['pe'],
        pb: mainRatios['pb'],
        roce: mainRatios['roce'],
        roe: mainRatios['roe'],
        dividendYield: mainRatios['dividendYield'],
        bookValue: mainRatios['bookValue'],
        faceValue: mainRatios['faceValue'],

        // Financial tables as JSON
        quarterlyResults: quarterlyResults,
        profitLoss: profitLoss,
        balanceSheet: balanceSheet,
        cashFlows: cashFlows,
        ratios: ratios,
        peerComparison: peerComparison,

        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      print('Error parsing company data: $e');
      return null;
    }
  }

  // Enhanced basic company information parsing
  static Map<String, String?> _parseBasicInfo(Document doc) {
    final result = <String, String?>{};

    // Company name from h1
    final h1 = doc.querySelector('h1');
    result['name'] = h1?.text.trim();
    print('Extracted company name: ${result['name']}');

    // Company description - look for first substantial paragraph
    final paragraphs = doc.querySelectorAll('p');
    for (final para in paragraphs) {
      final text = para.text.trim();
      if (text.length > 100 &&
          (text.contains('founded') ||
              text.contains('company') ||
              text.contains('business') ||
              text.contains('operates') ||
              text.contains('engaged') ||
              text.contains('established') ||
              text.contains('manufactures') ||
              text.contains('provides'))) {
        result['description'] = text;
        print(
            'Found company description: ${text.substring(0, text.length > 100 ? 100 : text.length)}...');
        break;
      }
    }

    // Extract sector/industry from peer comparison section
    final sectorIndustryData = _extractSectorIndustryFromPeerSection(doc);
    result['sector'] = sectorIndustryData['sector'];
    result['industry'] = sectorIndustryData['industry'];
    result['subIndustry'] = sectorIndustryData['subIndustry'];
    result['category'] = sectorIndustryData['category'];

    return result;
  }

  // Extract sector/industry hierarchy from peer comparison section
  static Map<String, String?> _extractSectorIndustryFromPeerSection(
      Document doc) {
    final result = <String, String?>{};

    try {
      // Look for the peer comparison section
      final peerHeading = doc
          .querySelectorAll('h1, h2, h3, h4, h5')
          .where((h) => h.text.toLowerCase().contains('peer'))
          .firstOrNull;

      if (peerHeading != null) {
        print('Found peer comparison heading: ${peerHeading.text}');

        // Look for the .sub paragraph right after the peer heading
        Element? current = peerHeading.nextElementSibling;
        while (current != null) {
          if (current.localName == 'p' && current.classes.contains('sub')) {
            print('Found .sub paragraph with sector links');

            // Found the sector hierarchy paragraph
            final links = current.querySelectorAll('a[href*="/market/"]');

            if (links.isNotEmpty) {
              // Extract hierarchy: Energy > Oil, Gas & Consumable Fuels > Petroleum Products > Refineries & Marketing
              result['sector'] =
                  links.length > 0 ? links[0].text.trim() : null; // Energy
              result['industry'] = links.length > 1
                  ? links[1].text.trim()
                  : null; // Oil, Gas & Consumable Fuels
              result['subIndustry'] = links.length > 2
                  ? links[2].text.trim()
                  : null; // Petroleum Products
              result['category'] = links.length > 3
                  ? links[3].text.trim()
                  : null; // Refineries & Marketing

              print('Extracted sector hierarchy:');
              print('  Sector: ${result['sector']}');
              print('  Industry: ${result['industry']}');
              print('  Sub-Industry: ${result['subIndustry']}');
              print('  Category: ${result['category']}');

              break;
            }
          }
          current = current.nextElementSibling;
        }
      }

      // Fallback: if peer section not found, try to find sector links elsewhere
      if (result['sector'] == null) {
        print('Fallback: Looking for market links elsewhere');
        final marketLinks = doc.querySelectorAll('a[href*="/market/"]');
        if (marketLinks.isNotEmpty) {
          // Sort by URL length to get hierarchy (shorter URLs = higher level)
          marketLinks.sort((a, b) => (a.attributes['href']?.length ?? 0)
              .compareTo(b.attributes['href']?.length ?? 0));

          result['sector'] =
              marketLinks.length > 0 ? marketLinks[0].text.trim() : null;
          result['industry'] =
              marketLinks.length > 1 ? marketLinks[1].text.trim() : null;
          result['subIndustry'] =
              marketLinks.length > 2 ? marketLinks[2].text.trim() : null;
          result['category'] =
              marketLinks.length > 3 ? marketLinks[3].text.trim() : null;

          print('Fallback extraction:');
          print('  Sector: ${result['sector']}');
          print('  Industry: ${result['industry']}');
        }
      }
    } catch (e) {
      print('Error extracting sector/industry: $e');
    }

    return result;
  }

  // Enhanced main ratios parsing with precise regex
  static Map<String, dynamic> _parseMainRatios(Document doc) {
    final text = doc.body?.text ?? '';
    final ratios = <String, dynamic>{};

    // Helper function to extract numbers more accurately
    double? extractNumber(String pattern) {
      final match = RegExp(pattern, caseSensitive: false).firstMatch(text);
      if (match != null && match.groupCount >= 1) {
        final numStr = match.group(1)?.replaceAll(',', '');
        return double.tryParse(numStr ?? '');
      }
      return null;
    }

    // More precise patterns to avoid cross-contamination
    ratios['marketCap'] =
        extractNumber(r'Market\s*Cap\s*[₹]?\s*([\d,\.]+)\s*Cr');
    ratios['currentPrice'] =
        extractNumber(r'Current\s*Price\s*[₹]?\s*([\d,\.]+)');
    ratios['pe'] = extractNumber(r'Stock\s*P/E\s*([\d,\.]+)');
    ratios['pb'] = extractNumber(r'P/B\s*Ratio\s*([\d,\.]+)');
    ratios['bookValue'] = extractNumber(r'Book\s*Value\s*[₹]?\s*([\d,\.]+)');
    ratios['dividendYield'] =
        extractNumber(r'Dividend\s*Yield\s*([\d,\.]+)\s*%');
    ratios['faceValue'] = extractNumber(r'Face\s*Value\s*[₹]?\s*([\d,\.]+)');

    // FIXED: More specific ROCE and ROE patterns to avoid picking up other metrics
    ratios['roce'] = extractNumber(r'\bROCE\s*([\d,\.]+)\s*%');
    ratios['roe'] = extractNumber(r'\bROE\s*([\d,\.]+)\s*%');

    // High/Low extraction
    final highLowMatch = RegExp(
            r'High\s*/\s*Low\s*[₹]?\s*([\d,\.]+)\s*/\s*[₹]?\s*([\d,\.]+)',
            caseSensitive: false)
        .firstMatch(text);
    if (highLowMatch != null) {
      ratios['highLow'] = '${highLowMatch.group(1)} / ${highLowMatch.group(2)}';
    }

    // Log extracted ratios for debugging
    print('Extracted ratios:');
    ratios.forEach((key, value) {
      print('  $key: $value');
    });

    return ratios;
  }

  // Key points extraction (Pros section)
  static String _parseKeyPoints(Document doc) {
    final bullets = <String>[];

    try {
      // Look for "Pros" section
      final prosHeading = doc
          .querySelectorAll('*')
          .where((e) => e.text.toLowerCase().trim() == 'pros')
          .firstOrNull;

      if (prosHeading != null) {
        print('Found Pros section');
        Element? current = prosHeading.nextElementSibling;
        while (current != null && bullets.length < 10) {
          if (current.localName == 'ul' || current.localName == 'ol') {
            bullets.addAll(current
                .querySelectorAll('li')
                .map((li) => '• ${li.text.trim()}'));
          } else if (current.text.toLowerCase().trim() == 'cons') {
            break;
          }
          current = current.nextElementSibling;
        }
        print('Extracted ${bullets.length} key points');
      } else {
        print('No Pros section found');
      }
    } catch (e) {
      print('Error parsing key points: $e');
    }

    return bullets.join('\n');
  }

  // Enhanced peer comparison table parsing
  static String? _parsePeerComparisonTable(Document doc) {
    Element? table;

    try {
      // Strategy 1: Look for peer comparison heading and find the table after it
      final peerHeading = doc
          .querySelectorAll('h1, h2, h3, h4, h5')
          .where((h) => h.text.toLowerCase().contains('peer'))
          .firstOrNull;

      if (peerHeading != null) {
        print('Found peer heading, looking for table...');
        Element? current = peerHeading.nextElementSibling;

        // Skip the .sub paragraph and find the table
        while (current != null) {
          if (current.localName == 'table') {
            table = current;
            print('Found peer comparison table after heading');
            break;
          }
          current = current.nextElementSibling;
        }
      }

      // Strategy 2: Look for table with peer-related classes
      if (table == null) {
        table = doc.querySelector('table.peer-comparison');
        if (table != null) print('Found table with .peer-comparison class');
      }

      if (table == null) {
        table = doc.querySelector('table[class*="peer"]');
        if (table != null) print('Found table with peer in class name');
      }

      // Strategy 3: Look for large tables (peer comparison usually has many columns)
      if (table == null) {
        final tables = doc.querySelectorAll('table');
        for (final t in tables) {
          final headerRow = t.querySelector('tr');
          final columnCount = headerRow?.querySelectorAll('th, td').length ?? 0;

          // Peer comparison tables typically have 10+ columns
          if (columnCount >= 10) {
            // Check if it contains financial metrics (good indicator of peer table)
            final tableText = t.text.toLowerCase();
            if (tableText.contains('p/e') ||
                tableText.contains('market cap') ||
                tableText.contains('roce') ||
                tableText.contains('roe')) {
              table = t;
              print('Found peer table by column count and content analysis');
              break;
            }
          }
        }
      }

      if (table == null) {
        print('No peer comparison table found');
        return null;
      }

      // Convert table to JSON with enhanced metadata
      final result = _convertTableToJson(table, 'Peer Comparison');

      // Add sector/industry context to the peer comparison data
      final sectorInfo = _extractSectorIndustryFromPeerSection(doc);
      if (result.isNotEmpty && !result.contains('"error"')) {
        try {
          final Map<String, dynamic> resultMap = jsonDecode(result);
          resultMap['sectorHierarchy'] = {
            'sector': sectorInfo['sector'],
            'industry': sectorInfo['industry'],
            'subIndustry': sectorInfo['subIndustry'],
            'category': sectorInfo['category'],
          };
          return jsonEncode(resultMap);
        } catch (e) {
          print('Error adding sector info to peer data: $e');
        }
      }

      return result;
    } catch (e) {
      print('Error parsing peer comparison table: $e');
      return null;
    }
  }

  // Financial table parsing methods
  static String _parseQuarterlyResults(Document doc) {
    return _parseFinancialTable(doc,
        ['quarterly results', 'quarterly', 'results'], 'Quarterly Results');
  }

  static String _parseProfitLoss(Document doc) {
    return _parseFinancialTable(
        doc, ['profit', 'loss', 'income statement'], 'Profit & Loss');
  }

  static String _parseBalanceSheet(Document doc) {
    return _parseFinancialTable(
        doc, ['balance sheet', 'balance', 'assets'], 'Balance Sheet');
  }

  static String _parseCashFlows(Document doc) {
    return _parseFinancialTable(
        doc, ['cash flow', 'cash', 'flows'], 'Cash Flows');
  }

  static String _parseRatiosTable(Document doc) {
    return _parseFinancialTable(doc, ['ratios', 'ratio', 'metrics'], 'Ratios');
  }

  // Generic financial table parser
  static String _parseFinancialTable(
      Document doc, List<String> keywords, String tableName) {
    Element? table;

    try {
      // Strategy 1: Find by heading
      final headings = doc.querySelectorAll('h1, h2, h3, h4, h5');
      for (final heading in headings) {
        final headingText = heading.text.toLowerCase();
        for (final keyword in keywords) {
          if (headingText.contains(keyword.toLowerCase())) {
            table = heading.nextElementSibling;
            while (table != null && table.localName != 'table') {
              table = table.nextElementSibling;
            }
            if (table != null) {
              print('Found $tableName table by heading');
              break;
            }
          }
        }
        if (table != null) break;
      }

      // Strategy 2: Find by class or data attributes
      if (table == null) {
        for (final keyword in keywords) {
          final cleanKeyword = keyword.replaceAll(' ', '-');
          table = doc.querySelector('table.$cleanKeyword');
          if (table != null) {
            print('Found $tableName table by class .$cleanKeyword');
            break;
          }
          table = doc.querySelector('table[data-test*="$cleanKeyword"]');
          if (table != null) {
            print('Found $tableName table by data-test attribute');
            break;
          }
          table = doc.querySelector('table[class*="$cleanKeyword"]');
          if (table != null) {
            print('Found $tableName table by class containing $cleanKeyword');
            break;
          }
        }
      }

      // Strategy 3: Find tables and check content
      if (table == null) {
        final tables = doc.querySelectorAll('table');
        for (final t in tables) {
          final tableText = t.text.toLowerCase();
          for (final keyword in keywords) {
            if (tableText.contains(keyword.toLowerCase())) {
              table = t;
              print('Found $tableName table by content analysis');
              break;
            }
          }
          if (table != null) break;
        }
      }

      if (table == null) {
        print('No $tableName table found');
        return jsonEncode(
            {'error': 'No $tableName table found', 'tableName': tableName});
      }

      return _convertTableToJson(table, tableName);
    } catch (e) {
      print('Error parsing $tableName table: $e');
      return jsonEncode(
          {'error': 'Error parsing $tableName: $e', 'tableName': tableName});
    }
  }

  // Enhanced table to JSON conversion
  static String _convertTableToJson(Element table, String tableName) {
    try {
      final result = <String, dynamic>{};

      // Extract headers
      final headers = <String>[];
      final headerRow =
          table.querySelector('thead tr') ?? table.querySelector('tr');
      if (headerRow != null) {
        final headerCells = headerRow.querySelectorAll('th, td');
        headers.addAll(headerCells.map((cell) => cell.text.trim()));
      }

      // Extract data rows
      final rows = <List<String>>[];
      var dataRows = table.querySelectorAll('tbody tr');
      if (dataRows.isEmpty) {
        // If no tbody, get all tr except first (header)
        final allRows = table.querySelectorAll('tr');
        dataRows = allRows.skip(1).toList();
      }

      for (final row in dataRows) {
        final cells = row.querySelectorAll('td, th');
        if (cells.isNotEmpty) {
          final rowData = cells.map((cell) => cell.text.trim()).toList();
          rows.add(rowData);
        }
      }

      result['tableName'] = tableName;
      result['headers'] = headers;
      result['rows'] = rows;
      result['totalRows'] = rows.length;
      result['totalColumns'] = headers.length;
      result['lastUpdated'] = DateTime.now().toIso8601String();

      print(
          'Converted $tableName table: ${headers.length} columns, ${rows.length} rows');
      return jsonEncode(result);
    } catch (e) {
      print('Error converting $tableName table to JSON: $e');
      return jsonEncode({
        'error': 'Failed to parse $tableName table: $e',
        'tableName': tableName
      });
    }
  }

  // Debug method to analyze page structure
  static void debugPageStructure(Document doc, [String? filename]) {
    print('=== PAGE STRUCTURE DEBUG ${filename ?? ''} ===');

    // All headings
    final headings = doc.querySelectorAll('h1, h2, h3, h4, h5, h6');
    print('\n--- HEADINGS (${headings.length}) ---');
    for (final h in headings) {
      print('${h.localName}: ${h.text.trim()}');
    }

    // All tables
    final tables = doc.querySelectorAll('table');
    print('\n--- TABLES (${tables.length}) ---');
    for (int i = 0; i < tables.length; i++) {
      final table = tables[i];
      final rows = table.querySelectorAll('tr');
      final cols =
          table.querySelector('tr')?.querySelectorAll('th, td').length ?? 0;
      print('Table ${i + 1}: ${rows.length} rows, $cols columns');
      print('  Classes: ${table.className}');
      if (table.querySelector('tr') != null) {
        final firstRowText = table.querySelector('tr')!.text.trim();
        print(
            '  First row: ${firstRowText.length > 100 ? firstRowText.substring(0, 100) + '...' : firstRowText}');
      }
    }

    // Market links (sector hierarchy)
    final marketLinks = doc.querySelectorAll('a[href*="/market/"]');
    print('\n--- MARKET LINKS (${marketLinks.length}) ---');
    for (final link in marketLinks) {
      print('${link.attributes['href']}: ${link.text.trim()}');
    }

    // Pros/Cons sections
    final prosElement = doc
        .querySelectorAll('*')
        .where((e) => e.text.toLowerCase().trim() == 'pros')
        .firstOrNull;
    print('\n--- PROS SECTION ---');
    print('Found pros element: ${prosElement != null}');

    if (prosElement != null) {
      Element? current = prosElement.nextElementSibling;
      int count = 0;
      while (current != null && count < 5) {
        final text = current.text.trim();
        print(
            'Next element: ${current.localName} - ${text.length > 50 ? text.substring(0, 50) + '...' : text}');
        current = current.nextElementSibling;
        count++;
      }
    }
  }
}
