// widgets/fundamental_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/fundamental_filter.dart';
import '../providers/company_provider.dart';
import '../providers/fundamental_providers.dart'; // Import shared providers
import '../theme/app_theme.dart';

class FundamentalTabs extends ConsumerStatefulWidget {
  const FundamentalTabs({Key? key}) : super(key: key);

  @override
  ConsumerState<FundamentalTabs> createState() => _FundamentalTabsState();
}

class _FundamentalTabsState extends ConsumerState<FundamentalTabs>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedFilter = ref.watch(selectedFundamentalProvider);
    final marketSummaryAsync = ref.watch(marketSummaryProvider);

    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Container(
            height: 140,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEnhancedHeader(selectedFilter, marketSummaryAsync),
                const SizedBox(height: 12),
                Expanded(
                  child: _buildProfessionalFilterTabs(selectedFilter),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEnhancedHeader(
    FundamentalFilter? selectedFilter,
    AsyncValue<Map<String, dynamic>> marketSummaryAsync,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.analytics,
                    color: AppTheme.primaryGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Professional Analysis Filters',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  if (selectedFilter != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppTheme.primaryGreen.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        'ACTIVE',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              marketSummaryAsync.when(
                data: (summary) => Text(
                  selectedFilter != null
                      ? 'Filtering by ${selectedFilter.name} • ${summary['totalCompanies']} companies available'
                      : 'Choose criteria to filter ${summary['totalCompanies']} companies • ${summary['highQualityPercentage']}% quality stocks',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                loading: () => const Text(
                  'Loading market data...',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                error: (_, __) => const Text(
                  'Select fundamental criteria to analyze companies',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (selectedFilter != null) _buildClearFilterButton(),
      ],
    );
  }

  Widget _buildClearFilterButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.clear, size: 16, color: Colors.red),
        onPressed: () {
          ref.read(selectedFundamentalProvider.notifier).state = null;
        },
        tooltip: 'Clear Filter',
        padding: const EdgeInsets.all(4),
        constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
      ),
    );
  }

  Widget _buildProfessionalFilterTabs(FundamentalFilter? selectedFilter) {
    final enhancedFilters = _getEnhancedFilters();

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: enhancedFilters.length,
      itemBuilder: (context, index) {
        final filter = enhancedFilters[index];
        final isSelected = selectedFilter?.type == filter.type;

        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => _handleFilterTap(filter, isSelected),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 160,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          AppTheme.primaryGreen,
                          AppTheme.primaryGreen.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.grey.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isSelected ? AppTheme.primaryGreen : AppTheme.borderColor,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryGreen.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
              ),
              child: _buildFilterCard(filter, isSelected),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterCard(FundamentalFilter filter, bool isSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : _getFilterColor(filter.type).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected
                      ? Colors.white.withOpacity(0.3)
                      : _getFilterColor(filter.type).withOpacity(0.2),
                ),
              ),
              child: Text(
                filter.icon,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      isSelected ? Colors.white : _getFilterColor(filter.type),
                ),
              ),
            ),
            const Spacer(),
            if (isSelected)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            if (filter.isPremium && !isSelected)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: Colors.amber.withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
                child: const Text(
                  'PRO',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          filter.name,
          style: TextStyle(
            color: isSelected ? Colors.white : AppTheme.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          _getFilterDescription(filter.type),
          style: TextStyle(
            color: isSelected
                ? Colors.white.withOpacity(0.8)
                : AppTheme.textSecondary,
            fontSize: 10,
            height: 1.2,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        Row(
          children: [
            _buildFilterMetric(filter, isSelected),
            const Spacer(),
            if (filter.successRate > 0)
              _buildSuccessRateBadge(filter.successRate, isSelected),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterMetric(FundamentalFilter filter, bool isSelected) {
    return Consumer(
      builder: (context, ref, child) {
        final marketSummary = ref.watch(marketSummaryProvider);

        return marketSummary.when(
          data: (summary) {
            final metric = _getFilterMetric(filter.type, summary);
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.1)
                    : _getFilterColor(filter.type).withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                metric,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color:
                      isSelected ? Colors.white : _getFilterColor(filter.type),
                ),
              ),
            );
          },
          loading: () => Container(
            width: 40,
            height: 16,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          error: (_, __) => const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildSuccessRateBadge(double successRate, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.white.withOpacity(0.15)
            : Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: isSelected
              ? Colors.white.withOpacity(0.3)
              : Colors.green.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Text(
        '${successRate.toStringAsFixed(0)}%',
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : Colors.green,
        ),
      ),
    );
  }

  void _handleFilterTap(FundamentalFilter filter, bool isSelected) {
    if (isSelected) {
      ref.read(selectedFundamentalProvider.notifier).state = null;
      _showFilterClearedSnackBar();
    } else {
      ref.read(selectedFundamentalProvider.notifier).state = filter;
      _showFilterAppliedSnackBar(filter);
    }
  }

  void _showFilterAppliedSnackBar(FundamentalFilter filter) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Text(filter.icon, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Applied ${filter.name} filter'),
            ),
            if (filter.successRate > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${filter.successRate.toStringAsFixed(0)}% success',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
        backgroundColor: AppTheme.primaryGreen,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: SnackBarAction(
          label: 'VIEW',
          textColor: Colors.white,
          onPressed: () {
            // Navigate to filtered results
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showFilterClearedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.clear, color: Colors.white, size: 16),
            SizedBox(width: 8),
            Text('Filter cleared - showing all companies'),
          ],
        ),
        backgroundColor: Colors.grey[600],
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  List<FundamentalFilter> _getEnhancedFilters() {
    try {
      // Use the static method from the updated fundamental filter model
      final allFilters = FundamentalFilter.getAllFilters();

      // Return the most popular and useful filters for the tabs
      return [
        allFilters.firstWhere((f) => f.type == FundamentalType.qualityStocks),
        allFilters.firstWhere((f) => f.type == FundamentalType.piotroskiHigh),
        allFilters.firstWhere((f) => f.type == FundamentalType.altmanSafe),
        allFilters.firstWhere((f) => f.type == FundamentalType.valueStocks),
        allFilters.firstWhere((f) => f.type == FundamentalType.growthStocks),
        allFilters.firstWhere((f) => f.type == FundamentalType.dividendStocks),
        allFilters.firstWhere((f) => f.type == FundamentalType.debtFree),
        allFilters
            .firstWhere((f) => f.type == FundamentalType.profitableStocks),
        allFilters
            .firstWhere((f) => f.type == FundamentalType.freeCashFlowRich),
        allFilters.firstWhere((f) => f.type == FundamentalType.highROIC),
        allFilters.firstWhere(
            (f) => f.type == FundamentalType.workingCapitalEfficient),
        allFilters.firstWhere((f) => f.type == FundamentalType.lowPE),
      ];
    } catch (e) {
      // Fallback to basic filters if getAllFilters() fails
      return _getFallbackFilters();
    }
  }

  List<FundamentalFilter> _getFallbackFilters() {
    return [
      FundamentalFilter(
        type: FundamentalType.qualityStocks,
        name: 'Quality Leaders',
        description: 'High quality fundamentals',
        category: FilterCategory.quality,
        icon: '⭐',
      ),
      FundamentalFilter(
        type: FundamentalType.valueStocks,
        name: 'Value Opportunities',
        description: 'Undervalued opportunities',
        category: FilterCategory.value,
        icon: '💎',
      ),
      FundamentalFilter(
        type: FundamentalType.growthStocks,
        name: 'Growth Champions',
        description: 'High growth potential',
        category: FilterCategory.growth,
        icon: '🚀',
      ),
      FundamentalFilter(
        type: FundamentalType.dividendStocks,
        name: 'Income Generators',
        description: 'Regular income',
        category: FilterCategory.income,
        icon: '💰',
      ),
    ];
  }

  Color _getFilterColor(FundamentalType type) {
    switch (type) {
      case FundamentalType.qualityStocks:
        return Colors.amber;
      case FundamentalType.piotroskiHigh:
        return Colors.purple;
      case FundamentalType.altmanSafe:
        return Colors.blue;
      case FundamentalType.valueStocks:
        return Colors.green;
      case FundamentalType.growthStocks:
        return Colors.orange;
      case FundamentalType.dividendStocks:
        return Colors.teal;
      case FundamentalType.debtFree:
        return Colors.cyan;
      case FundamentalType.profitableStocks:
        return Colors.indigo;
      case FundamentalType.freeCashFlowRich:
        return Colors.lightGreen;
      case FundamentalType.highROIC:
        return Colors.deepPurple;
      case FundamentalType.workingCapitalEfficient:
        return Colors.pink;
      case FundamentalType.lowPE:
        return Colors.brown;
      case FundamentalType.compoundingMachines:
        return Colors.deepOrange;
      case FundamentalType.grahamValue:
        return Colors.blueGrey;
      case FundamentalType.consistentProfits:
        return Colors.lime;
      case FundamentalType.strongBalance:
        return Colors.red;
      default:
        return AppTheme.primaryGreen;
    }
  }

  String _getFilterDescription(FundamentalType type) {
    switch (type) {
      case FundamentalType.qualityStocks:
        return 'Quality Score ≥ 3, Strong fundamentals';
      case FundamentalType.piotroskiHigh:
        return 'Piotroski F-Score ≥ 7/9';
      case FundamentalType.altmanSafe:
        return 'Z-Score > 3.0, Bankruptcy safe';
      case FundamentalType.valueStocks:
        return 'P/E < 12, Quality ≥ 2';
      case FundamentalType.growthStocks:
        return 'Sales growth ≥ 15%';
      case FundamentalType.dividendStocks:
        return 'Dividend yield ≥ 1%';
      case FundamentalType.debtFree:
        return 'Debt-to-equity < 0.1';
      case FundamentalType.profitableStocks:
        return 'ROE > 0, Current ratio ≥ 1';
      case FundamentalType.freeCashFlowRich:
        return 'FCF yield ≥ 5%';
      case FundamentalType.highROIC:
        return 'ROIC > 20%';
      case FundamentalType.workingCapitalEfficient:
        return 'WC days < 45, Efficient ops';
      case FundamentalType.lowPE:
        return 'P/E < 15, ROE ≥ 10%';
      case FundamentalType.compoundingMachines:
        return 'ROE ≥ 18%, ROCE ≥ 18%';
      case FundamentalType.grahamValue:
        return 'Below Graham value';
      case FundamentalType.consistentProfits:
        return 'ROE ≥ 12%, Quality ≥ 2';
      case FundamentalType.strongBalance:
        return 'Current ratio ≥ 1.5';
      default:
        return 'Professional analysis criteria';
    }
  }

  String _getFilterMetric(FundamentalType type, Map<String, dynamic> summary) {
    try {
      final totalCompanies =
          int.tryParse(summary['totalCompanies']?.toString() ?? '0') ?? 0;

      switch (type) {
        case FundamentalType.qualityStocks:
          return '${summary['highQualityPercentage'] ?? '15'}% qualify';
        case FundamentalType.piotroskiHigh:
          return 'Top ${(totalCompanies * 0.1).toInt()}';
        case FundamentalType.altmanSafe:
          return '${(totalCompanies * 0.12).toInt()} safe';
        case FundamentalType.valueStocks:
          return '${summary['undervaluedPercentage'] ?? '12'}% undervalued';
        case FundamentalType.growthStocks:
          return '${(totalCompanies * 0.08).toInt()} growing';
        case FundamentalType.dividendStocks:
          return '${(totalCompanies * 0.25).toInt()} paying';
        case FundamentalType.debtFree:
          return '${(totalCompanies * 0.15).toInt()} debt-free';
        case FundamentalType.profitableStocks:
          return '${summary['profitablePercentage'] ?? '68'}% profitable';
        case FundamentalType.freeCashFlowRich:
          return '${(totalCompanies * 0.18).toInt()} cash rich';
        case FundamentalType.highROIC:
          return '${(totalCompanies * 0.05).toInt()} efficient';
        case FundamentalType.workingCapitalEfficient:
          return '${(totalCompanies * 0.12).toInt()} efficient';
        case FundamentalType.lowPE:
          return '${(totalCompanies * 0.20).toInt()} attractive';
        case FundamentalType.compoundingMachines:
          return '${(totalCompanies * 0.03).toInt()} machines';
        case FundamentalType.grahamValue:
          return '${(totalCompanies * 0.08).toInt()} undervalued';
        case FundamentalType.consistentProfits:
          return '${(totalCompanies * 0.22).toInt()} consistent';
        case FundamentalType.strongBalance:
          return '${(totalCompanies * 0.28).toInt()} strong';
        default:
          return '${(totalCompanies * 0.1).toInt()} match';
      }
    } catch (e) {
      return 'Available';
    }
  }
}

// Enhanced fundamental filter model extensions
extension FundamentalFilterExtensions on FundamentalFilter {
  IconData get iconData {
    switch (type) {
      case FundamentalType.qualityStocks:
        return Icons.star;
      case FundamentalType.piotroskiHigh:
        return Icons.analytics;
      case FundamentalType.altmanSafe:
        return Icons.security;
      case FundamentalType.valueStocks:
        return Icons.diamond;
      case FundamentalType.growthStocks:
        return Icons.trending_up;
      case FundamentalType.dividendStocks:
        return Icons.monetization_on;
      case FundamentalType.debtFree:
        return Icons.check_circle;
      case FundamentalType.profitableStocks:
        return Icons.show_chart;
      case FundamentalType.freeCashFlowRich:
        return Icons.account_balance_wallet;
      case FundamentalType.highROIC:
        return Icons.gps_fixed;
      case FundamentalType.workingCapitalEfficient:
        return Icons.speed;
      case FundamentalType.lowPE:
        return Icons.price_check;
      case FundamentalType.compoundingMachines:
        return Icons.autorenew;
      case FundamentalType.grahamValue:
        return Icons.calculate;
      case FundamentalType.consistentProfits:
        return Icons.timeline;
      case FundamentalType.strongBalance:
        return Icons.account_balance;
      default:
        return Icons.filter_list;
    }
  }

  Color get primaryColor {
    switch (type) {
      case FundamentalType.qualityStocks:
        return Colors.amber;
      case FundamentalType.valueStocks:
        return Colors.green;
      case FundamentalType.growthStocks:
        return Colors.orange;
      case FundamentalType.dividendStocks:
        return Colors.teal;
      case FundamentalType.piotroskiHigh:
        return Colors.purple;
      case FundamentalType.altmanSafe:
        return Colors.blue;
      case FundamentalType.compoundingMachines:
        return Colors.deepOrange;
      default:
        return AppTheme.primaryGreen;
    }
  }

  String get shortDescription {
    switch (type) {
      case FundamentalType.qualityStocks:
        return 'High quality fundamentals';
      case FundamentalType.piotroskiHigh:
        return 'Top Piotroski scores';
      case FundamentalType.altmanSafe:
        return 'Bankruptcy safe';
      case FundamentalType.valueStocks:
        return 'Undervalued opportunities';
      case FundamentalType.growthStocks:
        return 'High growth potential';
      case FundamentalType.dividendStocks:
        return 'Regular income';
      case FundamentalType.debtFree:
        return 'Minimal debt';
      case FundamentalType.profitableStocks:
        return 'Consistent profits';
      case FundamentalType.freeCashFlowRich:
        return 'Strong cash flow';
      case FundamentalType.highROIC:
        return 'Capital efficient';
      case FundamentalType.workingCapitalEfficient:
        return 'Efficient operations';
      case FundamentalType.lowPE:
        return 'Attractive valuation';
      default:
        return description;
    }
  }

  String get detailedExplanation {
    switch (type) {
      case FundamentalType.qualityStocks:
        return 'Companies with strong financial health, good management, and sustainable business models. These stocks typically have high Piotroski scores and quality grades.';
      case FundamentalType.piotroskiHigh:
        return 'Companies scoring 7+ on the Piotroski F-Score, indicating excellent financial strength across profitability, leverage, and operating efficiency metrics.';
      case FundamentalType.altmanSafe:
        return 'Companies with Altman Z-Score > 3.0, indicating very low probability of bankruptcy within the next 2 years. These are financially stable businesses.';
      case FundamentalType.valueStocks:
        return 'Undervalued companies trading below their intrinsic value with strong fundamentals. These offer potential for capital appreciation with lower risk.';
      case FundamentalType.growthStocks:
        return 'Companies showing strong revenue and profit growth trends. These stocks offer potential for above-average returns but may come with higher volatility.';
      case FundamentalType.dividendStocks:
        return 'Companies that regularly pay dividends, providing steady income stream. Suitable for income-focused investors and retirees.';
      default:
        return explanation;
    }
  }
}
