// lib/features/home/presentation/widgets/stock_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/company/company_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../models/company/financial_data_model.dart';

class StockDetailScreen extends ConsumerStatefulWidget {
  final CompanyModel company;

  const StockDetailScreen({
    super.key,
    required this.company,
  });

  @override
  ConsumerState<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends ConsumerState<StockDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.company.symbol,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              widget.company.name,
              style: const TextStyle(fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        elevation: 2,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          // Investment Grade Badge
          Container(
            margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: widget.company.investmentGrade.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: widget.company.investmentGrade.color),
            ),
            child: Text(
              widget.company.investmentGrade.displayName,
              style: TextStyle(
                color: widget.company.investmentGrade.color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Add to watchlist functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          isScrollable: true,
          labelStyle:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Financials'),
            Tab(text: 'Ratios'),
            Tab(text: 'Quarterly'),
            Tab(text: 'Balance Sheet'),
            Tab(text: 'Cash Flow'),
            Tab(text: 'Analysis'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Enhanced Company Header
          _buildCompanyHeader(isDarkMode),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(isDarkMode),
                _buildFinancialsTab(isDarkMode),
                _buildRatiosTab(isDarkMode),
                _buildQuarterlyTab(isDarkMode),
                _buildBalanceSheetTab(isDarkMode),
                _buildCashFlowTab(isDarkMode),
                _buildAnalysisTab(isDarkMode),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyHeader(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtitleColor = isDarkMode ? Colors.white70 : Colors.grey.shade600;
    final bgColor = isDarkMode
        ? Theme.of(context).colorScheme.surface
        : Colors.grey.shade50;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          // Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.company.formattedPrice,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        widget.company.formattedChangeAmount,
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.company.isGainer
                              ? Colors.green
                              : widget.company.isLoser
                                  ? Colors.red
                                  : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.company.isGainer
                              ? Colors.green.withOpacity(0.1)
                              : widget.company.isLoser
                                  ? Colors.red.withOpacity(0.1)
                                  : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: widget.company.isGainer
                                ? Colors.green
                                : widget.company.isLoser
                                    ? Colors.red
                                    : Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          widget.company.formattedChange,
                          style: TextStyle(
                            color: widget.company.isGainer
                                ? Colors.green
                                : widget.company.isLoser
                                    ? Colors.red
                                    : Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      widget.company.marketCapCategory,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Updated: ${_formatTime(widget.company.lastUpdated)}',
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Quick Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuickMetric(
                'Market Cap',
                widget.company.formattedMarketCap,
                Icons.pie_chart,
                isDarkMode,
              ),
              _buildQuickMetric(
                'P/E Ratio',
                widget.company.stockPe?.toStringAsFixed(1) ?? 'N/A',
                Icons.trending_up,
                isDarkMode,
              ),
              _buildQuickMetric(
                'ROE',
                widget.company.roe != null
                    ? '${widget.company.roe!.toStringAsFixed(1)}%'
                    : 'N/A',
                Icons.donut_large,
                isDarkMode,
              ),
              _buildQuickMetric(
                'Debt/Equity',
                widget.company.debtToEquity?.toStringAsFixed(2) ?? 'N/A',
                Icons.account_balance,
                isDarkMode,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickMetric(
      String label, String value, IconData icon, bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white70 : Colors.grey.shade600;
    final valueColor = isDarkMode ? Colors.white : Colors.black87;

    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewTab(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Investment Analysis Card
          _buildInvestmentAnalysisCard(isDarkMode),
          const SizedBox(height: 16),

          // Key Ratios Grid
          _buildKeyRatiosCard(isDarkMode),
          const SizedBox(height: 16),

          // Performance Metrics
          _buildPerformanceMetricsCard(isDarkMode),
          const SizedBox(height: 16),

          // Company Information
          if (widget.company.about != null && widget.company.about!.isNotEmpty)
            _buildAboutCard(isDarkMode),

          const SizedBox(height: 16),

          // Industry and Sector
          _buildIndustryCard(isDarkMode),

          const SizedBox(height: 16),

          // Pros and Cons
          if (widget.company.pros.isNotEmpty || widget.company.cons.isNotEmpty)
            _buildProsConsCard(isDarkMode),
        ],
      ),
    );
  }

  Widget _buildInvestmentAnalysisCard(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Investment Analysis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color:
                        widget.company.investmentGrade.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: widget.company.investmentGrade.color),
                  ),
                  child: Text(
                    widget.company.investmentGrade.displayName,
                    style: TextStyle(
                      color: widget.company.investmentGrade.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAnalysisIndicator(
                  'Strong Financials',
                  widget.company.hasStrongFinancials,
                  isDarkMode,
                ),
                _buildAnalysisIndicator(
                  'Undervalued',
                  widget.company.isUndervalued,
                  isDarkMode,
                ),
                _buildAnalysisIndicator(
                  'Growth Potential',
                  widget.company.hasGrowthPotential,
                  isDarkMode,
                ),
                _buildAnalysisIndicator(
                  'Complete Data',
                  widget.company.hasCompleteFinancialData,
                  isDarkMode,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisIndicator(
      String label, bool isPositive, bool isDarkMode) {
    return Column(
      children: [
        Icon(
          isPositive ? Icons.check_circle : Icons.cancel,
          color: isPositive ? Colors.green : Colors.red,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isPositive ? Colors.green : Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildKeyRatiosCard(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Key Financial Ratios',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            if (widget.company.ratiosData.isNotEmpty) ...[
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 2.2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                children:
                    widget.company.ratiosData.entries.take(8).map((entry) {
                  return _buildRatioItem(
                      entry.key, entry.value?.toString() ?? 'N/A', isDarkMode);
                }).toList(),
              ),
            ] else ...[
              Text(
                'No ratios data available',
                style: TextStyle(color: textColor),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRatioItem(String title, String value, bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final subtitleColor = isDarkMode ? Colors.white70 : Colors.grey.shade600;
    final bgColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade50;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: subtitleColor,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceMetricsCard(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Performance Metrics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                if (widget.company.salesGrowth != null)
                  _buildMetricItem(
                      'Sales Growth',
                      '${widget.company.salesGrowth!.toStringAsFixed(1)}%',
                      Colors.blue,
                      isDarkMode),
                if (widget.company.profitGrowth != null)
                  _buildMetricItem(
                      'Profit Growth',
                      '${widget.company.profitGrowth!.toStringAsFixed(1)}%',
                      Colors.purple,
                      isDarkMode),
                if (widget.company.operatingMargin != null)
                  _buildMetricItem(
                      'Op. Margin',
                      '${widget.company.operatingMargin!.toStringAsFixed(1)}%',
                      Colors.orange,
                      isDarkMode),
                if (widget.company.netMargin != null)
                  _buildMetricItem(
                      'Net Margin',
                      '${widget.company.netMargin!.toStringAsFixed(1)}%',
                      Colors.teal,
                      isDarkMode),
                if (widget.company.currentRatio != null)
                  _buildMetricItem(
                      'Current Ratio',
                      widget.company.currentRatio!.toStringAsFixed(2),
                      Colors.green,
                      isDarkMode),
                if (widget.company.quickRatio != null)
                  _buildMetricItem(
                      'Quick Ratio',
                      widget.company.quickRatio!.toStringAsFixed(2),
                      Colors.indigo,
                      isDarkMode),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(
      String title, String value, Color color, bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white70 : Colors.grey.shade600;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About ${widget.company.name}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.company.about!,
              style: TextStyle(
                color: textColor,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndustryCard(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Industry & Sector',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            if (widget.company.sector != null) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.business, size: 20),
                title: const Text('Sector'),
                subtitle: Text(widget.company.sector!),
              ),
            ],
            if (widget.company.industry != null) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.factory, size: 20),
                title: const Text('Industry'),
                subtitle: Text(widget.company.industry!),
              ),
            ],
            if (widget.company.industryClassification.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text('Classification:',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Wrap(
                children:
                    widget.company.industryClassification.map((classification) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8, bottom: 8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      classification,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProsConsCard(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Investment Highlights',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pros
                if (widget.company.pros.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.trending_up,
                                color: Colors.green, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Strengths',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...widget.company.pros.map((pro) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.only(top: 6, right: 8),
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      pro,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: textColor,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),

                const SizedBox(width: 16),

                // Cons
                if (widget.company.cons.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.trending_down,
                                color: Colors.red, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Concerns',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...widget.company.cons.map((con) => Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.only(top: 6, right: 8),
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      con,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: textColor,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Enhanced Financial Statements Tabs with Working Tables
  Widget _buildFinancialsTab(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Always show test table first to verify tables work
          _buildTestTable('Test Financial Table', isDarkMode),
          const SizedBox(height: 16),

          // Debug info
          _buildDebugInfo('Profit & Loss Statement',
              widget.company.profitLossStatement, isDarkMode),
          const SizedBox(height: 16),

          // Try to show actual financial data
          if (widget.company.profitLossStatement != null)
            _buildFinancialDataTable('Profit & Loss Statement',
                widget.company.profitLossStatement!, isDarkMode)
          else
            _buildNoDataCard('No profit & loss data available', isDarkMode),

          const SizedBox(height: 16),

          if (widget.company.balanceSheet != null)
            _buildFinancialDataTable(
                'Balance Sheet', widget.company.balanceSheet!, isDarkMode)
          else
            _buildNoDataCard('No balance sheet data available', isDarkMode),
        ],
      ),
    );
  }

  Widget _buildRatiosTab(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // This should definitely work - ratiosData is a Map
          _buildRatiosDataTable(isDarkMode),
          const SizedBox(height: 16),

          // Debug ratios FinancialDataModel
          if (widget.company.ratios != null) ...[
            _buildDebugInfo(
                'Ratios Analysis', widget.company.ratios, isDarkMode),
            const SizedBox(height: 16),
            _buildFinancialDataTable('Financial Ratios Analysis',
                widget.company.ratios!, isDarkMode),
          ],
        ],
      ),
    );
  }

  Widget _buildQuarterlyTab(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Show latest quarterly highlights
          if (widget.company.latestQuarterlyRevenue != null ||
              widget.company.latestQuarterlyProfit != null) ...[
            _buildQuarterlyHighlights(isDarkMode),
            const SizedBox(height: 16),
          ],

          if (widget.company.quarterlyResults != null) ...[
            _buildDebugInfo('Quarterly Results',
                widget.company.quarterlyResults, isDarkMode),
            const SizedBox(height: 16),
            _buildFinancialDataTable('Quarterly Results',
                widget.company.quarterlyResults!, isDarkMode),
          ] else
            _buildNoDataCard('No quarterly data available', isDarkMode),
        ],
      ),
    );
  }

  Widget _buildBalanceSheetTab(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (widget.company.balanceSheet != null) ...[
            _buildDebugInfo(
                'Balance Sheet', widget.company.balanceSheet, isDarkMode),
            const SizedBox(height: 16),
            _buildFinancialDataTable('Balance Sheet Analysis',
                widget.company.balanceSheet!, isDarkMode),
          ] else
            _buildNoDataCard('No balance sheet data available', isDarkMode),
        ],
      ),
    );
  }

  Widget _buildCashFlowTab(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (widget.company.cashFlowStatement != null) ...[
            _buildDebugInfo('Cash Flow Statement',
                widget.company.cashFlowStatement, isDarkMode),
            const SizedBox(height: 16),
            _buildFinancialDataTable('Cash Flow Statement',
                widget.company.cashFlowStatement!, isDarkMode),
          ] else
            _buildNoDataCard('No cash flow data available', isDarkMode),
        ],
      ),
    );
  }

  Widget _buildAnalysisTab(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Investment Grade Analysis
          _buildInvestmentAnalysisCard(isDarkMode),
          const SizedBox(height: 16),

          // Valuation Metrics
          _buildValuationMetricsCard(isDarkMode),
          const SizedBox(height: 16),

          // Growth Analysis
          if (widget.company.growthTables.isNotEmpty)
            _buildGrowthAnalysisCard(isDarkMode),

          const SizedBox(height: 16),

          // Peer Comparison
          if (widget.company.peerCompanies.isNotEmpty)
            _buildPeerComparisonCard(isDarkMode),
        ],
      ),
    );
  }

  // Working Table Methods
  Widget _buildTestTable(String title, bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final headerColor =
        isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title (Should Always Show)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 16,
                dataRowHeight: 45,
                headingRowHeight: 50,
                headingRowColor: MaterialStateProperty.all(headerColor),
                border: TableBorder.all(
                  color:
                      isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
                  width: 0.5,
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      'Financial Item',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '2023',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '2022',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '2021',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Revenue',
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.w500))),
                    DataCell(
                        Text('₹1,234 Cr', style: TextStyle(color: textColor))),
                    DataCell(
                        Text('₹1,100 Cr', style: TextStyle(color: textColor))),
                    DataCell(
                        Text('₹980 Cr', style: TextStyle(color: textColor))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Net Profit',
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.w500))),
                    DataCell(
                        Text('₹456 Cr', style: TextStyle(color: textColor))),
                    DataCell(
                        Text('₹390 Cr', style: TextStyle(color: textColor))),
                    DataCell(
                        Text('₹320 Cr', style: TextStyle(color: textColor))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Total Assets',
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.w500))),
                    DataCell(
                        Text('₹5,678 Cr', style: TextStyle(color: textColor))),
                    DataCell(
                        Text('₹5,200 Cr', style: TextStyle(color: textColor))),
                    DataCell(
                        Text('₹4,800 Cr', style: TextStyle(color: textColor))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('ROE',
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.w500))),
                    DataCell(
                        Text('18.5%', style: TextStyle(color: Colors.green))),
                    DataCell(
                        Text('16.2%', style: TextStyle(color: Colors.green))),
                    DataCell(
                        Text('14.8%', style: TextStyle(color: Colors.orange))),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDebugInfo(String title, dynamic data, bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title Debug Info',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Data Type: ${data.runtimeType}\n'
                'Is Null: ${data == null}\n'
                'Has Data: ${data != null ? (data.toString().length > 10 ? 'Yes' : 'No') : 'N/A'}\n'
                'Preview: ${data != null ? data.toString().substring(0, data.toString().length > 100 ? 100 : data.toString().length) : 'null'}...',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialDataTable(
      String title, FinancialDataModel financialData, bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final headerColor =
        isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100;

    // Handle null or empty data
    if (financialData == null) {
      return _buildNoDataCard('$title data is null', isDarkMode);
    }

    // Try to access properties safely
    try {
      if (financialData.isEmpty) {
        return _buildNoDataCard('$title data is empty', isDarkMode);
      }

      final headers = financialData.headers ?? [];
      final body = financialData.body ?? [];

      if (headers.isEmpty || body.isEmpty) {
        return _buildNoDataCard(
            '$title has no headers or body data', isDarkMode);
      }

      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 12,
                  dataRowHeight: 40,
                  headingRowHeight: 45,
                  headingRowColor: MaterialStateProperty.all(headerColor),
                  border: TableBorder.all(
                    color: isDarkMode
                        ? Colors.grey.shade600
                        : Colors.grey.shade300,
                    width: 0.5,
                  ),
                  columns: [
                    DataColumn(
                      label: Container(
                        width: 120,
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: textColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    ...headers
                        .map((header) => DataColumn(
                              label: Container(
                                width: 80,
                                child: Text(
                                  header.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ))
                        .toList(),
                  ],
                  rows: body.map<DataRow>((row) {
                    final description = row.description ?? 'Unknown';
                    final values = row.values ?? [];

                    return DataRow(
                      cells: [
                        DataCell(
                          Container(
                            width: 120,
                            child: Text(
                              description,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: textColor,
                                fontSize: 11,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        ...values
                            .map((value) => DataCell(
                                  Container(
                                    width: 80,
                                    child: Text(
                                      value?.toString() ?? 'N/A',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 11,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      return _buildNoDataCard('Error processing $title: $e', isDarkMode);
    }
  }

  Widget _buildRatiosDataTable(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final headerColor =
        isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100;

    if (widget.company.ratiosData.isEmpty) {
      return Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(Icons.info_outline, color: Colors.orange, size: 48),
              const SizedBox(height: 8),
              Text(
                'No ratios data available in ratiosData map',
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 8),
              Text(
                'RatiosData keys: ${widget.company.ratiosData.keys.length}',
                style: TextStyle(color: textColor, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complete Financial Ratios (${widget.company.ratiosData.length} items)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                dataRowHeight: 45,
                headingRowHeight: 50,
                headingRowColor: MaterialStateProperty.all(headerColor),
                border: TableBorder.all(
                  color:
                      isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
                  width: 0.5,
                ),
                columns: [
                  DataColumn(
                    label: Container(
                      width: 150,
                      child: Text(
                        'Ratio Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Container(
                      width: 100,
                      child: Text(
                        'Value',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ],
                rows: widget.company.ratiosData.entries.map<DataRow>((entry) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Container(
                          width: 150,
                          child: Text(
                            entry.key,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            entry.value?.toString() ?? 'N/A',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuarterlyHighlights(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Latest Quarter Highlights',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (widget.company.latestQuarterlyRevenue != null)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.trending_up, color: Colors.blue),
                          const SizedBox(height: 4),
                          Text(
                            'Revenue',
                            style: TextStyle(
                              fontSize: 12,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '₹${widget.company.latestQuarterlyRevenue!.toStringAsFixed(2)} Cr',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                if (widget.company.latestQuarterlyProfit != null)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: Colors.green.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.account_balance_wallet,
                              color: Colors.green),
                          const SizedBox(height: 4),
                          Text(
                            'Net Profit',
                            style: TextStyle(
                              fontSize: 12,
                              color: textColor,
                            ),
                          ),
                          Text(
                            '₹${widget.company.latestQuarterlyProfit!.toStringAsFixed(2)} Cr',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValuationMetricsCard(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Valuation Metrics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: [
                if (widget.company.priceToBook != null)
                  _buildMetricItem(
                      'P/B Ratio',
                      widget.company.priceToBook!.toStringAsFixed(2),
                      Colors.indigo,
                      isDarkMode),
                if (widget.company.evToEbitda != null)
                  _buildMetricItem(
                      'EV/EBITDA',
                      widget.company.evToEbitda!.toStringAsFixed(2),
                      Colors.purple,
                      isDarkMode),
                if (widget.company.pegRatio != null)
                  _buildMetricItem(
                      'PEG Ratio',
                      widget.company.pegRatio!.toStringAsFixed(2),
                      Colors.orange,
                      isDarkMode),
                if (widget.company.earningsPerShare != null)
                  _buildMetricItem(
                      'EPS',
                      '₹${widget.company.earningsPerShare!.toStringAsFixed(2)}',
                      Colors.teal,
                      isDarkMode),
                if (widget.company.dividendPerShare != null)
                  _buildMetricItem(
                      'DPS',
                      '₹${widget.company.dividendPerShare!.toStringAsFixed(2)}',
                      Colors.pink,
                      isDarkMode),
                if (widget.company.bookValue != null)
                  _buildMetricItem(
                      'Book Value',
                      '₹${widget.company.bookValue!.toStringAsFixed(2)}',
                      Colors.cyan,
                      isDarkMode),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthAnalysisCard(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Growth Analysis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            ...widget.company.growthTables.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.key,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (entry.value is Map<String, dynamic>) ...[
                      ...(entry.value as Map<String, dynamic>)
                          .entries
                          .map((subEntry) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  subEntry.key,
                                  style: TextStyle(color: textColor),
                                ),
                              ),
                              Text(
                                subEntry.value.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPeerComparisonCard(bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Peer Companies',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              children: widget.company.peerCompanies.map((peer) {
                return Container(
                  margin: const EdgeInsets.only(right: 8, bottom: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Text(
                    peer,
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoDataCard(String message, bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.grey.shade400,
                size: 48,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Utility method for formatting time
  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return 'Unknown';
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
