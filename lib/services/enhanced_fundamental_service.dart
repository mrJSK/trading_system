import 'dart:math';
import '../models/company_model.dart';
import '../models/fundamental_filter.dart';
import '../utils/json_parsing_utils.dart';

class EnhancedFundamentalService {
  // ============================================================================
  // COMPREHENSIVE METRICS CALCULATION WITH MANUAL SERIALIZATION
  // ============================================================================

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
      'safetyMargin': _calculateSafetyMargin(company),
      'betaValue': company.betaValue,
      'marketCapCategory': _getMarketCapCategory(company),
      'sectorRanking': _calculateSectorRanking(company),
      'momentumScore': _calculateMomentumScore(company),
      'qualityScore': company.qualityScore,
      'sustainabilityScore': _calculateSustainabilityScore(company),
      'managementEfficiency': _assessManagementEfficiency(company),
      'competitiveStrength': _assessCompetitiveStrength(company),
    };
  }

  // ============================================================================
  // ENHANCED SCORING CALCULATIONS
  // ============================================================================

  static double _calculatePiotroskiScore(CompanyModel company) {
    double score = 0;

    try {
      // Profitability criteria (4 points)
      if (company.roe != null && company.roe! > 0) score += 1;

      if (company.annualDataHistory.isNotEmpty) {
        final latest = company.annualDataHistory.first;

        // Operating cash flow > net income
        if (latest.operatingCashFlow != null && latest.netProfit != null) {
          if (latest.operatingCashFlow! > latest.netProfit!) score += 1;
        }

        // Current year ROE > previous year ROE
        if (company.annualDataHistory.length > 1) {
          final current = company.annualDataHistory[0];
          final previous = company.annualDataHistory[1];
          if (current.roe != null && previous.roe != null) {
            if (current.roe! > previous.roe!) score += 1;
          }
        }

        // Positive long-term debt change (decreasing debt)
        if (company.annualDataHistory.length > 1) {
          final current = company.annualDataHistory[0];
          final previous = company.annualDataHistory[1];
          if (current.totalDebt != null && previous.totalDebt != null) {
            if (current.totalDebt! < previous.totalDebt!) score += 1;
          }
        }
      }

      // Leverage criteria (3 points)
      if (company.debtToEquity != null && company.debtToEquity! < 0.3)
        score += 1;
      if (company.currentRatio != null && company.currentRatio! > 1.5)
        score += 1;
      if (company.interestCoverage != null && company.interestCoverage! > 2.5)
        score += 1;

      // Efficiency criteria (2 points)
      if (company.assetTurnover != null && company.assetTurnover! > 0.8)
        score += 1;
      if (company.workingCapitalDays != null &&
          company.workingCapitalDays! < 60) score += 1;
    } catch (e) {
      print('Error calculating Piotroski score: $e');
    }

    return score;
  }

  static double _calculateAltmanZScore(CompanyModel company) {
    try {
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
    } catch (e) {
      print('Error calculating Altman Z-Score: $e');
      return 0;
    }
  }

  static double? _calculateGrahamNumber(CompanyModel company) {
    try {
      if (company.bookValue == null || company.annualDataHistory.isEmpty)
        return null;

      final latest = company.annualDataHistory.first;
      if (latest.eps == null || latest.eps! <= 0) return null;

      return sqrt(22.5 * latest.eps! * company.bookValue!);
    } catch (e) {
      print('Error calculating Graham Number: $e');
      return null;
    }
  }

  static double? _calculatePEGRatio(CompanyModel company) {
    try {
      if (company.stockPe == null || company.profitGrowth3Y == null)
        return null;
      if (company.profitGrowth3Y! <= 0) return null;

      return company.stockPe! / company.profitGrowth3Y!;
    } catch (e) {
      print('Error calculating PEG ratio: $e');
      return null;
    }
  }

  static double? _calculateROIC(CompanyModel company) {
    try {
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
    } catch (e) {
      print('Error calculating ROIC: $e');
      return null;
    }
  }

  static double? _calculateFCFYield(CompanyModel company) {
    try {
      if (company.marketCap == null || company.annualDataHistory.isEmpty)
        return null;

      final latest = company.annualDataHistory.first;
      if (latest.freeCashFlow == null) return null;

      return (latest.freeCashFlow! / company.marketCap!) * 100;
    } catch (e) {
      print('Error calculating FCF yield: $e');
      return null;
    }
  }

  static double? _calculateDebtServiceCoverage(CompanyModel company) {
    try {
      if (company.annualDataHistory.isEmpty) return null;

      final latest = company.annualDataHistory.first;
      if (latest.ebitda == null || latest.interestExpense == null) return null;
      if (latest.interestExpense! <= 0) return null;

      return latest.ebitda! / latest.interestExpense!;
    } catch (e) {
      print('Error calculating debt service coverage: $e');
      return null;
    }
  }

  static double? _calculateDividendCoverage(CompanyModel company) {
    try {
      if (company.annualDataHistory.isEmpty || company.dividendYield == null)
        return null;

      final latest = company.annualDataHistory.first;
      if (latest.eps == null || company.dividendYield! == 0) return null;

      final dividendPerShare =
          (company.dividendYield! / 100) * (company.currentPrice ?? 0);
      if (dividendPerShare <= 0) return null;

      return latest.eps! / dividendPerShare;
    } catch (e) {
      print('Error calculating dividend coverage: $e');
      return null;
    }
  }

  static double? _calculatePriceToFreeCashFlow(CompanyModel company) {
    try {
      if (company.marketCap == null || company.annualDataHistory.isEmpty)
        return null;

      final latest = company.annualDataHistory.first;
      if (latest.freeCashFlow == null || latest.freeCashFlow! <= 0) return null;

      return company.marketCap! / latest.freeCashFlow!;
    } catch (e) {
      print('Error calculating price to free cash flow: $e');
      return null;
    }
  }

  static double? _calculateSafetyMargin(CompanyModel company) {
    try {
      final graham = _calculateGrahamNumber(company);
      if (graham == null || company.currentPrice == null) return null;
      if (company.currentPrice! <= 0) return null;

      return ((graham - company.currentPrice!) / graham) * 100;
    } catch (e) {
      print('Error calculating safety margin: $e');
      return null;
    }
  }

  // ============================================================================
  // QUALITY AND ASSESSMENT METHODS
  // ============================================================================

  static double _calculateComprehensiveScore(CompanyModel company) {
    try {
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
        final avgGrowth =
            (company.salesGrowth3Y! + company.profitGrowth3Y!) / 2;
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
    } catch (e) {
      print('Error calculating comprehensive score: $e');
      return 0;
    }
  }

  static String _assessRisk(CompanyModel company) {
    try {
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
    } catch (e) {
      print('Error assessing risk: $e');
      return 'Unknown';
    }
  }

  static String _getInvestmentGrade(CompanyModel company) {
    try {
      final score = _calculateComprehensiveScore(company);
      final piotroski = _calculatePiotroskiScore(company);

      if (score > 80 && piotroski > 7) return 'AAA';
      if (score > 70 && piotroski > 6) return 'AA';
      if (score > 60 && piotroski > 5) return 'A';
      if (score > 50 && piotroski > 4) return 'BBB';
      if (score > 40 && piotroski > 3) return 'BB';
      if (score > 30 && piotroski > 2) return 'B';
      return 'C';
    } catch (e) {
      print('Error getting investment grade: $e');
      return 'C';
    }
  }

  static String _assessWorkingCapitalEfficiency(CompanyModel company) {
    try {
      if (company.workingCapitalDays == null) return 'Unknown';

      if (company.workingCapitalDays! < 30) return 'Excellent';
      if (company.workingCapitalDays! < 60) return 'Good';
      if (company.workingCapitalDays! < 90) return 'Average';
      return 'Poor';
    } catch (e) {
      print('Error assessing working capital efficiency: $e');
      return 'Unknown';
    }
  }

  static String _assessCashCycleEfficiency(CompanyModel company) {
    try {
      if (company.cashConversionCycle == null) return 'Unknown';

      if (company.cashConversionCycle! < 30) return 'Excellent';
      if (company.cashConversionCycle! < 60) return 'Good';
      if (company.cashConversionCycle! < 90) return 'Average';
      return 'Poor';
    } catch (e) {
      print('Error assessing cash cycle efficiency: $e');
      return 'Unknown';
    }
  }

  static double _calculateBusinessInsightScore(CompanyModel company) {
    try {
      double score = 0;

      if (company.businessOverview.isNotEmpty) score += 2;
      if (company.investmentHighlights.isNotEmpty) score += 2;
      if (company.keyMilestones.isNotEmpty) score += 2;
      if (company.pros.isNotEmpty) score += 1;
      if (company.cons.isNotEmpty) score += 1;
      if (company.industryClassification.isNotEmpty) score += 1;
      if (company.sector != null && company.sector!.isNotEmpty) score += 1;

      return score;
    } catch (e) {
      print('Error calculating business insight score: $e');
      return 0;
    }
  }

  static List<String> _getQualityFlags(CompanyModel company) {
    try {
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
    } catch (e) {
      print('Error getting quality flags: $e');
      return <String>[];
    }
  }

  static String _assessGrowthConsistency(CompanyModel company) {
    try {
      if (company.salesGrowth3Y == null || company.profitGrowth3Y == null) {
        return 'Unknown';
      }

      final salesGrowth = company.salesGrowth3Y!;
      final profitGrowth = company.profitGrowth3Y!;

      if (salesGrowth > 15 && profitGrowth > 15) return 'Excellent';
      if (salesGrowth > 10 || profitGrowth > 10) return 'Good';
      if (salesGrowth > 5 || profitGrowth > 5) return 'Moderate';
      return 'Poor';
    } catch (e) {
      print('Error assessing growth consistency: $e');
      return 'Unknown';
    }
  }

  static String _getValuationStatus(CompanyModel company) {
    try {
      if (company.stockPe == null) return 'Unknown';

      final pe = company.stockPe!;
      final roe = company.roe ?? 0;

      if (pe < 10 && roe > 15) return 'Deeply Undervalued';
      if (pe < 15 && roe > 10) return 'Undervalued';
      if (pe < 20) return 'Fair Value';
      if (pe < 30) return 'Slightly Overvalued';
      return 'Overvalued';
    } catch (e) {
      print('Error getting valuation status: $e');
      return 'Unknown';
    }
  }

  // ============================================================================
  // ADDITIONAL ENHANCEMENT METHODS
  // ============================================================================

  static String _getMarketCapCategory(CompanyModel company) {
    try {
      if (company.marketCap == null) return 'Unknown';

      if (company.marketCap! >= 20000) return 'Large Cap';
      if (company.marketCap! >= 5000) return 'Mid Cap';
      return 'Small Cap';
    } catch (e) {
      print('Error getting market cap category: $e');
      return 'Unknown';
    }
  }

  static String _calculateSectorRanking(CompanyModel company) {
    // This would require sector data - simplified for now
    try {
      final score = _calculateComprehensiveScore(company);

      if (score > 80) return 'Top 10%';
      if (score > 60) return 'Top 25%';
      if (score > 40) return 'Average';
      return 'Below Average';
    } catch (e) {
      print('Error calculating sector ranking: $e');
      return 'Unknown';
    }
  }

  static double _calculateMomentumScore(CompanyModel company) {
    try {
      double momentum = 0;

      if (company.changePercent > 0) momentum += 1;
      if (company.salesGrowth1Y != null && company.salesGrowth1Y! > 10)
        momentum += 1;
      if (company.profitGrowth1Y != null && company.profitGrowth1Y! > 15)
        momentum += 1;

      return momentum;
    } catch (e) {
      print('Error calculating momentum score: $e');
      return 0;
    }
  }

  static double _calculateSustainabilityScore(CompanyModel company) {
    try {
      double sustainability = 0;

      // Low debt contributes to sustainability
      if (company.debtToEquity != null && company.debtToEquity! < 0.3)
        sustainability += 2;

      // Strong cash flow
      if (company.annualDataHistory.isNotEmpty) {
        final latest = company.annualDataHistory.first;
        if (latest.freeCashFlow != null && latest.freeCashFlow! > 0)
          sustainability += 1;
      }

      // Consistent profitability
      if (company.roe != null && company.roe! > 10) sustainability += 1;

      return sustainability;
    } catch (e) {
      print('Error calculating sustainability score: $e');
      return 0;
    }
  }

  static String _assessManagementEfficiency(CompanyModel company) {
    try {
      double efficiency = 0;
      int factors = 0;

      if (company.roe != null) {
        efficiency += min(company.roe! / 20, 1);
        factors++;
      }

      if (company.assetTurnover != null) {
        efficiency += min(company.assetTurnover! / 2, 1);
        factors++;
      }

      if (company.workingCapitalDays != null) {
        efficiency += min(60 / company.workingCapitalDays!, 1);
        factors++;
      }

      final avgEfficiency = factors > 0 ? efficiency / factors : 0;

      if (avgEfficiency > 0.8) return 'Excellent';
      if (avgEfficiency > 0.6) return 'Good';
      if (avgEfficiency > 0.4) return 'Average';
      return 'Poor';
    } catch (e) {
      print('Error assessing management efficiency: $e');
      return 'Unknown';
    }
  }

  static String _assessCompetitiveStrength(CompanyModel company) {
    try {
      int strengths = 0;

      if (company.roe != null && company.roe! > 15) strengths++;
      if (company.roce != null && company.roce! > 15) strengths++;
      if (company.marketCap != null && company.marketCap! > 10000) strengths++;
      if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 15)
        strengths++;

      if (strengths >= 3) return 'Strong';
      if (strengths >= 2) return 'Moderate';
      if (strengths >= 1) return 'Weak';
      return 'Very Weak';
    } catch (e) {
      print('Error assessing competitive strength: $e');
      return 'Unknown';
    }
  }

  // ============================================================================
  // INVESTMENT SUMMARY GENERATION
  // ============================================================================

  static Map<String, dynamic> generateInvestmentSummary(CompanyModel company) {
    try {
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
        'investmentThesis': _generateInvestmentThesis(company),
        'keyMetrics': metrics,
      };
    } catch (e) {
      print('Error generating investment summary: $e');
      return <String, dynamic>{};
    }
  }

  static String _generateRecommendation(
      CompanyModel company, Map<String, dynamic> metrics) {
    try {
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
    } catch (e) {
      print('Error generating recommendation: $e');
      return 'Hold';
    }
  }

  static List<String> _identifyStrengths(CompanyModel company) {
    try {
      final strengths = <String>[];

      if (company.roe != null && company.roe! > 15) {
        strengths.add(
            'Strong profitability (ROE: ${company.roe!.toStringAsFixed(1)}%)');
      }

      if (company.debtToEquity != null && company.debtToEquity! < 0.3) {
        strengths.add(
            'Conservative debt levels (D/E: ${company.debtToEquity!.toStringAsFixed(2)})');
      }

      if (company.currentRatio != null && company.currentRatio! > 1.5) {
        strengths.add(
            'Strong liquidity position (CR: ${company.currentRatio!.toStringAsFixed(2)})');
      }

      if (company.salesGrowth3Y != null && company.salesGrowth3Y! > 15) {
        strengths.add(
            'High revenue growth (${company.salesGrowth3Y!.toStringAsFixed(1)}%)');
      }

      if (company.dividendYield != null && company.dividendYield! > 2) {
        strengths.add(
            'Attractive dividend yield (${company.dividendYield!.toStringAsFixed(1)}%)');
      }

      return strengths;
    } catch (e) {
      print('Error identifying strengths: $e');
      return <String>[];
    }
  }

  static List<String> _identifyWeaknesses(CompanyModel company) {
    try {
      final weaknesses = <String>[];

      if (company.roe != null && company.roe! < 10) {
        weaknesses.add(
            'Low profitability (ROE: ${company.roe!.toStringAsFixed(1)}%)');
      }

      if (company.debtToEquity != null && company.debtToEquity! > 1.0) {
        weaknesses.add(
            'High debt burden (D/E: ${company.debtToEquity!.toStringAsFixed(2)})');
      }

      if (company.currentRatio != null && company.currentRatio! < 1.0) {
        weaknesses.add(
            'Liquidity concerns (CR: ${company.currentRatio!.toStringAsFixed(2)})');
      }

      if (company.stockPe != null && company.stockPe! > 30) {
        weaknesses.add(
            'High valuation (P/E: ${company.stockPe!.toStringAsFixed(1)})');
      }

      if (company.salesGrowth3Y != null && company.salesGrowth3Y! < 5) {
        weaknesses.add(
            'Slow revenue growth (${company.salesGrowth3Y!.toStringAsFixed(1)}%)');
      }

      return weaknesses;
    } catch (e) {
      print('Error identifying weaknesses: $e');
      return <String>[];
    }
  }

  static List<String> _identifyRiskFactors(CompanyModel company) {
    try {
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

      if (company.marketCapCategory != null) {
        final category = _getMarketCapCategory(company);
        if (category == 'Small Cap') {
          risks.add('Small cap volatility');
        }
      }

      return risks;
    } catch (e) {
      print('Error identifying risk factors: $e');
      return <String>[];
    }
  }

  static List<String> _identifyOpportunities(CompanyModel company) {
    try {
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

      final safetyMargin = _calculateSafetyMargin(company);
      if (safetyMargin != null && safetyMargin > 20) {
        opportunities
            .add('Significant undervaluation based on intrinsic value');
      }

      return opportunities;
    } catch (e) {
      print('Error identifying opportunities: $e');
      return <String>[];
    }
  }

  static double? _calculateTargetPrice(CompanyModel company) {
    try {
      final graham = _calculateGrahamNumber(company);
      if (graham != null && company.currentPrice != null) {
        return graham;
      }
      return null;
    } catch (e) {
      print('Error calculating target price: $e');
      return null;
    }
  }

  static String _suggestTimeHorizon(CompanyModel company) {
    try {
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
    } catch (e) {
      print('Error suggesting time horizon: $e');
      return '3-5 years (Long-term)';
    }
  }

  static String _assessPortfolioSuitability(CompanyModel company) {
    try {
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
    } catch (e) {
      print('Error assessing portfolio suitability: $e');
      return 'Speculative allocation';
    }
  }

  static String _generateInvestmentThesis(CompanyModel company) {
    try {
      final score = _calculateComprehensiveScore(company);
      final risk = _assessRisk(company);
      final valuation = _getValuationStatus(company);

      return '${company.name} shows a comprehensive score of ${score.toStringAsFixed(1)}/100 with $risk risk profile. '
          'The stock appears $valuation based on current fundamentals. '
          '${company.sector != null ? "Operating in ${company.sector} sector, " : ""}'
          'this ${_getMarketCapCategory(company).toLowerCase()} company '
          '${company.roe != null && company.roe! > 15 ? "demonstrates strong profitability" : "shows moderate returns"}.';
    } catch (e) {
      print('Error generating investment thesis: $e');
      return 'Analysis unavailable due to insufficient data.';
    }
  }
}
