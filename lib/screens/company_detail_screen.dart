import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/company.dart';
import '../models/company_data.dart';
import '../services/database_service.dart';

class CompanyDetailScreen extends StatefulWidget {
  final Company company;

  const CompanyDetailScreen({Key? key, required this.company})
      : super(key: key);

  @override
  _CompanyDetailScreenState createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
  final DatabaseService _databaseService = DatabaseService();
  CompanyData? _companyData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCompanyData();
  }

  Future<void> _loadCompanyData() async {
    try {
      final data = await _databaseService.getCompanyData(widget.company.id!);
      setState(() {
        _companyData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Error loading company data: $e', Colors.red);
    }
  }

  double? _parseNumber(String text) {
    try {
      return double.tryParse(text.replaceAll(RegExp(r'[₹$,\s]'), ''));
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.company.name,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        elevation: 2,
        shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.7)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: _buildSliverWidgets(),
            ),
    );
  }

  List<Widget> _buildSliverWidgets() {
    final widgets = <Widget>[
      // Basic Info and Company Details
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Info Card
              AnimatedOpacity(
                opacity: _companyData != null ? 1.0 : 0.8,
                duration: const Duration(milliseconds: 300),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.company.name,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 22,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Symbol: ${widget.company.symbol}',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                        ),
                        if (widget.company.currentPrice != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'Current Price: ₹${widget.company.currentPrice!.toStringAsFixed(2)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.green,
                                  ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // NEW: Sector Hierarchy Card
              if (_companyData?.sector != null &&
                  _companyData!.sector!.isNotEmpty)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.category, color: Colors.blue, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Classification',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildClassificationRow(
                            'Sector', _companyData!.sector, Icons.public),
                        if (_companyData!.industry != null &&
                            _companyData!.industry!.isNotEmpty)
                          _buildClassificationRow('Industry',
                              _companyData!.industry, Icons.business),
                        if (_companyData!.subIndustry != null &&
                            _companyData!.subIndustry!.isNotEmpty)
                          _buildClassificationRow('Sub-Industry',
                              _companyData!.subIndustry, Icons.inventory),
                        if (_companyData!.category != null &&
                            _companyData!.category!.isNotEmpty)
                          _buildClassificationRow(
                              'Category', _companyData!.category, Icons.label),
                      ],
                    ),
                  ),
                ),
              if (_companyData?.sector != null &&
                  _companyData!.sector!.isNotEmpty)
                const SizedBox(height: 16),

              // Company Description Card (if available)
              if (_companyData?.companyDescription != null &&
                  _companyData!.companyDescription!.isNotEmpty)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About ${widget.company.name}',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _companyData!.companyDescription!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 14, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ),
              if (_companyData?.companyDescription != null &&
                  _companyData!.companyDescription!.isNotEmpty)
                const SizedBox(height: 16),

              // Pros and Cons Cards (if available)
              if (_companyData?.pros != null &&
                      _companyData!.pros!.isNotEmpty ||
                  _companyData?.cons != null && _companyData!.cons!.isNotEmpty)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_companyData?.pros != null &&
                        _companyData!.pros!.isNotEmpty)
                      Expanded(
                        child: Card(
                          elevation: 3,
                          color: Colors.green.withOpacity(0.05),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.thumb_up,
                                        color: Colors.green, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Key Points',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _companyData!.pros!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (_companyData?.pros != null &&
                        _companyData!.pros!.isNotEmpty &&
                        _companyData?.cons != null &&
                        _companyData!.cons!.isNotEmpty)
                      const SizedBox(width: 8),
                    if (_companyData?.cons != null &&
                        _companyData!.cons!.isNotEmpty)
                      Expanded(
                        child: Card(
                          elevation: 3,
                          color: Colors.red.withOpacity(0.05),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.thumb_down,
                                        color: Colors.red, size: 20),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Concerns',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _companyData!.cons!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              if (_companyData?.pros != null &&
                      _companyData!.pros!.isNotEmpty ||
                  _companyData?.cons != null && _companyData!.cons!.isNotEmpty)
                const SizedBox(height: 16),

              // Price History Chart Placeholder
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price History',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Price history chart placeholder\n(Data not available)',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ];

    // Add financial data widgets if available
    if (_companyData != null) {
      widgets.addAll([
        SliverToBoxAdapter(child: _buildFinancialMetricsCard()),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        // NEW: Peer Comparison Table
        if (_companyData!.peerComparison != null &&
            _companyData!.peerComparison!.isNotEmpty)
          SliverToBoxAdapter(
              child: _buildTableCard(
                  'Peer Comparison', _companyData!.peerComparison)),
        if (_companyData!.peerComparison != null &&
            _companyData!.peerComparison!.isNotEmpty)
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

        SliverToBoxAdapter(
            child: _buildTableCard(
                'Quarterly Results', _companyData!.quarterlyResults)),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
            child: _buildTableCard('Profit & Loss', _companyData!.profitLoss)),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
            child:
                _buildTableCard('Balance Sheet', _companyData!.balanceSheet)),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
            child: _buildTableCard('Cash Flows', _companyData!.cashFlows)),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverToBoxAdapter(
            child: _buildTableCard('Ratios', _companyData!.ratios)),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ]);
    } else {
      widgets.addAll([
        SliverToBoxAdapter(
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning, color: Colors.orange, size: 32),
                  SizedBox(height: 12),
                  Text(
                    'No detailed data available for this company.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ]);
    }

    return widgets;
  }

  // NEW: Helper method for classification rows
  Widget _buildClassificationRow(String label, String? value, IconData icon) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialMetricsCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Financial Metrics',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
            ),
            const SizedBox(height: 16),
            if (_companyData!.marketCap != null)
              _buildMetricRow('Market Cap',
                  '₹${_companyData!.marketCap!.toStringAsFixed(0)} Cr'),
            if (_companyData!.pe != null)
              _buildMetricRow(
                  'P/E Ratio', _companyData!.pe!.toStringAsFixed(2)),
            if (_companyData!.pb != null)
              _buildMetricRow(
                  'P/B Ratio', _companyData!.pb!.toStringAsFixed(2)),
            if (_companyData!.bookValue != null)
              _buildMetricRow('Book Value',
                  '₹${_companyData!.bookValue!.toStringAsFixed(2)}'),
            if (_companyData!.dividendYield != null)
              _buildMetricRow('Dividend Yield',
                  '${_companyData!.dividendYield!.toStringAsFixed(2)}%'),
            if (_companyData!.roce != null)
              _buildMetricRow(
                  'ROCE', '${_companyData!.roce!.toStringAsFixed(2)}%'),
            if (_companyData!.roe != null)
              _buildMetricRow(
                  'ROE', '${_companyData!.roe!.toStringAsFixed(2)}%'),
            if (_companyData!.faceValue != null)
              _buildMetricRow('Face Value',
                  '₹${_companyData!.faceValue!.toStringAsFixed(2)}'),
            if (_companyData!.highLow != null) _buildHighLowMetricRow(),
          ],
        ),
      ),
    );
  }

  // FIXED: Separate method for high/low metric
  Widget _buildHighLowMetricRow() {
    final parts =
        _companyData!.highLow!.split('/').map((s) => s.trim()).toList();
    final high = parts.isNotEmpty ? _parseNumber(parts[0]) : null;
    final low = parts.length > 1 ? _parseNumber(parts[1]) : null;

    return _buildMetricRow(
      '52 Week High/Low',
      '₹${high?.toStringAsFixed(2) ?? 'N/A'} / ₹${low?.toStringAsFixed(2) ?? 'N/A'}',
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCard(String title, String? jsonData) {
    Map<String, dynamic>? data;

    try {
      data = jsonData != null
          ? jsonDecode(jsonData) as Map<String, dynamic>?
          : null;
    } catch (e) {
      data = null;
    }

    if (data == null || (data.isNotEmpty && data.containsKey('error'))) {
      return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                data != null && data.containsKey('error')
                    ? data['error'].toString()
                    : 'No data available',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                ),
                // NEW: Show sector hierarchy for peer comparison
                if (title == 'Peer Comparison' &&
                    data['sectorHierarchy'] != null)
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          data['sectorHierarchy']['sector'] ?? '',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: _buildTableColumns(data),
                rows: _buildTableRows(data),
                columnSpacing: 24,
                horizontalMargin: 0,
                dataRowMinHeight: 48,
                headingRowHeight: 48,
                headingTextStyle:
                    Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                dataTextStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontSize: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            // NEW: Show table metadata
            if (data['totalRows'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Showing ${data['totalRows']} rows × ${data['totalColumns']} columns',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> _buildTableColumns(Map<String, dynamic> data) {
    final headers = data['headers'] as List<dynamic>? ?? [];
    final columns = <DataColumn>[];

    // Build columns based on actual headers
    for (int i = 0; i < headers.length; i++) {
      columns.add(
        DataColumn(
          label: Text(
            headers[i].toString(),
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
      );
    }

    return columns;
  }

  List<DataRow> _buildTableRows(Map<String, dynamic> data) {
    final rows = <DataRow>[];
    final rowData = data['rows'] as List<dynamic>? ?? [];
    final headers = data['headers'] as List<dynamic>? ?? [];
    final expectedColumnCount = headers.length;

    for (final rowItem in rowData) {
      final row = rowItem as List<dynamic>? ?? [];
      final cells = <DataCell>[];

      // Ensure each row has exactly the same number of cells as headers
      for (int i = 0; i < expectedColumnCount; i++) {
        String cellValue = '';
        if (i < row.length) {
          cellValue = row[i]?.toString() ?? '';
        }

        cells.add(
          DataCell(
            Text(
              cellValue,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: cellValue.isEmpty ? Colors.grey[400] : null,
                  ),
            ),
          ),
        );
      }

      // Only add the row if it has the correct number of cells
      if (cells.length == expectedColumnCount) {
        rows.add(DataRow(cells: cells));
      }
    }

    return rows;
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 14)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
