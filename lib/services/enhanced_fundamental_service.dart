import 'dart:math';
import '../models/company_model.dart';
import '../models/fundamental_filter.dart';

class EnhancedFundamentalService {
  static Map<String, dynamic> calculateComprehensiveMetrics(
      CompanyModel company) {
    return {
      'piotroskiScore': _calculatePiotroskiScore(company),
      'altmanZScore': _calculateAltmanZScore(company),
      'grahamNumber': _calculateGrahamNumber(company),
      'comprehensiveScore': _calculateComprehensiveScore(company),
      'riskAssessment': _assessRisk(company),
      'investmentGrade': _getInvestmentGrade(company),
      'workingCapitalEfficiency': _assessWorkingCapitalEfficiency(company),
      'cashCycleEfficiency': _assessCashCycleEfficiency(company),
      'businessInsightScore': _calculateBusinessInsightScore(company),
      'qualityFlags': _getQualityFlags(company),
      'growthConsistency': _assessGrowthConsistency(company),
      'valuationStatus': _getValuationStatus(company),
      'pegRatio': _calculatePEGRatio(company),
      'fcfYield': _calculateFCFYield(company),
      'roic': _calculateROIC(company),
      'debtServiceCoverage': _calculateDebtServiceCoverage(company),
      'dividendCoverage': _calculateDividendCoverage(company),
      'priceToFreeCashFlow': _calculatePriceToFreeCashFlow(company),
    };
  }

  static double _calculatePiotroskiScore(CompanyModel company) {
    double score = 0;

    // Profitability criteria (4 points)
    if (company.roe != null && company.roe! > 0) score += 1;
    if (company.currentRatio != null && company.currentRatio! > 1.5) score += 1;

    if (company.annualDataHistory.isNotEmpty) {
      final latest = company.annualDataHistory.first;
      if (latest.operatingCashFlow != null && latest.netProfit != null) {
        if (latest.operatingCashFlow! > latest.netProfit!) score += 1;
      }

      if (company.annualDataHistory.length > 1) {
        final current = company.annualDataHistory[0];
        final previous = company.annualDataHistory[1];
        if (current.roe != null && previous.roe != null) {
          if (current.roe! > previous.roe!) score += 1;
        }
      }
    }

    // Leverage criteria (3 points)
    if (company.debtToEquity != null && company.debtToEquity! < 0.3) score += 1;
    if (company.currentRatio != null && company.currentRatio! > 1.5) score += 1;
    if (company.interestCoverage != null && company.interestCoverage! > 2.5)
      score += 1;

    // Efficiency criteria (2 points)
    if (company.assetTurnover != null && company.assetTurnover! > 0.8)
      score += 1;
    if (company.workingCapitalDays != null && company.workingCapitalDays! < 60)
      score += 1;

    return score;
  }

  static double _calculateAltmanZScore(CompanyModel company) {
    if (company.annualDataHistory.isEmpty) return 0;

    final latest = company.annualDataHistory.first;
    if (latest.totalAssets == null || latest.totalAssets! <= 0) return 0;

    double score = 0;
    final totalAssets = latest.totalAssets!;

    // Working Capital / Total Assets * 1.2
    if (latest.workingCapital != null) {
      score += (latest.workingCapital! / totalAssets) * 1.2;
    }

    // Retained Earnings / Total Assets * 1.4
    if (latest.shareholdersEquity != null) {
      score += (latest.shareholdersEquity! / totalAssets) * 1.4;
    }

    // EBIT / Total Assets * 3.3
    if (latest.ebitda != null) {
      score += (latest.ebitda! / totalAssets) * 3.3;
    }

    // Market Cap / Total Liabilities * 0.6
    if (latest.totalLiabilities != null && company.marketCap != null) {
      score += (company.marketCap! / latest.totalLiabilities!) * 0.6;
    }

    // Sales / Total Assets * 1.0
    if (latest.sales != null) {
      score += (latest.sales! / totalAssets) * 1.0;
    }

    return score;
  }

  static double? _calculateGrahamNumber(CompanyModel company) {
    if (company.bookValue == null || company.annualDataHistory.isEmpty)
      return null;

    final latest = company.annualDataHistory.first;
    if (latest.eps == null || latest.eps! <= 0) return null;

    return sqrt(22.5 * latest.eps! * company.bookValue!);
  }

