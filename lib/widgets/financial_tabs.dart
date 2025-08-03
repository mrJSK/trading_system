import 'package:flutter/material.dart';
import '../models/company_model.dart';
import '../theme/app_theme.dart';

class FinancialTabs extends StatelessWidget {
  final CompanyModel company;
  final String initialTab;

  const FinancialTabs({
    Key? key,
    required this.company,
    required this.initialTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FinancialTab(
      company: company,
      type: initialTab,
      showProsAndCons: initialTab == 'overview',
    );
  }
}

class FinancialTab extends StatelessWidget {
  final CompanyModel company;
  final String type;
  final bool showProsAndCons;

  const FinancialTab({
    Key? key,
    required this.company,
    required this.type,
    this.showProsAndCons = false,
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
            _buildEnhancedFinancialHeader(),
            const SizedBox(height: 16),
            _buildFinancialTable(),
            const SizedBox(height: 20),
            if (showProsAndCons &&
                (company.pros.isNotEmpty || company.cons.isNotEmpty))
              _buildProsConsSection(),
            if (showProsAndCons &&
                (company.pros.isNotEmpty || company.cons.isNotEmpty))
              const SizedBox(height: 20),
            if (type == 'shareholding') _buildShareholdingDetails(),
            if (type == 'ratios') _buildEnhancedRatiosInsights(),
            if (type == 'quarterly' && company.quarterlyDataHistory.isNotEmpty)
              _buildQuarterlyTrends(),
            if (type == 'profit_loss') _buildProfitabilityAnalysis(),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedFinancialHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryGreen.withOpacity(0.05),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getTabIcon(),
              color: AppTheme.primaryGreen,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getTableTitle(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  '${company.name} (${company.symbol})',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Updated: ${_formatLastUpdated()}',
              style: TextStyle(
                fontSize: 10,
                color: AppTheme.primaryGreen.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatLastUpdated() {
    try {
      final now = DateTime.now();
      final lastUpdated = DateTime.parse(company.lastUpdated);
      final difference = now.difference(lastUpdated);

      if (difference.inDays > 7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Recently';
    }
  }

  IconData _getTabIcon() {
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

  Widget _buildFinancialTable() {
    final data = _getFinancialData();
    if (data.isEmpty) {
      return _buildEnhancedNoDataState();
    }

    final headers = _getTableHeaders();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'Particulars',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryGreen.withOpacity(0.8),
                    ),
                  ),
                ),
                ...headers.map((header) => Expanded(
                      child: Text(
                        header,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryGreen.withOpacity(0.8),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          ...data.entries
              .map((entry) => _buildEnhancedTableRow(entry.key, entry.value)),
        ],
      ),
    );
  }

  Widget _buildEnhancedNoDataState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getTabIcon(),
              size: 48,
              color: AppTheme.primaryGreen.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'No ${_getTableTitle()} Available',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Financial data will be updated during the next scraping cycle',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'Check other financial tabs for available data',
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.primaryGreen.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedTableRow(String label, List<String> values) {
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
          ...paddedValues.take(4).map((value) => Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: _getValueColor(value, label),
                      fontWeight:
                          value == 'N/A' ? FontWeight.w400 : FontWeight.w500,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Color _getValueColor(String value, String rowLabel) {
    if (value == 'N/A' || value.isEmpty) return AppTheme.textSecondary;

    final cleanValue = value.replaceAll(RegExp(r'[^\d.-]'), '');
    final numValue = double.tryParse(cleanValue);

    if (numValue != null) {
      if (rowLabel.contains('Loss') || rowLabel.contains('Debt')) {
        return numValue > 0 ? AppTheme.lossRed : AppTheme.profitGreen;
      }
      if (rowLabel.contains('Profit') ||
          rowLabel.contains('Revenue') ||
          rowLabel.contains('Growth')) {
        return numValue > 0 ? AppTheme.profitGreen : AppTheme.lossRed;
      }
    }

    return AppTheme.textPrimary;
  }

  Widget _buildEnhancedRatiosInsights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights, color: AppTheme.primaryGreen, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Key Ratio Insights',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildRatioInsightRow('Profitability',
              company.roe != null && company.roe! > 15 ? 'Strong' : 'Moderate'),
          _buildRatioInsightRow(
              'Valuation',
              company.stockPe != null && company.stockPe! < 20
                  ? 'Attractive'
                  : 'Premium'),
          _buildRatioInsightRow(
              'Leverage',
              company.debtToEquity != null && company.debtToEquity! < 0.5
                  ? 'Conservative'
                  : 'Moderate'),
          _buildRatioInsightRow(
              'Liquidity',
              company.currentRatio != null && company.currentRatio! > 1.5
                  ? 'Healthy'
                  : 'Adequate'),
          // Enhanced quality insights
          _buildRatioInsightRow('Quality Score',
              '${company.qualityScore}/5 (${company.overallQualityGrade})'),
          _buildRatioInsightRow('Piotroski Score',
              '${company.calculatedPiotroskiScore.toInt()}/9'),
          _buildRatioInsightRow('Altman Z-Score',
              company.calculatedAltmanZScore.toStringAsFixed(1)),
        ],
      ),
    );
  }

