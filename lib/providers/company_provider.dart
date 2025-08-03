import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/company_model.dart';
import '../models/fundamental_filter.dart';
import '../utils/json_parsing_utils.dart';
import 'dart:math';

part 'company_provider.g.dart';

@riverpod
class CompanyNotifier extends _$CompanyNotifier {
  @override
  Future<List<CompanyModel>> build() async {
    return await _fetchCompanies();
  }

  Future<List<CompanyModel>> _fetchCompanies() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('companies')
          .limit(1000)
          .get();

      final companies = snapshot.docs
          .map((doc) {
            try {
              return CompanyModel.fromFirestore(doc);
            } catch (e) {
              debugPrint('Error parsing company ${doc.id}: $e');
              return null;
            }
          })
          .whereType<CompanyModel>()
          .toList();

      final processedCompanies =
          await compute(_processCompaniesInBackground, companies);
      return processedCompanies;
    } catch (e, stack) {
      debugPrint('Error fetching companies: $e\n$stack');
      return [];
    }
  }

  static List<CompanyModel> _processCompaniesInBackground(
      List<CompanyModel> companies) {
    return companies.map(_enhanceCompanyWithCalculations).toList();
  }

  static CompanyModel _enhanceCompanyWithCalculations(CompanyModel company) {
    // Create enhanced calculated metrics
    final calculatedMetrics = CalculatedMetrics(
      piotroskiScore: company.calculatedPiotroskiScore,
      altmanZScore: company.calculatedAltmanZScore,
      grahamNumber: company.calculatedGrahamNumber,
      pegRatio: company.calculatedPEGRatio,
      roic: company.calculatedROIC,
      fcfYield: company.calculatedFCFYield,
      comprehensiveScore: company.calculatedComprehensiveScore,
      riskAssessment: company.calculatedRiskAssessment,
      investmentGrade: company.calculatedInvestmentGrade,
      investmentRecommendation: company.calculatedInvestmentRecommendation,
      safetyMargin: company.safetyMargin,
      strengthFactors: _calculateStrengthFactors(company),
      weaknessFactors: _calculateWeaknessFactors(company),
      qualityMetrics: _calculateQualityMetrics(company),
      valuationMetrics: _calculateValuationMetrics(company),
      debtServiceCoverage: _calculateDebtServiceCoverage(company),
      workingCapitalTurnover: _calculateWorkingCapitalTurnover(company),
      returnOnAssets: _calculateReturnOnAssets(company),
      returnOnCapital: _calculateReturnOnCapital(company),
      evToEbitda: _calculateEVToEBITDA(company),
      priceToFreeCashFlow: _calculatePriceToFreeCashFlow(company),
      enterpriseValueToSales: _calculateEnterpriseValueToSales(company),
      sectorComparison: _calculateSectorComparison(company),
    );

    // Create enhanced company with calculated metrics
    return CompanyModel(
      symbol: company.symbol,
      name: company.name,
      displayName: company.displayName,
      about: company.about,
      website: company.website,
      bseCode: company.bseCode,
      nseCode: company.nseCode,
      marketCap: company.marketCap,
      currentPrice: company.currentPrice,
      highLow: company.highLow,
      stockPe: company.stockPe,
      bookValue: company.bookValue,
      dividendYield: company.dividendYield,
      roce: company.roce,
      roe: company.roe,
      faceValue: company.faceValue,
      pros: company.pros,
      cons: company.cons,
      createdAt: company.createdAt,
      updatedAt: company.updatedAt,
      lastUpdated: company.lastUpdated,
      changePercent: company.changePercent,
      changeAmount: company.changeAmount,
      previousClose: company.previousClose,
      quarterlyResults: company.quarterlyResults,
      profitLossStatement: company.profitLossStatement,
      balanceSheet: company.balanceSheet,
      cashFlowStatement: company.cashFlowStatement,
      ratios: company.ratios,
      debtToEquity: company.debtToEquity,
      currentRatio: company.currentRatio,
      quickRatio: company.quickRatio,
      workingCapitalDays: company.workingCapitalDays,
      debtorDays: company.debtorDays,
      inventoryDays: company.inventoryDays,
      cashConversionCycle: company.cashConversionCycle,
      interestCoverage: company.interestCoverage,
      assetTurnover: company.assetTurnover,
      inventoryTurnover: company.inventoryTurnover,
      receivablesTurnover: company.receivablesTurnover,
      payablesTurnover: company.payablesTurnover,
      workingCapital: company.workingCapital,
      enterpriseValue: company.enterpriseValue,
      evEbitda: company.evEbitda,
      priceToBook: company.priceToBook,
      priceToSales: company.priceToSales,
      pegRatio: company.pegRatio,
      betaValue: company.betaValue,
      salesGrowth1Y: company.salesGrowth1Y,
      salesGrowth3Y: company.salesGrowth3Y,
      salesGrowth5Y: company.salesGrowth5Y,
      profitGrowth1Y: company.profitGrowth1Y,
      profitGrowth3Y: company.profitGrowth3Y,
      profitGrowth5Y: company.profitGrowth5Y,
      salesCAGR3Y: company.salesCAGR3Y,
      salesCAGR5Y: company.salesCAGR5Y,
      profitCAGR3Y: company.profitCAGR3Y,
      profitCAGR5Y: company.profitCAGR5Y,
      businessOverview: company.businessOverview,
      sector: company.sector,
      industry: company.industry,
      industryClassification: company.industryClassification,
      recentPerformance: company.recentPerformance,
      keyMilestones: company.keyMilestones,
      investmentHighlights: company.investmentHighlights,
      financialSummary: company.financialSummary,
      qualityScore: company.qualityScore,
      overallQualityGrade: company.overallQualityGrade,
      workingCapitalEfficiency: company.workingCapitalEfficiency,
      cashCycleEfficiency: company.cashCycleEfficiency,
      liquidityStatus: company.liquidityStatus,
      debtStatus: company.debtStatus,
      riskLevel: company.riskLevel,
      piotroskiScore: calculatedMetrics.piotroskiScore,
      altmanZScore: calculatedMetrics.altmanZScore,
      qualityGrade: calculatedMetrics.investmentGrade,
      creditRating: company.creditRating,
      grahamNumber: calculatedMetrics.grahamNumber,
      roic: calculatedMetrics.roic,
      fcfYield: calculatedMetrics.fcfYield,
      debtServiceCoverage: calculatedMetrics.debtServiceCoverage,
      comprehensiveScore: calculatedMetrics.comprehensiveScore,
      investmentRecommendation: calculatedMetrics.investmentRecommendation,
      ratiosData: company.ratiosData,
      growthTables: company.growthTables,
      quarterlyDataHistory: company.quarterlyDataHistory,
      annualDataHistory: company.annualDataHistory,
      peerCompanies: company.peerCompanies,
      sectorPE: company.sectorPE,
      sectorROE: company.sectorROE,
      sectorDebtToEquity: company.sectorDebtToEquity,
      dividendPerShare: company.dividendPerShare,
      dividendFrequency: company.dividendFrequency,
      dividendHistory: company.dividendHistory,
      keyManagement: company.keyManagement,
      promoterHolding: company.promoterHolding,
      institutionalHolding: company.institutionalHolding,
      publicHolding: company.publicHolding,
      volatility30D: company.volatility30D,
      volatility1Y: company.volatility1Y,
      maxDrawdown: company.maxDrawdown,
      sharpeRatio: company.sharpeRatio,
      marketCapCategory: company.marketCapCategory,
      isIndexConstituent: company.isIndexConstituent,
      indices: company.indices,
      rsi: company.rsi,
      sma50: company.sma50,
      sma200: company.sma200,
      ema12: company.ema12,
      ema26: company.ema26,
      isDebtFree: company.isDebtFree,
      isProfitable: company.isProfitable,
      hasConsistentProfits: company.hasConsistentProfits,
      paysDividends: company.paysDividends,
      isGrowthStock: company.isGrowthStock,
      isValueStock: company.isValueStock,
      isQualityStock: company.isQualityStock,
    );
  }

  static List<String> _calculateStrengthFactors(CompanyModel company) {
    final strengths = <String>[];

    if (company.roe != null && company.roe! > 15) {
      strengths.add('High ROE (${company.roe!.toStringAsFixed(1)}%)');
    }
    if (company.roce != null && company.roce! > 15) {
      strengths.add('Strong ROCE (${company.roce!.toStringAsFixed(1)}%)');
    }
    if (company.debtToEquity != null && company.debtToEquity! < 0.5) {
      strengths
          .add('Low Debt (D/E: ${company.debtToEquity!.toStringAsFixed(2)})');
    }
    if (company.currentRatio != null && company.currentRatio! > 1.5) {
      strengths.add(
          'Strong Liquidity (CR: ${company.currentRatio!.toStringAsFixed(2)})');
    }
    if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 15) {
      strengths.add(
          'High Sales Growth (${company.salesGrowth3Y!.toStringAsFixed(1)}%)');
    }
    if (company.profitGrowth3Y != null && company.profitGrowth3Y! > 15) {
      strengths.add(
          'Strong Profit Growth (${company.profitGrowth3Y!.toStringAsFixed(1)}%)');
    }
    if (company.dividendYield != null && company.dividendYield! > 2) {
      strengths.add(
          'Good Dividend Yield (${company.dividendYield!.toStringAsFixed(1)}%)');
    }
    if (company.interestCoverage != null && company.interestCoverage! > 5) {
      strengths.add(
          'Strong Interest Coverage (${company.interestCoverage!.toStringAsFixed(1)}x)');
    }
    if (company.workingCapitalDays != null &&
        company.workingCapitalDays! < 60) {
      strengths.add(
          'Efficient Working Capital (${company.workingCapitalDays!.toInt()} days)');
    }

    return strengths;
  }

  static List<String> _calculateWeaknessFactors(CompanyModel company) {
    final weaknesses = <String>[];

    if (company.roe != null && company.roe! < 10) {
      weaknesses.add('Low ROE (${company.roe!.toStringAsFixed(1)}%)');
    }
    if (company.debtToEquity != null && company.debtToEquity! > 1.0) {
      weaknesses
          .add('High Debt (D/E: ${company.debtToEquity!.toStringAsFixed(2)})');
    }
    if (company.currentRatio != null && company.currentRatio! < 1.0) {
      weaknesses.add(
          'Poor Liquidity (CR: ${company.currentRatio!.toStringAsFixed(2)})');
    }
    if (company.stockPe != null && company.stockPe! > 30) {
      weaknesses
          .add('High Valuation (P/E: ${company.stockPe!.toStringAsFixed(1)})');
    }
    if (company.interestCoverage != null && company.interestCoverage! < 2.5) {
      weaknesses.add(
          'Low Interest Coverage (${company.interestCoverage!.toStringAsFixed(1)}x)');
    }
    if (company.workingCapitalDays != null &&
        company.workingCapitalDays! > 120) {
      weaknesses.add(
          'Inefficient Working Capital (${company.workingCapitalDays!.toInt()} days)');
    }
    if (company.salesGrowth3Y != null && company.salesGrowth3Y! < 5) {
      weaknesses.add(
          'Slow Sales Growth (${company.salesGrowth3Y!.toStringAsFixed(1)}%)');
    }

    return weaknesses;
  }

  static Map<String, String> _calculateQualityMetrics(CompanyModel company) {
    final metrics = <String, String>{};

    final piotroski = company.calculatedPiotroskiScore;
    if (piotroski >= 7) {
      metrics['Piotroski'] = 'Excellent (${piotroski.toInt()}/9)';
    } else if (piotroski >= 5) {
      metrics['Piotroski'] = 'Good (${piotroski.toInt()}/9)';
    } else {
      metrics['Piotroski'] = 'Poor (${piotroski.toInt()}/9)';
    }

    final altman = company.calculatedAltmanZScore;
    if (altman > 3.0) {
      metrics['Bankruptcy Risk'] = 'Very Low';
    } else if (altman > 1.8) {
      metrics['Bankruptcy Risk'] = 'Low';
    } else {
      metrics['Bankruptcy Risk'] = 'High';
    }

    final comprehensive = company.calculatedComprehensiveScore;
    if (comprehensive > 80) {
      metrics['Overall Quality'] = 'Excellent';
    } else if (comprehensive > 60) {
      metrics['Overall Quality'] = 'Good';
    } else if (comprehensive > 40) {
      metrics['Overall Quality'] = 'Average';
    } else {
      metrics['Overall Quality'] = 'Poor';
    }

    // Add credit rating assessment
    if (altman > 3.0 && piotroski >= 7) {
      metrics['Credit Rating'] = 'AAA';
    } else if (altman > 2.5 && piotroski >= 6) {
      metrics['Credit Rating'] = 'AA';
    } else if (altman > 1.8 && piotroski >= 5) {
      metrics['Credit Rating'] = 'A';
    } else {
      metrics['Credit Rating'] = 'BBB or Below';
    }

    return metrics;
  }

  static Map<String, dynamic> _calculateValuationMetrics(CompanyModel company) {
    final metrics = <String, dynamic>{};

    if (company.stockPe != null) {
      metrics['PE_Ratio'] = company.stockPe;
      if (company.stockPe! < 15) {
        metrics['PE_Status'] = 'Undervalued';
      } else if (company.stockPe! < 25) {
        metrics['PE_Status'] = 'Fair';
      } else {
        metrics['PE_Status'] = 'Overvalued';
      }
    }

    if (company.priceToBook != null) {
      metrics['PB_Ratio'] = company.priceToBook;
      if (company.priceToBook! < 1.5) {
        metrics['PB_Status'] = 'Undervalued';
      } else if (company.priceToBook! < 3.0) {
        metrics['PB_Status'] = 'Fair';
      } else {
        metrics['PB_Status'] = 'Overvalued';
      }
    }

    final pegRatio = company.calculatedPEGRatio;
    if (pegRatio != null) {
      metrics['PEG_Ratio'] = pegRatio;
      if (pegRatio < 1.0) {
        metrics['PEG_Status'] = 'Undervalued';
      } else if (pegRatio < 2.0) {
        metrics['PEG_Status'] = 'Fair';
      } else {
        metrics['PEG_Status'] = 'Overvalued';
      }
    }

    final graham = company.calculatedGrahamNumber;
    if (graham != null && company.currentPrice != null) {
      metrics['Intrinsic_Value'] = graham;
      metrics['Current_Price'] = company.currentPrice;
      metrics['Safety_Margin'] = company.safetyMargin;

      if (company.safetyMargin != null) {
        if (company.safetyMargin! > 25) {
          metrics['Value_Status'] = 'Strong Buy';
        } else if (company.safetyMargin! > 10) {
          metrics['Value_Status'] = 'Buy';
        } else if (company.safetyMargin! > -10) {
          metrics['Value_Status'] = 'Fair';
        } else {
          metrics['Value_Status'] = 'Overvalued';
        }
      }
    }

    return metrics;
  }

  // Additional calculation methods
  static double? _calculateDebtServiceCoverage(CompanyModel company) {
    if (company.annualDataHistory.isEmpty) return null;
    final latest = company.annualDataHistory.first;
    if (latest.ebitda == null || latest.interestExpense == null) return null;
    if (latest.interestExpense! <= 0) return null;
    return latest.ebitda! / latest.interestExpense!;
  }

  static double? _calculateWorkingCapitalTurnover(CompanyModel company) {
    if (company.annualDataHistory.isEmpty) return null;
    final latest = company.annualDataHistory.first;
    if (latest.sales == null || latest.workingCapital == null) return null;
    if (latest.workingCapital! <= 0) return null;
    return latest.sales! / latest.workingCapital!;
  }

  static double? _calculateReturnOnAssets(CompanyModel company) {
    if (company.annualDataHistory.isEmpty) return null;
    final latest = company.annualDataHistory.first;
    if (latest.netProfit == null || latest.totalAssets == null) return null;
    if (latest.totalAssets! <= 0) return null;
    return (latest.netProfit! / latest.totalAssets!) * 100;
  }

  static double? _calculateReturnOnCapital(CompanyModel company) {
    if (company.annualDataHistory.isEmpty) return null;
    final latest = company.annualDataHistory.first;
    if (latest.ebitda == null ||
        latest.totalAssets == null ||
        latest.totalLiabilities == null) return null;
    final investedCapital = latest.totalAssets! - latest.totalLiabilities!;
    if (investedCapital <= 0) return null;
    return (latest.ebitda! / investedCapital) * 100;
  }

  static double? _calculateEVToEBITDA(CompanyModel company) {
    if (company.enterpriseValue == null || company.annualDataHistory.isEmpty)
      return null;
    final latest = company.annualDataHistory.first;
    if (latest.ebitda == null || latest.ebitda! <= 0) return null;
    return company.enterpriseValue! / latest.ebitda!;
  }

  static double? _calculatePriceToFreeCashFlow(CompanyModel company) {
    if (company.marketCap == null || company.annualDataHistory.isEmpty)
      return null;
    final latest = company.annualDataHistory.first;
    if (latest.freeCashFlow == null || latest.freeCashFlow! <= 0) return null;
    return company.marketCap! / latest.freeCashFlow!;
  }

  static double? _calculateEnterpriseValueToSales(CompanyModel company) {
    if (company.enterpriseValue == null || company.annualDataHistory.isEmpty)
      return null;
    final latest = company.annualDataHistory.first;
    if (latest.sales == null || latest.sales! <= 0) return null;
    return company.enterpriseValue! / latest.sales!;
  }

  static Map<String, double>? _calculateSectorComparison(CompanyModel company) {
    // This would need sector averages data
    // For now, return empty map
    return <String, double>{};
  }

  Future<void> refreshCompanies() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchCompanies());
  }

  Future<CompanyModel?> getCompanyBySymbol(String symbol) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('companies')
          .doc(symbol)
          .get();

      if (doc.exists) {
        final company = CompanyModel.fromFirestore(doc);
        return _enhanceCompanyWithCalculations(company);
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching company $symbol: $e');
      return null;
    }
  }

  Future<List<CompanyModel>> searchCompanies(String query) async {
    final companies = await future;
    if (query.isEmpty) return companies;

    return companies
        .where((company) => company.matchesSearchQuery(query))
        .toList();
  }

  Future<List<CompanyModel>> filterByFundamentals(
      List<FundamentalType> filters) async {
    final companies = await future;
    if (filters.isEmpty) return companies;

    return companies.where((company) {
      return filters
          .every((filter) => company.matchesFundamentalFilter(filter));
    }).toList();
  }

  Future<List<CompanyModel>> getTopPerformers({
    String sortBy = 'comprehensiveScore',
    int limit = 20,
  }) async {
    final companies = await future;
    final sorted = List<CompanyModel>.from(companies);

    switch (sortBy) {
      case 'comprehensiveScore':
        sorted.sort((a, b) => b.calculatedComprehensiveScore
            .compareTo(a.calculatedComprehensiveScore));
        break;
      case 'piotroskiScore':
        sorted.sort((a, b) =>
            b.calculatedPiotroskiScore.compareTo(a.calculatedPiotroskiScore));
        break;
      case 'roe':
        sorted.sort((a, b) => (b.roe ?? 0).compareTo(a.roe ?? 0));
        break;
      case 'marketCap':
        sorted.sort((a, b) => (b.marketCap ?? 0).compareTo(a.marketCap ?? 0));
        break;
      case 'salesGrowth':
        sorted.sort(
            (a, b) => (b.salesGrowth3Y ?? 0).compareTo(a.salesGrowth3Y ?? 0));
        break;
      case 'profitGrowth':
        sorted.sort(
            (a, b) => (b.profitGrowth3Y ?? 0).compareTo(a.profitGrowth3Y ?? 0));
        break;
      case 'altmanZScore':
        sorted.sort((a, b) =>
            b.calculatedAltmanZScore.compareTo(a.calculatedAltmanZScore));
        break;
      case 'grahamValue':
        sorted.sort((a, b) {
          final aMargin = a.safetyMargin ?? -100;
          final bMargin = b.safetyMargin ?? -100;
          return bMargin.compareTo(aMargin);
        });
        break;
    }

    return sorted.take(limit).toList();
  }

  Future<Map<String, List<CompanyModel>>> getCompaniesBySector() async {
    final companies = await future;
    final bySector = <String, List<CompanyModel>>{};

    for (final company in companies) {
      final sector = company.sector ?? 'Unknown';
      bySector.putIfAbsent(sector, () => []).add(company);
    }

    // Sort companies within each sector by comprehensive score
    for (final sectorList in bySector.values) {
      sectorList.sort((a, b) => b.calculatedComprehensiveScore
          .compareTo(a.calculatedComprehensiveScore));
    }

    return bySector;
  }

  Future<List<CompanyModel>> getSimilarCompanies(String symbol,
      {int limit = 5}) async {
    final companies = await future;
    final targetCompany = companies.firstWhere(
      (c) => c.symbol == symbol,
      orElse: () => companies.first,
    );

    final sameIndustry = companies
        .where(
            (c) => c.symbol != symbol && c.industry == targetCompany.industry)
        .toList();

    sameIndustry.sort((a, b) {
      final scoreA = a.calculatedComprehensiveScore;
      final scoreB = b.calculatedComprehensiveScore;
      return scoreB.compareTo(scoreA);
    });

    return sameIndustry.take(limit).toList();
  }

  // New methods for enhanced functionality
  Future<List<CompanyModel>> getHighQualityStocks({int limit = 50}) async {
    final companies = await future;
    return companies
        .where((c) =>
            c.calculatedPiotroskiScore >= 7 &&
            c.calculatedComprehensiveScore >= 70)
        .take(limit)
        .toList();
  }

  Future<List<CompanyModel>> getValueOpportunities({int limit = 30}) async {
    final companies = await future;
    return companies
        .where((c) =>
            c.safetyMargin != null &&
            c.safetyMargin! > 15 &&
            c.calculatedComprehensiveScore >= 50)
        .take(limit)
        .toList();
  }

  Future<Map<String, dynamic>> getMarketSummary() async {
    final companies = await future;
    if (companies.isEmpty) return {};

    final totalCompanies = companies.length;
    final profitableCompanies =
        companies.where((c) => c.roe != null && c.roe! > 0).length;
    final highQualityCompanies =
        companies.where((c) => c.calculatedPiotroskiScore >= 7).length;
    final undervaluedCompanies = companies
        .where((c) => c.safetyMargin != null && c.safetyMargin! > 10)
        .length;

    final avgPE = companies
            .where(
                (c) => c.stockPe != null && c.stockPe! > 0 && c.stockPe! < 100)
            .map((c) => c.stockPe!)
            .fold(0.0, (sum, pe) => sum + pe) /
        companies
            .where(
                (c) => c.stockPe != null && c.stockPe! > 0 && c.stockPe! < 100)
            .length;

    final avgROE = companies
            .where((c) => c.roe != null)
            .map((c) => c.roe!)
            .fold(0.0, (sum, roe) => sum + roe) /
        companies.where((c) => c.roe != null).length;

    return {
      'totalCompanies': totalCompanies,
      'profitablePercentage':
          (profitableCompanies / totalCompanies * 100).toStringAsFixed(1),
      'highQualityPercentage':
          (highQualityCompanies / totalCompanies * 100).toStringAsFixed(1),
      'undervaluedPercentage':
          (undervaluedCompanies / totalCompanies * 100).toStringAsFixed(1),
      'avgPE': avgPE.toStringAsFixed(1),
      'avgROE': avgROE.toStringAsFixed(1),
    };
  }
}