  static double? _calculatePEGRatio(CompanyModel company) {
    if (company.stockPe == null || company.profitGrowth3Y == null) return null;
    if (company.profitGrowth3Y! <= 0) return null;

    return company.stockPe! / company.profitGrowth3Y!;
  }

  static double? _calculateROIC(CompanyModel company) {
    if (company.annualDataHistory.isEmpty) return null;

    final latest = company.annualDataHistory.first;
    if (latest.ebitda == null ||
        latest.totalAssets == null ||
        latest.totalLiabilities == null) {
      return null;
    }

    final investedCapital = latest.totalAssets! - latest.totalLiabilities!;
    if (investedCapital <= 0) return null;

    return (latest.ebitda! / investedCapital) * 100;
  }

  static double? _calculateFCFYield(CompanyModel company) {
    if (company.marketCap == null || company.annualDataHistory.isEmpty)
      return null;

    final latest = company.annualDataHistory.first;
    if (latest.freeCashFlow == null) return null;

    return (latest.freeCashFlow! / company.marketCap!) * 100;
  }

  static double? _calculateDebtServiceCoverage(CompanyModel company) {
    if (company.annualDataHistory.isEmpty) return null;

    final latest = company.annualDataHistory.first;
    if (latest.ebitda == null || latest.interestExpense == null) return null;
    if (latest.interestExpense! <= 0) return null;

    return latest.ebitda! / latest.interestExpense!;
  }

  static double? _calculateDividendCoverage(CompanyModel company) {
    if (company.annualDataHistory.isEmpty || company.dividendYield == null)
      return null;

    final latest = company.annualDataHistory.first;
    if (latest.eps == null || company.dividendYield! == 0) return null;

    final dividendPerShare =
        (company.dividendYield! / 100) * (company.currentPrice ?? 0);
    if (dividendPerShare <= 0) return null;

    return latest.eps! / dividendPerShare;
  }

  static double? _calculatePriceToFreeCashFlow(CompanyModel company) {
    if (company.marketCap == null || company.annualDataHistory.isEmpty)
      return null;

    final latest = company.annualDataHistory.first;
    if (latest.freeCashFlow == null || latest.freeCashFlow! <= 0) return null;

    return company.marketCap! / latest.freeCashFlow!;
  }

  static double _calculateComprehensiveScore(CompanyModel company) {
    double totalScore = 0;
    int criteria = 0;

    // Profitability (25 points max)
    if (company.roe != null) {
      if (company.roe! > 20)
        totalScore += 25;
      else if (company.roe! > 15)
        totalScore += 20;
      else if (company.roe! > 10)
        totalScore += 15;
      else if (company.roe! > 5) totalScore += 10;
      criteria++;
    }

    // Financial Stability (25 points max)
    if (company.debtToEquity != null) {
      if (company.debtToEquity! < 0.1)
        totalScore += 25;
      else if (company.debtToEquity! < 0.3)
        totalScore += 20;
      else if (company.debtToEquity! < 0.6)
        totalScore += 15;
      else if (company.debtToEquity! < 1.0) totalScore += 10;
      criteria++;
    }

    // Growth (25 points max)
    if (company.salesGrowth3Y != null && company.profitGrowth3Y != null) {
      final avgGrowth = (company.salesGrowth3Y! + company.profitGrowth3Y!) / 2;
      if (avgGrowth > 25)
        totalScore += 25;
      else if (avgGrowth > 15)
        totalScore += 20;
      else if (avgGrowth > 10)
        totalScore += 15;
      else if (avgGrowth > 5) totalScore += 10;
      criteria++;
    }

    // Valuation (25 points max)
    if (company.stockPe != null) {
      if (company.stockPe! < 10)
        totalScore += 25;
      else if (company.stockPe! < 15)
        totalScore += 20;
      else if (company.stockPe! < 20)
        totalScore += 15;
      else if (company.stockPe! < 30) totalScore += 10;
      criteria++;
    }

    return criteria > 0 ? totalScore / criteria : 0;
  }

