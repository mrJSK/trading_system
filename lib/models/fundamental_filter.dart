import '../utils/json_parsing_utils.dart';

// ============================================================================
// FUNDAMENTAL FILTER MODEL WITH MANUAL SERIALIZATION
// ============================================================================

class FundamentalFilter {
  final FundamentalType type;
  final String name;
  final String description;
  final FilterCategory category;
  final List<String> tags;
  final String icon;
  final bool isPremium;
  final int minimumQualityScore;
  final Map<String, dynamic> criteria;
  final int difficulty; // 0=Beginner, 1=Intermediate, 2=Advanced
  final String explanation;
  final List<String> relatedFilters;
  final double successRate; // Historical success rate if available

  const FundamentalFilter({
    required this.type,
    required this.name,
    required this.description,
    required this.category,
    this.tags = const [],
    this.icon = '',
    this.isPremium = false,
    this.minimumQualityScore = 0,
    this.criteria = const {},
    this.difficulty = 0,
    this.explanation = '',
    this.relatedFilters = const [],
    this.successRate = 0.0,
  });

  // ============================================================================
  // MANUAL JSON SERIALIZATION
  // ============================================================================

  factory FundamentalFilter.fromJson(Map<String, dynamic> json) {
    return FundamentalFilter(
      type: _parseFilterType(json['type']),
      name: JsonParsingUtils.safeString(json['name']) ?? '',
      description: JsonParsingUtils.safeString(json['description']) ?? '',
      category: _parseFilterCategory(json['category']),
      tags: JsonParsingUtils.safeStringList(json['tags']) ?? [],
      icon: JsonParsingUtils.safeString(json['icon']) ?? '',
      isPremium: JsonParsingUtils.safeBool(json['isPremium']) ?? false,
      minimumQualityScore:
          JsonParsingUtils.safeInt(json['minimumQualityScore']) ?? 0,
      criteria: JsonParsingUtils.safeMap(json['criteria']),
      difficulty: JsonParsingUtils.safeInt(json['difficulty']) ?? 0,
      explanation: JsonParsingUtils.safeString(json['explanation']) ?? '',
      relatedFilters:
          JsonParsingUtils.safeStringList(json['relatedFilters']) ?? [],
      successRate: JsonParsingUtils.safeDouble(json['successRate']) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'name': name,
      'description': description,
      'category': category.name,
      'tags': tags,
      'icon': icon,
      'isPremium': isPremium,
      'minimumQualityScore': minimumQualityScore,
      'criteria': criteria,
      'difficulty': difficulty,
      'explanation': explanation,
      'relatedFilters': relatedFilters,
      'successRate': successRate,
    };
  }

  // Helper methods for parsing enums
  static FundamentalType _parseFilterType(dynamic value) {
    if (value == null) return FundamentalType.qualityStocks;
    if (value is FundamentalType) return value;
    if (value is String) {
      try {
        return FundamentalType.values.firstWhere(
          (type) => type.name == value,
          orElse: () => FundamentalType.qualityStocks,
        );
      } catch (e) {
        return FundamentalType.qualityStocks;
      }
    }
    return FundamentalType.qualityStocks;
  }

  static FilterCategory _parseFilterCategory(dynamic value) {
    if (value == null) return FilterCategory.quality;
    if (value is FilterCategory) return value;
    if (value is String) {
      try {
        return FilterCategory.values.firstWhere(
          (category) => category.name == value,
          orElse: () => FilterCategory.quality,
        );
      } catch (e) {
        return FilterCategory.quality;
      }
    }
    return FilterCategory.quality;
  }

  // ============================================================================
  // STATIC FILTER DATA
  // ============================================================================

