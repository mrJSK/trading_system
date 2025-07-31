import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/company/company_model.dart';
import '../widgets/financial_table_widget.dart';
import '../widgets/company_header_widget.dart';
import '../widgets/ratios_grid_widget.dart';

class CompanyDetailsScreen extends ConsumerStatefulWidget {
  final CompanyModel company;

  const CompanyDetailsScreen({
    super.key,
    required this.company,
  });

  @override
  ConsumerState<CompanyDetailsScreen> createState() =>
      _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends ConsumerState<CompanyDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.symbol ?? 'Company Details'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
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
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Financials'),
            Tab(text: 'Ratios'),
            Tab(text: 'Quarterly'),
            Tab(text: 'Balance Sheet'),
            Tab(text: 'Cash Flow'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Company Header
          CompanyHeaderWidget(company: widget.company),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildFinancialsTab(),
                _buildRatiosTab(),
                _buildQuarterlyTab(),
                _buildBalanceSheetTab(),
                _buildCashFlowTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Key Ratios Grid
          RatiosGridWidget(company: widget.company),

          const SizedBox(height: 24),

          // About Company
          if (widget.company.about != null) ...[
            Text(
              'About Company',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.company.about!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
          ],

          // Pros and Cons
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.company.pros?.isNotEmpty == true)
                Expanded(
                  child: _buildProsConsCard(
                    'Pros',
                    widget.company.pros!,
                    Colors.green,
                    Icons.trending_up,
                  ),
                ),
              const SizedBox(width: 16),
              if (widget.company.cons?.isNotEmpty == true)
                Expanded(
                  child: _buildProsConsCard(
                    'Cons',
                    widget.company.cons!,
                    Colors.red,
                    Icons.trending_down,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProsConsCard(
      String title, List<String> items, Color color, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            margin: const EdgeInsets.only(top: 8, right: 8),
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              item,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profit & Loss Statement',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          if (widget.company.profitLossStatement != null)
            FinancialTableWidget(
              title: 'Annual Results',
              data: widget.company.profitLossStatement!,
            ),
        ],
      ),
    );
  }

  Widget _buildRatiosTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Key Ratios',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          if (widget.company.ratios != null)
            FinancialTableWidget(
              title: 'Financial Ratios',
              data: widget.company.ratios!,
            ),
        ],
      ),
    );
  }

  Widget _buildQuarterlyTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quarterly Results',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          if (widget.company.quarterlyResults != null)
            FinancialTableWidget(
              title: 'Quarterly Performance',
              data: widget.company.quarterlyResults!,
            ),
        ],
      ),
    );
  }

  Widget _buildBalanceSheetTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Balance Sheet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          if (widget.company.balanceSheet != null)
            FinancialTableWidget(
              title: 'Balance Sheet Data',
              data: widget.company.balanceSheet!,
            ),
        ],
      ),
    );
  }

  Widget _buildCashFlowTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cash Flow Statement',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          if (widget.company.cashFlowStatement != null)
            FinancialTableWidget(
              title: 'Cash Flow Data',
              data: widget.company.cashFlowStatement!,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
