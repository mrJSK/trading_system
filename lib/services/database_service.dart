import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/company.dart';
import '../models/company_data.dart';
import '../models/watchlist.dart';
import '../models/watchlist_company.dart';
import '../models/saved_filter.dart';

class DatabaseService {
  static Isar? _isar;
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Future<Isar> get isar async {
    _isar ??= await _initDatabase();
    return _isar!;
  }

  Future<Isar> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [
        CompanySchema,
        CompanyDataSchema,
        WatchlistSchema,
        WatchlistCompanySchema,
        SavedFilterSchema,
      ],
      directory: dir.path,
    );
  }

  // Company operations
  Future<int> insertCompany(Company company) async {
    final isar = await this.isar;
    return await isar.writeTxn(() async {
      return await isar.companys.put(company);
    });
  }

  Future<List<Company>> getAllCompanies() async {
    final isar = await this.isar;
    return await isar.companys.where().findAll();
  }

  Future<Company?> getCompanyByUrl(String url) async {
    final isar = await this.isar;
    return await isar.companys.filter().urlEqualTo(url).findFirst();
  }

  Future<Company?> getCompanyById(int companyId) async {
    final isar = await this.isar;
    return await isar.companys.get(companyId);
  }

  Future<List<Company>> searchCompanies(String query) async {
    final isar = await this.isar;
    return await isar.companys
        .filter()
        .nameContains(query, caseSensitive: false)
        .or()
        .symbolContains(query, caseSensitive: false)
        .findAll();
  }

  // Company data operations
  Future<int> insertCompanyData(CompanyData data) async {
    final isar = await this.isar;
    return await isar.writeTxn(() async {
      return await isar.companyDatas.put(data);
    });
  }

  Future<CompanyData?> getCompanyData(int companyId) async {
    final isar = await this.isar;
    return await isar.companyDatas
        .filter()
        .companyIdEqualTo(companyId)
        .findFirst();
  }

  // Updated method to work with the new CompanyData model
  Future<void> updateCompanyWithData(Company company, CompanyData data) async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      // Save company first
      final savedCompanyId = await isar.companys.put(company);

      // Set company ID in data
      data.companyId = savedCompanyId;

      // Save company data
      await isar.companyDatas.put(data);
    });
  }

  // New method to get company with its data
  Future<Map<String, dynamic>?> getCompanyWithData(int companyId) async {
    final isar = await this.isar;

    final company = await isar.companys.get(companyId);
    if (company == null) return null;

    final data = await isar.companyDatas
        .filter()
        .companyIdEqualTo(companyId)
        .findFirst();

    return {
      'company': company,
      'data': data,
    };
  }

  // New method to get all companies with their data
  Future<List<Map<String, dynamic>>> getAllCompaniesWithData() async {
    final isar = await this.isar;
    final companies = await isar.companys.where().findAll();
    final companiesWithData = <Map<String, dynamic>>[];

    for (final company in companies) {
      final data = await isar.companyDatas
          .filter()
          .companyIdEqualTo(company.id)
          .findFirst();

      companiesWithData.add({
        'company': company,
        'data': data,
      });
    }

    return companiesWithData;
  }

  // Watchlist operations
  Future<int> createWatchlist(Watchlist watchlist) async {
    final isar = await this.isar;
    return await isar.writeTxn(() async {
      return await isar.watchlists.put(watchlist);
    });
  }

  Future<List<Watchlist>> getAllWatchlists() async {
    final isar = await this.isar;
    return await isar.watchlists.where().findAll();
  }

  Future<void> addCompanyToWatchlist(int watchlistId, int companyId) async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      // Check if already exists
      final existing = await isar.watchlistCompanys
          .filter()
          .watchlistIdEqualTo(watchlistId)
          .and()
          .companyIdEqualTo(companyId)
          .findFirst();

      if (existing == null) {
        final watchlistCompany = WatchlistCompany.fromData(
          watchlistId: watchlistId,
          companyId: companyId,
          addedAt: DateTime.now(),
        );
        await isar.watchlistCompanys.put(watchlistCompany);
      }
    });
  }

  Future<void> removeCompanyFromWatchlist(
      int watchlistId, int companyId) async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      final watchlistCompany = await isar.watchlistCompanys
          .filter()
          .watchlistIdEqualTo(watchlistId)
          .and()
          .companyIdEqualTo(companyId)
          .findFirst();

      if (watchlistCompany != null) {
        await isar.watchlistCompanys.delete(watchlistCompany.id);
      }
    });
  }

  Future<List<Company>> getWatchlistCompanies(int watchlistId) async {
    final isar = await this.isar;

    // Get all watchlist-company relationships for this watchlist
    final watchlistCompanies = await isar.watchlistCompanys
        .filter()
        .watchlistIdEqualTo(watchlistId)
        .findAll();

    // Get company IDs
    final companyIds = watchlistCompanies.map((wc) => wc.companyId).toList();

    // Get companies
    final companies = <Company>[];
    for (final companyId in companyIds) {
      final company = await isar.companys.get(companyId);
      if (company != null) {
        companies.add(company);
      }
    }

    return companies;
  }

  // New method to get watchlist companies with their data
  Future<List<Map<String, dynamic>>> getWatchlistCompaniesWithData(
      int watchlistId) async {
    final isar = await this.isar;

    final watchlistCompanies = await isar.watchlistCompanys
        .filter()
        .watchlistIdEqualTo(watchlistId)
        .findAll();

    final companiesWithData = <Map<String, dynamic>>[];

    for (final wc in watchlistCompanies) {
      final company = await isar.companys.get(wc.companyId);
      if (company != null) {
        final data = await isar.companyDatas
            .filter()
            .companyIdEqualTo(company.id)
            .findFirst();

        companiesWithData.add({
          'company': company,
          'data': data,
          'addedAt': wc.addedAt,
        });
      }
    }

    return companiesWithData;
  }

  Future<void> deleteWatchlist(int watchlistId) async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      // Delete all watchlist-company relationships
      final watchlistCompanies = await isar.watchlistCompanys
          .filter()
          .watchlistIdEqualTo(watchlistId)
          .findAll();

      for (final wc in watchlistCompanies) {
        await isar.watchlistCompanys.delete(wc.id);
      }

      // Delete the watchlist
      await isar.watchlists.delete(watchlistId);
    });
  }

  // Enhanced filter operations with new CompanyData fields
  Future<List<Company>> getFilteredCompanies({
    double? minMarketCap,
    double? maxMarketCap,
    double? minPE,
    double? maxPE,
    double? minROCE,
    double? maxROCE,
    double? minROE,
    double? maxROE,
    double? minDividendYield,
    double? maxDividendYield,
    double? minCurrentPrice,
    double? maxCurrentPrice,
    String? sector,
    String? industry,
  }) async {
    final isar = await this.isar;

    // Get all companies
    final companies = await isar.companys.where().findAll();
    final filteredCompanies = <Company>[];

    for (final company in companies) {
      // Get company data using companyId
      final data = await isar.companyDatas
          .filter()
          .companyIdEqualTo(company.id)
          .findFirst();

      if (data != null) {
        bool passesFilter = true;

        // Financial filters
        if (minMarketCap != null &&
            (data.marketCap == null || data.marketCap! < minMarketCap)) {
          passesFilter = false;
        }
        if (maxMarketCap != null &&
            (data.marketCap == null || data.marketCap! > maxMarketCap)) {
          passesFilter = false;
        }
        if (minPE != null && (data.pe == null || data.pe! < minPE)) {
          passesFilter = false;
        }
        if (maxPE != null && (data.pe == null || data.pe! > maxPE)) {
          passesFilter = false;
        }
        if (minROCE != null && (data.roce == null || data.roce! < minROCE)) {
          passesFilter = false;
        }
        if (maxROCE != null && (data.roce == null || data.roce! > maxROCE)) {
          passesFilter = false;
        }
        if (minROE != null && (data.roe == null || data.roe! < minROE)) {
          passesFilter = false;
        }
        if (maxROE != null && (data.roe == null || data.roe! > maxROE)) {
          passesFilter = false;
        }
        if (minDividendYield != null &&
            (data.dividendYield == null ||
                data.dividendYield! < minDividendYield)) {
          passesFilter = false;
        }
        if (maxDividendYield != null &&
            (data.dividendYield == null ||
                data.dividendYield! > maxDividendYield)) {
          passesFilter = false;
        }
        if (minCurrentPrice != null &&
            (data.currentPrice == null ||
                data.currentPrice! < minCurrentPrice)) {
          passesFilter = false;
        }
        if (maxCurrentPrice != null &&
            (data.currentPrice == null ||
                data.currentPrice! > maxCurrentPrice)) {
          passesFilter = false;
        }

        // Sector and Industry filters
        if (sector != null &&
            (data.sector == null ||
                !data.sector!.toLowerCase().contains(sector.toLowerCase()))) {
          passesFilter = false;
        }
        if (industry != null &&
            (data.industry == null ||
                !data.industry!
                    .toLowerCase()
                    .contains(industry.toLowerCase()))) {
          passesFilter = false;
        }

        if (passesFilter) {
          filteredCompanies.add(company);
        }
      }
    }

    return filteredCompanies;
  }

  // New method to get filtered companies with their data
  Future<List<Map<String, dynamic>>> getFilteredCompaniesWithData({
    double? minMarketCap,
    double? maxMarketCap,
    double? minPE,
    double? maxPE,
    double? minROCE,
    double? maxROCE,
    double? minROE,
    double? maxROE,
    double? minDividendYield,
    double? maxDividendYield,
    double? minCurrentPrice,
    double? maxCurrentPrice,
    String? sector,
    String? industry,
  }) async {
    final companies = await getFilteredCompanies(
      minMarketCap: minMarketCap,
      maxMarketCap: maxMarketCap,
      minPE: minPE,
      maxPE: maxPE,
      minROCE: minROCE,
      maxROCE: maxROCE,
      minROE: minROE,
      maxROE: maxROE,
      minDividendYield: minDividendYield,
      maxDividendYield: maxDividendYield,
      minCurrentPrice: minCurrentPrice,
      maxCurrentPrice: maxCurrentPrice,
      sector: sector,
      industry: industry,
    );

    final companiesWithData = <Map<String, dynamic>>[];
    final isar = await this.isar;

    for (final company in companies) {
      final data = await isar.companyDatas
          .filter()
          .companyIdEqualTo(company.id)
          .findFirst();

      companiesWithData.add({
        'company': company,
        'data': data,
      });
    }

    return companiesWithData;
  }

  // Saved filter operations
  Future<int> saveFilter(SavedFilter filter) async {
    final isar = await this.isar;
    return await isar.writeTxn(() async {
      return await isar.savedFilters.put(filter);
    });
  }

  Future<List<SavedFilter>> getAllSavedFilters() async {
    final isar = await this.isar;
    return await isar.savedFilters.where().findAll();
  }

  Future<void> deleteSavedFilter(int filterId) async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      await isar.savedFilters.delete(filterId);
    });
  }

  // Enhanced analytics and statistics
  Future<Map<String, int>> getCompanyStats() async {
    final isar = await this.isar;
    final totalCompanies = await isar.companys.count();
    final companiesWithData = await isar.companyDatas.count();
    final totalWatchlists = await isar.watchlists.count();

    return {
      'totalCompanies': totalCompanies,
      'companiesWithData': companiesWithData,
      'totalWatchlists': totalWatchlists,
    };
  }

  // New method to get detailed statistics
  Future<Map<String, dynamic>> getDetailedStats() async {
    final isar = await this.isar;

    final totalCompanies = await isar.companys.count();
    final companiesWithData = await isar.companyDatas.count();
    final totalWatchlists = await isar.watchlists.count();
    final totalWatchlistEntries = await isar.watchlistCompanys.count();

    // Get sector distribution
    final allData = await isar.companyDatas.where().findAll();
    final sectorCounts = <String, int>{};

    for (final data in allData) {
      if (data.sector != null && data.sector!.isNotEmpty) {
        sectorCounts[data.sector!] = (sectorCounts[data.sector!] ?? 0) + 1;
      }
    }

    return {
      'totalCompanies': totalCompanies,
      'companiesWithData': companiesWithData,
      'totalWatchlists': totalWatchlists,
      'totalWatchlistEntries': totalWatchlistEntries,
      'dataCompleteness':
          totalCompanies > 0 ? (companiesWithData / totalCompanies * 100) : 0.0,
      'sectorDistribution': sectorCounts,
      'lastUpdated': DateTime.now().toIso8601String(),
    };
  }

  Future<void> clearAllData() async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }

  // Additional helper methods
  Future<bool> isCompanyInWatchlist(int companyId, int watchlistId) async {
    final isar = await this.isar;
    final relationship = await isar.watchlistCompanys
        .filter()
        .companyIdEqualTo(companyId)
        .and()
        .watchlistIdEqualTo(watchlistId)
        .findFirst();

    return relationship != null;
  }

  Future<List<Watchlist>> getWatchlistsForCompany(int companyId) async {
    final isar = await this.isar;

    // Get all watchlist-company relationships for this company
    final watchlistCompanies = await isar.watchlistCompanys
        .filter()
        .companyIdEqualTo(companyId)
        .findAll();

    // Get watchlist IDs
    final watchlistIds =
        watchlistCompanies.map((wc) => wc.watchlistId).toList();

    // Get watchlists
    final watchlists = <Watchlist>[];
    for (final watchlistId in watchlistIds) {
      final watchlist = await isar.watchlists.get(watchlistId);
      if (watchlist != null) {
        watchlists.add(watchlist);
      }
    }

    return watchlists;
  }

  Future<int> getWatchlistCompanyCount(int watchlistId) async {
    final isar = await this.isar;
    return await isar.watchlistCompanys
        .filter()
        .watchlistIdEqualTo(watchlistId)
        .count();
  }

  Future<List<Company>> getCompaniesWithData() async {
    final isar = await this.isar;

    // Get all companies that have associated data
    final companiesWithData = <Company>[];
    final allCompanies = await isar.companys.where().findAll();

    for (final company in allCompanies) {
      final data = await isar.companyDatas
          .filter()
          .companyIdEqualTo(company.id)
          .findFirst();

      if (data != null) {
        companiesWithData.add(company);
      }
    }

    return companiesWithData;
  }

  Future<List<Company>> getCompaniesWithoutData() async {
    final isar = await this.isar;

    // Get all companies that don't have associated data
    final companiesWithoutData = <Company>[];
    final allCompanies = await isar.companys.where().findAll();

    for (final company in allCompanies) {
      final data = await isar.companyDatas
          .filter()
          .companyIdEqualTo(company.id)
          .findFirst();

      if (data == null) {
        companiesWithoutData.add(company);
      }
    }

    return companiesWithoutData;
  }

  Future<Map<String, dynamic>> getDatabaseInfo() async {
    final isar = await this.isar;

    final totalCompanies = await isar.companys.count();
    final totalCompanyData = await isar.companyDatas.count();
    final totalWatchlists = await isar.watchlists.count();
    final totalWatchlistCompanies = await isar.watchlistCompanys.count();
    final totalSavedFilters = await isar.savedFilters.count();

    return {
      'totalCompanies': totalCompanies,
      'totalCompanyData': totalCompanyData,
      'totalWatchlists': totalWatchlists,
      'totalWatchlistCompanies': totalWatchlistCompanies,
      'totalSavedFilters': totalSavedFilters,
      'dataCompleteness': totalCompanies > 0
          ? (totalCompanyData / totalCompanies * 100).toStringAsFixed(1)
          : '0.0',
    };
  }

  // New methods for advanced operations
  Future<List<String>> getAllSectors() async {
    final isar = await this.isar;
    final allData = await isar.companyDatas.where().findAll();
    final sectors = <String>{};

    for (final data in allData) {
      if (data.sector != null && data.sector!.isNotEmpty) {
        sectors.add(data.sector!);
      }
    }

    return sectors.toList()..sort();
  }

  Future<List<String>> getAllIndustries() async {
    final isar = await this.isar;
    final allData = await isar.companyDatas.where().findAll();
    final industries = <String>{};

    for (final data in allData) {
      if (data.industry != null && data.industry!.isNotEmpty) {
        industries.add(data.industry!);
      }
    }

    return industries.toList()..sort();
  }

  Future<void> bulkUpdateCompanyData(List<CompanyData> dataList) async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      await isar.companyDatas.putAll(dataList);
    });
  }

  Future<void> bulkInsertCompanies(List<Company> companies) async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      await isar.companys.putAll(companies);
    });
  }

  // Search methods
  Future<List<Map<String, dynamic>>> searchCompaniesWithData(
      String query) async {
    final companies = await searchCompanies(query);
    final isar = await this.isar;
    final results = <Map<String, dynamic>>[];

    for (final company in companies) {
      final data = await isar.companyDatas
          .filter()
          .companyIdEqualTo(company.id)
          .findFirst();

      results.add({
        'company': company,
        'data': data,
      });
    }

    return results;
  }
}
