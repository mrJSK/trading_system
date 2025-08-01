import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/company_model.dart';
import '../models/financial_data_model.dart';

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
    _tabController = TabController(length: 6, vsync: this);
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
              widget.company.displayName,
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
          ],
        ),
      ),
      body: Column(
        children: [
          _buildCompanyHeader(isDarkMode),
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
                        _formatChangeAmount(),
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
                      _getMarketCapCategory(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Updated: ${_formatLastUpdated()}',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuickMetric(
                'Market Cap',
                _formatMarketCap(),
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
                'ROCE',
                widget.company.roce != null
                    ? '${widget.company.roce!.toStringAsFixed(1)}%'
                    : 'N/A',
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
          _buildKeyRatiosCard(isDarkMode),
          const SizedBox(height: 16),
          if (widget.company.about != null && widget.company.about!.isNotEmpty)
            _buildAboutCard(isDarkMode),
          const SizedBox(height: 16),
          _buildIndustryCard(isDarkMode),
          const SizedBox(height: 16),
          if (widget.company.pros.isNotEmpty || widget.company.cons.isNotEmpty)
            _buildProsConsCard(isDarkMode),
        ],
      ),
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
          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300,
        ),
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
              'Industry Classification',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            if (widget.company.industryClassification.isNotEmpty) ...[
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
            ] else ...[
              Text(
                'No industry classification available',
                style: TextStyle(color: textColor),
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

  Widget _buildFinancialsTab(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (widget.company.profitLossStatement != null)
            _buildFinancialDataTable('Profit & Loss Statement',
                widget.company.profitLossStatement!, isDarkMode)
          else
            _buildNoDataCard('No profit & loss data available', isDarkMode),
        ],
      ),
    );
  }

  Widget _buildRatiosTab(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildRatiosDataTable(isDarkMode),
          const SizedBox(height: 16),
          if (widget.company.ratios != null)
            _buildFinancialDataTable('Financial Ratios Analysis',
                widget.company.ratios!, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildQuarterlyTab(bool isDarkMode) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (widget.company.quarterlyResults != null)
            _buildFinancialDataTable('Quarterly Results',
                widget.company.quarterlyResults!, isDarkMode)
          else
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
          if (widget.company.balanceSheet != null)
            _buildFinancialDataTable('Balance Sheet Analysis',
                widget.company.balanceSheet!, isDarkMode)
          else
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
          if (widget.company.cashFlowStatement != null)
            _buildFinancialDataTable('Cash Flow Statement',
                widget.company.cashFlowStatement!, isDarkMode)
          else
            _buildNoDataCard('No cash flow data available', isDarkMode),
        ],
      ),
    );
  }

  Widget _buildFinancialDataTable(
      String title, FinancialDataModel financialData, bool isDarkMode) {
    final textColor = isDarkMode ? Colors.white : Colors.black87;
    final headerColor =
        isDarkMode ? Colors.grey.shade700 : Colors.grey.shade100;

    if (financialData.isEmpty) {
      return _buildNoDataCard('$title data is empty', isDarkMode);
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
                  color:
                      isDarkMode ? Colors.grey.shade600 : Colors.grey.shade300,
                  width: 0.5,
                ),
                columns: [
                  DataColumn(
                    label: SizedBox(
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
                  ...financialData.headers.map((header) => DataColumn(
                        label: SizedBox(
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
                      )),
                ],
                rows: financialData.body.map<DataRow>((row) {
                  return DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: 120,
                          child: Text(
                            row.description,
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
                      ...row.values.map((value) => DataCell(
                            SizedBox(
                              width: 80,
                              child: Text(
                                value,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 11,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
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
                'No ratios data available',
                style: TextStyle(color: textColor),
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
              'Financial Ratios (${widget.company.ratiosData.length} items)',
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
                    label: SizedBox(
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
                    label: SizedBox(
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
                        SizedBox(
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

  // Helper methods
  String _getMarketCapCategory() {
    if (widget.company.marketCap == null) return 'Unknown';
    if (widget.company.marketCap! >= 20000) return 'Large Cap';
    if (widget.company.marketCap! >= 5000) return 'Mid Cap';
    return 'Small Cap';
  }

  String _formatMarketCap() {
    if (widget.company.marketCap == null) return 'N/A';
    if (widget.company.marketCap! >= 100000) {
      return '₹${(widget.company.marketCap! / 100000).toStringAsFixed(0)}L Cr';
    } else if (widget.company.marketCap! >= 1000) {
      return '₹${(widget.company.marketCap! / 1000).toStringAsFixed(0)}K Cr';
    } else {
      return '₹${widget.company.marketCap!.toStringAsFixed(0)} Cr';
    }
  }

  String _formatChangeAmount() {
    if (widget.company.changeAmount == 0.0) return '₹0.00';
    final sign = widget.company.changeAmount > 0 ? '+' : '';
    return '$sign₹${widget.company.changeAmount.abs().toStringAsFixed(2)}';
  }

  String _formatLastUpdated() {
    try {
      final date = DateTime.parse(widget.company.lastUpdated);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
