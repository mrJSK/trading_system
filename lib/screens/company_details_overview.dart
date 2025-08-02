import 'package:flutter/material.dart';
import '../models/company_model.dart';
import '../theme/app_theme.dart';

class CompanyDetailsOverview extends StatelessWidget {
  final CompanyModel company;

  const CompanyDetailsOverview({Key? key, required this.company})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildEnhancedCompanyHeader(),
          _buildEnhancedQuickStats(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (company.businessOverview.isNotEmpty)
                  _buildBusinessOverviewSection(),
                if (company.businessOverview.isNotEmpty)
                  const SizedBox(height: 16),
                _buildEnhancedCompanyAboutSection(),
                const SizedBox(height: 16),
                _buildKeyPointsSection(),
                const SizedBox(height: 16),
                _buildCompanyHistoryTimeline(),
                const SizedBox(height: 16),
                _buildEnhancedQuickAnalysis(),
                const SizedBox(height: 16),
                _buildEnhancedWorkingCapitalAnalysis(),
                const SizedBox(height: 16),
                _buildEnhancedFinancialHealthCard(),
                const SizedBox(height: 16),
                _buildEnhancedGrowthAnalysis(),
                const SizedBox(height: 16),
                if (company.investmentHighlights.isNotEmpty)
                  _buildInvestmentHighlightsSection(),
                if (company.investmentHighlights.isNotEmpty)
                  const SizedBox(height: 16),
                _buildEnhancedPeersComparisonSection(),
                const SizedBox(height: 16),
                if (_hasAnalysisSummary()) _buildEnhancedProsConsSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
                      company.name,
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
                          company.symbol,
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
                    if (company.sector != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        company.sector!,
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
                    company.formattedPrice,
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
                    'Updated: ${company.formattedLastUpdated}',
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

  Widget _buildMarketCapChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getMarketCapColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getMarketCapColor().withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        company.marketCapCategoryText,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: _getMarketCapColor(),
        ),
      ),
    );
  }

  Color _getMarketCapColor() {
    if (company.marketCap == null) return AppTheme.textSecondary;
    if (company.marketCap! >= 20000) return Colors.blue;
    if (company.marketCap! >= 5000) return Colors.orange;
    return Colors.purple;
  }

  Widget _buildPriceChangeChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: company.isGainer
            ? AppTheme.profitGreen.withOpacity(0.1)
            : company.isLoser
                ? AppTheme.lossRed.withOpacity(0.1)
                : AppTheme.textSecondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        company.formattedChange,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: company.isGainer
              ? AppTheme.profitGreen
              : company.isLoser
                  ? AppTheme.lossRed
                  : AppTheme.textSecondary,
        ),
      ),
    );
  }

  Widget _buildEnhancedIndicatorsRow() {
    return Row(
      children: [
        Expanded(child: _buildQualityIndicators()),
        _buildRiskBadge(),
      ],
    );
  }

  Widget _buildQualityIndicators() {
    final indicators = <Widget>[];

    if (company.isDebtFree) {
      indicators.add(_buildIndicatorChip('Debt Free', Colors.green));
    }
    if (company.paysDividends) {
      indicators.add(_buildIndicatorChip('Dividend', Colors.blue));
    }
    if (company.isGrowthStock) {
      indicators.add(_buildIndicatorChip('Growth', Colors.purple));
    }
    if (company.isQualityStock) {
      indicators.add(_buildIndicatorChip('Quality', Colors.teal));
    }
    if (company.workingCapitalEfficiency == 'Excellent') {
      indicators.add(_buildIndicatorChip('Efficient WC', Colors.green));
    }

    if (indicators.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: indicators.take(4).toList(),
    );
  }

  Widget _buildIndicatorChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 0.5,
        ),
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

  Widget _buildRiskBadge() {
    final riskLevel = company.riskLevel;
    Color riskColor = _getRiskColor(riskLevel);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: riskColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: riskColor.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            riskLevel.toLowerCase() == 'high'
                ? Icons.trending_up
                : riskLevel.toLowerCase() == 'low'
                    ? Icons.shield
                    : Icons.timeline,
            size: 10,
            color: riskColor,
          ),
          const SizedBox(width: 2),
          Text(
            'Risk: $riskLevel',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: riskColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedQuickStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
              child: _buildStatCard(
                  'P/E', company.stockPe?.toStringAsFixed(1) ?? 'N/A')),
          Expanded(
              child: _buildStatCard(
                  'ROE',
                  company.roe != null
                      ? '${company.roe!.toStringAsFixed(1)}%'
                      : 'N/A')),
          Expanded(
              child: _buildStatCard('Quality', '${company.qualityScore}/5')),
          Expanded(
              child: _buildStatCard(
                  'D/E', company.debtToEquity?.toStringAsFixed(2) ?? 'N/A')),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
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

  Widget _buildBusinessOverviewSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.business_center, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Business Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (company.sector?.isNotEmpty == true)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    ),
                    child: Text(
                      company.sector!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryGreen.withOpacity(0.05),
                    AppTheme.primaryGreen.withOpacity(0.02),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: AppTheme.primaryGreen.withOpacity(0.1)),
              ),
              child: Text(
                company.businessOverview,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                  height: 1.6,
                ),
              ),
            ),
            if (company.industryClassification.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: company.industryClassification
                    .take(3)
                    .map((classification) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.indigo.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: Colors.indigo.withOpacity(0.3)),
                          ),
                          child: Text(
                            classification,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.indigo,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildKeyPointsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.lightbulb_outline,
                    color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Key Points & Highlights',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildKeyPointItem(
              Icons.business_center,
              'Business Overview',
              _getBusinessOverviewText(),
              Colors.blue,
            ),
            _buildKeyPointItem(
              Icons.trending_up,
              'Financial Performance',
              _getFinancialPerformanceText(),
              Colors.green,
            ),
            _buildKeyPointItem(
              Icons.public,
              'Market Position',
              _getMarketPositionText(),
              Colors.orange,
            ),
            _buildKeyPointItem(
              Icons.new_releases,
              'Recent Developments',
              _getRecentDevelopments(),
              Colors.purple,
            ),
            _buildKeyPointItem(
              Icons.star,
              'Investment Highlights',
              _getInvestmentHighlights(),
              Colors.amber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyPointItem(
      IconData icon, String title, String content, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
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
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyHistoryTimeline() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.timeline, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Company History & Milestones',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ..._getHistoryTimeline().map((item) => _buildTimelineItem(
                  item['year'] as String,
                  item['title'] as String,
                  item['description'] as String,
                  item['color'] as Color,
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
      String year, String title, String description, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              Container(
                width: 2,
                height: 40,
                color: color.withOpacity(0.3),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: color.withOpacity(0.3)),
                      ),
                      child: Text(
                        year,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvestmentHighlightsSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star_border, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Investment Highlights',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...company.investmentHighlights
                .map((highlight) => _buildInvestmentHighlightItem(highlight)),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestmentHighlightItem(InvestmentHighlight highlight) {
    Color color = _getHighlightColor(highlight.impact);
    IconData icon = _getHighlightIcon(highlight.type);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  highlight.type.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  highlight.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textPrimary,
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

  Widget _buildEnhancedCompanyAboutSection() {
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
                  'Company Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildInfoItem(
                              'Sector', company.formattedSector)),
                      Expanded(
                          child: _buildInfoItem(
                              'Industry', company.formattedIndustry)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                          child: _buildInfoItem(
                              'Market Cap', company.formattedMarketCap)),
                      Expanded(
                          child: _buildInfoItem(
                              'Category', company.marketCapCategoryText)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                          child: _buildInfoItem(
                              'Quality Grade', company.overallQualityGrade)),
                      Expanded(
                          child:
                              _buildInfoItem('Risk Level', company.riskLevel)),
                    ],
                  ),
                ],
              ),
            ),
            if (company.about?.isNotEmpty == true) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Text(
                  company.about!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedQuickAnalysis() {
    return Card(
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
                  'Quick Analysis',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildAnalysisRow(
                'Overall Quality',
                '${company.overallQualityGrade} (${company.qualityScore}/5)',
                _getQualityColor(company.overallQualityGrade)),
            _buildAnalysisRow(
                'Working Capital',
                company.workingCapitalEfficiency,
                _getEfficiencyColor(company.workingCapitalEfficiency)),
            _buildAnalysisRow('Cash Cycle', company.cashCycleEfficiency,
                _getEfficiencyColor(company.cashCycleEfficiency)),
            _buildAnalysisRow('Liquidity', company.liquidityStatus,
                _getEfficiencyColor(company.liquidityStatus)),
            _buildAnalysisRow('Debt Status', company.debtStatus,
                _getDebtColor(company.debtStatus)),
            _buildAnalysisRow('Risk Assessment', company.riskLevel,
                _getRiskColor(company.riskLevel)),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withOpacity(0.3)),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedWorkingCapitalAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.account_balance_wallet,
                    color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Working Capital Analysis',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildWCMetric(
                    'Working Capital Days',
                    company.workingCapitalDays?.toStringAsFixed(0) ?? 'N/A',
                    'Days',
                  ),
                ),
                Expanded(
                  child: _buildWCMetric(
                    'Debtor Days',
                    company.debtorDays?.toStringAsFixed(0) ?? 'N/A',
                    'Days',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildWCMetric(
                    'Inventory Days',
                    company.inventoryDays?.toStringAsFixed(0) ?? 'N/A',
                    'Days',
                  ),
                ),
                Expanded(
                  child: _buildWCMetric(
                    'Cash Conversion Cycle',
                    company.cashConversionCycle?.toStringAsFixed(0) ?? 'N/A',
                    'Days',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildWCMetric(
                    'Current Ratio',
                    company.currentRatio?.toStringAsFixed(2) ?? 'N/A',
                    'x',
                  ),
                ),
                Expanded(
                  child: _buildWCMetric(
                    'Quick Ratio',
                    company.quickRatio?.toStringAsFixed(2) ?? 'N/A',
                    'x',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWCMetric(String label, String value, String unit) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                unit,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedFinancialHealthCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.health_and_safety,
                    color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Financial Health',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildHealthMetric(
                    'Overall Quality',
                    company.overallQualityGrade,
                    _getQualityColor(company.overallQualityGrade),
                  ),
                ),
                Expanded(
                  child: _buildHealthMetric(
                    'Debt Status',
                    company.debtStatus,
                    _getDebtColor(company.debtStatus),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildHealthMetric(
                    'Liquidity',
                    company.liquidityStatus,
                    _getEfficiencyColor(company.liquidityStatus),
                  ),
                ),
                Expanded(
                  child: _buildHealthMetric(
                    'Risk Level',
                    company.riskLevel,
                    _getRiskColor(company.riskLevel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthMetric(String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedGrowthAnalysis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.trending_up, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Growth Analysis',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildGrowthMetric(
                    'Sales Growth (3Y)',
                    company.salesGrowth3Y != null
                        ? '${company.salesGrowth3Y!.toStringAsFixed(1)}%'
                        : 'N/A',
                  ),
                ),
                Expanded(
                  child: _buildGrowthMetric(
                    'Profit Growth (3Y)',
                    company.profitGrowth3Y != null
                        ? '${company.profitGrowth3Y!.toStringAsFixed(1)}%'
                        : 'N/A',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildGrowthMetric(
                    'Dividend Yield',
                    company.dividendYield != null
                        ? '${company.dividendYield!.toStringAsFixed(1)}%'
                        : 'N/A',
                  ),
                ),
                Expanded(
                  child: _buildGrowthMetric(
                    'ROCE',
                    company.roce != null
                        ? '${company.roce!.toStringAsFixed(1)}%'
                        : 'N/A',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthMetric(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
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

  Widget _buildEnhancedPeersComparisonSection() {
    return Card(
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
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.cardBackground,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  Text(
                    'Sector: ${company.formattedSector}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (company.industry != null)
                    Text(
                      'Industry: ${company.industry}',
                      style: const TextStyle(
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
    );
  }

  Widget _buildEnhancedProsConsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.balance, color: AppTheme.primaryGreen),
                const SizedBox(width: 8),
                const Text(
                  'Pros & Cons Analysis',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (company.pros.isNotEmpty) ...[
              const Text(
                'Strengths',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              ...company.pros.map((pro) => _buildProConItem(pro, true)),
              const SizedBox(height: 16),
            ],
            if (company.cons.isNotEmpty) ...[
              const Text(
                'Areas of Concern',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              ...company.cons.map((con) => _buildProConItem(con, false)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProConItem(String text, bool isPro) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isPro ? Icons.check_circle : Icons.cancel,
            color: isPro ? Colors.green : Colors.red,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getBusinessOverviewText() {
    if (company.businessOverview.isNotEmpty) {
      return company.businessOverview.length > 200
          ? '${company.businessOverview.substring(0, 200)}...'
          : company.businessOverview;
    }
    return '${company.name} operates in the ${company.formattedSector} sector'
        '${company.industry != null ? ", specifically in ${company.industry}" : ""}. '
        'With a market capitalization of ${company.formattedMarketCap}, '
        'the company is classified as a ${company.marketCapCategoryText.toLowerCase()} entity.';
  }

  String _getFinancialPerformanceText() {
    final roe =
        company.roe != null ? '${company.roe!.toStringAsFixed(1)}%' : 'N/A';
    final pe = company.stockPe?.toStringAsFixed(1) ?? 'N/A';
    final quality = company.qualityScore;

    return 'Current ROE of $roe demonstrates ${_getRoeAssessment(company.roe)}. '
        'Trading at P/E ratio of $pe with overall quality score of $quality/5 '
        '(${company.overallQualityGrade} grade). '
        '${company.paysDividends ? "Regular dividend payer" : "Non-dividend paying company"}.';
  }

  String _getMarketPositionText() {
    return 'Listed on ${company.nseCode != null ? "NSE" : ""}${company.bseCode != null ? " and BSE" : ""} '
        'as part of the ${company.marketCapCategoryText} segment. '
        '${company.isGrowthStock ? "Growth-oriented" : company.isValueStock ? "Value-oriented" : "Balanced"} '
        'investment profile with ${company.workingCapitalEfficiency.toLowerCase()} working capital management.';
  }

  String _getRecentDevelopments() {
    final changePercent = company.changePercent;
    final trend = changePercent > 0
        ? "positive momentum"
        : changePercent < 0
            ? "recent decline"
            : "stable performance";

    return 'Stock showing $trend with ${changePercent >= 0 ? "+" : ""}${changePercent.toStringAsFixed(2)}% movement. '
        '${company.liquidityStatus} liquidity position with ${company.riskLevel.toLowerCase()} risk profile. '
        'Working capital efficiency rated as ${company.workingCapitalEfficiency.toLowerCase()}.';
  }

  String _getInvestmentHighlights() {
    final highlights = <String>[];

    if (company.isDebtFree) highlights.add("debt-free balance sheet");
    if (company.paysDividends) highlights.add("dividend-paying");
    if (company.roe != null && company.roe! > 15)
      highlights.add("strong ROE performance");
    if (company.qualityScore >= 4) highlights.add("high-quality metrics");
    if (company.currentRatio != null && company.currentRatio! > 2)
      highlights.add("excellent liquidity");

    if (highlights.isEmpty) {
      return "Investment considerations include market positioning, financial metrics, and growth prospects. "
          "Detailed analysis recommended for investment decisions.";
    }

    return "Key investment highlights: ${highlights.join(", ")}. "
        "Quality score of ${company.qualityScore}/5 reflects overall financial health and operational efficiency.";
  }

  List<Map<String, dynamic>> _getHistoryTimeline() {
    final timeline = <Map<String, dynamic>>[];

    timeline.add({
      'year': DateTime.now().year.toString(),
      'title': 'Current Performance',
      'description':
          'Trading at ${company.formattedPrice} with ${company.changePercent >= 0 ? "gains" : "decline"} of ${company.changePercent.toStringAsFixed(2)}%. Quality score: ${company.qualityScore}/5.',
      'color': company.changePercent >= 0 ? Colors.green : Colors.red,
    });

    if (company.qualityScore >= 4) {
      timeline.add({
        'year': (DateTime.now().year - 1).toString(),
        'title': 'Quality Recognition',
        'description':
            'Achieved high-quality rating with ${company.overallQualityGrade} grade based on financial metrics and operational efficiency.',
        'color': Colors.amber,
      });
    }

    if (company.isDebtFree) {
      timeline.add({
        'year': (DateTime.now().year - 2).toString(),
        'title': 'Debt-Free Achievement',
        'description':
            'Maintained minimal debt levels with debt-to-equity ratio below 0.1, demonstrating strong financial discipline.',
        'color': Colors.green,
      });
    }

    if (company.paysDividends) {
      timeline.add({
        'year': (DateTime.now().year - 1).toString(),
        'title': 'Dividend Distribution',
        'description':
            'Consistent dividend payments with current yield of ${company.dividendYield?.toStringAsFixed(2) ?? "N/A"}%, reflecting commitment to shareholder returns.',
        'color': Colors.blue,
      });
    }

    final marketCap = company.marketCap ?? 0;
    if (marketCap > 1000) {
      timeline.add({
        'year': (DateTime.now().year - 3).toString(),
        'title': 'Market Cap Growth',
        'description':
            'Achieved significant market capitalization of ${company.formattedMarketCap}, establishing position in ${company.marketCapCategoryText.toLowerCase()} segment.',
        'color': Colors.purple,
      });
    }

    timeline.add({
      'year': 'Est.',
      'title': 'Company Establishment',
      'description':
          '${company.name} established as a ${company.formattedSector} sector company, focusing on sustainable growth and operational excellence.',
      'color': Colors.grey,
    });

    return timeline;
  }

  String _getRoeAssessment(double? roe) {
    if (roe == null || roe <= 0) return "areas for improvement";
    if (roe > 20) return "excellent profitability";
    if (roe > 15) return "strong profitability";
    if (roe > 10) return "good profitability";
    return "moderate profitability";
  }

  Color _getHighlightColor(String impact) {
    switch (impact.toLowerCase()) {
      case 'positive':
        return Colors.green;
      case 'negative':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  IconData _getHighlightIcon(String type) {
    switch (type.toLowerCase()) {
      case 'strength':
        return Icons.trending_up;
      case 'financial_metric':
        return Icons.calculate;
      case 'income_generation':
        return Icons.account_balance_wallet;
      default:
        return Icons.star_outline;
    }
  }

  Color _getRiskColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'high':
        return AppTheme.lossRed;
      case 'medium':
        return Colors.orange;
      case 'low':
        return AppTheme.profitGreen;
      default:
        return AppTheme.textSecondary;
    }
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

  Color _getEfficiencyColor(String status) {
    switch (status.toLowerCase()) {
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

  Color _getDebtColor(String status) {
    switch (status.toLowerCase()) {
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

  bool _hasAnalysisSummary() {
    return company.pros.isNotEmpty || company.cons.isNotEmpty;
  }
}