// ============================================================================
// CALCULATED METRICS CLASS (Manual Implementation)
// ============================================================================

class CalculatedMetrics {
  final double? piotroskiScore;
  final double? altmanZScore;
  final double? grahamNumber;
  final double? pegRatio;
  final double? roic;
  final double? fcfYield;
  final double? comprehensiveScore;
  final String? riskAssessment;
  final String? investmentGrade;
  final String? investmentRecommendation;
  final double? safetyMargin;
  final double? debtServiceCoverage;
  final double? workingCapitalTurnover;
  final double? returnOnAssets;
  final double? returnOnCapital;
  final double? evToEbitda;
  final double? priceToFreeCashFlow;
  final double? enterpriseValueToSales;
  final Map<String, double>? sectorComparison;
  final Map<String, String>? qualityMetrics;
  final List<String>? strengthFactors;
  final List<String>? weaknessFactors;
  final Map<String, dynamic>? valuationMetrics;

  const CalculatedMetrics({
    this.piotroskiScore,
    this.altmanZScore,
    this.grahamNumber,
    this.pegRatio,
    this.roic,
    this.fcfYield,
    this.comprehensiveScore,
    this.riskAssessment,
    this.investmentGrade,
    this.investmentRecommendation,
    this.safetyMargin,
    this.debtServiceCoverage,
    this.workingCapitalTurnover,
    this.returnOnAssets,
    this.returnOnCapital,
    this.evToEbitda,
    this.priceToFreeCashFlow,
    this.enterpriseValueToSales,
    this.sectorComparison,
    this.qualityMetrics,
    this.strengthFactors,
    this.weaknessFactors,
    this.valuationMetrics,
  });

