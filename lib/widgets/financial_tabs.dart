// widgets/financial_tabs.dart
import 'package:flutter/material.dart';
import '../models/company_model.dart';
import '../theme/app_theme.dart';

class FinancialTab extends StatelessWidget {
  final CompanyModel company;
  final String type;
  final bool showProsAndCons; // FIXED: Made this a proper field

  const FinancialTab({
    Key? key,
    required this.company,
    required this.type,
    this.showProsAndCons = false, // FIXED: Made optional with default false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.cardBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFinancialTable(),
            const SizedBox(height: 20),

            // FIXED: Only show pros/cons if explicitly enabled AND data exists
            if (showProsAndCons &&
                (company.pros.isNotEmpty || company.cons.isNotEmpty)) ...[
              _buildProsConsSection(),
              const SizedBox(height: 20),
            ],

            if (type == 'shareholding' && company.shareholdingPattern != null)
              _buildShareholdingDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialTable() {
    final data = _getFinancialData();
    if (data.isEmpty) {
      return _buildNoDataAvailable();
    }

    final headers = _getTableHeaders();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    _getTableTitle(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                ...headers
                    .map((header) => Expanded(
                          child: Text(
                            header,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
          // Table Rows
          ...data.entries
              .map((entry) => _buildTableRow(
                    entry.key,
                    entry.value,
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildNoDataAvailable() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 48,
              color: AppTheme.textSecondary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Financial data not available',
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.textSecondary.withOpacity(0.7),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Data will be updated during the next scraping cycle',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSecondary.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getTableHeaders() {
    switch (type) {
      case 'quarterly':
      case 'profit_loss':
      case 'balance_sheet':
      case 'cash_flow':
        // Get actual quarter headers from data
        final quarters = company.quarterlyDataHistory
            .take(4)
            .map((q) => '${q.quarter} ${q.year}')
            .toList();
        if (quarters.isEmpty) {
          return ['Current', 'Previous', '-2', '-3'];
        }
        return quarters;

      case 'ratios':
        // For ratios, show years from annual data
        final years =
            company.annualDataHistory.take(4).map((a) => a.year).toList();
        if (years.isEmpty) {
          return ['Current', 'FY-1', 'FY-2', 'FY-3'];
        }
        return years;

      case 'shareholding':
        // Get latest quarter data for shareholding
        final shareholding = company.shareholdingPattern?.quarterly;
        if (shareholding?.isNotEmpty == true) {
          return shareholding!.keys.take(4).toList();
        }
        return ['Q1', 'Q2', 'Q3', 'Q4'];

      default:
        return ['Current', 'Previous', '-2', '-3'];
    }
  }

  Map<String, List<String>> _getFinancialData() {
    switch (type) {
      case 'quarterly':
        return _getQuarterlyData();
      case 'profit_loss':
        return _getProfitLossData();
      case 'balance_sheet':
        return _getBalanceSheetData();
      case 'cash_flow':
        return _getCashFlowData();
      case 'ratios':
        return _getRatiosData();
      case 'shareholding':
        return _getShareholdingData();
      default:
        return {};
    }
  }

  Map<String, List<String>> _getQuarterlyData() {
    final quarterlyData = company.quarterlyDataHistory;
    if (quarterlyData.isEmpty) return {};

    final data = <String, List<String>>{};
    final quarters = quarterlyData.take(4).toList();

    data['Sales (₹Cr)'] = quarters
        .map((q) => q.sales != null ? _formatCrores(q.sales!) : 'N/A')
        .toList();

    data['Net Profit (₹Cr)'] = quarters
        .map((q) => q.netProfit != null ? _formatCrores(q.netProfit!) : 'N/A')
        .toList();

    data['EPS (₹)'] =
        quarters.map((q) => q.eps?.toStringAsFixed(2) ?? 'N/A').toList();

    data['EBITDA (₹Cr)'] = quarters
        .map((q) => q.ebitda != null ? _formatCrores(q.ebitda!) : 'N/A')
        .toList();

    return data;
  }

  Map<String, List<String>> _getProfitLossData() {
    final annualData = company.annualDataHistory;
    if (annualData.isEmpty) return {};

    final data = <String, List<String>>{};
    final years = annualData.take(4).toList();

    data['Revenue (₹Cr)'] = years
        .map((y) => y.sales != null ? _formatCrores(y.sales!) : 'N/A')
        .toList();

    data['Net Profit (₹Cr)'] = years
        .map((y) => y.netProfit != null ? _formatCrores(y.netProfit!) : 'N/A')
        .toList();

    data['EPS (₹)'] =
        years.map((y) => y.eps?.toStringAsFixed(2) ?? 'N/A').toList();

    return data;
  }

  Map<String, List<String>> _getBalanceSheetData() {
    final annualData = company.annualDataHistory;
    if (annualData.isEmpty) return {};

    final data = <String, List<String>>{};
    final years = annualData.take(4).toList();

    data['Book Value (₹)'] =
        years.map((y) => y.bookValue?.toStringAsFixed(2) ?? 'N/A').toList();

    // Add more balance sheet items as available in your data model
    return data;
  }

  Map<String, List<String>> _getCashFlowData() {
    // This would need cash flow specific data from your model
    // For now, return empty if no cash flow data structure exists
    return {};
  }

  Map<String, List<String>> _getRatiosData() {
    final annualData = company.annualDataHistory;
    final data = <String, List<String>>{};

    // Current year ratios
    final currentRatios = [
      company.roe?.toStringAsFixed(1) ?? 'N/A',
      company.stockPe?.toStringAsFixed(1) ?? 'N/A',
      company.debtToEquity?.toStringAsFixed(2) ?? 'N/A',
      company.roce?.toStringAsFixed(1) ?? 'N/A',
    ];

    // Historical ratios from annual data
    final years = annualData.take(3).toList();

    data['ROE (%)'] = [
      currentRatios[0],
      ...years.map((y) => y.roe?.toStringAsFixed(1) ?? 'N/A'),
    ];

    data['P/E Ratio'] = [
      currentRatios[1],
      ...years.map((y) => y.peRatio?.toStringAsFixed(1) ?? 'N/A'),
    ];

    data['Debt/Equity'] = [
      currentRatios[2],
      ...List.filled(years.length, 'N/A'), // Historical D/E not in annual model
    ];

    data['ROCE (%)'] = [
      currentRatios[3],
      ...years.map((y) => y.roce?.toStringAsFixed(1) ?? 'N/A'),
    ];

    // Additional ratios
    if (company.currentRatio != null) {
      data['Current Ratio'] = [
        company.currentRatio!.toStringAsFixed(2),
        ...List.filled(3, 'N/A'),
      ];
    }

    if (company.priceToBook != null) {
      data['P/B Ratio'] = [
        company.priceToBook!.toStringAsFixed(2),
        ...years.map((y) => y.pbRatio?.toStringAsFixed(2) ?? 'N/A'),
      ];
    }

    return data;
  }

  Map<String, List<String>> _getShareholdingData() {
    final shareholding = company.shareholdingPattern;
    if (shareholding == null) return {};

    final data = <String, List<String>>{};
    final quarterlyData = shareholding.quarterly;

    if (quarterlyData.isNotEmpty) {
      final quarters = quarterlyData.keys.take(4).toList();

      // Extract shareholding pattern data
      data['Promoter (%)'] =
          quarters.map((q) => quarterlyData[q]?['promoter'] ?? 'N/A').toList();

      data['Public (%)'] =
          quarters.map((q) => quarterlyData[q]?['public'] ?? 'N/A').toList();

      data['Institutional (%)'] = quarters
          .map((q) => quarterlyData[q]?['institutional'] ?? 'N/A')
          .toList();
    }

    return data;
  }

  Widget _buildShareholdingDetails() {
    final shareholding = company.shareholdingPattern!;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Shareholding Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          if (shareholding.promoterHolding != null)
            _buildShareholdingRow('Promoter Holding',
                '${shareholding.promoterHolding!.toStringAsFixed(2)}%'),
          if (shareholding.publicHolding != null)
            _buildShareholdingRow('Public Holding',
                '${shareholding.publicHolding!.toStringAsFixed(2)}%'),
          if (shareholding.institutionalHolding != null)
            _buildShareholdingRow('Institutional Holding',
                '${shareholding.institutionalHolding!.toStringAsFixed(2)}%'),
          if (shareholding.foreignInstitutional != null)
            _buildShareholdingRow('FII Holding',
                '${shareholding.foreignInstitutional!.toStringAsFixed(2)}%'),
          if (shareholding.majorShareholders.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text(
              'Major Shareholders',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            ...shareholding.majorShareholders
                .take(5)
                .map(
                  (shareholder) => _buildShareholdingRow(
                    shareholder.name,
                    '${shareholder.percentage.toStringAsFixed(2)}%',
                  ),
                )
                .toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildShareholdingRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _getTableTitle() {
    switch (type) {
      case 'quarterly':
        return 'Quarterly Results';
      case 'profit_loss':
        return 'Profit & Loss Statement';
      case 'balance_sheet':
        return 'Balance Sheet';
      case 'cash_flow':
        return 'Cash Flow Statement';
      case 'ratios':
        return 'Financial Ratios';
      case 'shareholding':
        return 'Shareholding Pattern';
      default:
        return 'Financial Data';
    }
  }

  Widget _buildTableRow(String label, List<String> values) {
    // Ensure we have exactly 4 values, pad with 'N/A' if needed
    final paddedValues = List<String>.from(values);
    while (paddedValues.length < 4) {
      paddedValues.add('N/A');
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        border:
            Border(bottom: BorderSide(color: AppTheme.borderColor, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ...paddedValues
              .take(4)
              .map((value) => Expanded(
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: value == 'N/A'
                            ? AppTheme.textSecondary
                            : AppTheme.textPrimary,
                        fontWeight:
                            value == 'N/A' ? FontWeight.w400 : FontWeight.w500,
                      ),
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  // FIXED: This method now only gets called when showProsAndCons is true
  Widget _buildProsConsSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Analysis Summary',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          if (company.pros.isNotEmpty) ...[
            const Text(
              'Strengths',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.profitGreen,
              ),
            ),
            const SizedBox(height: 8),
            ...company.pros
                .map((pro) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle,
                              color: AppTheme.profitGreen, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              pro,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            if (company.cons.isNotEmpty) const SizedBox(height: 16),
          ],
          if (company.cons.isNotEmpty) ...[
            const Text(
              'Areas of Concern',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.lossRed,
              ),
            ),
            const SizedBox(height: 8),
            ...company.cons
                .map((con) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning,
                              color: AppTheme.lossRed, size: 16),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              con,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ],
      ),
    );
  }

  String _formatCrores(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(1);
  }
}
