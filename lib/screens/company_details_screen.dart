import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../models/company_model.dart';
import '../widgets/financial_tabs.dart';
import '../providers/fundamental_provider.dart';
import '../theme/app_theme.dart';
import 'company_details_overview.dart';

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
                CompanyDetailsOverview(company: widget.company),
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
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
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

  Widget _buildCleanFinancialTab(String type) {
    return Container(
      color: Colors.grey[50],
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Expanded(
            child: FinancialTabs(
              company: widget.company,
              initialTab: type,
            ),
          ),
        ],
      ),
    );
  }

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
        return Icons.analytics;
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
• Risk Level: ${widget.company.riskLevel}

📈 Growth (3Y):
• Sales: ${widget.company.salesGrowth3Y?.toStringAsFixed(1) ?? 'N/A'}%
• Profit: ${widget.company.profitGrowth3Y?.toStringAsFixed(1) ?? 'N/A'}%

🏢 Business Overview:
${widget.company.businessOverview.isNotEmpty ? widget.company.businessOverview.substring(0, 150) + "..." : "Operating in ${widget.company.formattedSector} sector"}

⭐ Investment Highlights:
${widget.company.investmentHighlights.take(2).map((h) => "• ${h.description}").join("\n")}

🎯 Overall Rating: ${widget.company.overallQualityGrade} Grade

Shared from Enhanced Trading Dashboard
''';

    Share.share(
      companyInfo,
      subject:
          '${widget.company.name} (${widget.company.symbol}) - Enhanced Stock Analysis',
    );
  }
}