  static List<FundamentalFilter> getAllFilters() {
    return [
      // ============================================================================
      // ENHANCED SAFETY & QUALITY FILTERS
      // ============================================================================

      const FundamentalFilter(
        type: FundamentalType.debtFree,
        name: 'Debt Free Companies',
        description: 'Companies with minimal or no debt (D/E < 0.1)',
        category: FilterCategory.quality,
        tags: ['safe', 'conservative', 'low-risk', 'warren-buffett'],
        icon: '🛡️',
        minimumQualityScore: 2,
        difficulty: 0,
        explanation:
            'Companies with low debt are generally safer investments as they have less financial risk and more flexibility during economic downturns.',
        criteria: {'debt_to_equity_max': '0.1', 'roe_min': '0'},
        relatedFilters: ['qualityStocks', 'altmanSafe'],
        successRate: 85.5,
      ),

      const FundamentalFilter(
        type: FundamentalType.qualityStocks,
        name: 'Quality Stocks',
        description:
            'High-quality companies with strong fundamentals (Quality Score ≥ 3)',
        category: FilterCategory.quality,
        tags: ['quality', 'fundamentals', 'reliable', 'blue-chip'],
        icon: '⭐',
        minimumQualityScore: 3,
        difficulty: 0,
        explanation:
            'Quality stocks combine profitability, financial stability, and growth. These are ideal for long-term investors seeking steady returns.',
        criteria: {
          'quality_score_min': '3',
          'roe_min': '12',
          'current_ratio_min': '1.5'
        },
        relatedFilters: ['debtFree', 'compoundingMachines'],
        successRate: 78.2,
      ),

      const FundamentalFilter(
        type: FundamentalType.strongBalance,
        name: 'Strong Balance Sheet',
        description:
            'Companies with excellent working capital and liquidity management',
        category: FilterCategory.quality,
        tags: ['balance-sheet', 'liquidity', 'efficient', 'financial-strength'],
        icon: '💪',
        minimumQualityScore: 2,
        difficulty: 1,
        explanation:
            'Strong balance sheets indicate good management and financial discipline, providing stability during market volatility.',
        criteria: {
          'current_ratio_min': '1.5',
          'working_capital_days_max': '60'
        },
        relatedFilters: ['workingCapitalEfficient', 'debtFree'],
        successRate: 72.8,
      ),

      const FundamentalFilter(
        type: FundamentalType.piotroskiHigh,
        name: 'High Piotroski Score',
        description: 'Companies with Piotroski F-Score ≥ 7 (Excellent Quality)',
        category: FilterCategory.quality,
        tags: ['piotroski', 'quality', 'fundamental-analysis', 'academic'],
        icon: '🏆',
        minimumQualityScore: 3,
        difficulty: 2,
        explanation:
            'Piotroski F-Score measures financial strength across 9 criteria. Scores ≥7 indicate exceptionally strong companies.',
        criteria: {'piotroski_score_min': '7'},
        relatedFilters: ['altmanSafe', 'compoundingMachines'],
        successRate: 89.3,
        isPremium: true,
      ),

      const FundamentalFilter(
        type: FundamentalType.altmanSafe,
        name: 'Altman Z-Score Safe',
        description: 'Companies with low bankruptcy risk (Altman Z > 3.0)',
        category: FilterCategory.quality,
        tags: ['altman', 'bankruptcy-risk', 'safe', 'financial-distress'],
        icon: '🛡️',
        minimumQualityScore: 2,
        difficulty: 2,
        explanation:
            'Altman Z-Score predicts bankruptcy probability. Scores >3.0 indicate very low bankruptcy risk within 2 years.',
        criteria: {'altman_z_score_min': '3.0'},
        relatedFilters: ['piotroskiHigh', 'debtFree'],
        successRate: 92.1,
        isPremium: true,
      ),

      const FundamentalFilter(
        type: FundamentalType.compoundingMachines,
        name: 'Compounding Machines',
        description: 'High-quality companies with consistent wealth creation',
        category: FilterCategory.quality,
        tags: ['compounding', 'wealth-creation', 'long-term', 'multibagger'],
        icon: '🔄',
        minimumQualityScore: 4,
        difficulty: 2,
        explanation:
            'Companies that reinvest profits efficiently to generate superior long-term returns through the power of compounding.',
        criteria: {
          'roe_min': '18',
          'roce_min': '18',
          'sales_growth_3y_min': '12',
          'debt_to_equity_max': '0.5'
        },
        relatedFilters: ['qualityStocks', 'highROIC'],
        successRate: 94.7,
        isPremium: true,
      ),

      // ============================================================================
      // ENHANCED PROFITABILITY FILTERS
      // ============================================================================

      const FundamentalFilter(
        type: FundamentalType.highROE,
        name: 'High ROE Stocks',
        description: 'Companies with excellent return on equity (ROE > 15%)',
        category: FilterCategory.profitability,
        tags: ['profitability', 'efficiency', 'returns', 'roe'],
        icon: '📈',
        minimumQualityScore: 2,
        difficulty: 0,
        explanation:
            'High ROE indicates efficient use of shareholders\' money to generate profits. ROE >15% is considered excellent.',
        criteria: {'roe_min': '15', 'roe_max': '100'},
        relatedFilters: ['highROIC', 'compoundingMachines'],
        successRate: 76.4,
      ),

      const FundamentalFilter(
        type: FundamentalType.profitableStocks,
        name: 'Consistently Profitable',
        description: 'Companies with consistent positive returns',
        category: FilterCategory.profitability,
        tags: ['profitable', 'consistent', 'stable', 'reliable'],
        icon: '💰',
        minimumQualityScore: 2,
        difficulty: 0,
        explanation:
            'Companies that consistently generate profits are more likely to weather economic downturns and provide steady returns.',
        criteria: {'roe_min': '0', 'current_ratio_min': '1.0'},
        relatedFilters: ['consistentProfits', 'qualityStocks'],
        successRate: 68.9,
      ),

      const FundamentalFilter(
        type: FundamentalType.consistentProfits,
        name: 'Consistent Profit Growth',
        description: 'Companies with steady profit growth over time',
        category: FilterCategory.profitability,
        tags: ['growth', 'consistent', 'reliable', 'predictable'],
        icon: '📊',
        minimumQualityScore: 2,
        difficulty: 1,
        explanation:
            'Steady profit growth indicates strong business models and management execution, leading to predictable returns.',
        criteria: {'roe_min': '12', 'quality_score_min': '2'},
        relatedFilters: ['profitableStocks', 'growthStocks'],
        successRate: 73.6,
      ),

      const FundamentalFilter(
        type: FundamentalType.highROIC,
        name: 'High ROIC Stocks',
        description:
            'Companies with excellent Return on Invested Capital (>20%)',
        category: FilterCategory.profitability,
        tags: ['roic', 'capital-efficiency', 'returns', 'warren-buffett'],
        icon: '💼',
        minimumQualityScore: 2,
        difficulty: 2,
        explanation:
            'ROIC measures how efficiently a company uses its capital. High ROIC indicates strong competitive advantages.',
        criteria: {'roic_min': '20'},
        relatedFilters: ['highROE', 'compoundingMachines'],
        successRate: 81.3,
        isPremium: true,
      ),

      const FundamentalFilter(
        type: FundamentalType.freeCashFlowRich,
        name: 'Free Cash Flow Rich',
        description: 'Companies generating strong free cash flows',
        category: FilterCategory.profitability,
        tags: ['free-cash-flow', 'cash-generation', 'quality', 'dividend'],
        icon: '💰',
        minimumQualityScore: 2,
        difficulty: 1,
        explanation:
            'Strong free cash flow provides flexibility for growth investments, debt reduction, and shareholder returns.',
        criteria: {'fcf_yield_min': '5', 'free_cash_flow_positive': 'true'},
        relatedFilters: ['dividendStocks', 'qualityStocks'],
        successRate: 79.8,
      ),

      // ============================================================================
      // ENHANCED GROWTH FILTERS
      // ============================================================================

      const FundamentalFilter(
        type: FundamentalType.growthStocks,
        name: 'Growth Stocks',
        description: 'High-growth companies with strong revenue expansion',
        category: FilterCategory.growth,
        tags: ['growth', 'expansion', 'potential', 'high-returns'],
        icon: '🚀',
        minimumQualityScore: 1,
        difficulty: 1,
        explanation:
            'Growth stocks prioritize revenue and earnings growth over dividends, often providing higher long-term returns.',
        criteria: {'sales_growth_3y_min': '15', 'sales_growth_3y_max': '200'},
        relatedFilters: ['highSalesGrowth', 'momentumStocks'],
        successRate: 71.2,
      ),

      const FundamentalFilter(
        type: FundamentalType.highSalesGrowth,
        name: 'High Sales Growth',
        description: 'Companies with exceptional revenue growth (>20%)',
        category: FilterCategory.growth,
        tags: ['revenue', 'expansion', 'fast-growing', 'emerging'],
        icon: '📈',
        difficulty: 1,
        explanation:
            'High sales growth indicates strong market demand and business expansion, but ensure it\'s sustainable.',
        criteria: {'sales_growth_3y_min': '20', 'sales_growth_3y_max': '200'},
        relatedFilters: ['growthStocks', 'momentumStocks'],
        successRate: 69.4,
      ),

      const FundamentalFilter(
        type: FundamentalType.momentumStocks,
        name: 'Momentum Stocks',
        description: 'Companies showing strong recent performance trends',
        category: FilterCategory.growth,
        tags: ['momentum', 'trending', 'performance', 'short-term'],
        icon: '⚡',
        difficulty: 2,
        explanation:
            'Momentum stocks show strong recent performance but can be volatile. Best for short to medium-term strategies.',
        criteria: {
          'profit_growth_3y_min': '20',
          'recent_performance': 'positive'
        },
        relatedFilters: ['growthStocks', 'highSalesGrowth'],
        successRate: 64.7,
      ),

      // ============================================================================
      // ENHANCED VALUE FILTERS
      // ============================================================================

      const FundamentalFilter(
        type: FundamentalType.lowPE,
        name: 'Low P/E Stocks',
        description: 'Potentially undervalued stocks with low P/E ratios',
        category: FilterCategory.value,
        tags: ['value', 'undervalued', 'pe-ratio', 'benjamin-graham'],
        icon: '💎',
        difficulty: 0,
        explanation:
            'Low P/E ratios may indicate undervaluation, but ensure the company has good fundamentals to avoid value traps.',
        criteria: {'stock_pe_max': '15', 'stock_pe_min': '0', 'roe_min': '10'},
        relatedFilters: ['valueStocks', 'undervalued'],
        successRate: 67.8,
      ),

      const FundamentalFilter(
        type: FundamentalType.valueStocks,
        name: 'Value Stocks',
        description: 'Undervalued companies with strong fundamentals',
        category: FilterCategory.value,
        tags: ['value', 'undervalued', 'bargain', 'warren-buffett'],
        icon: '🎯',
        minimumQualityScore: 2,
        difficulty: 1,
        explanation:
            'Classic value investing approach: buying quality companies at attractive prices for long-term wealth creation.',
        criteria: {
          'stock_pe_max': '12',
          'roe_min': '10',
          'quality_score_min': '2'
        },
        relatedFilters: ['lowPE', 'grahamValue'],
        successRate: 74.3,
      ),

      const FundamentalFilter(
        type: FundamentalType.undervalued,
        name: 'Deeply Undervalued',
        description: 'Significantly undervalued quality companies',
        category: FilterCategory.value,
        tags: ['deep-value', 'undervalued', 'opportunity', 'contrarian'],
        icon: '💰',
        minimumQualityScore: 2,
        difficulty: 2,
        explanation:
            'Deeply undervalued stocks offer significant upside potential but require patience and strong conviction.',
        criteria: {'stock_pe_max': '10', 'quality_score_min': '2'},
        relatedFilters: ['valueStocks', 'contrarian'],
        successRate: 76.9,
      ),

      const FundamentalFilter(
        type: FundamentalType.grahamValue,
        name: 'Graham Value Stocks',
        description: 'Stocks trading below their Graham Intrinsic Value',
        category: FilterCategory.value,
        tags: ['graham-number', 'intrinsic-value', 'undervalued', 'academic'],
        icon: '💎',
        minimumQualityScore: 2,
        difficulty: 2,
        explanation:
            'Based on Benjamin Graham\'s formula for intrinsic value. Stocks trading below this value may be undervalued.',
        criteria: {'graham_discount': 'true', 'safety_margin_min': '10'},
        relatedFilters: ['valueStocks', 'undervalued'],
        successRate: 82.4,
        isPremium: true,
      ),

      // ============================================================================
      // ENHANCED INCOME & DIVIDEND FILTERS
      // ============================================================================

      const FundamentalFilter(
        type: FundamentalType.dividendStocks,
        name: 'Dividend Paying Stocks',
        description: 'Companies that regularly pay dividends',
        category: FilterCategory.income,
        tags: ['dividend', 'income', 'regular-payout', 'passive-income'],
        icon: '💵',
        difficulty: 0,
        explanation:
            'Dividend stocks provide regular income and are often from mature, stable companies with predictable cash flows.',
        criteria: {'dividend_yield_min': '1.0', 'debt_status': 'Low Debt'},
        relatedFilters: ['highDividendYield', 'freeCashFlowRich'],
        successRate: 66.2,
      ),

      const FundamentalFilter(
        type: FundamentalType.highDividendYield,
        name: 'High Dividend Yield',
        description: 'Companies with attractive dividend yields (>4%)',
        category: FilterCategory.income,
        tags: ['high-yield', 'income', 'attractive-yield', 'retirees'],
        icon: '🎁',
        minimumQualityScore: 2,
        difficulty: 1,
        explanation:
            'High dividend yields provide attractive income but ensure the payout is sustainable and not a dividend trap.',
        criteria: {'dividend_yield_min': '4.0', 'quality_score_min': '2'},
        relatedFilters: ['dividendStocks', 'freeCashFlowRich'],
        successRate: 63.8,
      ),

      // ============================================================================
      // MARKET CAP FILTERS
      // ============================================================================

      const FundamentalFilter(
        type: FundamentalType.largeCap,
        name: 'Large Cap Stocks',
        description: 'Large capitalization companies (>₹20,000 Cr)',
        category: FilterCategory.marketCap,
        tags: ['large-cap', 'stable', 'established', 'blue-chip'],
        icon: '🏢',
        difficulty: 0,
        explanation:
            'Large-cap stocks are typically stable, established companies with lower volatility and steady growth.',
        criteria: {'market_cap_min': '20000'},
        relatedFilters: ['qualityStocks', 'dividendStocks'],
        successRate: 65.4,
      ),

      const FundamentalFilter(
        type: FundamentalType.midCap,
        name: 'Mid Cap Stocks',
        description: 'Mid capitalization companies (₹5,000-20,000 Cr)',
        category: FilterCategory.marketCap,
        tags: ['mid-cap', 'balanced', 'potential', 'growth'],
        icon: '🏛️',
        difficulty: 1,
        explanation:
            'Mid-cap stocks offer a balance between growth potential and stability, often outperforming in bull markets.',
        criteria: {'market_cap_min': '5000', 'market_cap_max': '20000'},
        relatedFilters: ['growthStocks', 'qualityStocks'],
        successRate: 69.7,
      ),

      const FundamentalFilter(
        type: FundamentalType.smallCap,
        name: 'Small Cap Stocks',
        description: 'Small capitalization companies (<₹5,000 Cr)',
        category: FilterCategory.marketCap,
        tags: ['small-cap', 'growth-potential', 'emerging', 'high-risk'],
        icon: '🏪',
        difficulty: 2,
        explanation:
            'Small-cap stocks offer high growth potential but come with higher volatility and risk. Suitable for risk-tolerant investors.',
        criteria: {'market_cap_max': '5000', 'market_cap_min': '100'},
        relatedFilters: ['growthStocks', 'momentumStocks'],
        successRate: 58.3,
      ),

      // ============================================================================
      // BUSINESS INTELLIGENCE FILTERS
      // ============================================================================

      const FundamentalFilter(
        type: FundamentalType.workingCapitalEfficient,
        name: 'Working Capital Efficient',
        description: 'Companies with excellent working capital management',
        category: FilterCategory.efficiency,
        tags: [
          'efficiency',
          'working-capital',
          'cash-management',
          'operational'
        ],
        icon: '⚙️',
        difficulty: 2,
        explanation:
            'Efficient working capital management indicates strong operational control and cash flow optimization.',
        criteria: {
          'working_capital_efficiency': 'Excellent',
          'working_capital_days_max': '45'
        },
        relatedFilters: ['cashEfficientStocks', 'strongBalance'],
        successRate: 77.2,
        isPremium: true,
      ),

      const FundamentalFilter(
        type: FundamentalType.cashEfficientStocks,
        name: 'Cash Cycle Efficient',
        description: 'Companies with optimized cash conversion cycles',
        category: FilterCategory.efficiency,
        tags: ['cash-cycle', 'efficiency', 'liquidity', 'working-capital'],
        icon: '💳',
        difficulty: 2,
        explanation:
            'Short cash conversion cycles mean companies collect payments faster, improving liquidity and returns.',
        criteria: {
          'cash_conversion_cycle_max': '60',
          'cash_cycle_efficiency': 'Good'
        },
        relatedFilters: ['workingCapitalEfficient', 'freeCashFlowRich'],
        successRate: 74.8,
        isPremium: true,
      ),

      const FundamentalFilter(
        type: FundamentalType.businessInsightRich,
        name: 'Rich Business Insights',
        description:
            'Companies with comprehensive business analysis and highlights',
        category: FilterCategory.insights,
        tags: ['insights', 'analysis', 'comprehensive', 'research'],
        icon: '🧠',
        minimumQualityScore: 2,
        difficulty: 1,
        explanation:
            'Companies with rich business insights provide better understanding of growth drivers and competitive advantages.',
        criteria: {
          'business_overview_available': 'true',
          'investment_highlights_min': '1'
        },
        relatedFilters: ['recentMilestones', 'qualityStocks'],
        successRate: 70.5,
      ),

      const FundamentalFilter(
        type: FundamentalType.recentMilestones,
        name: 'Recent Key Milestones',
        description: 'Companies with recent significant achievements',
        category: FilterCategory.insights,
        tags: ['milestones', 'achievements', 'recent', 'catalysts'],
        icon: '🎯',
        difficulty: 1,
        explanation:
            'Recent milestones can indicate positive business momentum and potential upcoming growth catalysts.',
        criteria: {'key_milestones_min': '1', 'recent_performance': 'positive'},
        relatedFilters: ['businessInsightRich', 'momentumStocks'],
        successRate: 68.1,
      ),

      // ============================================================================
      // RISK & OPPORTUNITY FILTERS
      // ============================================================================

      const FundamentalFilter(
        type: FundamentalType.lowVolatility,
        name: 'Low Risk Stocks',
        description: 'Low volatility, stable companies',
        category: FilterCategory.risk,
        tags: ['low-risk', 'stable', 'conservative', 'defensive'],
        icon: '🛡️',
        minimumQualityScore: 2,
        difficulty: 0,
        explanation:
            'Low volatility stocks provide stability and are suitable for conservative investors seeking steady returns.',
        criteria: {'risk_level': 'Low', 'market_cap_min': '5000'},
        relatedFilters: ['qualityStocks', 'dividendStocks'],
        successRate: 72.6,
      ),

      const FundamentalFilter(
        type: FundamentalType.contrarian,
        name: 'Contrarian Opportunities',
        description: 'Quality companies currently out of favor',
        category: FilterCategory.opportunity,
        tags: ['contrarian', 'opportunity', 'recovery', 'beaten-down'],
        icon: '🔄',
        minimumQualityScore: 2,
        difficulty: 2,
        explanation:
            'Contrarian investing involves buying quality companies when they\'re temporarily out of favor, requiring patience.',
        criteria: {'change_percent_max': '-5', 'quality_score_min': '2'},
        relatedFilters: ['valueStocks', 'undervalued'],
        successRate: 79.3,
      ),
    ];
  }