  factory CalculatedMetrics.fromJson(Map<String, dynamic> json) {
    return CalculatedMetrics(
      piotroskiScore: JsonParsingUtils.safeDouble(json['piotroski_score']),
      altmanZScore: JsonParsingUtils.safeDouble(json['altman_z_score']),
      grahamNumber: JsonParsingUtils.safeDouble(json['graham_number']),
      pegRatio: JsonParsingUtils.safeDouble(json['peg_ratio']),
      roic: JsonParsingUtils.safeDouble(json['roic']),
      fcfYield: JsonParsingUtils.safeDouble(json['fcf_yield']),
      comprehensiveScore:
          JsonParsingUtils.safeDouble(json['comprehensive_score']),
      riskAssessment: JsonParsingUtils.safeString(json['risk_assessment']),
      investmentGrade: JsonParsingUtils.safeString(json['investment_grade']),
      investmentRecommendation:
          JsonParsingUtils.safeString(json['investment_recommendation']),
      safetyMargin: JsonParsingUtils.safeDouble(json['safety_margin']),
      debtServiceCoverage:
          JsonParsingUtils.safeDouble(json['debt_service_coverage']),
      workingCapitalTurnover:
          JsonParsingUtils.safeDouble(json['working_capital_turnover']),
      returnOnAssets: JsonParsingUtils.safeDouble(json['return_on_assets']),
      returnOnCapital: JsonParsingUtils.safeDouble(json['return_on_capital']),
      evToEbitda: JsonParsingUtils.safeDouble(json['ev_to_ebitda']),
      priceToFreeCashFlow:
          JsonParsingUtils.safeDouble(json['price_to_free_cash_flow']),
      enterpriseValueToSales:
          JsonParsingUtils.safeDouble(json['enterprise_value_to_sales']),
      sectorComparison: _parseSectorComparison(json['sector_comparison']),
      qualityMetrics: _parseQualityMetrics(json['quality_metrics']),
      strengthFactors:
          JsonParsingUtils.safeStringList(json['strength_factors']),
      weaknessFactors:
          JsonParsingUtils.safeStringList(json['weakness_factors']),
      valuationMetrics: JsonParsingUtils.safeMap(json['valuation_metrics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'piotroski_score': piotroskiScore,
      'altman_z_score': altmanZScore,
      'graham_number': grahamNumber,
      'peg_ratio': pegRatio,
      'roic': roic,
      'fcf_yield': fcfYield,
      'comprehensive_score': comprehensiveScore,
      'risk_assessment': riskAssessment,
      'investment_grade': investmentGrade,
      'investment_recommendation': investmentRecommendation,
      'safety_margin': safetyMargin,
      'debt_service_coverage': debtServiceCoverage,
      'working_capital_turnover': workingCapitalTurnover,
      'return_on_assets': returnOnAssets,
      'return_on_capital': returnOnCapital,
      'ev_to_ebitda': evToEbitda,
      'price_to_free_cash_flow': priceToFreeCashFlow,
      'enterprise_value_to_sales': enterpriseValueToSales,
      'sector_comparison': sectorComparison,
      'quality_metrics': qualityMetrics,
      'strength_factors': strengthFactors,
      'weakness_factors': weaknessFactors,
      'valuation_metrics': valuationMetrics,
    };
  }

  static Map<String, double>? _parseSectorComparison(dynamic data) {
    if (data == null) return null;
    if (data is Map<String, double>) return data;
    if (data is Map) {
      final result = <String, double>{};
      data.forEach((k, v) {
        final doubleValue = JsonParsingUtils.safeDouble(v);
        if (doubleValue != null) {
          result[k.toString()] = doubleValue;
        }
      });
      return result;
    }
    return null;
  }

  static Map<String, String>? _parseQualityMetrics(dynamic data) {
    if (data == null) return null;
    if (data is Map<String, String>) return data;
    if (data is Map) {
      return Map<String, String>.from(
          data.map((k, v) => MapEntry(k.toString(), v?.toString() ?? '')));
    }
    return null;
  }
}

// ============================================================================
// FUNDAMENTAL ANALYSIS PROVIDER
// ============================================================================

@riverpod
class FundamentalAnalysis extends _$FundamentalAnalysis {
  @override
  Future<Map<String, dynamic>> build(String symbol) async {
    return await _analyzeCompany(symbol);
  }

  Future<Map<String, dynamic>> _analyzeCompany(String symbol) async {
    try {
      final companyNotifier = ref.read(companyNotifierProvider.notifier);
      final company = await companyNotifier.getCompanyBySymbol(symbol);

      if (company == null) return {};

      final allCompanies = await ref.read(companyNotifierProvider.future);
      final sectorPeers = allCompanies
          .where((c) => c.industry == company.industry && c.symbol != symbol)
          .toList();

      final analysis = {
        'company': company.toJson(), // Convert to JSON for provider
        'fundamentalScores': {
          'piotroskiScore': company.calculatedPiotroskiScore,
          'altmanZScore': company.calculatedAltmanZScore,
          'comprehensiveScore': company.calculatedComprehensiveScore,
          'qualityGrade': company.calculatedInvestmentGrade,
        },
        'valuationMetrics': {
          'intrinsicValue': company.calculatedGrahamNumber,
          'safetyMargin': company.safetyMargin,
          'pegRatio': company.calculatedPEGRatio,
          'priceToBook': company.priceToBook,
          'priceToEarnings': company.stockPe,
          'evToEbitda': company.calculatedROIC, // Use calculated ROIC as proxy
          'priceToFreeCashFlow': company.calculatedFCFYield,
        },
        'riskAnalysis': {
          'overallRisk': company.calculatedRiskAssessment,
          'debtLevel': _analyzeDebtLevel(company),
          'liquidityStatus': _analyzeLiquidity(company),
          'profitabilityTrend': _analyzeProfitability(company),
          'bankruptcyRisk': _assessBankruptcyRisk(company),
        },
        'benchmarkAnalysis': _generateBenchmarkAnalysis(company, sectorPeers),
        'investmentRecommendation': {
          'action': company.calculatedInvestmentRecommendation,
          'reasoning': _generateRecommendationReasoning(company),
          'keyStrengths': CompanyNotifier._calculateStrengthFactors(company),
          'keyWeaknesses': CompanyNotifier._calculateWeaknessFactors(company),
          'targetPrice': _calculateTargetPrice(company),
          'timeHorizon': _suggestTimeHorizon(company),
        },
        'financialHealthScore': _calculateFinancialHealthScore(company),
        'growthProspects': _analyzeGrowthProspects(company),
        'dividendAnalysis': _analyzeDividends(company),
        'managementEfficiency': _analyzeManagementEfficiency(company),
        'competitivePosition':
            _analyzeCompetitivePosition(company, sectorPeers),
        'sectorAnalysis': _analyzeSector(company, sectorPeers),
      };

      return analysis;
    } catch (e) {
      debugPrint('Error analyzing company $symbol: $e');
      return {};
    }
  }

  String _analyzeDebtLevel(CompanyModel company) {
    if (company.debtToEquity == null) return 'Unknown';
    if (company.debtToEquity! < 0.1) return 'Debt Free';
    if (company.debtToEquity! < 0.3) return 'Low Debt';
    if (company.debtToEquity! < 0.6) return 'Moderate Debt';
    if (company.debtToEquity! < 1.0) return 'High Debt';
    return 'Very High Debt';
  }

  String _analyzeLiquidity(CompanyModel company) {
    if (company.currentRatio == null) return 'Unknown';
    if (company.currentRatio! > 2.0) return 'Excellent';
    if (company.currentRatio! > 1.5) return 'Good';
    if (company.currentRatio! > 1.0) return 'Adequate';
    return 'Poor';
  }

  String _analyzeProfitability(CompanyModel company) {
    if (company.roe == null) return 'Unknown';
    if (company.roe! > 20) return 'Excellent';
    if (company.roe! > 15) return 'Good';
    if (company.roe! > 10) return 'Average';
    if (company.roe! > 0) return 'Weak';
    return 'Loss Making';
  }

  String _assessBankruptcyRisk(CompanyModel company) {
    final altman = company.calculatedAltmanZScore;
    if (altman > 3.0) return 'Very Low Risk';
    if (altman > 1.8) return 'Low Risk';
    if (altman > 1.2) return 'Gray Zone';
    return 'High Risk';
  }

  Map<String, dynamic> _generateBenchmarkAnalysis(
      CompanyModel company, List<CompanyModel> peers) {
    if (peers.isEmpty) return {};

    final avgROE =
        peers.map((p) => p.roe ?? 0).reduce((a, b) => a + b) / peers.length;
    final avgPE = peers
            .map((p) => p.stockPe ?? 0)
            .where((pe) => pe > 0 && pe < 100)
            .fold(0.0, (a, b) => a + b) /
        peers
            .where(
                (p) => p.stockPe != null && p.stockPe! > 0 && p.stockPe! < 100)
            .length;
    final avgDebtRatio =
        peers.map((p) => p.debtToEquity ?? 0).reduce((a, b) => a + b) /
            peers.length;
    final avgComprehensiveScore = peers
            .map((p) => p.calculatedComprehensiveScore)
            .reduce((a, b) => a + b) /
        peers.length;

    return {
      'industryAverages': {
        'roe': avgROE,
        'pe': avgPE,
        'debtToEquity': avgDebtRatio,
        'comprehensiveScore': avgComprehensiveScore,
      },
      'companyVsIndustry': {
        'roeComparison': company.roe != null ? (company.roe! - avgROE) : null,
        'peComparison': company.stockPe != null && company.stockPe! > 0
            ? (company.stockPe! - avgPE)
            : null,
        'debtComparison': company.debtToEquity != null
            ? (company.debtToEquity! - avgDebtRatio)
            : null,
        'scoreComparison':
            company.calculatedComprehensiveScore - avgComprehensiveScore,
      },
      'industryRanking': _calculateIndustryRanking(company, peers),
      'percentileRanking': _calculatePercentileRanking(company, peers),
    };
  }

  Map<String, int> _calculateIndustryRanking(
      CompanyModel company, List<CompanyModel> peers) {
    final allCompanies = [company, ...peers];

    allCompanies.sort((a, b) => (b.roe ?? 0).compareTo(a.roe ?? 0));
    final roeRank =
        allCompanies.indexWhere((c) => c.symbol == company.symbol) + 1;

    allCompanies.sort((a, b) => b.calculatedComprehensiveScore
        .compareTo(a.calculatedComprehensiveScore));
    final qualityRank =
        allCompanies.indexWhere((c) => c.symbol == company.symbol) + 1;

    allCompanies.sort((a, b) => (b.marketCap ?? 0).compareTo(a.marketCap ?? 0));
    final sizeRank =
        allCompanies.indexWhere((c) => c.symbol == company.symbol) + 1;

    return {
      'profitabilityRank': roeRank,
      'qualityRank': qualityRank,
      'sizeRank': sizeRank,
      'totalPeers': peers.length + 1,
    };
  }

  Map<String, double> _calculatePercentileRanking(
      CompanyModel company, List<CompanyModel> peers) {
    final allCompanies = [company, ...peers];
    final total = allCompanies.length;

    // ROE percentile
    allCompanies.sort((a, b) => (b.roe ?? 0).compareTo(a.roe ?? 0));
    final roeRank =
        allCompanies.indexWhere((c) => c.symbol == company.symbol) + 1;
    final roePercentile = (1 - (roeRank - 1) / total) * 100;

    // Quality percentile
    allCompanies.sort((a, b) => b.calculatedComprehensiveScore
        .compareTo(a.calculatedComprehensiveScore));
    final qualityRank =
        allCompanies.indexWhere((c) => c.symbol == company.symbol) + 1;
    final qualityPercentile = (1 - (qualityRank - 1) / total) * 100;

    return {
      'roePercentile': roePercentile,
      'qualityPercentile': qualityPercentile,
    };
  }

  List<String> _generateRecommendationReasoning(CompanyModel company) {
    final reasons = <String>[];

    final score = company.calculatedComprehensiveScore;
    if (score > 80) {
      reasons.add(
          'Excellent overall financial health (Score: ${score.toStringAsFixed(1)})');
    } else if (score > 60) {
      reasons.add(
          'Good financial fundamentals (Score: ${score.toStringAsFixed(1)})');
    } else if (score < 40) {
      reasons.add(
          'Weak financial performance (Score: ${score.toStringAsFixed(1)})');
    }

    final piotroski = company.calculatedPiotroskiScore;
    if (piotroski > 7) {
      reasons.add(
          'Strong Piotroski score indicates quality (${piotroski.toInt()}/9)');
    } else if (piotroski < 4) {
      reasons
          .add('Low Piotroski score raises concerns (${piotroski.toInt()}/9)');
    }

    final risk = company.calculatedRiskAssessment;
    if (risk == 'Very Low' || risk == 'Low') {
      reasons.add('Low risk profile');
    } else if (risk == 'High' || risk == 'Very High') {
      reasons.add('High risk factors present');
    }

    if (company.debtToEquity != null) {
      if (company.debtToEquity! < 0.3) {
        reasons.add('Conservative debt levels');
      } else if (company.debtToEquity! > 1.0) {
        reasons.add('High debt burden');
      }
    }

    if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 15) {
      reasons.add(
          'Strong revenue growth trend (${company.salesGrowth3Y!.toStringAsFixed(1)}%)');
    }

    if (company.roe != null && company.roe! > 15) {
      reasons.add(
          'Efficient capital utilization (ROE: ${company.roe!.toStringAsFixed(1)}%)');
    }

    if (company.safetyMargin != null && company.safetyMargin! > 20) {
      reasons.add(
          'Significant safety margin (${company.safetyMargin!.toStringAsFixed(1)}%)');
    }

    return reasons;
  }

  double? _calculateTargetPrice(CompanyModel company) {
    final graham = company.calculatedGrahamNumber;
    if (graham != null) return graham;

    // Alternative: P/E based target
    if (company.annualDataHistory.isNotEmpty && company.stockPe != null) {
      final latest = company.annualDataHistory.first;
      if (latest.eps != null) {
        final fairPE = min(company.stockPe! * 0.8, 20); // Conservative P/E
        return latest.eps! * fairPE;
      }
    }

    return null;
  }

  String _suggestTimeHorizon(CompanyModel company) {
    if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 20) {
      return '3-5 years (Growth play)';
    }
    if (company.dividendYield != null && company.dividendYield! > 4) {
      return '5+ years (Income play)';
    }
    if (company.safetyMargin != null && company.safetyMargin! > 20) {
      return '1-3 years (Value play)';
    }
    if (company.calculatedComprehensiveScore > 80) {
      return '5+ years (Quality play)';
    }
    return '3-5 years (Long-term)';
  }