  static String _assessRisk(CompanyModel company) {
    int riskFactors = 0;

    if (company.debtToEquity != null && company.debtToEquity! > 1.0)
      riskFactors++;
    if (company.currentRatio != null && company.currentRatio! < 1.0)
      riskFactors++;
    if (company.roe != null && company.roe! < 5) riskFactors++;
    if (company.interestCoverage != null && company.interestCoverage! < 2.5)
      riskFactors++;
    if (company.stockPe != null && company.stockPe! > 40) riskFactors++;

    if (riskFactors >= 4) return 'Very High';
    if (riskFactors >= 3) return 'High';
    if (riskFactors >= 2) return 'Medium';
    if (riskFactors >= 1) return 'Low';
    return 'Very Low';
  }

  static String _getInvestmentGrade(CompanyModel company) {
    final score = _calculateComprehensiveScore(company);
    final piotroski = _calculatePiotroskiScore(company);

    if (score > 80 && piotroski > 7) return 'AAA';
    if (score > 70 && piotroski > 6) return 'AA';
    if (score > 60 && piotroski > 5) return 'A';
    if (score > 50 && piotroski > 4) return 'BBB';
    if (score > 40 && piotroski > 3) return 'BB';
    if (score > 30 && piotroski > 2) return 'B';
    return 'C';
  }

  static String _assessWorkingCapitalEfficiency(CompanyModel company) {
    if (company.workingCapitalDays == null) return 'Unknown';

    if (company.workingCapitalDays! < 30) return 'Excellent';
    if (company.workingCapitalDays! < 60) return 'Good';
    if (company.workingCapitalDays! < 90) return 'Average';
    return 'Poor';
  }

  static String _assessCashCycleEfficiency(CompanyModel company) {
    if (company.cashConversionCycle == null) return 'Unknown';

    if (company.cashConversionCycle! < 30) return 'Excellent';
    if (company.cashConversionCycle! < 60) return 'Good';
    if (company.cashConversionCycle! < 90) return 'Average';
    return 'Poor';
  }

  static double _calculateBusinessInsightScore(CompanyModel company) {
    double score = 0;

    if (company.businessOverview.isNotEmpty) score += 2;
    if (company.investmentHighlights.isNotEmpty) score += 2;
    if (company.keyMilestones.isNotEmpty) score += 2;
    if (company.pros.isNotEmpty) score += 1;
    if (company.cons.isNotEmpty) score += 1;
    if (company.industryClassification.isNotEmpty) score += 1;
    if (company.sector != null && company.sector!.isNotEmpty) score += 1;

    return score;
  }

  static List<String> _getQualityFlags(CompanyModel company) {
    final flags = <String>[];

    if (company.debtToEquity != null && company.debtToEquity! < 0.1) {
      flags.add('Debt Free');
    }
    if (company.roe != null && company.roe! > 20) {
      flags.add('High ROE');
    }
    if (company.currentRatio != null && company.currentRatio! > 2.0) {
      flags.add('Strong Liquidity');
    }
    if (company.workingCapitalDays != null &&
        company.workingCapitalDays! < 45) {
      flags.add('Efficient WC Management');
    }
    if (company.dividendYield != null && company.dividendYield! > 3) {
      flags.add('Good Dividend Yield');
    }
    if (company.qualityScore >= 4) {
      flags.add('High Quality Score');
    }

    return flags;
  }

  static String _assessGrowthConsistency(CompanyModel company) {
    if (company.salesGrowth3Y == null || company.profitGrowth3Y == null) {
      return 'Unknown';
    }

    final salesGrowth = company.salesGrowth3Y!;
    final profitGrowth = company.profitGrowth3Y!;

    if (salesGrowth > 15 && profitGrowth > 15) return 'Excellent';
    if (salesGrowth > 10 || profitGrowth > 10) return 'Good';
    if (salesGrowth > 5 || profitGrowth > 5) return 'Moderate';
    return 'Poor';
  }

  static String _getValuationStatus(CompanyModel company) {
    if (company.stockPe == null) return 'Unknown';

    final pe = company.stockPe!;
    final roe = company.roe ?? 0;

    if (pe < 10 && roe > 15) return 'Deeply Undervalued';
    if (pe < 15 && roe > 10) return 'Undervalued';
    if (pe < 20) return 'Fair Value';
    if (pe < 30) return 'Slightly Overvalued';
    return 'Overvalued';
  }

