import 'dart:math';
import '../models/company_model.dart';
import '../utils/json_parsing_utils.dart';

class FundamentalAnalysisService {
  // ============================================================================
  // EXPERT-LEVEL RATIO CALCULATIONS WITH ENHANCED ERROR HANDLING
  // ============================================================================

  static double calculatePiotroskiScore(CompanyModel company) {
    try {
      double score = 0;

      // Profitability Criteria (4 points max)
      if (company.roe != null && company.roe! > 0) score += 1;

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

      // Leverage, Liquidity & Source of Funds (3 points max)
      if (company.debtToEquity != null && company.debtToEquity! < 0.3)
        score += 1;
      if (company.currentRatio != null && company.currentRatio! > 1.5)
        score += 1;
      if (company.interestCoverage != null && company.interestCoverage! > 2.5)
        score += 1;

      // Operating Efficiency (2 points max)
      if (company.assetTurnover != null && company.assetTurnover! > 0.8)
        score += 1;
      if (company.workingCapitalDays != null &&
          company.workingCapitalDays! < 60) score += 1;

      return score;
    } catch (e) {
      print('Error calculating Piotroski score: $e');
      return 0;
    }
  }

  static double calculateAltmanZScore(CompanyModel company) {
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

  static double? calculateGrahamNumber(CompanyModel company) {
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

  static double? calculatePEGRatio(CompanyModel company) {
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

  static double? calculateROIC(CompanyModel company) {
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

  static double? calculateFCFYield(CompanyModel company) {
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

  static double? calculateDebtServiceCoverage(CompanyModel company) {
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

  static double? calculateWorkingCapitalTurnover(CompanyModel company) {
    try {
      if (company.annualDataHistory.isEmpty) return null;

      final latest = company.annualDataHistory.first;
      if (latest.sales == null || latest.workingCapital == null) return null;
      if (latest.workingCapital! <= 0) return null;

      return latest.sales! / latest.workingCapital!;
    } catch (e) {
      print('Error calculating working capital turnover: $e');
      return null;
    }
  }

  static double? calculateReturnOnAssets(CompanyModel company) {
    try {
      if (company.annualDataHistory.isEmpty) return null;

      final latest = company.annualDataHistory.first;
      if (latest.netProfit == null || latest.totalAssets == null) return null;
      if (latest.totalAssets! <= 0) return null;

      return (latest.netProfit! / latest.totalAssets!) * 100;
    } catch (e) {
      print('Error calculating return on assets: $e');
      return null;
    }
  }

  static double? calculateEVToEBITDA(CompanyModel company) {
    try {
      if (company.enterpriseValue == null || company.annualDataHistory.isEmpty)
        return null;

      final latest = company.annualDataHistory.first;
      if (latest.ebitda == null || latest.ebitda! <= 0) return null;

      return company.enterpriseValue! / latest.ebitda!;
    } catch (e) {
      print('Error calculating EV/EBITDA: $e');
      return null;
    }
  }

  static double? calculatePriceToFreeCashFlow(CompanyModel company) {
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

  // Additional advanced ratios
  static double? calculateEnterpriseValueToSales(CompanyModel company) {
    try {
      if (company.enterpriseValue == null || company.annualDataHistory.isEmpty)
        return null;

      final latest = company.annualDataHistory.first;
      if (latest.sales == null || latest.sales! <= 0) return null;

      return company.enterpriseValue! / latest.sales!;
    } catch (e) {
      print('Error calculating EV/Sales: $e');
      return null;
    }
  }

  static double? calculateAssetQuality(CompanyModel company) {
    try {
      if (company.annualDataHistory.isEmpty) return null;

      final latest = company.annualDataHistory.first;
      if (latest.totalAssets == null || latest.totalLiabilities == null)
        return null;

      final tangibleAssets =
          latest.totalAssets! - (latest.totalLiabilities ?? 0);
      return tangibleAssets > 0
          ? (tangibleAssets / latest.totalAssets!) * 100
          : 0;
    } catch (e) {
      print('Error calculating asset quality: $e');
      return null;
    }
  }

  static double? calculateDividendPayout(CompanyModel company) {
    try {
      if (company.dividendYield == null || company.roe == null) return null;
      if (company.roe! <= 0) return null;

      return (company.dividendYield! / company.roe!) * 100;
    } catch (e) {
      print('Error calculating dividend payout: $e');
      return null;
    }
  }

  // ============================================================================
  // QUALITY SCORING SYSTEM
  // ============================================================================

  static double calculateComprehensiveScore(CompanyModel company) {
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

  // ============================================================================
  // RISK ASSESSMENT
  // ============================================================================

  static String assessOverallRisk(CompanyModel company) {
    try {
      int riskFactors = 0;

      // Debt risk
      if (company.debtToEquity != null && company.debtToEquity! > 1.0)
        riskFactors++;

      // Liquidity risk
      if (company.currentRatio != null && company.currentRatio! < 1.0)
        riskFactors++;

      // Profitability risk
      if (company.roe != null && company.roe! < 5) riskFactors++;

      // Interest coverage risk
      if (company.interestCoverage != null && company.interestCoverage! < 2.5)
        riskFactors++;

      // Valuation risk
      if (company.stockPe != null && company.stockPe! > 40) riskFactors++;

      if (riskFactors >= 4) return 'Very High';
      if (riskFactors >= 3) return 'High';
      if (riskFactors >= 2) return 'Medium';
      if (riskFactors >= 1) return 'Low';
      return 'Very Low';
    } catch (e) {
      print('Error assessing overall risk: $e');
      return 'Unknown';
    }
  }

  // ============================================================================
  // SECTOR COMPARISON & BENCHMARKING
  // ============================================================================

  static Map<String, dynamic> generateBenchmarkAnalysis(
      CompanyModel company, List<CompanyModel> sectorPeers) {
    try {
      if (sectorPeers.isEmpty) return <String, dynamic>{};

      final sectorROE = sectorPeers
              .where((c) => c.roe != null)
              .map((c) => c.roe!)
              .fold(0.0, (a, b) => a + b) /
          sectorPeers.where((c) => c.roe != null).length;

      final sectorPE = sectorPeers
              .where((c) =>
                  c.stockPe != null && c.stockPe! > 0 && c.stockPe! < 100)
              .map((c) => c.stockPe!)
              .fold(0.0, (a, b) => a + b) /
          sectorPeers
              .where((c) =>
                  c.stockPe != null && c.stockPe! > 0 && c.stockPe! < 100)
              .length;

      final sectorDebtRatio = sectorPeers
              .where((c) => c.debtToEquity != null)
              .map((c) => c.debtToEquity!)
              .fold(0.0, (a, b) => a + b) /
          sectorPeers.where((c) => c.debtToEquity != null).length;

      return {
        'sector_roe_avg': sectorROE,
        'sector_pe_avg': sectorPE,
        'sector_debt_avg': sectorDebtRatio,
        'roe_vs_sector':
            company.roe != null ? (company.roe! - sectorROE) : null,
        'pe_vs_sector': company.stockPe != null && company.stockPe! > 0
            ? (company.stockPe! - sectorPE)
            : null,
        'debt_vs_sector': company.debtToEquity != null
            ? (company.debtToEquity! - sectorDebtRatio)
            : null,
      };
    } catch (e) {
      print('Error generating benchmark analysis: $e');
      return <String, dynamic>{};
    }
  }

  // ============================================================================
  // FINANCIAL HEALTH ASSESSMENT
  // ============================================================================

  static Map<String, dynamic> analyzeFinancialHealth(CompanyModel company) {
    try {
      final health = <String, dynamic>{};

      // Liquidity Analysis
      health['liquidity'] = _analyzeLiquidity(company);

      // Solvency Analysis
      health['solvency'] = _analyzeSolvency(company);

      // Profitability Analysis
      health['profitability'] = _analyzeProfitability(company);

      // Efficiency Analysis
      health['efficiency'] = _analyzeEfficiency(company);

      // Overall Health Score
      health['overall_score'] = _calculateOverallHealthScore(company);

      return health;
    } catch (e) {
      print('Error analyzing financial health: $e');
      return <String, dynamic>{};
    }
  }

  static Map<String, dynamic> _analyzeLiquidity(CompanyModel company) {
    try {
      final liquidity = <String, dynamic>{};

      if (company.currentRatio != null) {
        liquidity['current_ratio'] = company.currentRatio;
        if (company.currentRatio! > 2.0) {
          liquidity['current_ratio_status'] = 'Excellent';
        } else if (company.currentRatio! > 1.5) {
          liquidity['current_ratio_status'] = 'Good';
        } else if (company.currentRatio! > 1.0) {
          liquidity['current_ratio_status'] = 'Adequate';
        } else {
          liquidity['current_ratio_status'] = 'Poor';
        }
      }

      if (company.quickRatio != null) {
        liquidity['quick_ratio'] = company.quickRatio;
        if (company.quickRatio! > 1.5) {
          liquidity['quick_ratio_status'] = 'Excellent';
        } else if (company.quickRatio! > 1.0) {
          liquidity['quick_ratio_status'] = 'Good';
        } else {
          liquidity['quick_ratio_status'] = 'Poor';
        }
      }

      return liquidity;
    } catch (e) {
      print('Error analyzing liquidity: $e');
      return <String, dynamic>{};
    }
  }

  static Map<String, dynamic> _analyzeSolvency(CompanyModel company) {
    try {
      final solvency = <String, dynamic>{};

      if (company.debtToEquity != null) {
        solvency['debt_to_equity'] = company.debtToEquity;
        if (company.debtToEquity! < 0.1) {
          solvency['debt_status'] = 'Debt Free';
        } else if (company.debtToEquity! < 0.3) {
          solvency['debt_status'] = 'Low Debt';
        } else if (company.debtToEquity! < 0.6) {
          solvency['debt_status'] = 'Moderate Debt';
        } else if (company.debtToEquity! < 1.0) {
          solvency['debt_status'] = 'High Debt';
        } else {
          solvency['debt_status'] = 'Very High Debt';
        }
      }

      if (company.interestCoverage != null) {
        solvency['interest_coverage'] = company.interestCoverage;
        if (company.interestCoverage! > 5.0) {
          solvency['interest_coverage_status'] = 'Excellent';
        } else if (company.interestCoverage! > 2.5) {
          solvency['interest_coverage_status'] = 'Good';
        } else if (company.interestCoverage! > 1.5) {
          solvency['interest_coverage_status'] = 'Adequate';
        } else {
          solvency['interest_coverage_status'] = 'Poor';
        }
      }

      return solvency;
    } catch (e) {
      print('Error analyzing solvency: $e');
      return <String, dynamic>{};
    }
  }

  static Map<String, dynamic> _analyzeProfitability(CompanyModel company) {
    try {
      final profitability = <String, dynamic>{};

      if (company.roe != null) {
        profitability['roe'] = company.roe;
        if (company.roe! > 20) {
          profitability['roe_status'] = 'Excellent';
        } else if (company.roe! > 15) {
          profitability['roe_status'] = 'Good';
        } else if (company.roe! > 10) {
          profitability['roe_status'] = 'Average';
        } else if (company.roe! > 0) {
          profitability['roe_status'] = 'Weak';
        } else {
          profitability['roe_status'] = 'Loss Making';
        }
      }

      if (company.roce != null) {
        profitability['roce'] = company.roce;
        if (company.roce! > 20) {
          profitability['roce_status'] = 'Excellent';
        } else if (company.roce! > 15) {
          profitability['roce_status'] = 'Good';
        } else if (company.roce! > 10) {
          profitability['roce_status'] = 'Average';
        } else {
          profitability['roce_status'] = 'Weak';
        }
      }

      return profitability;
    } catch (e) {
      print('Error analyzing profitability: $e');
      return <String, dynamic>{};
    }
  }

  static Map<String, dynamic> _analyzeEfficiency(CompanyModel company) {
    try {
      final efficiency = <String, dynamic>{};

      if (company.assetTurnover != null) {
        efficiency['asset_turnover'] = company.assetTurnover;
        if (company.assetTurnover! > 1.5) {
          efficiency['asset_turnover_status'] = 'Excellent';
        } else if (company.assetTurnover! > 1.0) {
          efficiency['asset_turnover_status'] = 'Good';
        } else if (company.assetTurnover! > 0.5) {
          efficiency['asset_turnover_status'] = 'Average';
        } else {
          efficiency['asset_turnover_status'] = 'Poor';
        }
      }

      if (company.workingCapitalDays != null) {
        efficiency['working_capital_days'] = company.workingCapitalDays;
        if (company.workingCapitalDays! < 30) {
          efficiency['working_capital_status'] = 'Excellent';
        } else if (company.workingCapitalDays! < 60) {
          efficiency['working_capital_status'] = 'Good';
        } else if (company.workingCapitalDays! < 90) {
          efficiency['working_capital_status'] = 'Average';
        } else {
          efficiency['working_capital_status'] = 'Poor';
        }
      }

      return efficiency;
    } catch (e) {
      print('Error analyzing efficiency: $e');
      return <String, dynamic>{};
    }
  }

  static double _calculateOverallHealthScore(CompanyModel company) {
    try {
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

      return factors > 0 ? score / factors : 0;
    } catch (e) {
      print('Error calculating overall health score: $e');
      return 0;
    }
  }

  // ============================================================================
  // INVESTMENT DECISION FRAMEWORK
  // ============================================================================

  static String generateInvestmentRecommendation(CompanyModel company) {
    try {
      final qualityScore = calculateComprehensiveScore(company);
      final piotroskiScore = calculatePiotroskiScore(company);
      final riskLevel = assessOverallRisk(company);

      if (qualityScore > 80 && piotroskiScore > 7 && riskLevel == 'Very Low') {
        return 'Strong Buy - High quality company with excellent fundamentals';
      } else if (qualityScore > 60 &&
          piotroskiScore > 5 &&
          riskLevel != 'Very High') {
        return 'Buy - Good fundamentals with manageable risk';
      } else if (qualityScore > 40 && riskLevel == 'Medium') {
        return 'Hold - Average fundamentals, monitor closely';
      } else if (riskLevel == 'High' || riskLevel == 'Very High') {
        return 'Sell - High risk factors present';
      } else {
        return 'Hold - Mixed signals, requires deeper analysis';
      }
    } catch (e) {
      print('Error generating investment recommendation: $e');
      return 'Hold - Analysis unavailable';
    }
  }

  // ============================================================================
  // VALUATION MODELS
  // ============================================================================

  static Map<String, dynamic> calculateValuationMetrics(CompanyModel company) {
    try {
      final valuation = <String, dynamic>{};

      // Graham Number
      final graham = calculateGrahamNumber(company);
      if (graham != null) {
        valuation['graham_number'] = graham;
        if (company.currentPrice != null) {
          final safetyMargin =
              ((graham - company.currentPrice!) / graham) * 100;
          valuation['safety_margin'] = safetyMargin;
          if (safetyMargin > 25) {
            valuation['value_status'] = 'Deeply Undervalued';
          } else if (safetyMargin > 10) {
            valuation['value_status'] = 'Undervalued';
          } else if (safetyMargin > -10) {
            valuation['value_status'] = 'Fair Value';
          } else {
            valuation['value_status'] = 'Overvalued';
          }
        }
      }

      // PEG Ratio
      final peg = calculatePEGRatio(company);
      if (peg != null) {
        valuation['peg_ratio'] = peg;
        if (peg < 1.0) {
          valuation['peg_status'] = 'Undervalued';
        } else if (peg < 2.0) {
          valuation['peg_status'] = 'Fair';
        } else {
          valuation['peg_status'] = 'Overvalued';
        }
      }

      // P/E Ratio Analysis
      if (company.stockPe != null) {
        valuation['pe_ratio'] = company.stockPe;
        if (company.stockPe! < 15) {
          valuation['pe_status'] = 'Undervalued';
        } else if (company.stockPe! < 25) {
          valuation['pe_status'] = 'Fair';
        } else {
          valuation['pe_status'] = 'Overvalued';
        }
      }

      // P/B Ratio Analysis
      if (company.priceToBook != null) {
        valuation['pb_ratio'] = company.priceToBook;
        if (company.priceToBook! < 1.5) {
          valuation['pb_status'] = 'Undervalued';
        } else if (company.priceToBook! < 3.0) {
          valuation['pb_status'] = 'Fair';
        } else {
          valuation['pb_status'] = 'Overvalued';
        }
      }

      return valuation;
    } catch (e) {
      print('Error calculating valuation metrics: $e');
      return <String, dynamic>{};
    }
  }

  // ============================================================================
  // TREND ANALYSIS
  // ============================================================================

  static Map<String, dynamic> analyzeTrends(CompanyModel company) {
    try {
      final trends = <String, dynamic>{};

      if (company.annualDataHistory.length >= 3) {
        // Revenue Trend
        final revenueData = company.annualDataHistory
            .take(3)
            .where((d) => d.sales != null)
            .map((d) => d.sales!)
            .toList();
        if (revenueData.length >= 3) {
          trends['revenue_trend'] = _calculateTrend(revenueData);
        }

        // Profit Trend
        final profitData = company.annualDataHistory
            .take(3)
            .where((d) => d.netProfit != null)
            .map((d) => d.netProfit!)
            .toList();
        if (profitData.length >= 3) {
          trends['profit_trend'] = _calculateTrend(profitData);
        }

        // ROE Trend
        final roeData = company.annualDataHistory
            .take(3)
            .where((d) => d.roe != null)
            .map((d) => d.roe!)
            .toList();
        if (roeData.length >= 3) {
          trends['roe_trend'] = _calculateTrend(roeData);
        }
      }

      return trends;
    } catch (e) {
      print('Error analyzing trends: $e');
      return <String, dynamic>{};
    }
  }

  static String _calculateTrend(List<double> data) {
    try {
      if (data.length < 3) return 'Insufficient Data';

      // Simple trend analysis
      final recent = data[0];
      final middle = data[1];
      final old = data[2];

      if (middle == 0 || old == 0) return 'Invalid Data';

      final recentChange = (recent - middle) / middle * 100;
      final olderChange = (middle - old) / old * 100;

      if (recentChange > 5 && olderChange > 5) return 'Strong Upward';
      if (recentChange > 0 && olderChange > 0) return 'Upward';
      if (recentChange < -5 && olderChange < -5) return 'Strong Downward';
      if (recentChange < 0 && olderChange < 0) return 'Downward';
      return 'Sideways';
    } catch (e) {
      print('Error calculating trend: $e');
      return 'Error';
    }
  }

  // ============================================================================
  // DIVIDEND ANALYSIS
  // ============================================================================

  static Map<String, dynamic> analyzeDividendMetrics(CompanyModel company) {
    try {
      final dividend = <String, dynamic>{};

      if (company.dividendYield != null) {
        dividend['yield'] = company.dividendYield;

        // Dividend coverage
        final coverage = calculateDividendPayout(company);
        if (coverage != null) {
          dividend['payout_ratio'] = coverage;
          if (coverage < 30) {
            dividend['sustainability'] = 'Very Safe';
          } else if (coverage < 60) {
            dividend['sustainability'] = 'Safe';
          } else if (coverage < 80) {
            dividend['sustainability'] = 'Moderate';
          } else {
            dividend['sustainability'] = 'Risky';
          }
        }
      }

      return dividend;
    } catch (e) {
      print('Error analyzing dividend metrics: $e');
      return <String, dynamic>{};
    }
  }

  // ============================================================================
  // SECTOR-SPECIFIC ANALYSIS
  // ============================================================================

  static Map<String, dynamic> analyzeBySector(
      CompanyModel company, String sector) {
    try {
      final sectorAnalysis = <String, dynamic>{};

      // Sector-specific benchmarks
      switch (sector.toLowerCase()) {
        case 'banking':
        case 'finance':
          sectorAnalysis['key_metrics'] = ['roe', 'npa', 'capital_adequacy'];
          sectorAnalysis['benchmark_roe'] = 15.0;
          break;
        case 'pharma':
        case 'pharmaceuticals':
          sectorAnalysis['key_metrics'] = [
            'r&d_spend',
            'patent_expiry',
            'regulatory_approvals'
          ];
          sectorAnalysis['benchmark_roe'] = 18.0;
          break;
        case 'it':
        case 'software':
          sectorAnalysis['key_metrics'] = [
            'employee_cost',
            'utilization_rate',
            'pricing_power'
          ];
          sectorAnalysis['benchmark_roe'] = 20.0;
          break;
        case 'fmcg':
          sectorAnalysis['key_metrics'] = [
            'brand_strength',
            'distribution_network',
            'pricing_power'
          ];
          sectorAnalysis['benchmark_roe'] = 16.0;
          break;
        default:
          sectorAnalysis['key_metrics'] = [
            'roe',
            'debt_to_equity',
            'current_ratio'
          ];
          sectorAnalysis['benchmark_roe'] = 15.0;
      }

      return sectorAnalysis;
    } catch (e) {
      print('Error analyzing by sector: $e');
      return <String, dynamic>{};
    }
  }
}