  Widget _buildRatioInsightRow(String metric, String assessment) {
    Color assessmentColor;
    switch (assessment) {
      case 'Strong':
      case 'Healthy':
      case 'Conservative':
        assessmentColor = AppTheme.profitGreen;
        break;
      case 'Attractive':
        assessmentColor = Colors.blue;
        break;
      case 'Premium':
        assessmentColor = Colors.orange;
        break;
      default:
        // Handle score-based assessments
        if (assessment.contains('/')) {
          final parts = assessment.split('/');
          if (parts.length == 2) {
            final current = double.tryParse(parts[0]);
            final max = double.tryParse(parts[1].split(' ')[0]);
            if (current != null && max != null) {
              final ratio = current / max;
              if (ratio >= 0.8) {
                assessmentColor = AppTheme.profitGreen;
              } else if (ratio >= 0.6) {
                assessmentColor = Colors.blue;
              } else if (ratio >= 0.4) {
                assessmentColor = Colors.orange;
              } else {
                assessmentColor = AppTheme.lossRed;
              }
            } else {
              assessmentColor = AppTheme.textSecondary;
            }
          } else {
            assessmentColor = AppTheme.textSecondary;
          }
        } else {
          // Handle numeric scores like Altman Z-Score
          final score = double.tryParse(assessment);
          if (score != null) {
            if (score > 3.0) {
              assessmentColor = AppTheme.profitGreen;
            } else if (score > 1.8) {
              assessmentColor = Colors.orange;
            } else {
              assessmentColor = AppTheme.lossRed;
            }
          } else {
            assessmentColor = AppTheme.textSecondary;
          }
        }
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            metric,
            style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: assessmentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              assessment,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: assessmentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuarterlyTrends() {
    if (company.quarterlyDataHistory.length < 2) return const SizedBox.shrink();

    final recent = company.quarterlyDataHistory.first;
    final previous = company.quarterlyDataHistory[1];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: AppTheme.primaryGreen, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Quarter-over-Quarter Trends',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (recent.sales != null && previous.sales != null)
            _buildTrendRow('Sales Growth',
                _calculateGrowth(recent.sales!, previous.sales!)),
          if (recent.netProfit != null && previous.netProfit != null)
            _buildTrendRow('Profit Growth',
                _calculateGrowth(recent.netProfit!, previous.netProfit!)),
          if (recent.ebitda != null && previous.ebitda != null)
            _buildTrendRow('EBITDA Growth',
                _calculateGrowth(recent.ebitda!, previous.ebitda!)),
          if (recent.eps != null && previous.eps != null)
            _buildTrendRow(
                'EPS Growth', _calculateGrowth(recent.eps!, previous.eps!)),
          if (recent.profitMargin != null && previous.profitMargin != null)
            _buildTrendRow('Margin Change',
                _calculateGrowth(recent.profitMargin!, previous.profitMargin!)),
        ],
      ),
    );
  }