  // ============================================================================
  // ENHANCED HELPER METHODS
  // ============================================================================

  static List<FundamentalFilter> getFiltersByCategory(FilterCategory category) {
    return getAllFilters()
        .where((filter) => filter.category == category)
        .toList();
  }

  static List<FilterCategory> getAllCategories() {
    return FilterCategory.values;
  }

  static List<FundamentalFilter> getPopularFilters() {
    return [
      getAllFilters()
          .firstWhere((f) => f.type == FundamentalType.qualityStocks),
      getAllFilters().firstWhere((f) => f.type == FundamentalType.debtFree),
      getAllFilters().firstWhere((f) => f.type == FundamentalType.highROE),
      getAllFilters().firstWhere((f) => f.type == FundamentalType.growthStocks),
      getAllFilters().firstWhere((f) => f.type == FundamentalType.valueStocks),
      getAllFilters()
          .firstWhere((f) => f.type == FundamentalType.dividendStocks),
    ];
  }

  static List<FundamentalFilter> getAdvancedFilters() {
    return getAllFilters().where((filter) => filter.difficulty >= 2).toList();
  }

  static List<FundamentalFilter> getBeginnerFilters() {
    return getAllFilters().where((filter) => filter.difficulty == 0).toList();
  }

  static List<FundamentalFilter> getPremiumFilters() {
    return getAllFilters().where((filter) => filter.isPremium).toList();
  }

