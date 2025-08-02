// models/fundamental_filter.dart
import 'package:flutter/material.dart';

enum FundamentalType {
  // Safety & Quality Filters
  debtFree,
  qualityStocks,
  strongBalance,
  consistentProfits,

  // Profitability Filters
  highROE,
  profitableStocks,

  // Growth Filters
  growthStocks,
  highSalesGrowth,
  momentumStocks,

  // Value Filters
  lowPE,
  valueStocks,
  undervalued,

  // Income & Dividend Filters
  dividendStocks,
  highDividendYield,

  // Market Cap Filters
  largeCap,
  midCap,
  smallCap,

  // Risk & Volatility Filters
  lowVolatility,
  contrarian,

  // Enhanced Working Capital & Efficiency Filters
  workingCapitalEfficient,
  cashEfficientStocks,
  highLiquidityStocks,
  debtFreeQuality,

  // NEW: Business Insights & Enhanced Quality Filters
  businessInsightRich,
  recentMilestones,
  comprehensiveAnalysis,
  qualityWithGrowth,
  sustainableBusiness,
  innovativeCompanies,
  marketLeaders,
  emergingOpportunities,
}

class FundamentalFilter {
  final FundamentalType type;
  final String title;
  final String description;
  final IconData icon;
  final Map<String, dynamic> criteria;
  final Color? color;
  final FilterCategory category;
  final bool isPremium;

  const FundamentalFilter({
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.criteria,
    required this.category,
    this.color,
    this.isPremium = false,
  });

  static List<FundamentalFilter> defaultFilters = [
    // ========================================================================
    // ENHANCED SAFETY & QUALITY FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.debtFree,
      title: 'Debt Free',
      description: 'Companies with minimal or zero debt (Debt-to-Equity < 0.1)',
      icon: Icons.shield_outlined,
      criteria: {'debtToEquity': 0.1, 'roe': 0.0, 'qualityScore': 2},
      category: FilterCategory.quality,
      color: Colors.green,
    ),

    FundamentalFilter(
      type: FundamentalType.qualityStocks,
      title: 'Quality Stocks',
      description:
          'High-quality companies with strong fundamentals and A/B grades',
      icon: Icons.star_outlined,
      criteria: {
        'qualityScore': 3,
        'roe': 12.0,
        'debtToEquity': 0.5,
        'currentRatio': 1.5,
        'overallQualityGrade': ['A', 'B']
      },
      category: FilterCategory.quality,
      color: Colors.blue,
    ),

    FundamentalFilter(
      type: FundamentalType.strongBalance,
      title: 'Strong Balance Sheet',
      description:
          'Companies with healthy balance sheets and excellent liquidity',
      icon: Icons.account_balance,
      criteria: {
        'currentRatio': 1.5,
        'debtToEquity': 0.3,
        'interestCoverage': 5.0,
        'workingCapitalDays': 60,
        'liquidityStatus': 'Excellent'
      },
      category: FilterCategory.quality,
      color: Colors.teal,
    ),

    FundamentalFilter(
      type: FundamentalType.consistentProfits,
      title: 'Profit Consistency',
      description:
          'Stable earnings over multiple years with quality fundamentals',
      icon: Icons.timeline,
      criteria: {
        'hasConsistentProfits': true,
        'profitGrowth3Y': 0.0,
        'currentRatio': 1.2,
        'qualityScore': 2,
        'riskLevel': 'Low'
      },
      category: FilterCategory.quality,
      color: Colors.cyan,
    ),

