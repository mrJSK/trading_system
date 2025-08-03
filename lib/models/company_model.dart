import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:math';
import 'financial_data_model.dart';
import 'fundamental_filter.dart';
import '../utils/json_parsing_utils.dart';

// ============================================================================
// SUPPORTING MODEL CLASSES (Manual Serialization)
// ============================================================================

class KeyMilestone {
  final String category;
  final String description;
  final String relevance;
  final String? year;
  final DateTime? date;

  const KeyMilestone({
    required this.category,
    required this.description,
    this.relevance = 'medium',
    this.year,
    this.date,
  });

  factory KeyMilestone.fromJson(Map<String, dynamic> json) {
    return KeyMilestone(
      category: JsonParsingUtils.safeString(json['category']) ?? '',
      description: JsonParsingUtils.safeString(json['description']) ?? '',
      relevance: JsonParsingUtils.safeString(json['relevance']) ?? 'medium',
      year: JsonParsingUtils.safeString(json['year']),
      date: JsonParsingUtils.safeDateTime(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'description': description,
      'relevance': relevance,
      'year': year,
      'date': date?.toIso8601String(),
    };
  }
}

class InvestmentHighlight {
  final String type;
  final String description;
  final String impact;
  final double? value;
  final String? unit;

  const InvestmentHighlight({
    required this.type,
    required this.description,
    required this.impact,
    this.value,
    this.unit,
  });

  factory InvestmentHighlight.fromJson(Map<String, dynamic> json) {
    return InvestmentHighlight(
      type: JsonParsingUtils.safeString(json['type']) ?? '',
      description: JsonParsingUtils.safeString(json['description']) ?? '',
      impact: JsonParsingUtils.safeString(json['impact']) ?? '',
      value: JsonParsingUtils.safeDouble(json['value']),
      unit: JsonParsingUtils.safeString(json['unit']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'description': description,
      'impact': impact,
      'value': value,
      'unit': unit,
    };
  }
}

class FinancialSummary {
  final String metric;
  final String value;
  final String? unit;
  final String? trend;

  const FinancialSummary({
    required this.metric,
    required this.value,
    this.unit,
    this.trend,
  });

  factory FinancialSummary.fromJson(Map<String, dynamic> json) {
    return FinancialSummary(
      metric: JsonParsingUtils.safeString(json['metric']) ?? '',
      value: JsonParsingUtils.safeString(json['value']) ?? '',
      unit: JsonParsingUtils.safeString(json['unit']),
      trend: JsonParsingUtils.safeString(json['trend']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metric': metric,
      'value': value,
      'unit': unit,
      'trend': trend,
    };
  }
}

class QuarterlyData {
  final String quarter;
  final String year;
  final double? sales;
  final double? netProfit;
  final double? eps;
  final double? operatingProfit;
  final double? ebitda;
  final double? totalIncome;
  final double? totalExpenses;
  final double? otherIncome;
  final double? rawMaterials;
  final double? powerAndFuel;
  final double? employeeCost;
  final double? sellingExpenses;
  final double? adminExpenses;
  final double? researchAndDevelopment;
  final double? depreciation;
  final double? interestExpense;
  final double? taxExpense;
  final double? profitMargin;
  final double? ebitdaMargin;
  final DateTime? reportDate;

  const QuarterlyData({
    required this.quarter,
    required this.year,
    this.sales,
    this.netProfit,
    this.eps,
    this.operatingProfit,
    this.ebitda,
    this.totalIncome,
    this.totalExpenses,
    this.otherIncome,
    this.rawMaterials,
    this.powerAndFuel,
    this.employeeCost,
    this.sellingExpenses,
    this.adminExpenses,
    this.researchAndDevelopment,
    this.depreciation,
    this.interestExpense,
    this.taxExpense,
    this.profitMargin,
    this.ebitdaMargin,
    this.reportDate,
  });