  static List<FundamentalFilter> getFiltersBySuccessRate(
      {double minRate = 70.0}) {
    return getAllFilters()
        .where((filter) => filter.successRate >= minRate)
        .toList()
      ..sort((a, b) => b.successRate.compareTo(a.successRate));
  }

  static List<FundamentalFilter> searchFilters(String query) {
    final queryLower = query.toLowerCase();
    return getAllFilters()
        .where((filter) =>
            filter.name.toLowerCase().contains(queryLower) ||
            filter.description.toLowerCase().contains(queryLower) ||
            filter.tags.any((tag) => tag.toLowerCase().contains(queryLower)))
        .toList();
  }

  static FundamentalFilter? getFilterByType(FundamentalType type) {
    try {
      return getAllFilters().firstWhere((filter) => filter.type == type);
    } catch (e) {
      return null;
    }
  }

  static List<FundamentalFilter> getRelatedFilters(FundamentalType type) {
    final filter = getFilterByType(type);
    if (filter == null) return [];

    final relatedTypes = filter.relatedFilters
        .map((name) => FundamentalType.values.firstWhere(
              (t) => t.name == name,
              orElse: () => FundamentalType.qualityStocks,
            ))
        .toList();

    return relatedTypes
        .map((type) => getFilterByType(type))
        .where((f) => f != null)
        .cast<FundamentalFilter>()
        .toList();
  }
}