  double _calculateFinancialHealthScore(CompanyModel company) {
    double score = 0;
    int factors = 0;

    if (company.roe != null) {
      score += min(company.roe! / 20 * 100, 100);
      factors++;
    }

    if (company.currentRatio != null) {
      score += min(company.currentRatio! / 2 * 100, 100);
      factors++;
    }

    if (company.debtToEquity != null) {
      score += max(100 - (company.debtToEquity! * 100), 0);
      factors++;
    }

    if (company.interestCoverage != null) {
      score += min(company.interestCoverage! / 5 * 100, 100);
      factors++;
    }

    // Add Altman Z-Score contribution
    final altman = company.calculatedAltmanZScore;
    if (altman > 0) {
      score += min((altman / 3.0) * 100, 100);
      factors++;
    }

    return factors > 0 ? score / factors : 0;
  }

  Map<String, dynamic> _analyzeGrowthProspects(CompanyModel company) {
    return {
      'salesGrowthTrend': company.salesGrowth3Y ?? 0,
      'profitGrowthTrend': company.profitGrowth3Y ?? 0,
      'growthConsistency': _calculateGrowthConsistency(company),
      'growthQuality': _assessGrowthQuality(company),
      'futureGrowthPotential': _assessFutureGrowthPotential(company),
      'growthSustainability': _assessGrowthSustainability(company),
    };
  }

