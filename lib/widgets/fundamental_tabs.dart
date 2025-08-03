// widgets/fundamental_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/fundamental_filter.dart';
import '../providers/company_provider.dart';
import '../theme/app_theme.dart';

// Enhanced providers for the fundamental tabs
final selectedFundamentalProvider =
    StateProvider<FundamentalFilter?>((ref) => null);
final tabAnimationController =
    StateProvider<AnimationController?>((ref) => null);

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
        _buildFilterMetric(filter, isSelected),
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
          ],
        ),
        backgroundColor: AppTheme.primaryGreen,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
    return [
      // Quality & Score Based Filters
      FundamentalFilter(
        type: FundamentalType.qualityStocks,
        name: 'Quality Leaders',
        description:
            'Companies with high Piotroski scores and strong fundamentals',
        category: FilterCategory.quality,
        icon: '⭐',
      ),
      FundamentalFilter(
        type: FundamentalType.piotroskiHigh,
        name: 'Top Performers',
        description: 'Highest overall comprehensive analysis scores',
        category: FilterCategory.quality,
        icon: '🏆',
      ),
      FundamentalFilter(
        type: FundamentalType.altmanSafe,
        name: 'Financial Stability',
        description: 'Companies with strong bankruptcy prediction scores',
        category: FilterCategory.quality,
        icon: '🛡️',
      ),

      // Value & Growth Filters
      FundamentalFilter(
        type: FundamentalType.valueStocks,
        name: 'Value Opportunities',
        description: 'Undervalued stocks with safety margin',
        category: FilterCategory.value,
        icon: '💎',
      ),
      FundamentalFilter(
        type: FundamentalType.growthStocks,
        name: 'Growth Champions',
        description: 'High revenue and profit growth companies',
        category: FilterCategory.growth,
        icon: '🚀',
      ),
      FundamentalFilter(
        type: FundamentalType.dividendStocks,
        name: 'Income Generators',
        description: 'Reliable dividend paying companies',
        category: FilterCategory.income,
        icon: '💰',
      ),

      // Financial Health Filters
      FundamentalFilter(
        type: FundamentalType.debtFree,
        name: 'Debt Free',
        description: 'Companies with minimal or no debt',
        category: FilterCategory.quality,
        icon: '🆓',
      ),
      FundamentalFilter(
        type: FundamentalType.profitableStocks,
        name: 'Consistently Profitable',
        description: 'Strong ROE and profit margins',
        category: FilterCategory.profitability,
        icon: '📈',
      ),
      FundamentalFilter(
        type: FundamentalType.freeCashFlowRich,
        name: 'Cash Rich',
        description: 'Strong cash position and liquidity',
        category: FilterCategory.profitability,
        icon: '💵',
      ),

      // Advanced Analysis Filters
      FundamentalFilter(
        type: FundamentalType.highROIC,
        name: 'ROIC Leaders',
        description: 'Exceptional return on invested capital',
        category: FilterCategory.profitability,
        icon: '🎯',
      ),
      FundamentalFilter(
        type: FundamentalType.workingCapitalEfficient,
        name: 'Efficient Management',
        description: 'Superior working capital management',
        category: FilterCategory.efficiency,
        icon: '⚡',
      ),
      FundamentalFilter(
        type: FundamentalType.lowPE,
        name: 'Attractive Valuation',
        description: 'Low P/E and P/B ratios',
        category: FilterCategory.value,
        icon: '🔻',
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
      default:
        return AppTheme.primaryGreen;
    }
  }

  String _getFilterDescription(FundamentalType type) {
    switch (type) {
      case FundamentalType.qualityStocks:
        return 'Piotroski ≥ 7, Quality grade A-B';
      case FundamentalType.piotroskiHigh:
        return 'Overall score ≥ 80/100';
      case FundamentalType.altmanSafe:
        return 'Z-Score > 3.0, low bankruptcy risk';
      case FundamentalType.valueStocks:
        return 'Safety margin > 15%';
      case FundamentalType.growthStocks:
        return 'Sales & profit growth > 15%';
      case FundamentalType.dividendStocks:
        return 'Dividend yield > 2%';
      case FundamentalType.debtFree:
        return 'Debt-to-equity < 0.1';
      case FundamentalType.profitableStocks:
        return 'ROE > 15%, consistent profits';
      case FundamentalType.freeCashFlowRich:
        return 'Strong current ratio > 2.0';
      case FundamentalType.highROIC:
        return 'ROIC > 20%, capital efficient';
      case FundamentalType.workingCapitalEfficient:
        return 'WC days < 60, efficient ops';
      case FundamentalType.lowPE:
        return 'P/E < 15, P/B < 2.0';
      default:
        return 'Professional analysis criteria';
    }
  }

  String _getFilterMetric(FundamentalType type, Map<String, dynamic> summary) {
    switch (type) {
      case FundamentalType.qualityStocks:
        return '${summary['highQualityPercentage']}% qualify';
      case FundamentalType.piotroskiHigh:
        return 'Top ${(summary['totalCompanies'] * 0.1).toInt()}';
      case FundamentalType.valueStocks:
        return '${summary['undervaluedPercentage'] ?? '12'}% undervalued';
      case FundamentalType.debtFree:
        return '${(summary['totalCompanies'] * 0.15).toInt()} companies';
      case FundamentalType.dividendStocks:
        return '${(summary['totalCompanies'] * 0.25).toInt()} paying';
      case FundamentalType.growthStocks:
        return '${(summary['totalCompanies'] * 0.08).toInt()} growing';
      default:
        return '${(summary['totalCompanies'] * 0.1).toInt()} match';
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
      default:
        return AppTheme.primaryGreen;
    }
  }
}