// Enhanced enum with all filter types
enum FundamentalType {
  // Enhanced Safety & Quality
  debtFree,
  qualityStocks,
  strongBalance,
  piotroskiHigh,
  altmanSafe,
  compoundingMachines,

  // Enhanced Profitability
  highROE,
  profitableStocks,
  consistentProfits,
  highROIC,
  freeCashFlowRich,

  // Enhanced Growth
  growthStocks,
  highSalesGrowth,
  momentumStocks,

  // Enhanced Value
  lowPE,
  valueStocks,
  undervalued,
  grahamValue,

  // Enhanced Income
  dividendStocks,
  highDividendYield,

  // Market Cap
  largeCap,
  midCap,
  smallCap,

  // Business Intelligence
  workingCapitalEfficient,
  cashEfficientStocks,
  businessInsightRich,
  recentMilestones,

  // Risk & Opportunity
  lowVolatility,
  contrarian,
}

enum FilterCategory {
  quality('Quality & Safety', '🛡️',
      'Safe, high-quality companies with strong fundamentals'),
  profitability(
      'Profitability', '💰', 'Companies with excellent profit generation'),
  growth('Growth', '📈', 'High-growth companies with expansion potential'),
  value('Value', '💎', 'Undervalued companies with attractive valuations'),
  income('Income', '💵', 'Dividend-paying companies for regular income'),
  marketCap(
      'Market Cap', '🏢', 'Companies categorized by market capitalization'),
  efficiency(
      'Efficiency', '⚙️', 'Companies with excellent operational efficiency'),
  insights(
      'Business Insights', '🧠', 'Companies with rich business intelligence'),
  risk('Risk Management', '🛡️', 'Low-risk, stable investment options'),
  opportunity(
      'Opportunities', '🎯', 'Special situation and contrarian opportunities');