  String _calculateGrowthConsistency(CompanyModel company) {
    if (company.salesGrowth3Y == null || company.profitGrowth3Y == null) {
      return 'Unknown';
    }

    final salesGrowth = company.salesGrowth3Y!;
    final profitGrowth = company.profitGrowth3Y!;

    if (salesGrowth > 10 && profitGrowth > 10) return 'Consistent';
    if (salesGrowth > 5 || profitGrowth > 5) return 'Moderate';
    return 'Inconsistent';
  }

  String _assessGrowthQuality(CompanyModel company) {
    if (company.roe == null || company.roce == null) return 'Unknown';

    if (company.roe! > 15 && company.roce! > 15) return 'High Quality';
    if (company.roe! > 10 || company.roce! > 10) return 'Moderate Quality';
    return 'Low Quality';
  }

  String _assessFutureGrowthPotential(CompanyModel company) {
    int positiveFactors = 0;

    if (company.roe != null && company.roe! > 15) positiveFactors++;
    if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 15)
      positiveFactors++;
    if (company.debtToEquity != null && company.debtToEquity! < 0.5)
      positiveFactors++;
    if (company.currentRatio != null && company.currentRatio! > 1.5)
      positiveFactors++;
    if (company.workingCapitalDays != null && company.workingCapitalDays! < 90)
      positiveFactors++;

