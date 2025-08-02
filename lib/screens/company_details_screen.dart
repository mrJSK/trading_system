// screens/company_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../models/company_model.dart';
import '../widgets/financial_tabs.dart';
import '../providers/fundamental_provider.dart';
import '../theme/app_theme.dart';

class CompanyDetailsScreen extends ConsumerStatefulWidget {
  final CompanyModel company;

  const CompanyDetailsScreen({Key? key, required this.company})
      : super(key: key);

  @override
  ConsumerState<CompanyDetailsScreen> createState() =>
      _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends ConsumerState<CompanyDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchlist = ref.watch(watchlistProvider);
    final isInWatchlist = watchlist.contains(widget.company.symbol);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.symbol),
        elevation: 0,
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareCompany(context),
          ),
          IconButton(
            icon: Icon(
              isInWatchlist ? Icons.favorite : Icons.favorite_border,
              color: isInWatchlist ? Colors.red : Colors.white,
            ),
            onPressed: () {
              ref
                  .read(watchlistProvider.notifier)
                  .toggleWatchlist(widget.company.symbol);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isInWatchlist
                        ? '${widget.company.symbol} removed from watchlist'
                        : '${widget.company.symbol} added to watchlist',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildEnhancedTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildComprehensiveOverviewTab(), // Enhanced overview with all sections
                _buildCleanFinancialTab('quarterly'),
                _buildCleanFinancialTab('profit_loss'),
                _buildCleanFinancialTab('balance_sheet'),
                _buildCleanFinancialTab('cash_flow'),
                _buildCleanFinancialTab('ratios'),
                _buildCleanFinancialTab('shareholding'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // COMPREHENSIVE OVERVIEW TAB - WITH ALL COMPANY DETAILS
  // ============================================================================

  Widget _buildComprehensiveOverviewTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Company header with basic info
          _buildEnhancedCompanyHeader(),

          // Quick financial stats
          _buildEnhancedQuickStats(),

          // Overview content sections
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Company About Section
                _buildCompanyAboutSection(),
                const SizedBox(height: 16),

                // Quick Financial Analysis
                _buildQuickAnalysis(),
                const SizedBox(height: 16),

                // Working Capital Analysis
                _buildWorkingCapitalAnalysis(),
                const SizedBox(height: 16),

                // Financial Health
                _buildFinancialHealthCard(),
                const SizedBox(height: 16),

                // Growth Analysis
                _buildGrowthAnalysis(),
                const SizedBox(height: 16),

                // Company History & Key Points
                _buildCompanyHistorySection(),
                const SizedBox(height: 16),

                // Peers Comparison
                _buildPeersComparisonSection(),
                const SizedBox(height: 16),

                // Pros/Cons Analysis (ONLY in overview)
                if (_hasAnalysisSummary()) _buildProsConsSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // CLEAN FINANCIAL TABS - NO PROS/CONS, NO HEADER/STATS
  // ============================================================================

  Widget _buildCleanFinancialTab(String type) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Simple header for the financial section
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  _getFinancialTabIcon(type),
                  color: AppTheme.primaryGreen,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  _getFinancialTabTitle(type),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.company.symbol,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ============================================================================
  // NEW: COMPANY ABOUT SECTION
  // ============================================================================

  Widget _buildCompanyAboutSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.business, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'About Company',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Company basic info
            if (widget.company.sector != null) ...[
              _buildInfoRow('Sector', widget.company.sector!),
            ],
            if (widget.company.industry != null) ...[
              _buildInfoRow('Industry', widget.company.industry!),
            ],
            _buildInfoRow('Market Cap', widget.company.formattedMarketCap),
            _buildInfoRow('Category', widget.company.marketCapCategoryText),

            const SizedBox(height: 12),

            // Company description (if available)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Text(
                widget.company.about ??
                    '${widget.company.name} is a ${widget.company.marketCapCategoryText.toLowerCase()} company operating in the ${widget.company.sector ?? "various"} sector. The company is listed on Indian stock exchanges and is tracked for its financial performance and market presence.',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // NEW: COMPANY HISTORY & KEY POINTS SECTION
  // ============================================================================

  Widget _buildCompanyHistorySection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.history, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Key Highlights & History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Key financial milestones
            _buildTimelineItem(
              'Recent Performance',
              '${widget.company.changePercent >= 0 ? 'Gained' : 'Lost'} ${widget.company.changePercent.abs().toStringAsFixed(2)}% in recent trading',
              _getPerformanceIcon(widget.company.changePercent),
              _getPerformanceColor(widget.company.changePercent),
            ),

            if (widget.company.roe != null && widget.company.roe! > 15) ...[
              _buildTimelineItem(
                'High ROE Achievement',
                'Achieved ${widget.company.roe!.toStringAsFixed(1)}% Return on Equity, indicating strong profitability',
                Icons.trending_up,
                Colors.green,
              ),
            ],

            if (widget.company.isDebtFree) ...[
              _buildTimelineItem(
                'Debt-Free Status',
                'Maintains a debt-free balance sheet with minimal financial leverage',
                Icons.shield,
                Colors.green,
              ),
            ],

            if (widget.company.paysDividends) ...[
              _buildTimelineItem(
                'Dividend Distribution',
                'Regular dividend payer with ${widget.company.dividendYield?.toStringAsFixed(2) ?? 'N/A'}% yield',
                Icons.account_balance_wallet,
                Colors.blue,
              ),
            ],

            if (widget.company.qualityScore >= 4) ...[
              _buildTimelineItem(
                'Quality Rating',
                'Achieved ${widget.company.qualityScore}/5 quality score based on financial metrics',
                Icons.star,
                Colors.amber,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
      String title, String description, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // NEW: PEERS COMPARISON SECTION
  // ============================================================================

  Widget _buildPeersComparisonSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.compare_arrows, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Peer Comparison',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Comparison metrics table
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text(
                            'Metric',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Company',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Sector Avg',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Rating',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Comparison rows
                  _buildComparisonRow(
                    'P/E Ratio',
                    widget.company.stockPe?.toStringAsFixed(1) ?? 'N/A',
                    '18.5', // Sector average (you can make this dynamic)
                    _getRatingForPE(widget.company.stockPe),
                  ),
                  _buildComparisonRow(
                    'ROE (%)',
                    widget.company.roe?.toStringAsFixed(1) ?? 'N/A',
                    '14.2',
                    _getRatingForROE(widget.company.roe),
                  ),
                  _buildComparisonRow(
                    'Debt/Equity',
                    widget.company.debtToEquity?.toStringAsFixed(2) ?? 'N/A',
                    '0.45',
                    _getRatingForDebt(widget.company.debtToEquity),
                  ),
                  _buildComparisonRow(
                    'Current Ratio',
                    widget.company.currentRatio?.toStringAsFixed(2) ?? 'N/A',
                    '1.35',
                    _getRatingForCurrentRatio(widget.company.currentRatio),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Peer comparison summary
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getOverallRatingColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: _getOverallRatingColor().withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    _getOverallRatingIcon(),
                    color: _getOverallRatingColor(),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Overall Peer Ranking: ${_getOverallRating()}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _getOverallRatingColor(),
                          ),
                        ),
                        Text(
                          _getOverallRatingDescription(),
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonRow(
      String metric, String companyValue, String sectorAvg, String rating) {
    final ratingColor = _getRatingColor(rating);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(metric),
          ),
          Expanded(
            child: Text(
              companyValue,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              sectorAvg,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ratingColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: ratingColor.withOpacity(0.3)),
              ),
              child: Text(
                rating,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ratingColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // EXISTING SECTIONS (KEEP AS THEY WERE)
  // ============================================================================

  Widget _buildEnhancedCompanyHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, AppTheme.cardBackground],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.company.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          widget.company.symbol,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildMarketCapChip(),
                      ],
                    ),
                    if (widget.company.sector != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.company.sector!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.company.formattedPrice,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _buildPriceChangeChip(),
                  const SizedBox(height: 4),
                  Text(
                    'Updated: ${widget.company.formattedLastUpdated}',
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildEnhancedIndicatorsRow(),
        ],
      ),
    );
  }

  // [Keep all your existing methods: _buildMarketCapChip, _buildPriceChangeChip,
  //  _buildEnhancedIndicatorsRow, _buildEnhancedQuickStats, etc.]

  Widget _buildMarketCapChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getMarketCapColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getMarketCapColor().withOpacity(0.3),
        ),
      ),
      child: Text(
        widget.company.marketCapCategoryText,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: _getMarketCapColor(),
        ),
      ),
    );
  }

  Widget _buildPriceChangeChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.company.isGainer
            ? AppTheme.profitGreen.withOpacity(0.1)
            : widget.company.isLoser
                ? AppTheme.lossRed.withOpacity(0.1)
                : AppTheme.textSecondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: widget.company.isGainer
              ? AppTheme.profitGreen.withOpacity(0.3)
              : widget.company.isLoser
                  ? AppTheme.lossRed.withOpacity(0.3)
                  : AppTheme.textSecondary.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            widget.company.isGainer
                ? Icons.trending_up
                : widget.company.isLoser
                    ? Icons.trending_down
                    : Icons.remove,
            size: 14,
            color: widget.company.isGainer
                ? AppTheme.profitGreen
                : widget.company.isLoser
                    ? AppTheme.lossRed
                    : AppTheme.textSecondary,
          ),
          const SizedBox(width: 4),
          Text(
            widget.company.formattedChange,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: widget.company.isGainer
                  ? AppTheme.profitGreen
                  : widget.company.isLoser
                      ? AppTheme.lossRed
                      : AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedIndicatorsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildEnhancedQualityBadge(),
          const SizedBox(width: 8),
          _buildRiskBadge(),
          const SizedBox(width: 8),
          _buildWorkingCapitalBadge(),
          const SizedBox(width: 8),
          _buildLiquidityBadge(),
          const SizedBox(width: 8),
          if (widget.company.isDebtFree)
            _buildIndicatorChip('Debt Free', Colors.green),
          if (widget.company.isDebtFree) const SizedBox(width: 4),
          if (widget.company.paysDividends)
            _buildIndicatorChip('Dividend', Colors.blue),
          if (widget.company.paysDividends) const SizedBox(width: 4),
          if (widget.company.isGrowthStock)
            _buildIndicatorChip('Growth', Colors.orange),
          if (widget.company.isGrowthStock) const SizedBox(width: 4),
          if (widget.company.isValueStock)
            _buildIndicatorChip('Value', Colors.purple),
        ],
      ),
    );
  }

  Widget _buildEnhancedQualityBadge() {
    final score = widget.company.qualityScore;
    final grade = widget.company.overallQualityGrade;

    Color color;
    IconData icon;
    String text = 'Quality: $grade';

    if (score >= 4) {
      color = Colors.green;
      icon = Icons.star;
    } else if (score >= 3) {
      color = Colors.blue;
      icon = Icons.star_half;
    } else if (score >= 2) {
      color = Colors.orange;
      icon = Icons.star_outline;
    } else {
      color = Colors.red;
      icon = Icons.star_border;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingCapitalBadge() {
    final efficiency = widget.company.workingCapitalEfficiency;
    Color color;
    IconData icon;

    switch (efficiency.toLowerCase()) {
      case 'excellent':
        color = Colors.green;
        icon = Icons.fast_forward;
        break;
      case 'good':
        color = Colors.blue;
        icon = Icons.schedule;
        break;
      case 'average':
        color = Colors.orange;
        icon = Icons.access_time;
        break;
      case 'poor':
        color = Colors.red;
        icon = Icons.hourglass_empty;
        break;
      default:
        color = AppTheme.textSecondary;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            'WC: $efficiency',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiquidityBadge() {
    final liquidity = widget.company.liquidityStatus;
    Color color;
    IconData icon;

    switch (liquidity.toLowerCase()) {
      case 'excellent':
        color = Colors.green;
        icon = Icons.water_drop;
        break;
      case 'good':
        color = Colors.blue;
        icon = Icons.opacity;
        break;
      case 'adequate':
        color = Colors.orange;
        icon = Icons.invert_colors;
        break;
      case 'poor':
        color = Colors.red;
        icon = Icons.warning;
        break;
      default:
        color = AppTheme.textSecondary;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            'Liquidity: $liquidity',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskBadge() {
    final riskLevel = widget.company.riskLevel;
    Color color;
    IconData icon;

    switch (riskLevel.toLowerCase()) {
      case 'high':
        color = AppTheme.lossRed;
        icon = Icons.trending_up;
        break;
      case 'medium':
        color = Colors.orange;
        icon = Icons.timeline;
        break;
      case 'low':
        color = AppTheme.profitGreen;
        icon = Icons.shield;
        break;
      default:
        color = AppTheme.textSecondary;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            'Risk: $riskLevel',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicatorChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _buildEnhancedQuickStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppTheme.cardBackground,
      child: Column(
        children: [
          // Primary financial metrics
          Row(
            children: [
              Expanded(
                  child: _buildMetricCard(
                      'Market Cap', widget.company.formattedMarketCap)),
              Expanded(
                  child: _buildMetricCard('P/E Ratio',
                      widget.company.stockPe?.toStringAsFixed(1) ?? 'N/A')),
              Expanded(
                  child: _buildMetricCard(
                      'ROE',
                      widget.company.roe != null
                          ? '${widget.company.roe!.toStringAsFixed(1)}%'
                          : 'N/A')),
              Expanded(
                  child: _buildMetricCard(
                      'Quality', '${widget.company.qualityScore}/5')),
            ],
          ),
          const SizedBox(height: 12),

          // Enhanced liquidity and efficiency metrics
          Row(
            children: [
              Expanded(
                  child: _buildMetricCard(
                      'Current Ratio',
                      widget.company.currentRatio?.toStringAsFixed(2) ??
                          'N/A')),
              Expanded(
                  child: _buildMetricCard(
                      'Debt/Equity',
                      widget.company.debtToEquity?.toStringAsFixed(2) ??
                          'N/A')),
              Expanded(
                  child: _buildMetricCard(
                      'WC Days',
                      widget.company.workingCapitalDays?.toStringAsFixed(0) ??
                          'N/A')),
              Expanded(
                  child: _buildMetricCard(
                      'Cash Cycle',
                      widget.company.cashConversionCycle?.toStringAsFixed(0) ??
                          'N/A')),
            ],
          ),
          const SizedBox(height: 12),

          // Growth and valuation metrics
          Row(
            children: [
              Expanded(
                  child: _buildMetricCard(
                      'Sales Growth',
                      widget.company.salesGrowth3Y != null
                          ? '${widget.company.salesGrowth3Y!.toStringAsFixed(1)}%'
                          : 'N/A')),
              Expanded(
                  child: _buildMetricCard(
                      'Profit Growth',
                      widget.company.profitGrowth3Y != null
                          ? '${widget.company.profitGrowth3Y!.toStringAsFixed(1)}%'
                          : 'N/A')),
              Expanded(
                  child: _buildMetricCard(
                      'Div Yield',
                      widget.company.dividendYield != null
                          ? '${widget.company.dividendYield!.toStringAsFixed(1)}%'
                          : 'N/A')),
              Expanded(
                  child: _buildMetricCard('Book Value',
                      widget.company.bookValue?.toStringAsFixed(1) ?? 'N/A')),
            ],
          ),

          // Additional efficiency metrics if available
          if (widget.company.debtorDays != null ||
              widget.company.inventoryDays != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: _buildMetricCard(
                        'Debtor Days',
                        widget.company.debtorDays?.toStringAsFixed(0) ??
                            'N/A')),
                Expanded(
                    child: _buildMetricCard(
                        'Inventory Days',
                        widget.company.inventoryDays?.toStringAsFixed(0) ??
                            'N/A')),
                Expanded(
                    child: _buildMetricCard(
                        'Interest Coverage',
                        widget.company.interestCoverage?.toStringAsFixed(1) ??
                            'N/A')),
                Expanded(
                    child: _buildMetricCard(
                        'ROCE',
                        widget.company.roce != null
                            ? '${widget.company.roce!.toStringAsFixed(1)}%'
                            : 'N/A')),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value) {
    Color valueColor = AppTheme.textPrimary;
    if (value == 'N/A') {
      valueColor = AppTheme.textSecondary;
    } else if (label.contains('Growth') && value.contains('-')) {
      valueColor = AppTheme.lossRed;
    } else if (label.contains('Growth') || label == 'ROE' || label == 'ROCE') {
      valueColor = AppTheme.profitGreen;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // [Keep all your existing analysis methods: _buildQuickAnalysis, _buildWorkingCapitalAnalysis, etc.]

  Widget _buildQuickAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Analysis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildAnalysisRow(
                'Overall Quality',
                widget.company.overallQualityGrade,
                _getQualityColor(widget.company.overallQualityGrade)),
            _buildAnalysisRow(
                'Working Capital',
                widget.company.workingCapitalEfficiency,
                _getEfficiencyColor(widget.company.workingCapitalEfficiency)),
            _buildAnalysisRow('Cash Cycle', widget.company.cashCycleEfficiency,
                _getEfficiencyColor(widget.company.cashCycleEfficiency)),
            _buildAnalysisRow('Liquidity', widget.company.liquidityStatus,
                _getEfficiencyColor(widget.company.liquidityStatus)),
            _buildAnalysisRow('Debt Status', widget.company.debtStatus,
                _getDebtColor(widget.company.debtStatus)),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: color,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingCapitalAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Working Capital Analysis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (widget.company.workingCapitalDays != null) ...[
              _buildMetricRow('Working Capital Days',
                  '${widget.company.workingCapitalDays!.toStringAsFixed(0)} days'),
              _buildMetricRow(
                  'Assessment', widget.company.workingCapitalEfficiency),
            ],
            if (widget.company.debtorDays != null)
              _buildMetricRow('Collection Period',
                  '${widget.company.debtorDays!.toStringAsFixed(0)} days'),
            if (widget.company.inventoryDays != null)
              _buildMetricRow('Inventory Days',
                  '${widget.company.inventoryDays!.toStringAsFixed(0)} days'),
            if (widget.company.cashConversionCycle != null) ...[
              _buildMetricRow('Cash Conversion Cycle',
                  '${widget.company.cashConversionCycle!.toStringAsFixed(0)} days'),
              _buildMetricRow(
                  'Cycle Efficiency', widget.company.cashCycleEfficiency),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialHealthCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Financial Health',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (widget.company.currentRatio != null)
              _buildMetricRow('Current Ratio',
                  widget.company.currentRatio!.toStringAsFixed(2)),
            if (widget.company.quickRatio != null)
              _buildMetricRow(
                  'Quick Ratio', widget.company.quickRatio!.toStringAsFixed(2)),
            if (widget.company.debtToEquity != null) ...[
              _buildMetricRow('Debt-to-Equity',
                  widget.company.debtToEquity!.toStringAsFixed(2)),
              _buildMetricRow('Debt Status', widget.company.debtStatus),
            ],
            if (widget.company.interestCoverage != null)
              _buildMetricRow('Interest Coverage',
                  '${widget.company.interestCoverage!.toStringAsFixed(1)}x'),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Growth Analysis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (widget.company.salesGrowth3Y != null)
              _buildMetricRow('Sales Growth (3Y)',
                  '${widget.company.salesGrowth3Y!.toStringAsFixed(1)}%'),
            if (widget.company.profitGrowth3Y != null)
              _buildMetricRow('Profit Growth (3Y)',
                  '${widget.company.profitGrowth3Y!.toStringAsFixed(1)}%'),
            if (widget.company.salesCAGR3Y != null)
              _buildMetricRow('Sales CAGR (3Y)',
                  '${widget.company.salesCAGR3Y!.toStringAsFixed(1)}%'),
            if (widget.company.roe != null)
              _buildMetricRow('Return on Equity',
                  '${widget.company.roe!.toStringAsFixed(1)}%'),
            if (widget.company.roce != null)
              _buildMetricRow('Return on Capital',
                  '${widget.company.roce!.toStringAsFixed(1)}%'),
          ],
        ),
      ),
    );
  }

  bool _hasAnalysisSummary() {
    return widget.company.pros.isNotEmpty || widget.company.cons.isNotEmpty;
  }

  Widget _buildProsConsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.analytics, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Analysis Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // STRENGTHS SECTION
            if (widget.company.pros.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.thumb_up, color: Colors.green, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Strengths',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...widget.company.pros.map((pro) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 18),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            pro,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],

            // AREAS OF CONCERN SECTION
            if (widget.company.cons.isNotEmpty) ...[
              if (widget.company.pros.isNotEmpty) const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.warning, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Areas of Concern',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.red),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...widget.company.cons.map((con) => Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 18),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            con,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],

            // FOOTER NOTE
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline,
                      color: AppTheme.textSecondary, size: 16),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Analysis based on financial data and market indicators',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // HELPER METHODS FOR FINANCIAL TAB ICONS AND TITLES
  // ============================================================================

  IconData _getFinancialTabIcon(String type) {
    switch (type) {
      case 'quarterly':
        return Icons.calendar_view_month;
      case 'profit_loss':
        return Icons.trending_up;
      case 'balance_sheet':
        return Icons.account_balance;
      case 'cash_flow':
        return Icons.water_drop;
      case 'ratios':
        return Icons.calculate;
      case 'shareholding':
        return Icons.pie_chart;
      default:
        return Icons.bar_chart;
    }
  }

  String _getFinancialTabTitle(String type) {
    switch (type) {
      case 'quarterly':
        return 'Quarterly Results';
      case 'profit_loss':
        return 'Profit & Loss';
      case 'balance_sheet':
        return 'Balance Sheet';
      case 'cash_flow':
        return 'Cash Flow';
      case 'ratios':
        return 'Financial Ratios';
      case 'shareholding':
        return 'Shareholding Pattern';
      default:
        return 'Financial Data';
    }
  }

  // ============================================================================
  // HELPER METHODS FOR PEER COMPARISON
  // ============================================================================

  String _getRatingForPE(double? pe) {
    if (pe == null || pe <= 0) return 'N/A';
    if (pe < 15) return 'Good';
    if (pe < 25) return 'Average';
    return 'High';
  }

  String _getRatingForROE(double? roe) {
    if (roe == null || roe <= 0) return 'Poor';
    if (roe > 20) return 'Excellent';
    if (roe > 15) return 'Good';
    if (roe > 10) return 'Average';
    return 'Poor';
  }

  String _getRatingForDebt(double? debt) {
    if (debt == null) return 'N/A';
    if (debt < 0.1) return 'Excellent';
    if (debt < 0.3) return 'Good';
    if (debt < 0.6) return 'Average';
    return 'High';
  }

  String _getRatingForCurrentRatio(double? ratio) {
    if (ratio == null || ratio <= 0) return 'Poor';
    if (ratio > 2.0) return 'Excellent';
    if (ratio > 1.5) return 'Good';
    if (ratio > 1.0) return 'Average';
    return 'Poor';
  }

  Color _getRatingColor(String rating) {
    switch (rating.toLowerCase()) {
      case 'excellent':
        return Colors.green;
      case 'good':
        return Colors.blue;
      case 'average':
        return Colors.orange;
      case 'poor':
      case 'high':
        return Colors.red;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getOverallRating() {
    int score = 0;
    int total = 0;

    // Calculate overall rating based on individual metrics
    if (widget.company.stockPe != null && widget.company.stockPe! > 0) {
      total++;
      if (widget.company.stockPe! < 15) score++;
    }

    if (widget.company.roe != null && widget.company.roe! > 0) {
      total++;
      if (widget.company.roe! > 15) score++;
    }

    if (widget.company.debtToEquity != null) {
      total++;
      if (widget.company.debtToEquity! < 0.3) score++;
    }

    if (widget.company.currentRatio != null &&
        widget.company.currentRatio! > 0) {
      total++;
      if (widget.company.currentRatio! > 1.5) score++;
    }

    if (total == 0) return 'N/A';

    double percentage = score / total;
    if (percentage >= 0.75) return 'Above Average';
    if (percentage >= 0.5) return 'Average';
    return 'Below Average';
  }

  Color _getOverallRatingColor() {
    final rating = _getOverallRating();
    switch (rating) {
      case 'Above Average':
        return Colors.green;
      case 'Average':
        return Colors.blue;
      case 'Below Average':
        return Colors.orange;
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData _getOverallRatingIcon() {
    final rating = _getOverallRating();
    switch (rating) {
      case 'Above Average':
        return Icons.trending_up;
      case 'Average':
        return Icons.remove;
      case 'Below Average':
        return Icons.trending_down;
      default:
        return Icons.help_outline;
    }
  }

  String _getOverallRatingDescription() {
    final rating = _getOverallRating();
    switch (rating) {
      case 'Above Average':
        return 'Company outperforms sector averages on most key metrics';
      case 'Average':
        return 'Company performance is in line with sector averages';
      case 'Below Average':
        return 'Company underperforms sector averages on several metrics';
      default:
        return 'Insufficient data for peer comparison';
    }
  }

  IconData _getPerformanceIcon(double changePercent) {
    if (changePercent > 0) return Icons.trending_up;
    if (changePercent < 0) return Icons.trending_down;
    return Icons.remove;
  }

  Color _getPerformanceColor(double changePercent) {
    if (changePercent > 0) return Colors.green;
    if (changePercent < 0) return Colors.red;
    return AppTheme.textSecondary;
  }

  // ============================================================================
  // TAB BAR
  // ============================================================================

  Widget _buildEnhancedTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: AppTheme.primaryGreen,
        unselectedLabelColor: AppTheme.textSecondary,
        indicatorColor: AppTheme.primaryGreen,
        indicatorWeight: 3,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Quarterly'),
          Tab(text: 'P&L'),
          Tab(text: 'Balance Sheet'),
          Tab(text: 'Cash Flow'),
          Tab(text: 'Ratios'),
          Tab(text: 'Shareholding'),
        ],
      ),
    );
  }

  // ============================================================================
  // HELPER COLOR METHODS
  // ============================================================================

  Color _getMarketCapColor() {
    if (widget.company.marketCap == null) return AppTheme.textSecondary;
    if (widget.company.marketCap! >= 20000) return Colors.blue;
    if (widget.company.marketCap! >= 5000) return Colors.orange;
    return Colors.purple;
  }

  Color _getQualityColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.red;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getEfficiencyColor(String efficiency) {
    switch (efficiency.toLowerCase()) {
      case 'excellent':
        return Colors.green;
      case 'good':
        return Colors.blue;
      case 'average':
      case 'adequate':
        return Colors.orange;
      case 'poor':
        return Colors.red;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getDebtColor(String debtStatus) {
    switch (debtStatus.toLowerCase()) {
      case 'debt free':
        return Colors.green;
      case 'low debt':
        return Colors.blue;
      case 'moderate debt':
        return Colors.orange;
      case 'high debt':
        return Colors.red;
      default:
        return AppTheme.textSecondary;
    }
  }

  // ============================================================================
  // SHARE FUNCTIONALITY
  // ============================================================================

  void _shareCompany(BuildContext context) {
    final companyInfo = '''
${widget.company.name} (${widget.company.symbol})
Current Price: ${widget.company.formattedPrice}
Change: ${widget.company.formattedChange}
Market Cap: ${widget.company.formattedMarketCap}

📊 Key Metrics:
• P/E Ratio: ${widget.company.stockPe?.toStringAsFixed(1) ?? 'N/A'}
• ROE: ${widget.company.roe != null ? '${widget.company.roe!.toStringAsFixed(1)}%' : 'N/A'}
• Quality Score: ${widget.company.qualityScore}/5 (${widget.company.overallQualityGrade})
• Debt-to-Equity: ${widget.company.debtToEquity?.toStringAsFixed(2) ?? 'N/A'}

💰 Efficiency Metrics:
• Working Capital: ${widget.company.workingCapitalEfficiency}
• Liquidity: ${widget.company.liquidityStatus}
• Cash Cycle: ${widget.company.cashCycleEfficiency}

📈 Growth (3Y):
• Sales: ${widget.company.salesGrowth3Y?.toStringAsFixed(1) ?? 'N/A'}%
• Profit: ${widget.company.profitGrowth3Y?.toStringAsFixed(1) ?? 'N/A'}%

🏆 Peer Ranking: ${_getOverallRating()}

Shared from Enhanced Trading Dashboard
''';

    Share.share(
      companyInfo,
      subject:
          '${widget.company.name} (${widget.company.symbol}) - Stock Analysis',
    );
  }
}