    // ========================================================================
    // ENHANCED WORKING CAPITAL & EFFICIENCY FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.workingCapitalEfficient,
      title: 'Working Capital Efficient',
      description:
          'Companies with excellent working capital management (< 45 days)',
      icon: Icons.access_time,
      criteria: {
        'workingCapitalDays': 45,
        'currentRatio': 1.5,
        'cashConversionCycle': 60,
        'workingCapitalEfficiency': 'Excellent'
      },
      category: FilterCategory.efficiency,
      color: Colors.lightBlue,
    ),

    FundamentalFilter(
      type: FundamentalType.cashEfficientStocks,
      title: 'Cash Efficient',
      description:
          'Companies with efficient cash conversion and cycle management',
      icon: Icons.monetization_on,
      criteria: {
        'cashConversionCycle': 60,
        'debtorDays': 60,
        'inventoryDays': 90,
        'currentRatio': 1.2,
        'cashCycleEfficiency': 'Good'
      },
      category: FilterCategory.efficiency,
      color: Colors.amber,
    ),

    FundamentalFilter(
      type: FundamentalType.highLiquidityStocks,
      title: 'High Liquidity',
      description:
          'Companies with excellent liquidity ratios and cash position',
      icon: Icons.water_drop,
      criteria: {
        'currentRatio': 2.0,
        'quickRatio': 1.5,
        'debtToEquity': 0.4,
        'liquidityStatus': 'Excellent'
      },
      category: FilterCategory.efficiency,
      color: Colors.cyan,
    ),

    FundamentalFilter(
      type: FundamentalType.debtFreeQuality,
      title: 'Debt-Free Quality',
      description: 'Debt-free companies with high quality scores and A grades',
      icon: Icons.verified_outlined,
      criteria: {
        'debtToEquity': 0.05,
        'qualityScore': 4,
        'roe': 15.0,
        'currentRatio': 1.8,
        'overallQualityGrade': 'A',
        'debtStatus': 'Debt Free'
      },
      category: FilterCategory.quality,
      color: Colors.purpleAccent,
    ),

    // ========================================================================
    // NEW: BUSINESS INSIGHTS & ENHANCED QUALITY FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.businessInsightRich,
      title: 'Business Insight Rich',
      description:
          'Companies with comprehensive business overviews and investment highlights',
      icon: Icons.insights,
      criteria: {
        'businessOverview': true,
        'investmentHighlights': 2,
        'qualityScore': 2,
        'industryClassification': 1
      },
      category: FilterCategory.insights,
      color: Colors.deepPurple,
      isPremium: true,
    ),

    FundamentalFilter(
      type: FundamentalType.recentMilestones,
      title: 'Recent Milestones',
      description: 'Companies with recent key milestones and positive momentum',
      icon: Icons.timeline,
      criteria: {
        'keyMilestones': 1,
        'recentPerformance': 'positive',
        'changePercent': 0.0,
        'qualityScore': 2
      },
      category: FilterCategory.insights,
      color: Colors.orange,
      isPremium: true,
    ),

    FundamentalFilter(
      type: FundamentalType.comprehensiveAnalysis,
      title: 'Comprehensive Analysis',
      description:
          'Companies with detailed pros/cons analysis and business insights',
      icon: Icons.analytics,
      criteria: {
        'pros': 2,
        'cons': 1,
        'businessOverview': true,
        'qualityScore': 3,
        'investmentHighlights': 1
      },
      category: FilterCategory.insights,
      color: Colors.indigo,
      isPremium: true,
    ),

    FundamentalFilter(
      type: FundamentalType.qualityWithGrowth,
      title: 'Quality + Growth',
      description: 'High-quality companies with strong growth prospects',
      icon: Icons.rocket_launch,
      criteria: {
        'qualityScore': 3,
        'salesGrowth3Y': 15.0,
        'profitGrowth3Y': 15.0,
        'roe': 15.0,
        'overallQualityGrade': ['A', 'B']
      },
      category: FilterCategory.growth,
      color: Colors.green,
    ),

    FundamentalFilter(
      type: FundamentalType.sustainableBusiness,
      title: 'Sustainable Business',
      description: 'Companies with sustainable business models and low risk',
      icon: Icons.eco,
      criteria: {
        'qualityScore': 3,
        'riskLevel': 'Low',
        'debtToEquity': 0.3,
        'roe': 12.0,
        'businessOverview': true
      },
      category: FilterCategory.quality,
      color: Colors.lightGreen,
    ),

    FundamentalFilter(
      type: FundamentalType.innovativeCompanies,
      title: 'Innovative Companies',
      description:
          'Companies showing innovation and strong investment highlights',
      icon: Icons.lightbulb,
      criteria: {
        'investmentHighlights': 3,
        'salesGrowth3Y': 10.0,
        'qualityScore': 2,
        'marketCapCategory': 'Mid Cap'
      },
      category: FilterCategory.growth,
      color: Colors.purple,
      isPremium: true,
    ),

    FundamentalFilter(
      type: FundamentalType.marketLeaders,
      title: 'Market Leaders',
      description: 'Large-cap companies with market leadership and quality',
      icon: Icons.emoji_events,
      criteria: {
        'marketCap': 20000,
        'qualityScore': 3,
        'roe': 12.0,
        'overallQualityGrade': ['A', 'B'],
        'businessOverview': true
      },
      category: FilterCategory.quality,
      color: Colors.amber,
    ),

    FundamentalFilter(
      type: FundamentalType.emergingOpportunities,
      title: 'Emerging Opportunities',
      description: 'Small to mid-cap companies with high growth potential',
      icon: Icons.trending_up,
      criteria: {
        'marketCapMax': 10000,
        'salesGrowth3Y': 20.0,
        'qualityScore': 2,
        'investmentHighlights': 1,
        'riskLevel': ['Low', 'Medium']
      },
      category: FilterCategory.growth,
      color: Colors.teal,
    ),

    // ========================================================================
    // ENHANCED PROFITABILITY FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.highROE,
      title: 'High ROE',
      description: 'Return on Equity > 15% with excellent quality metrics',
      icon: Icons.trending_up,
      criteria: {
        'roe': 15.0,
        'currentRatio': 1.0,
        'qualityScore': 2,
        'overallQualityGrade': ['A', 'B', 'C']
      },
      category: FilterCategory.profitability,
      color: Colors.purple,
    ),

    FundamentalFilter(
      type: FundamentalType.profitableStocks,
      title: 'Consistently Profitable',
      description: 'Companies with consistent profits and quality fundamentals',
      icon: Icons.trending_up_outlined,
      criteria: {
        'isProfitable': true,
        'hasConsistentProfits': true,
        'currentRatio': 1.0,
        'qualityScore': 2,
        'riskLevel': ['Low', 'Medium']
      },
      category: FilterCategory.profitability,
      color: Colors.indigo,
    ),

    // ========================================================================
    // ENHANCED GROWTH FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.growthStocks,
      title: 'Growth Stocks',
      description: 'High revenue and profit growth with quality fundamentals',
      icon: Icons.rocket_launch,
      criteria: {
        'salesGrowth3Y': 15.0,
        'profitGrowth3Y': 15.0,
        'qualityScore': 2
      },
      category: FilterCategory.growth,
      color: Colors.orange,
    ),

    FundamentalFilter(
      type: FundamentalType.highSalesGrowth,
      title: 'High Sales Growth',
      description:
          'Strong revenue growth companies (> 20%) with quality metrics',
      icon: Icons.show_chart,
      criteria: {'salesGrowth3Y': 20.0, 'qualityScore': 1, 'currentRatio': 1.0},
      category: FilterCategory.growth,
      color: Colors.deepOrange,
    ),

    FundamentalFilter(
      type: FundamentalType.momentumStocks,
      title: 'Momentum Stocks',
      description: 'Strong price and earnings momentum with positive trends',
      icon: Icons.speed,
      criteria: {
        'salesGrowth1Y': 20.0,
        'profitGrowth1Y': 20.0,
        'recentPerformance': 'positive'
      },
      category: FilterCategory.growth,
      color: Colors.red,
    ),

    // ========================================================================
    // ENHANCED VALUE FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.lowPE,
      title: 'Low P/E',
      description: 'P/E Ratio < 15 with positive ROE and quality metrics',
      icon: Icons.price_check,
      criteria: {'stockPe': 15.0, 'roe': 5.0, 'qualityScore': 1},
      category: FilterCategory.value,
      color: Colors.brown,
    ),

    FundamentalFilter(
      type: FundamentalType.valueStocks,
      title: 'Value Stocks',
      description: 'Undervalued companies with strong fundamentals and quality',
      icon: Icons.diamond_outlined,
      criteria: {
        'stockPe': 12.0,
        'priceToBook': 1.5,
        'roe': 10.0,
        'currentRatio': 1.0,
        'qualityScore': 2
      },
      category: FilterCategory.value,
      color: Colors.amber,
    ),

    FundamentalFilter(
      type: FundamentalType.undervalued,
      title: 'Undervalued',
      description:
          'Trading below intrinsic value with excellent quality grades',
      icon: Icons.local_offer,
      criteria: {
        'stockPe': 10.0,
        'priceToBook': 1.0,
        'qualityScore': 2,
        'overallQualityGrade': ['A', 'B']
      },
      category: FilterCategory.value,
      color: Colors.lime,
    ),

    // ========================================================================
    // ENHANCED INCOME & DIVIDEND FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.dividendStocks,
      title: 'Dividend Stocks',
      description: 'Regular dividend paying companies with excellent liquidity',
      icon: Icons.account_balance_wallet,
      criteria: {
        'paysDividends': true,
        'dividendYield': 1.0,
        'currentRatio': 1.2,
        'debtStatus': ['Low Debt', 'Debt Free']
      },
      category: FilterCategory.income,
      color: Colors.lightBlue,
    ),

    FundamentalFilter(
      type: FundamentalType.highDividendYield,
      title: 'High Dividend Yield',
      description: 'Dividend yield > 4% with low debt and quality fundamentals',
      icon: Icons.savings,
      criteria: {
        'dividendYield': 4.0,
        'paysDividends': true,
        'debtToEquity': 0.6,
        'qualityScore': 2
      },
      category: FilterCategory.income,
      color: Colors.lightGreen,
    ),

    // ========================================================================
    // MARKET CAP FILTERS (Enhanced with quality integration)
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.largeCap,
      title: 'Large Cap',
      description: 'Market Cap > ₹20,000 Cr with quality fundamentals',
      icon: Icons.business,
      criteria: {'marketCap': 20000, 'qualityScore': 1},
      category: FilterCategory.marketCap,
      color: Colors.blue,
    ),

    FundamentalFilter(
      type: FundamentalType.midCap,
      title: 'Mid Cap',
      description: 'Market Cap ₹5,000-20,000 Cr with growth potential',
      icon: Icons.business_center,
      criteria: {
        'marketCapMin': 5000,
        'marketCapMax': 20000,
        'qualityScore': 1
      },
      category: FilterCategory.marketCap,
      color: Colors.orange,
    ),

    FundamentalFilter(
      type: FundamentalType.smallCap,
      title: 'Small Cap',
      description: 'Market Cap < ₹5,000 Cr with quality metrics',
      icon: Icons.store,
      criteria: {'marketCapMax': 5000, 'qualityScore': 1, 'currentRatio': 1.0},
      category: FilterCategory.marketCap,
      color: Colors.purple,
    ),

    // ========================================================================
    // ENHANCED RISK & VOLATILITY FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.lowVolatility,
      title: 'Low Volatility',
      description: 'Stable movements with low risk and excellent liquidity',
      icon: Icons.waves,
      criteria: {
        'riskLevel': 'Low',
        'roe': 10.0,
        'marketCap': 5000,
        'currentRatio': 1.5,
        'qualityScore': 2
      },
      category: FilterCategory.risk,
      color: Colors.grey,
    ),

    FundamentalFilter(
      type: FundamentalType.contrarian,
      title: 'Contrarian Picks',
      description: 'Temporarily underperforming quality stocks with potential',
      icon: Icons.trending_down,
      criteria: {
        'changePercent': -5.0,
        'roe': 10.0,
        'qualityScore': 2,
        'currentRatio': 1.0,
        'riskLevel': ['Low', 'Medium']
      },
      category: FilterCategory.value,
      color: Colors.deepPurple,
    ),
  ];

  // ============================================================================
  // ENHANCED CATEGORY FILTERS WITH NEW CATEGORIES
  // ============================================================================

  static List<FundamentalFilter> getFiltersByCategory(FilterCategory category) {
    return defaultFilters.where((f) => f.category == category).toList();
  }

  // Enhanced popular filters with business insights
  static List<FundamentalFilter> getPopularFilters() {
    return defaultFilters
        .where((f) => [
              FundamentalType.debtFree,
              FundamentalType.highROE,
              FundamentalType.growthStocks,
              FundamentalType.dividendStocks,
              FundamentalType.largeCap,
              FundamentalType.qualityStocks,
              FundamentalType.workingCapitalEfficient,
              FundamentalType.businessInsightRich,
              FundamentalType.qualityWithGrowth,
            ].contains(f.type))
        .toList();
  }

  // Get premium filters (requiring business insights)
  static List<FundamentalFilter> getPremiumFilters() {
    return defaultFilters.where((f) => f.isPremium).toList();
  }

  // Get efficiency-focused filters
  static List<FundamentalFilter> getEfficiencyFilters() {
    return defaultFilters
        .where((f) => f.category == FilterCategory.efficiency)
        .toList();
  }

  // Get business insight filters
  static List<FundamentalFilter> getBusinessInsightFilters() {
    return defaultFilters
        .where((f) => f.category == FilterCategory.insights)
        .toList();
  }

  // Enhanced search filters
  static List<FundamentalFilter> searchFilters(String query) {
    final lowercaseQuery = query.toLowerCase();
    return defaultFilters
        .where((filter) =>
            filter.title.toLowerCase().contains(lowercaseQuery) ||
            filter.description.toLowerCase().contains(lowercaseQuery) ||
            filter.type.displayName.toLowerCase().contains(lowercaseQuery))
        .toList();
  }

  // Get filters by quality level
  static List<FundamentalFilter> getQualityFilters({int minQuality = 3}) {
    return defaultFilters
        .where((f) =>
            f.criteria['qualityScore'] != null &&
            f.criteria['qualityScore'] >= minQuality)
        .toList();
  }

  // Get recently added filters
  static List<FundamentalFilter> getRecentFilters() {
    return defaultFilters
        .where((f) => [
              FundamentalType.businessInsightRich,
              FundamentalType.recentMilestones,
              FundamentalType.comprehensiveAnalysis,
              FundamentalType.sustainableBusiness,
              FundamentalType.innovativeCompanies,
              FundamentalType.marketLeaders,
              FundamentalType.emergingOpportunities,
            ].contains(f.type))
        .toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FundamentalFilter && other.type == type;
  }

  @override
  int get hashCode => type.hashCode;

  @override
  String toString() => 'FundamentalFilter(${type.name}: $title)';
}