    if (positiveFactors >= 4) return 'Very High';
    if (positiveFactors >= 3) return 'High';
    if (positiveFactors >= 2) return 'Moderate';
    return 'Low';
  }

  String _assessGrowthSustainability(CompanyModel company) {
    // Check if growth is backed by fundamentals
    if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 20) {
      if (company.roe != null &&
          company.roe! > 15 &&
          company.debtToEquity != null &&
          company.debtToEquity! < 0.5) {
        return 'Sustainable';
      }
      return 'Questionable';
    }
    return 'Stable';
  }

  Map<String, dynamic> _analyzeDividends(CompanyModel company) {
    return {
      'currentYield': company.dividendYield ?? 0,
      'payoutSustainability': _assessPayoutSustainability(company),
      'dividendGrowthPotential': _assessDividendGrowthPotential(company),
      'incomeAttractiveness': _assessIncomeAttractiveness(company),
      'dividendCoverage': _calculateDividendCoverage(company),
    };
  }

  String _assessPayoutSustainability(CompanyModel company) {
    if (company.dividendYield == null || company.roe == null) return 'Unknown';

    final payoutRatio = (company.dividendYield! / company.roe!) * 100;

    if (payoutRatio < 30) return 'Very Sustainable';
    if (payoutRatio < 50) return 'Sustainable';
    if (payoutRatio < 70) return 'Moderate Risk';
    return 'High Risk';
  }

  String _assessDividendGrowthPotential(CompanyModel company) {
    if (company.profitGrowth3Y == null) return 'Unknown';

    if (company.profitGrowth3Y! > 15) return 'High';
    if (company.profitGrowth3Y! > 5) return 'Moderate';
    return 'Low';
  }

  String _assessIncomeAttractiveness(CompanyModel company) {
    if (company.dividendYield == null) return 'No Dividend';

    if (company.dividendYield! > 4) return 'High Income';
    if (company.dividendYield! > 2) return 'Moderate Income';
    if (company.dividendYield! > 0) return 'Low Income';
    return 'No Income';
  }

  double? _calculateDividendCoverage(CompanyModel company) {
    if (company.annualDataHistory.isEmpty || company.dividendYield == null)
      return null;

    final latest = company.annualDataHistory.first;
    if (latest.eps == null || company.dividendYield! == 0) return null;

    final dividendPerShare =
        (company.dividendYield! / 100) * (company.currentPrice ?? 0);
    if (dividendPerShare <= 0) return null;

    return latest.eps! / dividendPerShare;
  }

  Map<String, dynamic> _analyzeManagementEfficiency(CompanyModel company) {
    return {
      'returnOnEquity': company.roe ?? 0,
      'returnOnCapital': company.roce ?? 0,
      'assetUtilization': company.assetTurnover ?? 0,
      'workingCapitalManagement': _assessWorkingCapitalManagement(company),
      'overallEfficiency': _calculateManagementEfficiencyScore(company),
      'capitalAllocation': _assessCapitalAllocation(company),
    };
  }

  String _assessWorkingCapitalManagement(CompanyModel company) {
    if (company.workingCapitalDays == null) return 'Unknown';

    if (company.workingCapitalDays! < 30) return 'Excellent';
    if (company.workingCapitalDays! < 60) return 'Good';
    if (company.workingCapitalDays! < 90) return 'Average';
    return 'Poor';
  }

  double _calculateManagementEfficiencyScore(CompanyModel company) {
    double score = 0;
    int factors = 0;

    if (company.roe != null) {
      score += min(company.roe! / 20 * 100, 100);
      factors++;
    }

    if (company.roce != null) {
      score += min(company.roce! / 20 * 100, 100);
      factors++;
    }

    if (company.assetTurnover != null) {
      score += min(company.assetTurnover! / 2 * 100, 100);
      factors++;
    }

    if (company.workingCapitalDays != null) {
      score += max(100 - (company.workingCapitalDays! / 150 * 100), 0);
      factors++;
    }

    return factors > 0 ? score / factors : 0;
  }

  String _assessCapitalAllocation(CompanyModel company) {
    // Simple assessment based on ROE and growth
    if (company.roe != null && company.salesGrowth3Y != null) {
      if (company.roe! > 15 && company.salesGrowth3Y! > 15) {
        return 'Excellent';
      } else if (company.roe! > 10 && company.salesGrowth3Y! > 10) {
        return 'Good';
      }
    }
    return 'Average';
  }

  Map<String, dynamic> _analyzeCompetitivePosition(
      CompanyModel company, List<CompanyModel> peers) {
    if (peers.isEmpty) return {};

    final ranking = _calculateIndustryRanking(company, peers);

    return {
      'marketPosition': _assessMarketPosition(company, peers),
      'competitiveStrength': _assessCompetitiveStrength(company, peers),
      'industryRanking': ranking,
      'marketShare': 'Unknown', // Would need additional data
      'competitiveAdvantages': company.pros,
      'competitiveChallenges': company.cons,
      'moatStrength': _assessMoatStrength(company),
    };
  }

  String _assessMarketPosition(CompanyModel company, List<CompanyModel> peers) {
    final marketCaps = peers.map((p) => p.marketCap ?? 0).toList()
      ..add(company.marketCap ?? 0);
    marketCaps.sort((a, b) => b.compareTo(a));

    final position = marketCaps.indexOf(company.marketCap ?? 0) + 1;
    final percentile = (1 - (position / marketCaps.length)) * 100;

    if (percentile > 75) return 'Market Leader';
    if (percentile > 50) return 'Strong Player';
    if (percentile > 25) return 'Mid-Tier Player';
    return 'Niche Player';
  }

  String _assessCompetitiveStrength(
      CompanyModel company, List<CompanyModel> peers) {
    int strengths = 0;
    int total = 0;

    final avgROE =
        peers.map((p) => p.roe ?? 0).reduce((a, b) => a + b) / peers.length;
    if (company.roe != null) {
      if (company.roe! > avgROE) strengths++;
      total++;
    }

    final avgScore = peers
            .map((p) => p.calculatedComprehensiveScore)
            .reduce((a, b) => a + b) /
        peers.length;
    if (company.calculatedComprehensiveScore > avgScore) strengths++;
    total++;

    final avgMarketCap =
        peers.map((p) => p.marketCap ?? 0).reduce((a, b) => a + b) /
            peers.length;
    if (company.marketCap != null && company.marketCap! > avgMarketCap)
      strengths++;
    total++;

    if (total == 0) return 'Unknown';
    final strengthRatio = strengths / total;

    if (strengthRatio > 0.75) return 'Very Strong';
    if (strengthRatio > 0.5) return 'Strong';
    if (strengthRatio > 0.3) return 'Average';
    return 'Weak';
  }

  String _assessMoatStrength(CompanyModel company) {
    // Simple assessment based on ROE consistency and margins
    if (company.roe != null &&
        company.roe! > 20 &&
        company.calculatedComprehensiveScore > 80) {
      return 'Strong';
    } else if (company.roe != null && company.roe! > 15) {
      return 'Moderate';
    }
    return 'Weak';
  }

  Map<String, dynamic> _analyzeSector(
      CompanyModel company, List<CompanyModel> peers) {
    if (peers.isEmpty || company.sector == null) return {};

    final sectorCompanies = [company, ...peers];

    final avgGrowth = sectorCompanies
            .where((c) => c.salesGrowth3Y != null)
            .map((c) => c.salesGrowth3Y!)
            .fold(0.0, (sum, growth) => sum + growth) /
        sectorCompanies.where((c) => c.salesGrowth3Y != null).length;

    final avgROE = sectorCompanies
            .where((c) => c.roe != null)
            .map((c) => c.roe!)
            .fold(0.0, (sum, roe) => sum + roe) /
        sectorCompanies.where((c) => c.roe != null).length;

    final avgPE = sectorCompanies
            .where(
                (c) => c.stockPe != null && c.stockPe! > 0 && c.stockPe! < 100)
            .map((c) => c.stockPe!)
            .fold(0.0, (sum, pe) => sum + pe) /
        sectorCompanies
            .where(
                (c) => c.stockPe != null && c.stockPe! > 0 && c.stockPe! < 100)
            .length;

    return {
      'sectorName': company.sector,
      'sectorMetrics': {
        'avgGrowth': avgGrowth,
        'avgROE': avgROE,
        'avgPE': avgPE,
        'companiesAnalyzed': sectorCompanies.length,
      },
      'sectorOutlook': _assessSectorOutlook(avgGrowth, avgROE),
      'companyVsSector': {
        'growthVsSector': company.salesGrowth3Y != null
            ? (company.salesGrowth3Y! - avgGrowth)
            : null,
        'roeVsSector': company.roe != null ? (company.roe! - avgROE) : null,
        'peVsSector': company.stockPe != null && company.stockPe! > 0
            ? (company.stockPe! - avgPE)
            : null,
      },
    };
  }

  String _assessSectorOutlook(double avgGrowth, double avgROE) {
    if (avgGrowth > 15 && avgROE > 15) return 'Very Positive';
    if (avgGrowth > 10 && avgROE > 12) return 'Positive';
    if (avgGrowth > 5 || avgROE > 10) return 'Neutral';
    return 'Challenging';
  }
}