  const FilterCategory(this.displayName, this.icon, this.description);

  final String displayName;
  final String icon;
  final String description;
}

// Enhanced extension with comprehensive properties
extension FundamentalTypeExtension on FundamentalType {
  String get displayName {
    switch (this) {
      case FundamentalType.debtFree:
        return 'Debt Free';
      case FundamentalType.qualityStocks:
        return 'Quality Stocks';
      case FundamentalType.strongBalance:
        return 'Strong Balance Sheet';
      case FundamentalType.piotroskiHigh:
        return 'High Piotroski Score';
      case FundamentalType.altmanSafe:
        return 'Altman Z-Score Safe';
      case FundamentalType.compoundingMachines:
        return 'Compounding Machines';
      case FundamentalType.highROE:
        return 'High ROE';
      case FundamentalType.profitableStocks:
        return 'Profitable Stocks';
      case FundamentalType.consistentProfits:
        return 'Consistent Profits';
      case FundamentalType.highROIC:
        return 'High ROIC';
      case FundamentalType.freeCashFlowRich:
        return 'Free Cash Flow Rich';
      case FundamentalType.growthStocks:
        return 'Growth Stocks';
      case FundamentalType.highSalesGrowth:
        return 'High Sales Growth';
      case FundamentalType.momentumStocks:
        return 'Momentum Stocks';
      case FundamentalType.lowPE:
        return 'Low P/E';
      case FundamentalType.valueStocks:
        return 'Value Stocks';
      case FundamentalType.undervalued:
        return 'Undervalued';
      case FundamentalType.grahamValue:
        return 'Graham Value';
      case FundamentalType.dividendStocks:
        return 'Dividend Stocks';
      case FundamentalType.highDividendYield:
        return 'High Dividend Yield';
      case FundamentalType.largeCap:
        return 'Large Cap';
      case FundamentalType.midCap:
        return 'Mid Cap';
      case FundamentalType.smallCap:
        return 'Small Cap';
      case FundamentalType.workingCapitalEfficient:
        return 'Working Capital Efficient';
      case FundamentalType.cashEfficientStocks:
        return 'Cash Efficient';
      case FundamentalType.businessInsightRich:
        return 'Rich Business Insights';
      case FundamentalType.recentMilestones:
        return 'Recent Milestones';
      case FundamentalType.lowVolatility:
        return 'Low Volatility';
      case FundamentalType.contrarian:
        return 'Contrarian';
    }
  }