// ============================================================================
// ENHANCED FILTER CATEGORIES WITH NEW CATEGORIES
// ============================================================================

enum FilterCategory {
  quality,
  profitability,
  growth,
  value,
  income,
  marketCap,
  risk,
  efficiency,
  insights, // NEW: For business insights filters
}

// Enhanced extension with new categories
extension FilterCategoryExtension on FilterCategory {
  String get displayName {
    switch (this) {
      case FilterCategory.quality:
        return 'Quality & Safety';
      case FilterCategory.profitability:
        return 'Profitability';
      case FilterCategory.growth:
        return 'Growth';
      case FilterCategory.value:
        return 'Value';
      case FilterCategory.income:
        return 'Income';
      case FilterCategory.marketCap:
        return 'Market Cap';
      case FilterCategory.risk:
        return 'Low Risk';
      case FilterCategory.efficiency:
        return 'Efficiency';
      case FilterCategory.insights:
        return 'Business Insights';
    }
  }

  String get description {
    switch (this) {
      case FilterCategory.quality:
        return 'Companies with strong fundamentals, low debt, and quality metrics';
      case FilterCategory.profitability:
        return 'Companies with strong profit margins and consistent earnings';
      case FilterCategory.growth:
        return 'Companies showing strong revenue and profit growth';
      case FilterCategory.value:
        return 'Undervalued companies trading below intrinsic value';
      case FilterCategory.income:
        return 'Dividend-paying companies with regular income streams';
      case FilterCategory.marketCap:
        return 'Companies categorized by market capitalization size';
      case FilterCategory.risk:
        return 'Conservative investments with low volatility';
      case FilterCategory.efficiency:
        return 'Companies with efficient capital and working capital management';
      case FilterCategory.insights:
        return 'Companies with comprehensive business analysis and insights';
    }
  }