// ============================================================================
// ADDITIONAL PROVIDER FUNCTIONS
// ============================================================================

@riverpod
Future<List<CompanyModel>> topCompanies(TopCompaniesRef ref,
    {String sortBy = 'comprehensiveScore'}) async {
  final notifier = ref.watch(companyNotifierProvider.notifier);
  return await notifier.getTopPerformers(sortBy: sortBy, limit: 20);
}

@riverpod
Future<Map<String, List<CompanyModel>>> companiesBySector(
    CompaniesBySectorRef ref) async {
  final notifier = ref.watch(companyNotifierProvider.notifier);
  return await notifier.getCompaniesBySector();
}

@riverpod
Future<List<CompanyModel>> searchResults(
    SearchResultsRef ref, String query) async {
  final notifier = ref.watch(companyNotifierProvider.notifier);
  return await notifier.searchCompanies(query);
}

@riverpod
Future<List<CompanyModel>> filteredCompanies(
    FilteredCompaniesRef ref, List<FundamentalType> filters) async {
  final notifier = ref.watch(companyNotifierProvider.notifier);
  return await notifier.filterByFundamentals(filters);
}

@riverpod
Future<List<CompanyModel>> similarCompanies(
    SimilarCompaniesRef ref, String symbol) async {
  final notifier = ref.watch(companyNotifierProvider.notifier);
  return await notifier.getSimilarCompanies(symbol);
}

@riverpod
Future<CompanyModel?> companyDetails(
    CompanyDetailsRef ref, String symbol) async {
  final notifier = ref.watch(companyNotifierProvider.notifier);
  return await notifier.getCompanyBySymbol(symbol);
}

@riverpod
Future<List<CompanyModel>> highQualityStocks(HighQualityStocksRef ref) async {
  final notifier = ref.watch(companyNotifierProvider.notifier);
  return await notifier.getHighQualityStocks();
}

@riverpod
Future<List<CompanyModel>> valueOpportunities(ValueOpportunitiesRef ref) async {
  final notifier = ref.watch(companyNotifierProvider.notifier);
  return await notifier.getValueOpportunities();
}

@riverpod
Future<Map<String, dynamic>> marketSummary(MarketSummaryRef ref) async {
  final notifier = ref.watch(companyNotifierProvider.notifier);
  return await notifier.getMarketSummary();
}