  String get description {
    switch (this) {
      case FundamentalType.debtFree:
        return 'Companies with minimal debt (D/E < 0.1)';
      case FundamentalType.qualityStocks:
        return 'High-quality companies with strong fundamentals';
      case FundamentalType.strongBalance:
        return 'Excellent balance sheet and liquidity management';
      case FundamentalType.piotroskiHigh:
        return 'Piotroski F-Score ≥ 7 (Excellent Quality)';
      case FundamentalType.altmanSafe:
        return 'Low bankruptcy risk (Altman Z > 3.0)';
      case FundamentalType.compoundingMachines:
        return 'Consistent wealth creators with high returns';
      case FundamentalType.highROE:
        return 'Return on Equity > 15%';
      case FundamentalType.profitableStocks:
        return 'Consistently profitable companies';
      case FundamentalType.consistentProfits:
        return 'Steady profit growth over time';
      case FundamentalType.highROIC:
        return 'Return on Invested Capital > 20%';
      case FundamentalType.freeCashFlowRich:
        return 'Strong free cash flow generation';
      case FundamentalType.growthStocks:
        return 'High revenue and profit growth';
      case FundamentalType.highSalesGrowth:
        return 'Revenue growth > 20%';
      case FundamentalType.momentumStocks:
        return 'Strong recent performance trends';
      case FundamentalType.lowPE:
        return 'P/E Ratio < 15';
      case FundamentalType.valueStocks:
        return 'Undervalued with strong fundamentals';
      case FundamentalType.undervalued:
        return 'Significantly undervalued opportunities';
      case FundamentalType.grahamValue:
        return 'Trading below Graham Intrinsic Value';
      case FundamentalType.dividendStocks:
        return 'Regular dividend paying companies';
      case FundamentalType.highDividendYield:
        return 'Dividend yield > 4%';
      case FundamentalType.largeCap:
        return 'Market cap > ₹20,000 Cr';
      case FundamentalType.midCap:
        return 'Market cap ₹5,000-20,000 Cr';
      case FundamentalType.smallCap:
        return 'Market cap < ₹5,000 Cr';
      case FundamentalType.workingCapitalEfficient:
        return 'Excellent working capital management';
      case FundamentalType.cashEfficientStocks:
        return 'Optimized cash conversion cycles';
      case FundamentalType.businessInsightRich:
        return 'Comprehensive business analysis available';
      case FundamentalType.recentMilestones:
        return 'Recent significant achievements';
      case FundamentalType.lowVolatility:
        return 'Low risk, stable companies';
      case FundamentalType.contrarian:
        return 'Quality companies currently out of favor';
    }
  }