  IconData get icon {
    switch (this) {
      case FilterCategory.quality:
        return Icons.verified;
      case FilterCategory.profitability:
        return Icons.attach_money;
      case FilterCategory.growth:
        return Icons.trending_up;
      case FilterCategory.value:
        return Icons.local_offer;
      case FilterCategory.income:
        return Icons.account_balance_wallet;
      case FilterCategory.marketCap:
        return Icons.business;
      case FilterCategory.risk:
        return Icons.shield;
      case FilterCategory.efficiency:
        return Icons.speed;
      case FilterCategory.insights:
        return Icons.insights;
    }
  }

  Color get color {
    switch (this) {
      case FilterCategory.quality:
        return Colors.blue;
      case FilterCategory.profitability:
        return Colors.green;
      case FilterCategory.growth:
        return Colors.orange;
      case FilterCategory.value:
        return Colors.purple;
      case FilterCategory.income:
        return Colors.teal;
      case FilterCategory.marketCap:
        return Colors.indigo;
      case FilterCategory.risk:
        return Colors.grey;
      case FilterCategory.efficiency:
        return Colors.cyan;
      case FilterCategory.insights:
        return Colors.deepPurple;
    }
  }

  bool get isPremium {
    return this == FilterCategory.insights;
  }
}

// ============================================================================
// ENHANCED UTILITY EXTENSIONS
// ============================================================================

