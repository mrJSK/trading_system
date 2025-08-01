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
    // Safety & Quality Filters
    FundamentalFilter(
      type: FundamentalType.debtFree,
      title: 'Debt Free',
      description: 'Companies with minimal or zero debt',
      icon: Icons.shield_outlined,
      criteria: {'debtToEquity': 0.1},
      color: Colors.green,
    ),
    FundamentalFilter(
      type: FundamentalType.qualityStocks,
      title: 'Quality Stocks',
      description: 'High-quality companies with strong fundamentals',
      icon: Icons.star_outlined,
      criteria: {'qualityScore': 3, 'roe': 12.0, 'debtToEquity': 0.5},
      color: Colors.blue,
    ),
    FundamentalFilter(
      type: FundamentalType.strongBalance,
      title: 'Strong Balance',
      description: 'Companies with healthy balance sheets',
      icon: Icons.account_balance,
      criteria: {
        'currentRatio': 1.5,
        'debtToEquity': 0.3,
        'interestCoverage': 5.0
      },
      color: Colors.teal,
    ),

    // Profitability Filters
    FundamentalFilter(
      type: FundamentalType.highROE,
      title: 'High ROE',
      description: 'Return on Equity > 15%',
      icon: Icons.trending_up,
      criteria: {'roe': 15.0},
      color: Colors.purple,
    ),
    FundamentalFilter(
      type: FundamentalType.profitableStocks,
      title: 'Consistently Profitable',
      description: 'Companies with consistent profits',
      icon: Icons.trending_up_outlined,
      criteria: {'isProfitable': true, 'hasConsistentProfits': true},
      color: Colors.indigo,
    ),
    FundamentalFilter(
      type: FundamentalType.consistentProfits,
      title: 'Profit Consistency',
      description: 'Stable earnings over multiple years',
      icon: Icons.timeline,
      criteria: {'hasConsistentProfits': true, 'profitGrowth3Y': 0.0},
      color: Colors.cyan,
    ),

    // Growth Filters
    FundamentalFilter(
      type: FundamentalType.growthStocks,
      title: 'Growth Stocks',
      description: 'High revenue and profit growth',
      icon: Icons.rocket_launch,
      criteria: {'salesGrowth3Y': 15.0, 'profitGrowth3Y': 15.0},
      color: Colors.orange,
    ),
    FundamentalFilter(
      type: FundamentalType.highSalesGrowth,
      title: 'High Sales Growth',
      description: 'Strong revenue growth companies',
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

    // Value Filters
    FundamentalFilter(
      type: FundamentalType.lowPE,
      title: 'Low P/E',
      description: 'P/E Ratio < 15',
      icon: Icons.price_check,
      criteria: {'stockPe': 15.0},
      color: Colors.brown,
    ),
    FundamentalFilter(
      type: FundamentalType.valueStocks,
      title: 'Value Stocks',
      description: 'Undervalued companies with good fundamentals',
      icon: Icons.diamond_outlined,
      criteria: {'stockPe': 12.0, 'priceToBook': 1.5, 'roe': 10.0},
      color: Colors.amber,
    ),
    FundamentalFilter(
      type: FundamentalType.undervalued,
      title: 'Undervalued',
      description: 'Trading below intrinsic value',
      icon: Icons.local_offer,
      criteria: {'stockPe': 10.0, 'priceToBook': 1.0},
      color: Colors.lime,
    ),

    // Income & Dividend Filters
    FundamentalFilter(
      type: FundamentalType.dividendStocks,
      title: 'Dividend Stocks',
      description: 'Regular dividend paying companies',
      icon: Icons.account_balance_wallet,
      criteria: {'paysDividends': true, 'dividendYield': 2.0},
      color: Colors.lightBlue,
    ),
    FundamentalFilter(
      type: FundamentalType.highDividendYield,
      title: 'High Dividend Yield',
      description: 'Dividend yield > 4%',
      icon: Icons.savings,
      criteria: {'dividendYield': 4.0, 'paysDividends': true},
      color: Colors.lightGreen,
    ),

    // Market Cap Filters
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

    // Risk & Volatility Filters
    FundamentalFilter(
      type: FundamentalType.lowVolatility,
      title: 'Low Volatility',
      description: 'Stable stock price movements',
      icon: Icons.waves,
      criteria: {'volatility1Y': 25.0, 'betaValue': 1.0},
      color: Colors.grey,
    ),
    FundamentalFilter(
      type: FundamentalType.contrarian,
      title: 'Contrarian Picks',
      description: 'Temporarily underperforming quality stocks',
      icon: Icons.trending_down,
      criteria: {'changePercent': -10.0, 'roe': 10.0, 'qualityScore': 2},
      color: Colors.deepPurple,
    ),
  ];

  // Helper method to get filters by category
  static List<FundamentalFilter> getFiltersByCategory(FilterCategory category) {
    switch (category) {
      case FilterCategory.quality:
        return defaultFilters
            .where((f) => [
                  FundamentalType.debtFree,
                  FundamentalType.qualityStocks,
                  FundamentalType.strongBalance,
                  FundamentalType.consistentProfits,
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
                ].contains(f.type))
            .toList();
    }
  }

  // Get popular/recommended filters
  static List<FundamentalFilter> getPopularFilters() {
    return defaultFilters
        .where((f) => [
              FundamentalType.debtFree,
              FundamentalType.highROE,
              FundamentalType.growthStocks,
              FundamentalType.dividendStocks,
              FundamentalType.largeCap,
              FundamentalType.qualityStocks,
            ].contains(f.type))
        .toList();
  }

  // Search filters by name or description
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

enum FilterCategory {
  quality,
  growth,
  value,
  income,
  marketCap,
  risk,
}

// Extension to get human-readable category names
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
    }
  }
}