  Widget _buildTrendRow(String metric, double growth) {
    final isPositive = growth >= 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            metric,
            style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary),
          ),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                size: 16,
                color: isPositive ? AppTheme.profitGreen : AppTheme.lossRed,
              ),
              const SizedBox(width: 4),
              Text(
                '${growth >= 0 ? '+' : ''}${growth.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isPositive ? AppTheme.profitGreen : AppTheme.lossRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateGrowth(double current, double previous) {
    if (previous == 0) return 0;
    return ((current - previous) / previous) * 100;
  }

  Widget _buildProfitabilityAnalysis() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics_outlined,
                  color: AppTheme.primaryGreen, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Profitability Analysis',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildAnalysisItem(
              'ROE Performance',
              company.roe != null
                  ? '${company.roe!.toStringAsFixed(1)}%'
                  : 'N/A'),
          _buildAnalysisItem(
              'ROCE Performance',
              company.roce != null
                  ? '${company.roce!.toStringAsFixed(1)}%'
                  : 'N/A'),
          _buildAnalysisItem(
              'Profit Growth (3Y)',
              company.profitGrowth3Y != null
                  ? '${company.profitGrowth3Y!.toStringAsFixed(1)}%'
                  : 'N/A'),
          _buildAnalysisItem('Quality Score',
              '${company.qualityScore}/5 (${company.overallQualityGrade})'),
          _buildAnalysisItem('Comprehensive Score',
              '${company.calculatedComprehensiveScore.toInt()}/100'),
          _buildAnalysisItem(
              'Investment Grade', company.calculatedInvestmentGrade),
          _buildAnalysisItem('Risk Level', company.calculatedRiskAssessment),
          if (company.calculatedGrahamNumber != null)
            _buildAnalysisItem('Graham Value',
                '₹${company.calculatedGrahamNumber!.toStringAsFixed(0)}'),
          if (company.safetyMargin != null)
            _buildAnalysisItem('Safety Margin',
                '${company.safetyMargin!.toStringAsFixed(1)}%'),
        ],
      ),
    );
  }

  Widget _buildAnalysisItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: AppTheme.textPrimary),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getTableHeaders() {
    switch (type) {
      case 'quarterly':
      case 'profit_loss':
      case 'balance_sheet':
      case 'cash_flow':
        final quarters = company.quarterlyDataHistory
            .take(4)
            .map((q) => '${q.quarter} ${q.year}')
            .toList();
        if (quarters.isEmpty) {
          return ['Current', 'Previous', '-2', '-3'];
        }
        return quarters;
      case 'ratios':
        final years =
            company.annualDataHistory.take(4).map((a) => a.year).toList();
        if (years.isEmpty) {
          return ['Current', 'FY-1', 'FY-2', 'FY-3'];
        }
        return years;
      case 'shareholding':
        return ['Latest', 'Q-1', 'Q-2', 'Q-3'];
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

    data['Operating Profit (₹Cr)'] = quarters
        .map((q) => q.operatingProfit != null
            ? _formatCrores(q.operatingProfit!)
            : 'N/A')
        .toList();

    data['Total Income (₹Cr)'] = quarters
        .map((q) =>
            q.totalIncome != null ? _formatCrores(q.totalIncome!) : 'N/A')
        .toList();

    data['Profit Margin (%)'] = quarters
        .map((q) => q.profitMargin?.toStringAsFixed(1) ?? 'N/A')
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

    data['Operating Profit (₹Cr)'] = years
        .map((y) => y.operatingProfit != null
            ? _formatCrores(y.operatingProfit!)
            : 'N/A')
        .toList();

    data['EBITDA (₹Cr)'] = years
        .map((y) => y.ebitda != null ? _formatCrores(y.ebitda!) : 'N/A')
        .toList();

    data['Gross Profit (₹Cr)'] = years
        .map((y) =>
            y.grossProfit != null ? _formatCrores(y.grossProfit!) : 'N/A')
        .toList();

    data['Interest Expense (₹Cr)'] = years
        .map((y) => y.interestExpense != null
            ? _formatCrores(y.interestExpense!)
            : 'N/A')
        .toList();

    data['Tax Expense (₹Cr)'] = years
        .map((y) => y.taxExpense != null ? _formatCrores(y.taxExpense!) : 'N/A')
        .toList();

    return data;
  }

  Map<String, List<String>> _getBalanceSheetData() {
    final annualData = company.annualDataHistory;
    if (annualData.isEmpty) return {};

    final data = <String, List<String>>{};
    final years = annualData.take(4).toList();

    data['Total Assets (₹Cr)'] = years
        .map((y) =>
            y.totalAssets != null ? _formatCrores(y.totalAssets!) : 'N/A')
        .toList();

    data['Total Liabilities (₹Cr)'] = years
        .map((y) => y.totalLiabilities != null
            ? _formatCrores(y.totalLiabilities!)
            : 'N/A')
        .toList();

    data['Shareholders Equity (₹Cr)'] = years
        .map((y) => y.shareholdersEquity != null
            ? _formatCrores(y.shareholdersEquity!)
            : 'N/A')
        .toList();

    data['Total Debt (₹Cr)'] = years
        .map((y) => y.totalDebt != null ? _formatCrores(y.totalDebt!) : 'N/A')
        .toList();

    data['Working Capital (₹Cr)'] = years
        .map((y) =>
            y.workingCapital != null ? _formatCrores(y.workingCapital!) : 'N/A')
        .toList();

    data['Book Value (₹)'] =
        years.map((y) => y.bookValue?.toStringAsFixed(2) ?? 'N/A').toList();

    return data;
  }

  Map<String, List<String>> _getCashFlowData() {
    final annualData = company.annualDataHistory;
    if (annualData.isEmpty) return {};

    final data = <String, List<String>>{};
    final years = annualData.take(4).toList();

    data['Operating Cash Flow (₹Cr)'] = years
        .map((y) => y.operatingCashFlow != null
            ? _formatCrores(y.operatingCashFlow!)
            : 'N/A')
        .toList();

    data['Investing Cash Flow (₹Cr)'] = years
        .map((y) => y.investingCashFlow != null
            ? _formatCrores(y.investingCashFlow!)
            : 'N/A')
        .toList();

    data['Financing Cash Flow (₹Cr)'] = years
        .map((y) => y.financingCashFlow != null
            ? _formatCrores(y.financingCashFlow!)
            : 'N/A')
        .toList();

    data['Free Cash Flow (₹Cr)'] = years
        .map((y) =>
            y.freeCashFlow != null ? _formatCrores(y.freeCashFlow!) : 'N/A')
        .toList();

    data['Capital Expenditures (₹Cr)'] = years
        .map((y) => y.capitalExpenditures != null
            ? _formatCrores(y.capitalExpenditures!)
            : 'N/A')
        .toList();

    return data;
  }

  Map<String, List<String>> _getRatiosData() {
    final annualData = company.annualDataHistory;
    final data = <String, List<String>>{};

    final currentRatios = [
      company.roe?.toStringAsFixed(1) ?? 'N/A',
      company.stockPe?.toStringAsFixed(1) ?? 'N/A',
      company.debtToEquity?.toStringAsFixed(2) ?? 'N/A',
      company.roce?.toStringAsFixed(1) ?? 'N/A',
    ];

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
      ...years.map((y) => y.debtToEquity?.toStringAsFixed(2) ?? 'N/A'),
    ];

    data['ROCE (%)'] = [
      currentRatios[3],
      ...years.map((y) => y.roce?.toStringAsFixed(1) ?? 'N/A'),
    ];

    if (company.currentRatio != null) {
      data['Current Ratio'] = [
        company.currentRatio!.toStringAsFixed(2),
        ...years.map((y) => y.currentRatio?.toStringAsFixed(2) ?? 'N/A'),
      ];
    }

    if (company.priceToBook != null) {
      data['P/B Ratio'] = [
        company.priceToBook!.toStringAsFixed(2),
        ...years.map((y) => y.pbRatio?.toStringAsFixed(2) ?? 'N/A'),
      ];
    }

    if (company.quickRatio != null) {
      data['Quick Ratio'] = [
        company.quickRatio!.toStringAsFixed(2),
        ...years.map((y) => y.quickRatio?.toStringAsFixed(2) ?? 'N/A'),
      ];
    }

    // Add advanced ratios
    if (company.calculatedROIC != null) {
      data['ROIC (%)'] = [
        company.calculatedROIC!.toStringAsFixed(1),
        ...List.filled(3, 'N/A'),
      ];
    }

    if (company.calculatedFCFYield != null) {
      data['FCF Yield (%)'] = [
        company.calculatedFCFYield!.toStringAsFixed(1),
        ...List.filled(3, 'N/A'),
      ];
    }

    if (company.dividendYield != null) {
      data['Dividend Yield (%)'] = [
        company.dividendYield!.toStringAsFixed(1),
        ...List.filled(3, 'N/A'),
      ];
    }

    return data;
  }

  Map<String, List<String>> _getShareholdingData() {
    final data = <String, List<String>>{};

    // Use the company shareholding data from the model
    if (company.promoterHolding != null) {
      data['Promoter (%)'] = [
        company.promoterHolding!.toStringAsFixed(2),
        'N/A',
        'N/A',
        'N/A',
      ];
    }

    if (company.publicHolding != null) {
      data['Public (%)'] = [
        company.publicHolding!.toStringAsFixed(2),
        'N/A',
        'N/A',
        'N/A',
      ];
    }

    if (company.institutionalHolding != null) {
      data['Institutional (%)'] = [
        company.institutionalHolding!.toStringAsFixed(2),
        'N/A',
        'N/A',
        'N/A',
      ];
    }

    return data;
  }

  Widget _buildShareholdingDetails() {
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
          if (company.promoterHolding != null)
            _buildShareholdingRow('Promoter Holding',
                '${company.promoterHolding!.toStringAsFixed(2)}%'),
          if (company.publicHolding != null)
            _buildShareholdingRow('Public Holding',
                '${company.publicHolding!.toStringAsFixed(2)}%'),
          if (company.institutionalHolding != null)
            _buildShareholdingRow('Institutional Holding',
                '${company.institutionalHolding!.toStringAsFixed(2)}%'),
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
            ...company.pros.map((pro) => Padding(
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
                )),
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
            ...company.cons.map(
              (con) => Padding(
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
              ),
            ),
          ],
          // Add investment highlights section
          if (company.investmentHighlights.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              'Investment Highlights',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            ...company.investmentHighlights.take(3).map(
                  (highlight) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.lightbulb,
                            color: _getHighlightColor(highlight.impact),
                            size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            highlight.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ],
      ),
    );
  }

  Color _getHighlightColor(String impact) {
    switch (impact.toLowerCase()) {
      case 'positive':
        return Colors.green;
      case 'negative':
        return Colors.red;
      case 'neutral':
        return Colors.blue;
      default:
        return Colors.orange;
    }
  }

  String _formatCrores(double value) {
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }
    return value.toStringAsFixed(1);
  }
}