extension FundamentalTypeExtension on FundamentalType {
  String get displayName {
    switch (this) {
      case FundamentalType.workingCapitalEfficient:
        return 'Working Capital Efficient';
      case FundamentalType.cashEfficientStocks:
        return 'Cash Efficient';
      case FundamentalType.highLiquidityStocks:
        return 'High Liquidity';
      case FundamentalType.debtFreeQuality:
        return 'Debt-Free Quality';
      case FundamentalType.businessInsightRich:
        return 'Business Insight Rich';
      case FundamentalType.recentMilestones:
        return 'Recent Milestones';
      case FundamentalType.comprehensiveAnalysis:
        return 'Comprehensive Analysis';
      case FundamentalType.qualityWithGrowth:
        return 'Quality + Growth';
      case FundamentalType.sustainableBusiness:
        return 'Sustainable Business';
      case FundamentalType.innovativeCompanies:
        return 'Innovative Companies';
      case FundamentalType.marketLeaders:
        return 'Market Leaders';
      case FundamentalType.emergingOpportunities:
        return 'Emerging Opportunities';
      default:
        return name;
    }
  }

  bool get isEfficiencyFilter {
    return [
      FundamentalType.workingCapitalEfficient,
      FundamentalType.cashEfficientStocks,
      FundamentalType.highLiquidityStocks,
      FundamentalType.debtFreeQuality,
    ].contains(this);
  }