  static Map<String, dynamic> generateInvestmentSummary(CompanyModel company) {
    final metrics = calculateComprehensiveMetrics(company);

    return {
      'recommendation': _generateRecommendation(company, metrics),
      'strengths': _identifyStrengths(company),
      'weaknesses': _identifyWeaknesses(company),
      'riskFactors': _identifyRiskFactors(company),
      'opportunities': _identifyOpportunities(company),
      'targetPrice': _calculateTargetPrice(company),
      'timeHorizon': _suggestTimeHorizon(company),
      'portfolioSuitability': _assessPortfolioSuitability(company),
    };
  }

  static String _generateRecommendation(
      CompanyModel company, Map<String, dynamic> metrics) {
    final score = metrics['comprehensiveScore'] as double;
    final risk = metrics['riskAssessment'] as String;

    if (score > 75 && (risk == 'Low' || risk == 'Very Low')) {
      return 'Strong Buy';
    } else if (score > 60 && risk != 'Very High') {
      return 'Buy';
    } else if (score > 40) {
      return 'Hold';
    } else {
      return 'Avoid';
    }
  }

  static List<String> _identifyStrengths(CompanyModel company) {
    final strengths = <String>[];

    if (company.roe != null && company.roe! > 15) {
      strengths.add(
          'Strong profitability (ROE: ${company.roe!.toStringAsFixed(1)}%)');
    }
    if (company.debtToEquity != null && company.debtToEquity! < 0.3) {
      strengths.add('Conservative debt levels');
    }
    if (company.currentRatio != null && company.currentRatio! > 1.5) {
      strengths.add('Strong liquidity position');
    }
    if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 15) {
      strengths.add('High revenue growth');
    }

    return strengths;
  }

  static List<String> _identifyWeaknesses(CompanyModel company) {
    final weaknesses = <String>[];

    if (company.roe != null && company.roe! < 10) {
      weaknesses.add('Low profitability');
    }
    if (company.debtToEquity != null && company.debtToEquity! > 1.0) {
      weaknesses.add('High debt burden');
    }
    if (company.currentRatio != null && company.currentRatio! < 1.0) {
      weaknesses.add('Liquidity concerns');
    }
    if (company.stockPe != null && company.stockPe! > 30) {
      weaknesses.add('High valuation');
    }

    return weaknesses;
  }

  static List<String> _identifyRiskFactors(CompanyModel company) {
    final risks = <String>[];

    if (company.debtToEquity != null && company.debtToEquity! > 1.0) {
      risks.add('High financial leverage');
    }
    if (company.interestCoverage != null && company.interestCoverage! < 2.5) {
      risks.add('Low interest coverage');
    }
    if (company.currentRatio != null && company.currentRatio! < 1.0) {
      risks.add('Working capital shortage');
    }

    return risks;
  }

  static List<String> _identifyOpportunities(CompanyModel company) {
    final opportunities = <String>[];

    if (company.stockPe != null &&
        company.stockPe! < 12 &&
        company.roe != null &&
        company.roe! > 12) {
      opportunities.add('Undervalued with strong fundamentals');
    }
    if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 20) {
      opportunities.add('High growth trajectory');
    }
    if (company.marketCap != null &&
        company.marketCap! < 5000 &&
        company.qualityScore >= 3) {
      opportunities.add('Quality small-cap with growth potential');
    }

    return opportunities;
  }

  static double? _calculateTargetPrice(CompanyModel company) {
    final graham = _calculateGrahamNumber(company);
    if (graham != null && company.currentPrice != null) {
      return graham;
    }
    return null;
  }

  static String _suggestTimeHorizon(CompanyModel company) {
    if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 20) {
      return '3-5 years (Growth play)';
    }
    if (company.dividendYield != null && company.dividendYield! > 4) {
      return '5+ years (Income play)';
    }
    if (company.stockPe != null && company.stockPe! < 10) {
      return '1-3 years (Value play)';
    }
    return '3-5 years (Long-term)';
  }

  static String _assessPortfolioSuitability(CompanyModel company) {
    if (company.qualityScore >= 4 &&
        company.debtToEquity != null &&
        company.debtToEquity! < 0.3) {
      return 'Core holding';
    }
    if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 20) {
      return 'Growth allocation';
    }
    if (company.dividendYield != null && company.dividendYield! > 3) {
      return 'Income allocation';
    }
    if (company.stockPe != null && company.stockPe! < 12) {
      return 'Value allocation';
    }
    return 'Speculative allocation';
  }
}
