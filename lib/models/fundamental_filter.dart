// models/fundamental_filter.dart
import 'package:flutter/material.dart';

enum FundamentalType {
  debtFree,
  highROE,
  lowPE,
  dividendStocks,
  growthStocks,
  valueStocks,
  smallCap,
  midCap,
  largeCap,
  profitableStocks,
  highSalesGrowth,
  qualityStocks,
  momentumStocks,
  contrarian,
  highDividendYield,
  lowVolatility,
  consistentProfits,
  strongBalance,
  undervalued,

  // NEW: Enhanced working capital and efficiency filters
  workingCapitalEfficient,
  cashEfficientStocks,
  highLiquidityStocks,
  debtFreeQuality,
}

class FundamentalFilter {
  final FundamentalType type;
  final String title;
  final String description;
  final IconData icon;
  final Map<String, dynamic> criteria;
  final Color? color;

  const FundamentalFilter({
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.criteria,
    this.color,
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
      criteria: {'debtToEquity': 0.1, 'roe': 0.0},
      color: Colors.green,
    ),

    FundamentalFilter(
      type: FundamentalType.qualityStocks,
      title: 'Quality Stocks',
      description:
          'High-quality companies with strong fundamentals and good ratios',
      icon: Icons.star_outlined,
      criteria: {
        'qualityScore': 3,
        'roe': 12.0,
        'debtToEquity': 0.5,
        'currentRatio': 1.5
      },
      color: Colors.blue,
    ),

    FundamentalFilter(
      type: FundamentalType.strongBalance,
      title: 'Strong Balance Sheet',
      description: 'Companies with healthy balance sheets and working capital',
      icon: Icons.account_balance,
      criteria: {
        'currentRatio': 1.5,
        'debtToEquity': 0.3,
        'interestCoverage': 5.0,
        'workingCapitalDays': 60
      },
      color: Colors.teal,
    ),

    // NEW: Enhanced working capital filters
    FundamentalFilter(
      type: FundamentalType.workingCapitalEfficient,
      title: 'Working Capital Efficient',
      description:
          'Companies with efficient working capital management (< 45 days)',
      icon: Icons.access_time,
      criteria: {
        'workingCapitalDays': 45,
        'currentRatio': 1.5,
        'cashConversionCycle': 60
      },
      color: Colors.lightBlue,
    ),

    FundamentalFilter(
      type: FundamentalType.cashEfficientStocks,
      title: 'Cash Efficient',
      description: 'Companies with efficient cash conversion cycle (< 60 days)',
      icon: Icons.monetization_on,
      criteria: {
        'cashConversionCycle': 60,
        'debtorDays': 60,
        'inventoryDays': 90,
        'currentRatio': 1.2
      },
      color: Colors.amber,
    ),

    FundamentalFilter(
      type: FundamentalType.highLiquidityStocks,
      title: 'High Liquidity',
      description: 'Companies with excellent liquidity ratios',
      icon: Icons.water_drop,
      criteria: {'currentRatio': 2.0, 'quickRatio': 1.5, 'debtToEquity': 0.4},
      color: Colors.cyan,
    ),

    FundamentalFilter(
      type: FundamentalType.debtFreeQuality,
      title: 'Debt-Free Quality',
      description: 'Debt-free companies with high quality scores',
      icon: Icons.verified_outlined,
      criteria: {
        'debtToEquity': 0.05,
        'qualityScore': 4,
        'roe': 15.0,
        'currentRatio': 1.8
      },
      color: Colors.purpleAccent,
    ),

    // ========================================================================
    // ENHANCED PROFITABILITY FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.highROE,
      title: 'High ROE',
      description: 'Return on Equity > 15% with good liquidity',
      icon: Icons.trending_up,
      criteria: {'roe': 15.0, 'currentRatio': 1.0},
      color: Colors.purple,
    ),

    FundamentalFilter(
      type: FundamentalType.profitableStocks,
      title: 'Consistently Profitable',
      description: 'Companies with consistent profits and good liquidity',
      icon: Icons.trending_up_outlined,
      criteria: {
        'isProfitable': true,
        'hasConsistentProfits': true,
        'currentRatio': 1.0
      },
      color: Colors.indigo,
    ),

    FundamentalFilter(
      type: FundamentalType.consistentProfits,
      title: 'Profit Consistency',
      description: 'Stable earnings over multiple years with good ratios',
      icon: Icons.timeline,
      criteria: {
        'hasConsistentProfits': true,
        'profitGrowth3Y': 0.0,
        'currentRatio': 1.2
      },
      color: Colors.cyan,
    ),