  factory QuarterlyData.fromJson(Map<String, dynamic> json) {
    return QuarterlyData(
      quarter: JsonParsingUtils.safeString(json['quarter']) ?? '',
      year: JsonParsingUtils.safeString(json['year']) ?? '',
      sales: JsonParsingUtils.safeDouble(json['sales']),
      netProfit: JsonParsingUtils.safeDouble(json['netProfit']),
      eps: JsonParsingUtils.safeDouble(json['eps']),
      operatingProfit: JsonParsingUtils.safeDouble(json['operatingProfit']),
      ebitda: JsonParsingUtils.safeDouble(json['ebitda']),
      totalIncome: JsonParsingUtils.safeDouble(json['totalIncome']),
      totalExpenses: JsonParsingUtils.safeDouble(json['totalExpenses']),
      otherIncome: JsonParsingUtils.safeDouble(json['otherIncome']),
      rawMaterials: JsonParsingUtils.safeDouble(json['rawMaterials']),
      powerAndFuel: JsonParsingUtils.safeDouble(json['powerAndFuel']),
      employeeCost: JsonParsingUtils.safeDouble(json['employeeCost']),
      sellingExpenses: JsonParsingUtils.safeDouble(json['sellingExpenses']),
      adminExpenses: JsonParsingUtils.safeDouble(json['adminExpenses']),
      researchAndDevelopment:
          JsonParsingUtils.safeDouble(json['researchAndDevelopment']),
      depreciation: JsonParsingUtils.safeDouble(json['depreciation']),
      interestExpense: JsonParsingUtils.safeDouble(json['interestExpense']),
      taxExpense: JsonParsingUtils.safeDouble(json['taxExpense']),
      profitMargin: JsonParsingUtils.safeDouble(json['profitMargin']),
      ebitdaMargin: JsonParsingUtils.safeDouble(json['ebitdaMargin']),
      reportDate: JsonParsingUtils.safeDateTime(json['reportDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quarter': quarter,
      'year': year,
      'sales': sales,
      'netProfit': netProfit,
      'eps': eps,
      'operatingProfit': operatingProfit,
      'ebitda': ebitda,
      'totalIncome': totalIncome,
      'totalExpenses': totalExpenses,
      'otherIncome': otherIncome,
      'rawMaterials': rawMaterials,
      'powerAndFuel': powerAndFuel,
      'employeeCost': employeeCost,
      'sellingExpenses': sellingExpenses,
      'adminExpenses': adminExpenses,
      'researchAndDevelopment': researchAndDevelopment,
      'depreciation': depreciation,
      'interestExpense': interestExpense,
      'taxExpense': taxExpense,
      'profitMargin': profitMargin,
      'ebitdaMargin': ebitdaMargin,
      'reportDate': reportDate?.toIso8601String(),
    };
  }
}

class AnnualData {
  final String year;
  final double? sales;
  final double? netProfit;
  final double? eps;
  final double? bookValue;
  final double? roe;
  final double? roce;
  final double? peRatio;
  final double? pbRatio;
  final double? dividendPerShare;
  final double? faceValue;
  final double? operatingProfit;
  final double? ebitda;
  final double? grossProfit;
  final double? totalAssets;
  final double? totalLiabilities;
  final double? shareholdersEquity;
  final double? totalDebt;
  final double? workingCapital;
  final double? operatingCashFlow;
  final double? investingCashFlow;
  final double? financingCashFlow;
  final double? freeCashFlow;
  final double? currentRatio;
  final double? quickRatio;
  final double? debtToEquity;
  final double? profitMargin;
  final double? ebitdaMargin;
  final double? assetTurnover;
  final double? inventoryTurnover;
  final double? interestCoverage;
  final double? interestExpense;
  final double? taxExpense;
  final double? depreciation;
  final double? amortization;
  final double? capitalExpenditures;
  final DateTime? yearEnd;

  const AnnualData({
    required this.year,
    this.sales,
    this.netProfit,
    this.eps,
    this.bookValue,
    this.roe,
    this.roce,
    this.peRatio,
    this.pbRatio,
    this.dividendPerShare,
    this.faceValue,
    this.operatingProfit,
    this.ebitda,
    this.grossProfit,
    this.totalAssets,
    this.totalLiabilities,
    this.shareholdersEquity,
    this.totalDebt,
    this.workingCapital,
    this.operatingCashFlow,
    this.investingCashFlow,
    this.financingCashFlow,
    this.freeCashFlow,
    this.currentRatio,
    this.quickRatio,
    this.debtToEquity,
    this.profitMargin,
    this.ebitdaMargin,
    this.assetTurnover,
    this.inventoryTurnover,
    this.interestCoverage,
    this.interestExpense,
    this.taxExpense,
    this.depreciation,
    this.amortization,
    this.capitalExpenditures,
    this.yearEnd,
  });

  factory AnnualData.fromJson(Map<String, dynamic> json) {
    return AnnualData(
      year: JsonParsingUtils.safeString(json['year']) ?? '',
      sales: JsonParsingUtils.safeDouble(json['sales']),
      netProfit: JsonParsingUtils.safeDouble(json['netProfit']),
      eps: JsonParsingUtils.safeDouble(json['eps']),
      bookValue: JsonParsingUtils.safeDouble(json['bookValue']),
      roe: JsonParsingUtils.safeDouble(json['roe']),
      roce: JsonParsingUtils.safeDouble(json['roce']),
      peRatio: JsonParsingUtils.safeDouble(json['peRatio']),
      pbRatio: JsonParsingUtils.safeDouble(json['pbRatio']),
      dividendPerShare: JsonParsingUtils.safeDouble(json['dividendPerShare']),
      faceValue: JsonParsingUtils.safeDouble(json['faceValue']),
      operatingProfit: JsonParsingUtils.safeDouble(json['operatingProfit']),
      ebitda: JsonParsingUtils.safeDouble(json['ebitda']),
      grossProfit: JsonParsingUtils.safeDouble(json['grossProfit']),
      totalAssets: JsonParsingUtils.safeDouble(json['totalAssets']),
      totalLiabilities: JsonParsingUtils.safeDouble(json['totalLiabilities']),
      shareholdersEquity:
          JsonParsingUtils.safeDouble(json['shareholdersEquity']),
      totalDebt: JsonParsingUtils.safeDouble(json['totalDebt']),
      workingCapital: JsonParsingUtils.safeDouble(json['workingCapital']),
      operatingCashFlow: JsonParsingUtils.safeDouble(json['operatingCashFlow']),
      investingCashFlow: JsonParsingUtils.safeDouble(json['investingCashFlow']),
      financingCashFlow: JsonParsingUtils.safeDouble(json['financingCashFlow']),
      freeCashFlow: JsonParsingUtils.safeDouble(json['freeCashFlow']),
      currentRatio: JsonParsingUtils.safeDouble(json['currentRatio']),
      quickRatio: JsonParsingUtils.safeDouble(json['quickRatio']),
      debtToEquity: JsonParsingUtils.safeDouble(json['debtToEquity']),
      profitMargin: JsonParsingUtils.safeDouble(json['profitMargin']),
      ebitdaMargin: JsonParsingUtils.safeDouble(json['ebitdaMargin']),
      assetTurnover: JsonParsingUtils.safeDouble(json['assetTurnover']),
      inventoryTurnover: JsonParsingUtils.safeDouble(json['inventoryTurnover']),
      interestCoverage: JsonParsingUtils.safeDouble(json['interestCoverage']),
      interestExpense: JsonParsingUtils.safeDouble(json['interestExpense']),
      taxExpense: JsonParsingUtils.safeDouble(json['taxExpense']),
      depreciation: JsonParsingUtils.safeDouble(json['depreciation']),
      amortization: JsonParsingUtils.safeDouble(json['amortization']),
      capitalExpenditures:
          JsonParsingUtils.safeDouble(json['capitalExpenditures']),
      yearEnd: JsonParsingUtils.safeDateTime(json['yearEnd']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'sales': sales,
      'netProfit': netProfit,
      'eps': eps,
      'bookValue': bookValue,
      'roe': roe,
      'roce': roce,
      'peRatio': peRatio,
      'pbRatio': pbRatio,
      'dividendPerShare': dividendPerShare,
      'faceValue': faceValue,
      'operatingProfit': operatingProfit,
      'ebitda': ebitda,
      'grossProfit': grossProfit,
      'totalAssets': totalAssets,
      'totalLiabilities': totalLiabilities,
      'shareholdersEquity': shareholdersEquity,
      'totalDebt': totalDebt,
      'workingCapital': workingCapital,
      'operatingCashFlow': operatingCashFlow,
      'investingCashFlow': investingCashFlow,
      'financingCashFlow': financingCashFlow,
      'freeCashFlow': freeCashFlow,
      'currentRatio': currentRatio,
      'quickRatio': quickRatio,
      'debtToEquity': debtToEquity,
      'profitMargin': profitMargin,
      'ebitdaMargin': ebitdaMargin,
      'assetTurnover': assetTurnover,
      'inventoryTurnover': inventoryTurnover,
      'interestCoverage': interestCoverage,
      'interestExpense': interestExpense,
      'taxExpense': taxExpense,
      'depreciation': depreciation,
      'amortization': amortization,
      'capitalExpenditures': capitalExpenditures,
      'yearEnd': yearEnd?.toIso8601String(),
    };
  }
}

class DividendHistory {
  final String year;
  final double? dividendPerShare;
  final String? dividendType;
  final DateTime? exDividendDate;
  final DateTime? recordDate;
  final DateTime? paymentDate;

  const DividendHistory({
    required this.year,
    this.dividendPerShare,
    this.dividendType,
    this.exDividendDate,
    this.recordDate,
    this.paymentDate,
  });

  factory DividendHistory.fromJson(Map<String, dynamic> json) {
    return DividendHistory(
      year: JsonParsingUtils.safeString(json['year']) ?? '',
      dividendPerShare: JsonParsingUtils.safeDouble(json['dividendPerShare']),
      dividendType: JsonParsingUtils.safeString(json['dividendType']),
      exDividendDate: JsonParsingUtils.safeDateTime(json['exDividendDate']),
      recordDate: JsonParsingUtils.safeDateTime(json['recordDate']),
      paymentDate: JsonParsingUtils.safeDateTime(json['paymentDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'dividendPerShare': dividendPerShare,
      'dividendType': dividendType,
      'exDividendDate': exDividendDate?.toIso8601String(),
      'recordDate': recordDate?.toIso8601String(),
      'paymentDate': paymentDate?.toIso8601String(),
    };
  }
}

// ============================================================================
// MAIN COMPANY MODEL WITH MANUAL JSON SERIALIZATION
// ============================================================================

class CompanyModel {
  final String symbol;
  final String name;
  final String displayName;
  final String? about;
  final String? website;
  final String? bseCode;
  final String? nseCode;
  final double? marketCap;
  final double? currentPrice;
  final String? highLow;
  final double? stockPe;
  final double? bookValue;
  final double? dividendYield;
  final double? roce;
  final double? roe;
  final double? faceValue;
  final List<String> pros;
  final List<String> cons;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String lastUpdated;
  final double changePercent;
  final double changeAmount;
  final double previousClose;
  final FinancialDataModel? quarterlyResults;
  final FinancialDataModel? profitLossStatement;
  final FinancialDataModel? balanceSheet;
  final FinancialDataModel? cashFlowStatement;
  final FinancialDataModel? ratios;
  final double? debtToEquity;
  final double? currentRatio;
  final double? quickRatio;
  final double? workingCapitalDays;
  final double? debtorDays;
  final double? inventoryDays;
  final double? cashConversionCycle;
  final double? interestCoverage;
  final double? assetTurnover;
  final double? inventoryTurnover;
  final double? receivablesTurnover;
  final double? payablesTurnover;
  final double? workingCapital;
  final double? enterpriseValue;
  final double? evEbitda;
  final double? priceToBook;
  final double? priceToSales;
  final double? pegRatio;
  final double? betaValue;
  final double? salesGrowth1Y;
  final double? salesGrowth3Y;
  final double? salesGrowth5Y;
  final double? profitGrowth1Y;
  final double? profitGrowth3Y;
  final double? profitGrowth5Y;
  final double? salesCAGR3Y;
  final double? salesCAGR5Y;
  final double? profitCAGR3Y;
  final double? profitCAGR5Y;
  final String businessOverview;
  final String? sector;
  final String? industry;
  final List<String> industryClassification;
  final Map<String, dynamic> recentPerformance;
  final List<KeyMilestone> keyMilestones;
  final List<InvestmentHighlight> investmentHighlights;
  final List<FinancialSummary> financialSummary;
  final int qualityScore;
  final String overallQualityGrade;
  final String workingCapitalEfficiency;
  final String cashCycleEfficiency;
  final String liquidityStatus;
  final String debtStatus;
  final String riskLevel;
  final double? piotroskiScore;
  final double? altmanZScore;
  final String? qualityGrade;
  final String? creditRating;
  final double? grahamNumber;
  final double? roic;
  final double? fcfYield;
  final double? debtServiceCoverage;
  final double? comprehensiveScore;
  final String? investmentRecommendation;
  final Map<String, dynamic> ratiosData;
  final Map<String, Map<String, String>> growthTables;
  final List<QuarterlyData> quarterlyDataHistory;
  final List<AnnualData> annualDataHistory;
  final List<String> peerCompanies;
  final double? sectorPE;
  final double? sectorROE;
  final double? sectorDebtToEquity;
  final double? dividendPerShare;
  final String? dividendFrequency;
  final List<DividendHistory> dividendHistory;
  final List<String> keyManagement;
  final double? promoterHolding;
  final double? institutionalHolding;
  final double? publicHolding;
  final double? volatility30D;
  final double? volatility1Y;
  final double? maxDrawdown;
  final double? sharpeRatio;
  final double? marketCapCategory;
  final bool? isIndexConstituent;
  final List<String> indices;
  final double? rsi;
  final double? sma50;
  final double? sma200;
  final double? ema12;
  final double? ema26;
  final bool isDebtFree;
  final bool isProfitable;
  final bool hasConsistentProfits;
  final bool paysDividends;
  final bool isGrowthStock;
  final bool isValueStock;
  final bool isQualityStock;

  const CompanyModel({
    required this.symbol,
    required this.name,
    required this.displayName,
    this.about,
    this.website,
    this.bseCode,
    this.nseCode,
    this.marketCap,
    this.currentPrice,
    this.highLow,
    this.stockPe,
    this.bookValue,
    this.dividendYield,
    this.roce,
    this.roe,
    this.faceValue,
    this.pros = const [],
    this.cons = const [],
    this.createdAt,
    this.updatedAt,
    required this.lastUpdated,
    this.changePercent = 0.0,
    this.changeAmount = 0.0,
    this.previousClose = 0.0,
    this.quarterlyResults,
    this.profitLossStatement,
    this.balanceSheet,
    this.cashFlowStatement,
    this.ratios,
    this.debtToEquity,
    this.currentRatio,
    this.quickRatio,
    this.workingCapitalDays,
    this.debtorDays,
    this.inventoryDays,
    this.cashConversionCycle,
    this.interestCoverage,
    this.assetTurnover,
    this.inventoryTurnover,
    this.receivablesTurnover,
    this.payablesTurnover,
    this.workingCapital,
    this.enterpriseValue,
    this.evEbitda,
    this.priceToBook,
    this.priceToSales,
    this.pegRatio,
    this.betaValue,
    this.salesGrowth1Y,
    this.salesGrowth3Y,
    this.salesGrowth5Y,
    this.profitGrowth1Y,
    this.profitGrowth3Y,
    this.profitGrowth5Y,
    this.salesCAGR3Y,
    this.salesCAGR5Y,
    this.profitCAGR3Y,
    this.profitCAGR5Y,
    this.businessOverview = '',
    this.sector,
    this.industry,
    this.industryClassification = const [],
    this.recentPerformance = const {},
    this.keyMilestones = const [],
    this.investmentHighlights = const [],
    this.financialSummary = const [],
    this.qualityScore = 3,
    this.overallQualityGrade = 'C',
    this.workingCapitalEfficiency = 'Unknown',
    this.cashCycleEfficiency = 'Unknown',
    this.liquidityStatus = 'Unknown',
    this.debtStatus = 'Unknown',
    this.riskLevel = 'Medium',
    this.piotroskiScore,
    this.altmanZScore,
    this.qualityGrade,
    this.creditRating,
    this.grahamNumber,
    this.roic,
    this.fcfYield,
    this.debtServiceCoverage,
    this.comprehensiveScore,
    this.investmentRecommendation,
    this.ratiosData = const {},
    this.growthTables = const {},
    this.quarterlyDataHistory = const [],
    this.annualDataHistory = const [],
    this.peerCompanies = const [],
    this.sectorPE,
    this.sectorROE,
    this.sectorDebtToEquity,
    this.dividendPerShare,
    this.dividendFrequency,
    this.dividendHistory = const [],
    this.keyManagement = const [],
    this.promoterHolding,
    this.institutionalHolding,
    this.publicHolding,
    this.volatility30D,
    this.volatility1Y,
    this.maxDrawdown,
    this.sharpeRatio,
    this.marketCapCategory,
    this.isIndexConstituent,
    this.indices = const [],
    this.rsi,
    this.sma50,
    this.sma200,
    this.ema12,
    this.ema26,
    this.isDebtFree = false,
    this.isProfitable = false,
    this.hasConsistentProfits = false,
    this.paysDividends = false,
    this.isGrowthStock = false,
    this.isValueStock = false,
    this.isQualityStock = false,
  });

  // ============================================================================
  // MANUAL JSON DESERIALIZATION
  // ============================================================================

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      symbol: JsonParsingUtils.safeString(json['symbol']) ?? '',
      name: JsonParsingUtils.safeString(json['name']) ?? 'Unknown Company',
      displayName: JsonParsingUtils.safeString(json['displayName']) ??
          JsonParsingUtils.safeString(json['display_name']) ??
          'Unknown Company',
      about: JsonParsingUtils.safeString(json['about']),
      website: JsonParsingUtils.safeString(json['website']),
      bseCode: JsonParsingUtils.safeString(json['bseCode']) ??
          JsonParsingUtils.safeString(json['bse_code']),
      nseCode: JsonParsingUtils.safeString(json['nseCode']) ??
          JsonParsingUtils.safeString(json['nse_code']),
      marketCap: JsonParsingUtils.safeDouble(json['marketCap']) ??
          JsonParsingUtils.safeDouble(json['market_cap']),
      currentPrice: JsonParsingUtils.safeDouble(json['currentPrice']) ??
          JsonParsingUtils.safeDouble(json['current_price']),
      highLow: JsonParsingUtils.safeString(json['highLow']) ??
          JsonParsingUtils.safeString(json['high_low']),
      stockPe: JsonParsingUtils.safeDouble(json['stockPe']) ??
          JsonParsingUtils.safeDouble(json['stock_pe']),
      bookValue: JsonParsingUtils.safeDouble(json['bookValue']) ??
          JsonParsingUtils.safeDouble(json['book_value']),
      dividendYield: JsonParsingUtils.safeDouble(json['dividendYield']) ??
          JsonParsingUtils.safeDouble(json['dividend_yield']),
      roce: JsonParsingUtils.safeDouble(json['roce']),
      roe: JsonParsingUtils.safeDouble(json['roe']),
      faceValue: JsonParsingUtils.safeDouble(json['faceValue']) ??
          JsonParsingUtils.safeDouble(json['face_value']),
      pros: JsonParsingUtils.safeStringList(json['pros']) ?? [],
      cons: JsonParsingUtils.safeStringList(json['cons']) ?? [],
      createdAt: JsonParsingUtils.safeDateTime(json['createdAt']) ??
          JsonParsingUtils.safeDateTime(json['created_at']),
      updatedAt: JsonParsingUtils.safeDateTime(json['updatedAt']) ??
          JsonParsingUtils.safeDateTime(json['updated_at']),
      lastUpdated: JsonParsingUtils.safeString(json['lastUpdated']) ??
          JsonParsingUtils.safeString(json['last_updated']) ??
          DateTime.now().toIso8601String(),
      changePercent: JsonParsingUtils.safeDouble(json['changePercent']) ??
          JsonParsingUtils.safeDouble(json['change_percent']) ??
          0.0,
      changeAmount: JsonParsingUtils.safeDouble(json['changeAmount']) ??
          JsonParsingUtils.safeDouble(json['change_amount']) ??
          0.0,
      previousClose: JsonParsingUtils.safeDouble(json['previousClose']) ??
          JsonParsingUtils.safeDouble(json['previous_close']) ??
          0.0,
      quarterlyResults: _parseFinancialDataModel(
          json['quarterlyResults'] ?? json['quarterly_results']),
      profitLossStatement: _parseFinancialDataModel(
          json['profitLossStatement'] ?? json['profit_loss_statement']),
      balanceSheet: _parseFinancialDataModel(
          json['balanceSheet'] ?? json['balance_sheet']),
      cashFlowStatement: _parseFinancialDataModel(
          json['cashFlowStatement'] ?? json['cash_flow_statement']),
      ratios: _parseFinancialDataModel(json['ratios']),
      debtToEquity: JsonParsingUtils.safeDouble(json['debtToEquity']) ??
          JsonParsingUtils.safeDouble(json['debt_to_equity']),
      currentRatio: JsonParsingUtils.safeDouble(json['currentRatio']) ??
          JsonParsingUtils.safeDouble(json['current_ratio']),
      quickRatio: JsonParsingUtils.safeDouble(json['quickRatio']) ??
          JsonParsingUtils.safeDouble(json['quick_ratio']),
      workingCapitalDays:
          JsonParsingUtils.safeDouble(json['workingCapitalDays']) ??
              JsonParsingUtils.safeDouble(json['working_capital_days']),
      debtorDays: JsonParsingUtils.safeDouble(json['debtorDays']) ??
          JsonParsingUtils.safeDouble(json['debtor_days']),
      inventoryDays: JsonParsingUtils.safeDouble(json['inventoryDays']) ??
          JsonParsingUtils.safeDouble(json['inventory_days']),
      cashConversionCycle:
          JsonParsingUtils.safeDouble(json['cashConversionCycle']) ??
              JsonParsingUtils.safeDouble(json['cash_conversion_cycle']),
      interestCoverage: JsonParsingUtils.safeDouble(json['interestCoverage']) ??
          JsonParsingUtils.safeDouble(json['interest_coverage']),
      assetTurnover: JsonParsingUtils.safeDouble(json['assetTurnover']) ??
          JsonParsingUtils.safeDouble(json['asset_turnover']),
      inventoryTurnover:
          JsonParsingUtils.safeDouble(json['inventoryTurnover']) ??
              JsonParsingUtils.safeDouble(json['inventory_turnover']),
      receivablesTurnover:
          JsonParsingUtils.safeDouble(json['receivablesTurnover']) ??
              JsonParsingUtils.safeDouble(json['receivables_turnover']),
      payablesTurnover: JsonParsingUtils.safeDouble(json['payablesTurnover']) ??
          JsonParsingUtils.safeDouble(json['payables_turnover']),
      workingCapital: JsonParsingUtils.safeDouble(json['workingCapital']) ??
          JsonParsingUtils.safeDouble(json['working_capital']),
      enterpriseValue: JsonParsingUtils.safeDouble(json['enterpriseValue']) ??
          JsonParsingUtils.safeDouble(json['enterprise_value']),
      evEbitda: JsonParsingUtils.safeDouble(json['evEbitda']) ??
          JsonParsingUtils.safeDouble(json['ev_ebitda']),
      priceToBook: JsonParsingUtils.safeDouble(json['priceToBook']) ??
          JsonParsingUtils.safeDouble(json['price_to_book']),
      priceToSales: JsonParsingUtils.safeDouble(json['priceToSales']) ??
          JsonParsingUtils.safeDouble(json['price_to_sales']),
      pegRatio: JsonParsingUtils.safeDouble(json['pegRatio']) ??
          JsonParsingUtils.safeDouble(json['peg_ratio']),
      betaValue: JsonParsingUtils.safeDouble(json['betaValue']) ??
          JsonParsingUtils.safeDouble(json['beta_value']),
      salesGrowth1Y: JsonParsingUtils.safeDouble(json['salesGrowth1Y']) ??
          JsonParsingUtils.safeDouble(json['sales_growth_1y']),
      salesGrowth3Y: JsonParsingUtils.safeDouble(json['salesGrowth3Y']) ??
          JsonParsingUtils.safeDouble(json['sales_growth_3y']),
      salesGrowth5Y: JsonParsingUtils.safeDouble(json['salesGrowth5Y']) ??
          JsonParsingUtils.safeDouble(json['sales_growth_5y']),
      profitGrowth1Y: JsonParsingUtils.safeDouble(json['profitGrowth1Y']) ??
          JsonParsingUtils.safeDouble(json['profit_growth_1y']),
      profitGrowth3Y: JsonParsingUtils.safeDouble(json['profitGrowth3Y']) ??
          JsonParsingUtils.safeDouble(json['profit_growth_3y']),
      profitGrowth5Y: JsonParsingUtils.safeDouble(json['profitGrowth5Y']) ??
          JsonParsingUtils.safeDouble(json['profit_growth_5y']),
      salesCAGR3Y: JsonParsingUtils.safeDouble(json['salesCAGR3Y']) ??
          JsonParsingUtils.safeDouble(json['sales_cagr_3y']),
      salesCAGR5Y: JsonParsingUtils.safeDouble(json['salesCAGR5Y']) ??
          JsonParsingUtils.safeDouble(json['sales_cagr_5y']),
      profitCAGR3Y: JsonParsingUtils.safeDouble(json['profitCAGR3Y']) ??
          JsonParsingUtils.safeDouble(json['profit_cagr_3y']),
      profitCAGR5Y: JsonParsingUtils.safeDouble(json['profitCAGR5Y']) ??
          JsonParsingUtils.safeDouble(json['profit_cagr_5y']),
      businessOverview: JsonParsingUtils.safeString(json['businessOverview']) ??
          JsonParsingUtils.safeString(json['business_overview']) ??
          '',
      sector: JsonParsingUtils.safeString(json['sector']),
      industry: JsonParsingUtils.safeString(json['industry']),
      industryClassification: JsonParsingUtils.safeStringList(
              json['industryClassification']) ??
          JsonParsingUtils.safeStringList(json['industry_classification']) ??
          [],
      recentPerformance: JsonParsingUtils.safeMap(json['recentPerformance']) ??
          JsonParsingUtils.safeMap(json['recent_performance']),
      keyMilestones:
          _parseKeyMilestones(json['keyMilestones'] ?? json['key_milestones']),
      investmentHighlights: _parseInvestmentHighlights(
          json['investmentHighlights'] ?? json['investment_highlights']),
      financialSummary: _parseFinancialSummary(
          json['financialSummary'] ?? json['financial_summary']),
      qualityScore: JsonParsingUtils.safeInt(json['qualityScore']) ??
          JsonParsingUtils.safeInt(json['quality_score']) ??
          3,
      overallQualityGrade:
          JsonParsingUtils.safeString(json['overallQualityGrade']) ??
              JsonParsingUtils.safeString(json['overall_quality_grade']) ??
              'C',
      workingCapitalEfficiency:
          JsonParsingUtils.safeString(json['workingCapitalEfficiency']) ??
              JsonParsingUtils.safeString(json['working_capital_efficiency']) ??
              'Unknown',
      cashCycleEfficiency:
          JsonParsingUtils.safeString(json['cashCycleEfficiency']) ??
              JsonParsingUtils.safeString(json['cash_cycle_efficiency']) ??
              'Unknown',
      liquidityStatus: JsonParsingUtils.safeString(json['liquidityStatus']) ??
          JsonParsingUtils.safeString(json['liquidity_status']) ??
          'Unknown',
      debtStatus: JsonParsingUtils.safeString(json['debtStatus']) ??
          JsonParsingUtils.safeString(json['debt_status']) ??
          'Unknown',
      riskLevel: JsonParsingUtils.safeString(json['riskLevel']) ??
          JsonParsingUtils.safeString(json['risk_level']) ??
          'Medium',
      piotroskiScore: JsonParsingUtils.safeDouble(json['piotroskiScore']) ??
          JsonParsingUtils.safeDouble(json['piotroski_score']),
      altmanZScore: JsonParsingUtils.safeDouble(json['altmanZScore']) ??
          JsonParsingUtils.safeDouble(json['altman_z_score']),
      qualityGrade: JsonParsingUtils.safeString(json['qualityGrade']) ??
          JsonParsingUtils.safeString(json['quality_grade']),
      creditRating: JsonParsingUtils.safeString(json['creditRating']) ??
          JsonParsingUtils.safeString(json['credit_rating']),
      grahamNumber: JsonParsingUtils.safeDouble(json['grahamNumber']) ??
          JsonParsingUtils.safeDouble(json['graham_number']),
      roic: JsonParsingUtils.safeDouble(json['roic']),
      fcfYield: JsonParsingUtils.safeDouble(json['fcfYield']) ??
          JsonParsingUtils.safeDouble(json['fcf_yield']),
      debtServiceCoverage:
          JsonParsingUtils.safeDouble(json['debtServiceCoverage']) ??
              JsonParsingUtils.safeDouble(json['debt_service_coverage']),
      comprehensiveScore:
          JsonParsingUtils.safeDouble(json['comprehensiveScore']) ??
              JsonParsingUtils.safeDouble(json['comprehensive_score']),
      investmentRecommendation:
          JsonParsingUtils.safeString(json['investmentRecommendation']) ??
              JsonParsingUtils.safeString(json['investment_recommendation']),
      ratiosData: JsonParsingUtils.safeMap(json['ratiosData']) ??
          JsonParsingUtils.safeMap(json['ratios_data']),
      growthTables:
          _parseGrowthTables(json['growthTables'] ?? json['growth_tables']),
      quarterlyDataHistory: _parseQuarterlyDataList(
          json['quarterlyDataHistory'] ?? json['quarterly_data_history']),
      annualDataHistory: _parseAnnualDataList(
          json['annualDataHistory'] ?? json['annual_data_history']),
      peerCompanies: JsonParsingUtils.safeStringList(json['peerCompanies']) ??
          JsonParsingUtils.safeStringList(json['peer_companies']) ??
          [],
      sectorPE: JsonParsingUtils.safeDouble(json['sectorPE']) ??
          JsonParsingUtils.safeDouble(json['sector_pe']),
      sectorROE: JsonParsingUtils.safeDouble(json['sectorROE']) ??
          JsonParsingUtils.safeDouble(json['sector_roe']),
      sectorDebtToEquity:
          JsonParsingUtils.safeDouble(json['sectorDebtToEquity']) ??
              JsonParsingUtils.safeDouble(json['sector_debt_to_equity']),
      dividendPerShare: JsonParsingUtils.safeDouble(json['dividendPerShare']) ??
          JsonParsingUtils.safeDouble(json['dividend_per_share']),
      dividendFrequency:
          JsonParsingUtils.safeString(json['dividendFrequency']) ??
              JsonParsingUtils.safeString(json['dividend_frequency']),
      dividendHistory: _parseDividendHistoryList(
          json['dividendHistory'] ?? json['dividend_history']),
      keyManagement: JsonParsingUtils.safeStringList(json['keyManagement']) ??
          JsonParsingUtils.safeStringList(json['key_management']) ??
          [],
      promoterHolding: JsonParsingUtils.safeDouble(json['promoterHolding']) ??
          JsonParsingUtils.safeDouble(json['promoter_holding']),
      institutionalHolding:
          JsonParsingUtils.safeDouble(json['institutionalHolding']) ??
              JsonParsingUtils.safeDouble(json['institutional_holding']),
      publicHolding: JsonParsingUtils.safeDouble(json['publicHolding']) ??
          JsonParsingUtils.safeDouble(json['public_holding']),
      volatility30D: JsonParsingUtils.safeDouble(json['volatility30D']) ??
          JsonParsingUtils.safeDouble(json['volatility_30d']),
      volatility1Y: JsonParsingUtils.safeDouble(json['volatility1Y']) ??
          JsonParsingUtils.safeDouble(json['volatility_1y']),
      maxDrawdown: JsonParsingUtils.safeDouble(json['maxDrawdown']) ??
          JsonParsingUtils.safeDouble(json['max_drawdown']),
      sharpeRatio: JsonParsingUtils.safeDouble(json['sharpeRatio']) ??
          JsonParsingUtils.safeDouble(json['sharpe_ratio']),
      marketCapCategory:
          JsonParsingUtils.safeDouble(json['marketCapCategory']) ??
              JsonParsingUtils.safeDouble(json['market_cap_category']),
      isIndexConstituent:
          JsonParsingUtils.safeBool(json['isIndexConstituent']) ??
              JsonParsingUtils.safeBool(json['is_index_constituent']),
      indices: JsonParsingUtils.safeStringList(json['indices']) ?? [],
      rsi: JsonParsingUtils.safeDouble(json['rsi']),
      sma50: JsonParsingUtils.safeDouble(json['sma50']),
      sma200: JsonParsingUtils.safeDouble(json['sma200']),
      ema12: JsonParsingUtils.safeDouble(json['ema12']),
      ema26: JsonParsingUtils.safeDouble(json['ema26']),
      isDebtFree: JsonParsingUtils.safeBool(json['isDebtFree']) ??
          JsonParsingUtils.safeBool(json['is_debt_free']) ??
          false,
      isProfitable: JsonParsingUtils.safeBool(json['isProfitable']) ??
          JsonParsingUtils.safeBool(json['is_profitable']) ??
          false,
      hasConsistentProfits:
          JsonParsingUtils.safeBool(json['hasConsistentProfits']) ??
              JsonParsingUtils.safeBool(json['has_consistent_profits']) ??
              false,
      paysDividends: JsonParsingUtils.safeBool(json['paysDividends']) ??
          JsonParsingUtils.safeBool(json['pays_dividends']) ??
          false,
      isGrowthStock: JsonParsingUtils.safeBool(json['isGrowthStock']) ??
          JsonParsingUtils.safeBool(json['is_growth_stock']) ??
          false,
      isValueStock: JsonParsingUtils.safeBool(json['isValueStock']) ??
          JsonParsingUtils.safeBool(json['is_value_stock']) ??
          false,
      isQualityStock: JsonParsingUtils.safeBool(json['isQualityStock']) ??
          JsonParsingUtils.safeBool(json['is_quality_stock']) ??
          false,
    );
  }

  // ============================================================================
  // MANUAL JSON SERIALIZATION
  // ============================================================================

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'name': name,
      'displayName': displayName,
      'about': about,
      'website': website,
      'bseCode': bseCode,
      'nseCode': nseCode,
      'marketCap': marketCap,
      'currentPrice': currentPrice,
      'highLow': highLow,
      'stockPe': stockPe,
      'bookValue': bookValue,
      'dividendYield': dividendYield,
      'roce': roce,
      'roe': roe,
      'faceValue': faceValue,
      'pros': pros,
      'cons': cons,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'lastUpdated': lastUpdated,
      'changePercent': changePercent,
      'changeAmount': changeAmount,
      'previousClose': previousClose,
      'quarterlyResults': quarterlyResults?.toJson(),
      'profitLossStatement': profitLossStatement?.toJson(),
      'balanceSheet': balanceSheet?.toJson(),
      'cashFlowStatement': cashFlowStatement?.toJson(),
      'ratios': ratios?.toJson(),
      'debtToEquity': debtToEquity,
      'currentRatio': currentRatio,
      'quickRatio': quickRatio,
      'workingCapitalDays': workingCapitalDays,
      'debtorDays': debtorDays,
      'inventoryDays': inventoryDays,
      'cashConversionCycle': cashConversionCycle,
      'interestCoverage': interestCoverage,
      'assetTurnover': assetTurnover,
      'inventoryTurnover': inventoryTurnover,
      'receivablesTurnover': receivablesTurnover,
      'payablesTurnover': payablesTurnover,
      'workingCapital': workingCapital,
      'enterpriseValue': enterpriseValue,
      'evEbitda': evEbitda,
      'priceToBook': priceToBook,
      'priceToSales': priceToSales,
      'pegRatio': pegRatio,
      'betaValue': betaValue,
      'salesGrowth1Y': salesGrowth1Y,
      'salesGrowth3Y': salesGrowth3Y,
      'salesGrowth5Y': salesGrowth5Y,
      'profitGrowth1Y': profitGrowth1Y,
      'profitGrowth3Y': profitGrowth3Y,
      'profitGrowth5Y': profitGrowth5Y,
      'salesCAGR3Y': salesCAGR3Y,
      'salesCAGR5Y': salesCAGR5Y,
      'profitCAGR3Y': profitCAGR3Y,
      'profitCAGR5Y': profitCAGR5Y,
      'businessOverview': businessOverview,
      'sector': sector,
      'industry': industry,
      'industryClassification': industryClassification,
      'recentPerformance': recentPerformance,
      'keyMilestones': keyMilestones.map((k) => k.toJson()).toList(),
      'investmentHighlights':
          investmentHighlights.map((i) => i.toJson()).toList(),
      'financialSummary': financialSummary.map((f) => f.toJson()).toList(),
      'qualityScore': qualityScore,
      'overallQualityGrade': overallQualityGrade,
      'workingCapitalEfficiency': workingCapitalEfficiency,
      'cashCycleEfficiency': cashCycleEfficiency,
      'liquidityStatus': liquidityStatus,
      'debtStatus': debtStatus,
      'riskLevel': riskLevel,
      'piotroskiScore': piotroskiScore,
      'altmanZScore': altmanZScore,
      'qualityGrade': qualityGrade,
      'creditRating': creditRating,
      'grahamNumber': grahamNumber,
      'roic': roic,
      'fcfYield': fcfYield,
      'debtServiceCoverage': debtServiceCoverage,
      'comprehensiveScore': comprehensiveScore,
      'investmentRecommendation': investmentRecommendation,
      'ratiosData': ratiosData,
      'growthTables': growthTables,
      'quarterlyDataHistory':
          quarterlyDataHistory.map((q) => q.toJson()).toList(),
      'annualDataHistory': annualDataHistory.map((a) => a.toJson()).toList(),
      'peerCompanies': peerCompanies,
      'sectorPE': sectorPE,
      'sectorROE': sectorROE,
      'sectorDebtToEquity': sectorDebtToEquity,
      'dividendPerShare': dividendPerShare,
      'dividendFrequency': dividendFrequency,
      'dividendHistory': dividendHistory.map((d) => d.toJson()).toList(),
      'keyManagement': keyManagement,
      'promoterHolding': promoterHolding,
      'institutionalHolding': institutionalHolding,
      'publicHolding': publicHolding,
      'volatility30D': volatility30D,
      'volatility1Y': volatility1Y,
      'maxDrawdown': maxDrawdown,
      'sharpeRatio': sharpeRatio,
      'marketCapCategory': marketCapCategory,
      'isIndexConstituent': isIndexConstituent,
      'indices': indices,
      'rsi': rsi,
      'sma50': sma50,
      'sma200': sma200,
      'ema12': ema12,
      'ema26': ema26,
      'isDebtFree': isDebtFree,
      'isProfitable': isProfitable,
      'hasConsistentProfits': hasConsistentProfits,
      'paysDividends': paysDividends,
      'isGrowthStock': isGrowthStock,
      'isValueStock': isValueStock,
      'isQualityStock': isQualityStock,
    };
  }

  // ============================================================================
  // FIRESTORE FACTORY
  // ============================================================================

  factory CompanyModel.fromFirestore(DocumentSnapshot doc) {
    try {
      final rawData = doc.data();
      if (rawData == null) {
        throw Exception('Document data is null for ${doc.id}');
      }

      final dataMap = rawData is Map
          ? Map<String, dynamic>.from(rawData)
          : <String, dynamic>{};

      // Add the document ID as symbol
      dataMap['symbol'] = doc.id;

      return CompanyModel.fromJson(dataMap);
    } catch (e, stack) {
      debugPrint('🔥 Error parsing company ${doc.id}: $e\n$stack');

      // Return a safe fallback company model
      return CompanyModel(
        symbol: doc.id,
        name: 'Unknown Company',
        displayName: 'Unknown Company',
        lastUpdated: DateTime.now().toIso8601String(),
      );
    }
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('symbol'); // Remove symbol as it's the document ID
    return json;
  }

  // ============================================================================
  // HELPER PARSING METHODS
  // ============================================================================

  static FinancialDataModel? _parseFinancialDataModel(dynamic data) {
    if (data == null) return null;
    try {
      if (data is FinancialDataModel) return data;
      if (data is Map<String, dynamic>) {
        return FinancialDataModel.fromJson(data);
      }
      return null;
    } catch (e) {
      debugPrint('Error parsing FinancialDataModel: $e');
      return null;
    }
  }

  static List<KeyMilestone> _parseKeyMilestones(dynamic data) {
    if (data == null) return [];
    try {
      if (data is List) {
        return data
            .map((item) {
              if (item is KeyMilestone) return item;
              if (item is Map<String, dynamic>) {
                return KeyMilestone.fromJson(item);
              }
              return null;
            })
            .where((item) => item != null)
            .cast<KeyMilestone>()
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error parsing key milestones: $e');
      return [];
    }
  }

  static List<InvestmentHighlight> _parseInvestmentHighlights(dynamic data) {
    if (data == null) return [];
    try {
      if (data is List) {
        return data
            .map((item) {
              if (item is InvestmentHighlight) return item;
              if (item is Map<String, dynamic>) {
                return InvestmentHighlight.fromJson(item);
              }
              return null;
            })
            .where((item) => item != null)
            .cast<InvestmentHighlight>()
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error parsing investment highlights: $e');
      return [];
    }
  }

  static List<FinancialSummary> _parseFinancialSummary(dynamic data) {
    if (data == null) return [];
    try {
      if (data is List) {
        return data
            .map((item) {
              if (item is FinancialSummary) return item;
              if (item is Map<String, dynamic>) {
                return FinancialSummary.fromJson(item);
              }
              return null;
            })
            .where((item) => item != null)
            .cast<FinancialSummary>()
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error parsing financial summary: $e');
      return [];
    }
  }

  static Map<String, Map<String, String>> _parseGrowthTables(dynamic data) {
    try {
      if (data is Map<String, Map<String, String>>) return data;
      if (data is Map) {
        final result = <String, Map<String, String>>{};
        data.forEach((key, value) {
          if (value is Map<String, String>) {
            result[key.toString()] = value;
          } else if (value is Map) {
            result[key.toString()] = Map<String, String>.from(value);
          }
        });
        return result;
      }
      return {};
    } catch (e) {
      debugPrint('Error parsing growth tables: $e');
      return {};
    }
  }

  static List<QuarterlyData> _parseQuarterlyDataList(dynamic data) {
    if (data == null) return [];
    try {
      if (data is List) {
        return data
            .map((item) {
              if (item is QuarterlyData) return item;
              if (item is Map<String, dynamic>) {
                return QuarterlyData.fromJson(item);
              }
              return null;
            })
            .where((item) => item != null)
            .cast<QuarterlyData>()
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error parsing quarterly data list: $e');
      return [];
    }
  }

  static List<AnnualData> _parseAnnualDataList(dynamic data) {
    if (data == null) return [];
    try {
      if (data is List) {
        return data
            .map((item) {
              if (item is AnnualData) return item;
              if (item is Map<String, dynamic>) {
                return AnnualData.fromJson(item);
              }
              return null;
            })
            .where((item) => item != null)
            .cast<AnnualData>()
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error parsing annual data list: $e');
      return [];
    }
  }

  static List<DividendHistory> _parseDividendHistoryList(dynamic data) {
    if (data == null) return [];
    try {
      if (data is List) {
        return data
            .map((item) {
              if (item is DividendHistory) return item;
              if (item is Map<String, dynamic>) {
                return DividendHistory.fromJson(item);
              }
              return null;
            })
            .where((item) => item != null)
            .cast<DividendHistory>()
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error parsing dividend history list: $e');
      return [];
    }
  }

  // ============================================================================
  // COMPUTED PROPERTIES AND METHODS
  // ============================================================================

  bool get isGainer => changePercent > 0;
  bool get isLoser => changePercent < 0;

  String get formattedPrice {
    return currentPrice != null
        ? '₹${currentPrice!.toStringAsFixed(2)}'
        : 'N/A';
  }

  String get formattedChange {
    if (changePercent == 0.0) return '0.00%';
    return '${changePercent > 0 ? '+' : ''}${changePercent.toStringAsFixed(2)}%';
  }

  String get formattedMarketCap {
    if (marketCap == null) return 'N/A';
    if (marketCap! >= 100000)
      return '₹${(marketCap! / 100000).toStringAsFixed(1)}L Cr';
    if (marketCap! >= 1000)
      return '₹${(marketCap! / 1000).toStringAsFixed(1)}K Cr';
    return '₹${marketCap!.toStringAsFixed(0)} Cr';
  }

  String get marketCapCategoryText {
    if (marketCap == null) return 'Unknown';
    if (marketCap! >= 20000) return 'Large Cap';
    if (marketCap! >= 5000) return 'Mid Cap';
    return 'Small Cap';
  }

  String get formattedLastUpdated {
    try {
      final date = DateTime.parse(lastUpdated);
      final diff = DateTime.now().difference(date);
      if (diff.inDays > 0) return '${diff.inDays}d ago';
      if (diff.inHours > 0) return '${diff.inHours}h ago';
      return '${diff.inMinutes}m ago';
    } catch (e) {
      return 'Unknown';
    }
  }

  String get formattedBusinessOverview {
    if (businessOverview.isEmpty) {
      return '$name operates in the ${sector ?? "various"} sector'
          '${industry != null ? ", specifically in $industry" : ""}. '
          'With a market capitalization of $formattedMarketCap, '
          'the company is classified as a ${marketCapCategoryText.toLowerCase()} entity.';
    }
    return businessOverview;
  }

  String get formattedSector => sector ?? 'Unknown Sector';
  String get formattedIndustry => industry ?? 'Unknown Industry';

  double get calculatedPiotroskiScore {
    if (piotroskiScore != null) return piotroskiScore!;

    double score = 0;

    if (roe != null && roe! > 0) score += 1;
    if (currentRatio != null && currentRatio! > 1.5) score += 1;

    if (annualDataHistory.isNotEmpty && annualDataHistory.length > 1) {
      final current = annualDataHistory[0];
      final previous = annualDataHistory[1];

      if (current.operatingCashFlow != null && current.netProfit != null) {
        if (current.operatingCashFlow! > current.netProfit!) score += 1;
      }

      if (current.roe != null && previous.roe != null) {
        if (current.roe! > previous.roe!) score += 1;
      }
    }

    if (debtToEquity != null && debtToEquity! < 0.3) score += 1;
    if (currentRatio != null && currentRatio! > 1.5) score += 1;
    if (assetTurnover != null && assetTurnover! > 0.8) score += 1;
    if (workingCapitalDays != null && workingCapitalDays! < 60) score += 1;

    return score;
  }

  double get calculatedAltmanZScore {
    if (altmanZScore != null) return altmanZScore!;
    if (annualDataHistory.isEmpty) return 0;

    final latest = annualDataHistory.first;
    if (latest.totalAssets == null || latest.totalAssets! <= 0) return 0;

    double score = 0;
    final totalAssets = latest.totalAssets!;

    if (latest.workingCapital != null) {
      score += (latest.workingCapital! / totalAssets) * 1.2;
    }

    if (latest.shareholdersEquity != null) {
      score += (latest.shareholdersEquity! / totalAssets) * 1.4;
    }

    if (latest.ebitda != null) {
      score += (latest.ebitda! / totalAssets) * 3.3;
    }

    if (latest.totalLiabilities != null && marketCap != null) {
      score += (marketCap! / latest.totalLiabilities!) * 0.6;
    }

    if (latest.sales != null) {
      score += (latest.sales! / totalAssets) * 1.0;
    }

    return score;
  }

  double? get calculatedGrahamNumber {
    if (grahamNumber != null) return grahamNumber;
    if (bookValue == null || annualDataHistory.isEmpty) return null;

    final latest = annualDataHistory.first;
    if (latest.eps == null || latest.eps! <= 0) return null;

    return sqrt(22.5 * latest.eps! * bookValue!);
  }

  double? get calculatedPEGRatio {
    if (pegRatio != null) return pegRatio;
    if (stockPe == null || profitGrowth3Y == null) return null;
    if (profitGrowth3Y! <= 0) return null;

    return stockPe! / profitGrowth3Y!;
  }

  double? get calculatedROIC {
    if (roic != null) return roic;
    if (annualDataHistory.isEmpty) return null;

    final latest = annualDataHistory.first;
    if (latest.ebitda == null ||
        latest.totalAssets == null ||
        latest.totalLiabilities == null) {
      return null;
    }

    final investedCapital = latest.totalAssets! - latest.totalLiabilities!;
    if (investedCapital <= 0) return null;

    return (latest.ebitda! / investedCapital) * 100;
  }

  double? get calculatedFCFYield {
    if (fcfYield != null) return fcfYield;
    if (marketCap == null || annualDataHistory.isEmpty) return null;

    final latest = annualDataHistory.first;
    if (latest.freeCashFlow == null) return null;

    return (latest.freeCashFlow! / marketCap!) * 100;
  }

  double get calculatedComprehensiveScore {
    if (comprehensiveScore != null) return comprehensiveScore!;

    double totalScore = 0;
    int criteria = 0;

    if (roe != null) {
      if (roe! > 20)
        totalScore += 25;
      else if (roe! > 15)
        totalScore += 20;
      else if (roe! > 10)
        totalScore += 15;
      else if (roe! > 5) totalScore += 10;
      criteria++;
    }

    if (debtToEquity != null) {
      if (debtToEquity! < 0.1)
        totalScore += 25;
      else if (debtToEquity! < 0.3)
        totalScore += 20;
      else if (debtToEquity! < 0.6)
        totalScore += 15;
      else if (debtToEquity! < 1.0) totalScore += 10;
      criteria++;
    }

    if (salesGrowth3Y != null && profitGrowth3Y != null) {
      final avgGrowth = (salesGrowth3Y! + profitGrowth3Y!) / 2;
      if (avgGrowth > 25)
        totalScore += 25;
      else if (avgGrowth > 15)
        totalScore += 20;
      else if (avgGrowth > 10)
        totalScore += 15;
      else if (avgGrowth > 5) totalScore += 10;
      criteria++;
    }

    if (stockPe != null) {
      if (stockPe! < 10)
        totalScore += 25;
      else if (stockPe! < 15)
        totalScore += 20;
      else if (stockPe! < 20)
        totalScore += 15;
      else if (stockPe! < 30) totalScore += 10;
      criteria++;
    }

    return criteria > 0 ? totalScore / criteria : 0;
  }

  String get calculatedRiskAssessment {
    int riskFactors = 0;

    if (debtToEquity != null && debtToEquity! > 1.0) riskFactors++;
    if (currentRatio != null && currentRatio! < 1.0) riskFactors++;
    if (roe != null && roe! < 5) riskFactors++;
    if (interestCoverage != null && interestCoverage! < 2.5) riskFactors++;
    if (stockPe != null && stockPe! > 40) riskFactors++;

    if (riskFactors >= 4) return 'Very High';
    if (riskFactors >= 3) return 'High';
    if (riskFactors >= 2) return 'Medium';
    if (riskFactors >= 1) return 'Low';
    return 'Very Low';
  }

  String get calculatedInvestmentGrade {
    final score = calculatedComprehensiveScore;
    final piotroski = calculatedPiotroskiScore;

    if (score > 80 && piotroski > 7) return 'AAA';
    if (score > 70 && piotroski > 6) return 'AA';
    if (score > 60 && piotroski > 5) return 'A';
    if (score > 50 && piotroski > 4) return 'BBB';
    if (score > 40 && piotroski > 3) return 'BB';
    if (score > 30 && piotroski > 2) return 'B';
    return 'C';
  }

  double? get safetyMargin {
    final intrinsic = calculatedGrahamNumber;
    if (intrinsic == null || currentPrice == null || currentPrice! <= 0) {
      return null;
    }

    return ((intrinsic - currentPrice!) / intrinsic) * 100;
  }

  String get calculatedInvestmentRecommendation {
    if (investmentRecommendation != null) return investmentRecommendation!;

    final qualityScore = calculatedComprehensiveScore;
    final piotroskiScore = calculatedPiotroskiScore;
    final riskLevel = calculatedRiskAssessment;

    if (qualityScore > 80 && piotroskiScore > 7 && riskLevel == 'Low') {
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
  }

  bool matchesFundamentalFilter(FundamentalType type) {
    switch (type) {
      case FundamentalType.debtFree:
        return isDebtFree || (debtToEquity != null && debtToEquity! < 0.1);
      case FundamentalType.highROE:
        return roe != null && roe! > 15.0;
      case FundamentalType.lowPE:
        return stockPe != null && stockPe! < 20.0 && stockPe! > 0;
      case FundamentalType.dividendStocks:
        return paysDividends || (dividendYield != null && dividendYield! > 2.0);
      case FundamentalType.growthStocks:
        return isGrowthStock ||
            (salesGrowth3Y != null && salesGrowth3Y! > 15.0) ||
            (profitGrowth3Y != null && profitGrowth3Y! > 15.0);
      case FundamentalType.valueStocks:
        return isValueStock || (stockPe != null && stockPe! < 15.0);
      case FundamentalType.largeCap:
        return marketCap != null && marketCap! > 20000;
      case FundamentalType.midCap:
        return marketCap != null && marketCap! >= 5000 && marketCap! <= 20000;
      case FundamentalType.smallCap:
        return marketCap != null && marketCap! < 5000;
      case FundamentalType.profitableStocks:
        return isProfitable || (roe != null && roe! > 0);
      case FundamentalType.highSalesGrowth:
        return salesGrowth3Y != null && salesGrowth3Y! > 20.0;
      case FundamentalType.qualityStocks:
        return isQualityStock || calculatedComprehensiveScore >= 60;
      case FundamentalType.momentumStocks:
        return (salesGrowth1Y != null && salesGrowth1Y! > 20.0) ||
            (profitGrowth1Y != null && profitGrowth1Y! > 20.0);
      case FundamentalType.contrarian:
        return changePercent < -10.0 &&
            (roe != null && roe! > 10.0) &&
            calculatedComprehensiveScore >= 40;
      default:
        return false;
    }
  }

  bool matchesSearchQuery(String query) {
    if (query.isEmpty) return true;
    final queryLower = query.toLowerCase();
    return name.toLowerCase().contains(queryLower) ||
        symbol.toLowerCase().contains(queryLower) ||
        displayName.toLowerCase().contains(queryLower) ||
        (sector?.toLowerCase().contains(queryLower) ?? false) ||
        (industry?.toLowerCase().contains(queryLower) ?? false);
  }
}
