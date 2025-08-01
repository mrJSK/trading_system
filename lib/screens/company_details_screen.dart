// screens/company_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    _tabController = TabController(length: 6, vsync: this);
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
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareCompany(context),
          ),
          IconButton(
            icon: Icon(
              isInWatchlist ? Icons.favorite : Icons.favorite_border,
              color: isInWatchlist ? Colors.red : null,
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
          _buildCompanyHeader(),
          _buildQuickStats(),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                FinancialTab(company: widget.company, type: 'quarterly'),
                FinancialTab(company: widget.company, type: 'profit_loss'),
                FinancialTab(company: widget.company, type: 'balance_sheet'),
                FinancialTab(company: widget.company, type: 'cash_flow'),
                FinancialTab(company: widget.company, type: 'ratios'),
                FinancialTab(company: widget.company, type: 'shareholding'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
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
                        ),
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: widget.company.isGainer
                          ? AppTheme.profitGreen.withOpacity(0.1)
                          : widget.company.isLoser
                              ? AppTheme.lossRed.withOpacity(0.1)
                              : AppTheme.textSecondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
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
                  ),
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

          // Quality and Risk Indicators
          Row(
            children: [
              _buildQualityBadge(),
              const SizedBox(width: 8),
              _buildRiskBadge(),
              const Spacer(),
              if (widget.company.isDebtFree)
                _buildIndicatorChip('Debt Free', Colors.green),
              const SizedBox(width: 4),
              if (widget.company.paysDividends)
                _buildIndicatorChip('Dividend', Colors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppTheme.cardBackground,
      child: Column(
        children: [
          // Primary metrics
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

          // Secondary metrics
          Row(
            children: [
              Expanded(
                  child: _buildMetricCard('Book Value',
                      widget.company.bookValue?.toStringAsFixed(1) ?? 'N/A')),
              Expanded(
                  child: _buildMetricCard(
                      'Debt/Equity',
                      widget.company.debtToEquity?.toStringAsFixed(2) ??
                          'N/A')),
              Expanded(
                  child: _buildMetricCard(
                      'Div Yield',
                      widget.company.dividendYield != null
                          ? '${widget.company.dividendYield!.toStringAsFixed(1)}%'
                          : 'N/A')),
              Expanded(
                  child: _buildMetricCard(
                      'ROCE',
                      widget.company.roce != null
                          ? '${widget.company.roce!.toStringAsFixed(1)}%'
                          : 'N/A')),
            ],
          ),

          // Growth metrics (if available)
          if (widget.company.salesGrowth3Y != null ||
              widget.company.profitGrowth3Y != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: _buildMetricCard(
                        'Sales Growth (3Y)',
                        widget.company.salesGrowth3Y != null
                            ? '${widget.company.salesGrowth3Y!.toStringAsFixed(1)}%'
                            : 'N/A')),
                Expanded(
                    child: _buildMetricCard(
                        'Profit Growth (3Y)',
                        widget.company.profitGrowth3Y != null
                            ? '${widget.company.profitGrowth3Y!.toStringAsFixed(1)}%'
                            : 'N/A')),
                Expanded(
                    child: _buildMetricCard(
                        'Sales CAGR (5Y)',
                        widget.company.salesCAGR5Y != null
                            ? '${widget.company.salesCAGR5Y!.toStringAsFixed(1)}%'
                            : 'N/A')),
                Expanded(
                    child: _buildMetricCard('Beta',
                        widget.company.betaValue?.toStringAsFixed(2) ?? 'N/A')),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: value == 'N/A'
                  ? AppTheme.textSecondary
                  : AppTheme.textPrimary,
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

  Widget _buildQualityBadge() {
    final score = widget.company.qualityScore;
    Color color;
    String text;

    if (score >= 4) {
      color = Colors.green;
      text = 'Excellent';
    } else if (score >= 3) {
      color = Colors.blue;
      text = 'Good';
    } else if (score >= 2) {
      color = Colors.orange;
      text = 'Average';
    } else {
      color = Colors.red;
      text = 'Poor';
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
          Icon(Icons.star, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            'Quality: $text',
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

  Color _getMarketCapColor() {
    if (widget.company.marketCap == null) return AppTheme.textSecondary;
    if (widget.company.marketCap! >= 20000) return Colors.blue;
    if (widget.company.marketCap! >= 5000) return Colors.orange;
    return Colors.purple;
  }

  Widget _buildTabBar() {
    return Container(
      color: Colors.white,
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        labelColor: AppTheme.primaryGreen,
        unselectedLabelColor: AppTheme.textSecondary,
        indicatorColor: AppTheme.primaryGreen,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        tabs: const [
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

  void _shareCompany(BuildContext context) {
    final companyInfo = '''
${widget.company.name} (${widget.company.symbol})
Current Price: ${widget.company.formattedPrice}
Change: ${widget.company.formattedChange}
Market Cap: ${widget.company.formattedMarketCap}
P/E Ratio: ${widget.company.stockPe?.toStringAsFixed(1) ?? 'N/A'}
ROE: ${widget.company.roe != null ? '${widget.company.roe!.toStringAsFixed(1)}%' : 'N/A'}
Quality Score: ${widget.company.qualityScore}/5

Shared from Trading Dashboard
''';

    // In a real app, you would use share_plus package
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Company'),
        content: SingleChildScrollView(
          child: Text(companyInfo),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement actual sharing functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Sharing functionality would be implemented here')),
              );
            },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }
}