    // ========================================================================
    // ENHANCED GROWTH FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.growthStocks,
      title: 'Growth Stocks',
      description: 'High revenue and profit growth companies',
      icon: Icons.rocket_launch,
      criteria: {'salesGrowth3Y': 15.0, 'profitGrowth3Y': 15.0},
      color: Colors.orange,
    ),

    FundamentalFilter(
      type: FundamentalType.highSalesGrowth,
      title: 'High Sales Growth',
      description: 'Strong revenue growth companies (> 20%)',
      icon: Icons.show_chart,
      criteria: {'salesGrowth3Y': 20.0},
      color: Colors.deepOrange,
    ),

    FundamentalFilter(
      type: FundamentalType.momentumStocks,
      title: 'Momentum Stocks',
      description: 'Strong price and earnings momentum',
      icon: Icons.speed,
      criteria: {'salesGrowth1Y': 20.0, 'profitGrowth1Y': 20.0},
      color: Colors.red,
    ),

    // ========================================================================
    // ENHANCED VALUE FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.lowPE,
      title: 'Low P/E',
      description: 'P/E Ratio < 15 with positive ROE',
      icon: Icons.price_check,
      criteria: {'stockPe': 15.0, 'roe': 5.0},
      color: Colors.brown,
    ),

    FundamentalFilter(
      type: FundamentalType.valueStocks,
      title: 'Value Stocks',
      description: 'Undervalued companies with good fundamentals and liquidity',
      icon: Icons.diamond_outlined,
      criteria: {
        'stockPe': 12.0,
        'priceToBook': 1.5,
        'roe': 10.0,
        'currentRatio': 1.0
      },
      color: Colors.amber,
    ),

    FundamentalFilter(
      type: FundamentalType.undervalued,
      title: 'Undervalued',
      description: 'Trading below intrinsic value with quality metrics',
      icon: Icons.local_offer,
      criteria: {'stockPe': 10.0, 'priceToBook': 1.0, 'qualityScore': 2},
      color: Colors.lime,
    ),

    // ========================================================================
    // ENHANCED INCOME & DIVIDEND FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.dividendStocks,
      title: 'Dividend Stocks',
      description: 'Regular dividend paying companies with good liquidity',
      icon: Icons.account_balance_wallet,
      criteria: {
        'paysDividends': true,
        'dividendYield': 1.0,
        'currentRatio': 1.2
      },
      color: Colors.lightBlue,
    ),

    FundamentalFilter(
      type: FundamentalType.highDividendYield,
      title: 'High Dividend Yield',
      description: 'Dividend yield > 4% with low debt',
      icon: Icons.savings,
      criteria: {
        'dividendYield': 4.0,
        'paysDividends': true,
        'debtToEquity': 0.6
      },
      color: Colors.lightGreen,
    ),

    // ========================================================================
    // MARKET CAP FILTERS (unchanged)
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.largeCap,
      title: 'Large Cap',
      description: 'Market Cap > ₹20,000 Cr',
      icon: Icons.business,
      criteria: {'marketCap': 20000},
      color: Colors.blue,
    ),

    FundamentalFilter(
      type: FundamentalType.midCap,
      title: 'Mid Cap',
      description: 'Market Cap ₹5,000-20,000 Cr',
      icon: Icons.business_center,
      criteria: {'marketCapMin': 5000, 'marketCapMax': 20000},
      color: Colors.orange,
    ),

    FundamentalFilter(
      type: FundamentalType.smallCap,
      title: 'Small Cap',
      description: 'Market Cap < ₹5,000 Cr',
      icon: Icons.store,
      criteria: {'marketCapMax': 5000},
      color: Colors.purple,
    ),

    // ========================================================================
    // ENHANCED RISK & VOLATILITY FILTERS
    // ========================================================================

    FundamentalFilter(
      type: FundamentalType.lowVolatility,
      title: 'Low Volatility',
      description: 'Stable stock price movements with good liquidity',
      icon: Icons.waves,
      criteria: {'volatility1Y': 25.0, 'betaValue': 1.2, 'currentRatio': 1.5},
      color: Colors.grey,
    ),

    FundamentalFilter(
      type: FundamentalType.contrarian,
      title: 'Contrarian Picks',
      description:
          'Temporarily underperforming quality stocks with good ratios',
      icon: Icons.trending_down,
      criteria: {
        'changePercent': -5.0,
        'roe': 10.0,
        'qualityScore': 2,
        'currentRatio': 1.0
      },
      color: Colors.deepPurple,
    ),
  ];

  // ============================================================================
  // ENHANCED CATEGORY FILTERS WITH NEW WORKING CAPITAL FILTERS
  // ============================================================================

  static List<FundamentalFilter> getFiltersByCategory(FilterCategory category) {
    switch (category) {
      case FilterCategory.quality:
        return defaultFilters
            .where((f) => [
                  FundamentalType.debtFree,
                  FundamentalType.qualityStocks,
                  FundamentalType.strongBalance,
                  FundamentalType.consistentProfits,
                  FundamentalType.workingCapitalEfficient,
                  FundamentalType.cashEfficientStocks,
                  FundamentalType.highLiquidityStocks,
                  FundamentalType.debtFreeQuality,
                ].contains(f.type))
            .toList();

      case FilterCategory.growth:
        return defaultFilters
            .where((f) => [
                  FundamentalType.growthStocks,
                  FundamentalType.highSalesGrowth,
                  FundamentalType.momentumStocks,
                  FundamentalType.highROE,
                ].contains(f.type))
            .toList();

      case FilterCategory.value:
        return defaultFilters
            .where((f) => [
                  FundamentalType.lowPE,
                  FundamentalType.valueStocks,
                  FundamentalType.undervalued,
                  FundamentalType.contrarian,
                ].contains(f.type))
            .toList();

      case FilterCategory.income:
        return defaultFilters
            .where((f) => [
                  FundamentalType.dividendStocks,
                  FundamentalType.highDividendYield,
                ].contains(f.type))
            .toList();

      case FilterCategory.marketCap:
        return defaultFilters
            .where((f) => [
                  FundamentalType.largeCap,
                  FundamentalType.midCap,
                  FundamentalType.smallCap,
                ].contains(f.type))
            .toList();

      case FilterCategory.risk:
        return defaultFilters
            .where((f) => [
                  FundamentalType.lowVolatility,
                  FundamentalType.profitableStocks,
                  FundamentalType.strongBalance,
                  FundamentalType.highLiquidityStocks,
                ].contains(f.type))
            .toList();

      // NEW: Enhanced efficiency category
      case FilterCategory.efficiency:
        return defaultFilters
            .where((f) => [
                  FundamentalType.workingCapitalEfficient,
                  FundamentalType.cashEfficientStocks,
                  FundamentalType.highLiquidityStocks,
                  FundamentalType.debtFreeQuality,
                ].contains(f.type))
            .toList();
    }
  }

  // Enhanced popular filters with working capital efficient stocks
  static List<FundamentalFilter> getPopularFilters() {
    return defaultFilters
        .where((f) => [
              FundamentalType.debtFree,
              FundamentalType.highROE,
              FundamentalType.growthStocks,
              FundamentalType.dividendStocks,
              FundamentalType.largeCap,
              FundamentalType.qualityStocks,
              FundamentalType.workingCapitalEfficient, // NEW
            ].contains(f.type))
        .toList();
  }

  // Get efficiency-focused filters
  static List<FundamentalFilter> getEfficiencyFilters() {
    return defaultFilters
        .where((f) => [
              FundamentalType.workingCapitalEfficient,
              FundamentalType.cashEfficientStocks,
              FundamentalType.highLiquidityStocks,
              FundamentalType.debtFreeQuality,
            ].contains(f.type))
        .toList();
  }

  // Enhanced search filters
  static List<FundamentalFilter> searchFilters(String query) {
    final lowercaseQuery = query.toLowerCase();
    return defaultFilters
        .where((filter) =>
            filter.title.toLowerCase().contains(lowercaseQuery) ||
            filter.description.toLowerCase().contains(lowercaseQuery))
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
// ENHANCED FILTER CATEGORIES
// ============================================================================

enum FilterCategory {
  quality,
  growth,
  value,
  income,
  marketCap,
  risk,
  efficiency, // NEW: For working capital and efficiency filters
}

// Enhanced extension with new category
extension FilterCategoryExtension on FilterCategory {
  String get displayName {
    switch (this) {
      case FilterCategory.quality:
        return 'Quality & Safety';
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
        return 'Efficiency'; // NEW
    }
  }

  IconData get icon {
    switch (this) {
      case FilterCategory.quality:
        return Icons.verified;
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
        return Icons.speed; // NEW
    }
  }
}

// ============================================================================
// UTILITY EXTENSIONS
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
}