  String get icon {
    switch (this) {
      case FundamentalType.debtFree:
        return '🛡️';
      case FundamentalType.qualityStocks:
        return '⭐';
      case FundamentalType.strongBalance:
        return '💪';
      case FundamentalType.piotroskiHigh:
        return '🏆';
      case FundamentalType.altmanSafe:
        return '🛡️';
      case FundamentalType.compoundingMachines:
        return '🔄';
      case FundamentalType.highROE:
        return '📈';
      case FundamentalType.profitableStocks:
        return '💰';
      case FundamentalType.consistentProfits:
        return '📊';
      case FundamentalType.highROIC:
        return '💼';
      case FundamentalType.freeCashFlowRich:
        return '💰';
      case FundamentalType.growthStocks:
        return '🚀';
      case FundamentalType.highSalesGrowth:
        return '📈';
      case FundamentalType.momentumStocks:
        return '⚡';
      case FundamentalType.lowPE:
        return '💎';
      case FundamentalType.valueStocks:
        return '🎯';
      case FundamentalType.undervalued:
        return '💰';
      case FundamentalType.grahamValue:
        return '💎';
      case FundamentalType.dividendStocks:
        return '💵';
      case FundamentalType.highDividendYield:
        return '🎁';
      case FundamentalType.largeCap:
        return '🏢';
      case FundamentalType.midCap:
        return '🏛️';
      case FundamentalType.smallCap:
        return '🏪';
      case FundamentalType.workingCapitalEfficient:
        return '⚙️';
      case FundamentalType.cashEfficientStocks:
        return '💳';
      case FundamentalType.businessInsightRich:
        return '🧠';
      case FundamentalType.recentMilestones:
        return '🎯';
      case FundamentalType.lowVolatility:
        return '🛡️';
      case FundamentalType.contrarian:
        return '🔄';
    }
  }

  FilterCategory get category {
    switch (this) {
      case FundamentalType.debtFree:
      case FundamentalType.qualityStocks:
      case FundamentalType.strongBalance:
      case FundamentalType.piotroskiHigh:
      case FundamentalType.altmanSafe:
      case FundamentalType.compoundingMachines:
        return FilterCategory.quality;
      case FundamentalType.highROE:
      case FundamentalType.profitableStocks:
      case FundamentalType.consistentProfits:
      case FundamentalType.highROIC:
      case FundamentalType.freeCashFlowRich:
        return FilterCategory.profitability;
      case FundamentalType.growthStocks:
      case FundamentalType.highSalesGrowth:
      case FundamentalType.momentumStocks:
        return FilterCategory.growth;
      case FundamentalType.lowPE:
      case FundamentalType.valueStocks:
      case FundamentalType.undervalued:
      case FundamentalType.grahamValue:
        return FilterCategory.value;
      case FundamentalType.dividendStocks:
      case FundamentalType.highDividendYield:
        return FilterCategory.income;
      case FundamentalType.largeCap:
      case FundamentalType.midCap:
      case FundamentalType.smallCap:
        return FilterCategory.marketCap;
      case FundamentalType.workingCapitalEfficient:
      case FundamentalType.cashEfficientStocks:
        return FilterCategory.efficiency;
      case FundamentalType.businessInsightRich:
      case FundamentalType.recentMilestones:
        return FilterCategory.insights;
      case FundamentalType.lowVolatility:
        return FilterCategory.risk;
      case FundamentalType.contrarian:
        return FilterCategory.opportunity;
    }
  }

  int get difficulty {
    final filter = FundamentalFilter.getFilterByType(this);
    return filter?.difficulty ?? 1;
  }

  bool get isPremium {
    final filter = FundamentalFilter.getFilterByType(this);
    return filter?.isPremium ?? false;
  }

  double get successRate {
    final filter = FundamentalFilter.getFilterByType(this);
    return filter?.successRate ?? 0.0;
  }
}