  bool get isBusinessInsightFilter {
    return [
      FundamentalType.businessInsightRich,
      FundamentalType.recentMilestones,
      FundamentalType.comprehensiveAnalysis,
      FundamentalType.sustainableBusiness,
      FundamentalType.innovativeCompanies,
      FundamentalType.marketLeaders,
      FundamentalType.emergingOpportunities,
    ].contains(this);
  }

  bool get isQualityFocused {
    return [
      FundamentalType.qualityStocks,
      FundamentalType.strongBalance,
      FundamentalType.debtFreeQuality,
      FundamentalType.qualityWithGrowth,
      FundamentalType.sustainableBusiness,
      FundamentalType.marketLeaders,
    ].contains(this);
  }

  bool get requiresBusinessData {
    return [
      FundamentalType.businessInsightRich,
      FundamentalType.comprehensiveAnalysis,
      FundamentalType.sustainableBusiness,
      FundamentalType.innovativeCompanies,
      FundamentalType.marketLeaders,
    ].contains(this);
  }

  FilterCategory get category {
    if (isEfficiencyFilter) return FilterCategory.efficiency;
    if (isBusinessInsightFilter) return FilterCategory.insights;

    switch (this) {
      case FundamentalType.debtFree:
      case FundamentalType.qualityStocks:
      case FundamentalType.strongBalance:
      case FundamentalType.consistentProfits:
      case FundamentalType.debtFreeQuality:
      case FundamentalType.sustainableBusiness:
      case FundamentalType.marketLeaders:
        return FilterCategory.quality;

      case FundamentalType.highROE:
      case FundamentalType.profitableStocks:
        return FilterCategory.profitability;

      case FundamentalType.growthStocks:
      case FundamentalType.highSalesGrowth:
      case FundamentalType.momentumStocks:
      case FundamentalType.qualityWithGrowth:
      case FundamentalType.innovativeCompanies:
      case FundamentalType.emergingOpportunities:
        return FilterCategory.growth;

      case FundamentalType.lowPE:
      case FundamentalType.valueStocks:
      case FundamentalType.undervalued:
      case FundamentalType.contrarian:
        return FilterCategory.value;

      case FundamentalType.dividendStocks:
      case FundamentalType.highDividendYield:
        return FilterCategory.income;

      case FundamentalType.largeCap:
      case FundamentalType.midCap:
      case FundamentalType.smallCap:
        return FilterCategory.marketCap;

      case FundamentalType.lowVolatility:
        return FilterCategory.risk;

      default:
        return FilterCategory.quality;
    }
  }
}

// ============================================================================
// FILTER UTILITY FUNCTIONS
// ============================================================================

class FilterUtils {
  static List<FundamentalFilter> getRecommendedFilters({
    required bool isNewUser,
    required bool hasBusinessInsights,
  }) {
    if (isNewUser) {
      return [
        ...FundamentalFilter.defaultFilters.where((f) => [
              FundamentalType.qualityStocks,
              FundamentalType.debtFree,
              FundamentalType.largeCap,
              FundamentalType.dividendStocks,
            ].contains(f.type)),
      ];
    }

    if (hasBusinessInsights) {
      return FundamentalFilter.getPremiumFilters();
    }

    return FundamentalFilter.getPopularFilters();
  }

  static List<FundamentalFilter> getFiltersForRiskProfile(String riskProfile) {
    switch (riskProfile.toLowerCase()) {
      case 'conservative':
        return FundamentalFilter.defaultFilters
            .where((f) => [
                  FundamentalType.debtFree,
                  FundamentalType.qualityStocks,
                  FundamentalType.largeCap,
                  FundamentalType.dividendStocks,
                  FundamentalType.lowVolatility,
                ].contains(f.type))
            .toList();

      case 'moderate':
        return FundamentalFilter.defaultFilters
            .where((f) => [
                  FundamentalType.qualityStocks,
                  FundamentalType.growthStocks,
                  FundamentalType.midCap,
                  FundamentalType.valueStocks,
                  FundamentalType.qualityWithGrowth,
                ].contains(f.type))
            .toList();

      case 'aggressive':
        return FundamentalFilter.defaultFilters
            .where((f) => [
                  FundamentalType.growthStocks,
                  FundamentalType.smallCap,
                  FundamentalType.momentumStocks,
                  FundamentalType.emergingOpportunities,
                  FundamentalType.innovativeCompanies,
                ].contains(f.type))
            .toList();

      default:
        return FundamentalFilter.getPopularFilters();
    }
  }

  static bool doesFilterRequireBusinessData(FundamentalType type) {
    return type.requiresBusinessData;
  }

  static String getFilterComplexityLevel(FundamentalType type) {
    if (type.isBusinessInsightFilter) return 'Advanced';
    if (type.isEfficiencyFilter) return 'Intermediate';
    if (type.isQualityFocused) return 'Beginner';
    return 'Intermediate';
  }
}
