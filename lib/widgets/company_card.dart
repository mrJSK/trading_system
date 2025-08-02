// widgets/company_card.dart
import 'package:flutter/material.dart';
import '../models/company_model.dart';
import '../screens/company_details_screen.dart';
import '../theme/app_theme.dart';

class CompanyCard extends StatelessWidget {
  final CompanyModel company;

  const CompanyCard({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompanyDetailsScreen(company: company),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with company info and price
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Company name with quality grade indicator
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              company.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          _buildQualityGradeBadge(),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Symbol and market cap
                      Row(
                        children: [
                          Text(
                            company.symbol,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildMarketCapChip(),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Sector and industry
                      if (company.sector != null || company.industry != null)
                        _buildSectorIndustryRow(),
                    ],
                  ),
                ),
                // Price section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      company.formattedPrice,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: company.isGainer
                            ? AppTheme.profitGreen.withOpacity(0.1)
                            : company.isLoser
                                ? AppTheme.lossRed.withOpacity(0.1)
                                : AppTheme.textSecondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        company.formattedChange,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: company.isGainer
                              ? AppTheme.profitGreen
                              : company.isLoser
                                  ? AppTheme.lossRed
                                  : AppTheme.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      company.formattedLastUpdated,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // NEW: Business overview (if available)
            if (company.businessOverview.isNotEmpty)
              _buildBusinessOverviewSection(),

            const SizedBox(height: 12),

            // Enhanced quality and efficiency indicators row
            Row(
              children: [
                Expanded(child: _buildQualityIndicators()),
                _buildRiskBadge(),
              ],
            ),

            const SizedBox(height: 12),

            // Enhanced financial metrics row with new ratios
            _buildFinancialMetricsGrid(),

            const SizedBox(height: 8),

            // NEW: Enhanced working capital and efficiency metrics
            _buildEfficiencyMetricsRow(),

            const SizedBox(height: 8),

            // Growth and dividend metrics row
            _buildGrowthMetricsRow(),

            // NEW: Key highlights (if available)
            if (company.investmentHighlights.isNotEmpty) _buildKeyHighlights(),
          ],
        ),
      ),
    );
  }

  // NEW: Quality grade badge
  Widget _buildQualityGradeBadge() {
    final grade = company.overallQualityGrade;
    final score = company.qualityScore;

    Color gradeColor;
    switch (grade.toUpperCase()) {
      case 'A':
        gradeColor = Colors.green;
        break;
      case 'B':
        gradeColor = Colors.blue;
        break;
      case 'C':
        gradeColor = Colors.orange;
        break;
      case 'D':
        gradeColor = Colors.red;
        break;
      default:
        gradeColor = AppTheme.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: gradeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: gradeColor.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        '$grade ($score/5)',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: gradeColor,
        ),
      ),
    );
  }

  // Enhanced sector and industry display
  Widget _buildSectorIndustryRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (company.sector != null)
          Text(
            company.sector!,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (company.industry != null && company.industry != company.sector)
          Text(
            company.industry!,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textSecondary,
              fontStyle: FontStyle.italic,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    );
  }

  // NEW: Business overview section
  Widget _buildBusinessOverviewSection() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppTheme.primaryGreen.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.business_center,
            size: 14,
            color: AppTheme.primaryGreen,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              company.businessOverview.length > 120
                  ? '${company.businessOverview.substring(0, 120)}...'
                  : company.businessOverview,
              style: const TextStyle(
                fontSize: 11,
                color: AppTheme.textSecondary,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Enhanced financial metrics grid
  Widget _buildFinancialMetricsGrid() {
    return Column(
      children: [
        // First row - Core metrics
        Row(
          children: [
            Expanded(
              child: _buildMetric(
                'Market Cap',
                company.formattedMarketCap,
              ),
            ),
            Expanded(
              child: _buildMetric(
                'P/E',
                company.stockPe?.toStringAsFixed(1) ?? 'N/A',
              ),
            ),
            Expanded(
              child: _buildMetric(
                'ROE',
                company.roe != null
                    ? '${company.roe!.toStringAsFixed(1)}%'
                    : 'N/A',
              ),
            ),
            Expanded(
              child: _buildMetric(
                'ROCE',
                company.roce != null
                    ? '${company.roce!.toStringAsFixed(1)}%'
                    : 'N/A',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // NEW: Enhanced working capital and efficiency metrics
  Widget _buildEfficiencyMetricsRow() {
    if (company.workingCapitalDays == null &&
        company.debtToEquity == null &&
        company.currentRatio == null &&
        company.cashConversionCycle == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.blue.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                size: 12,
                color: Colors.blue,
              ),
              const SizedBox(width: 4),
              const Text(
                'Efficiency Metrics',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (company.workingCapitalDays != null)
                Expanded(
                  child: _buildMiniMetric(
                    'WC Days',
                    '${company.workingCapitalDays!.toStringAsFixed(0)}',
                    _getWorkingCapitalColor(company.workingCapitalDays!),
                  ),
                ),
              if (company.debtToEquity != null)
                Expanded(
                  child: _buildMiniMetric(
                    'D/E',
                    company.debtToEquity!.toStringAsFixed(2),
                    _getDebtColor(company.debtToEquity!),
                  ),
                ),
              if (company.currentRatio != null)
                Expanded(
                  child: _buildMiniMetric(
                    'Current',
                    company.currentRatio!.toStringAsFixed(1),
                    _getCurrentRatioColor(company.currentRatio!),
                  ),
                ),
              if (company.cashConversionCycle != null)
                Expanded(
                  child: _buildMiniMetric(
                    'CCC',
                    '${company.cashConversionCycle!.toStringAsFixed(0)}d',
                    _getCashCycleColor(company.cashConversionCycle!),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          // Efficiency status badges
          Row(
            children: [
              if (company.workingCapitalEfficiency != 'Unknown')
                _buildStatusBadge(
                  'WC: ${company.workingCapitalEfficiency}',
                  _getEfficiencyColor(company.workingCapitalEfficiency),
                ),
              const SizedBox(width: 4),
              if (company.liquidityStatus != 'Unknown')
                _buildStatusBadge(
                  'Liquidity: ${company.liquidityStatus}',
                  _getEfficiencyColor(company.liquidityStatus),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // Enhanced growth metrics row
  Widget _buildGrowthMetricsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildMetric(
            'Sales Growth',
            company.salesGrowth3Y != null
                ? '${company.salesGrowth3Y!.toStringAsFixed(1)}%'
                : 'N/A',
          ),
        ),
        Expanded(
          child: _buildMetric(
            'Profit Growth',
            company.profitGrowth3Y != null
                ? '${company.profitGrowth3Y!.toStringAsFixed(1)}%'
                : 'N/A',
          ),
        ),
        Expanded(
          child: _buildMetric(
            'Div Yield',
            company.dividendYield != null
                ? '${company.dividendYield!.toStringAsFixed(1)}%'
                : 'N/A',
          ),
        ),
        Expanded(
          child: _buildMetric(
            'Interest Cov',
            company.interestCoverage != null
                ? '${company.interestCoverage!.toStringAsFixed(1)}x'
                : 'N/A',
          ),
        ),
      ],
    );
  }

  // NEW: Key highlights section
  Widget _buildKeyHighlights() {
    final highlights = company.investmentHighlights.take(2).toList();
    if (highlights.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.05),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.amber.withOpacity(0.2),
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.star_outline,
                    size: 12,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Key Highlights',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ...highlights.map((highlight) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Row(
                      children: [
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: _getHighlightColor(highlight.impact),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            highlight.description,
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppTheme.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  // Helper method for mini metrics
  Widget _buildMiniMetric(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  // Helper method for status badges
  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  // Color helper methods
  Color _getWorkingCapitalColor(double days) {
    if (days < 30) return Colors.green;
    if (days < 60) return Colors.blue;
    if (days < 90) return Colors.orange;
    return Colors.red;
  }

  Color _getDebtColor(double debt) {
    if (debt < 0.1) return Colors.green;
    if (debt < 0.3) return Colors.blue;
    if (debt < 0.6) return Colors.orange;
    return Colors.red;
  }

  Color _getCurrentRatioColor(double ratio) {
    if (ratio > 2.5) return Colors.green;
    if (ratio > 1.5) return Colors.blue;
    if (ratio > 1.0) return Colors.orange;
    return Colors.red;
  }

  Color _getCashCycleColor(double cycle) {
    if (cycle < 30) return Colors.green;
    if (cycle < 60) return Colors.blue;
    if (cycle < 90) return Colors.orange;
    return Colors.red;
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

  // Existing helper methods (enhanced)
  Widget _buildMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildMarketCapChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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

  // Enhanced quality indicators
  Widget _buildQualityIndicators() {
    final indicators = <Widget>[];

    // Enhanced indicators with new classifications
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

    // NEW: Working capital efficiency indicator
    if (company.workingCapitalEfficiency == 'Excellent') {
      indicators.add(_buildIndicatorChip('Efficient WC', Colors.green));
    }

    // NEW: Cash conversion cycle indicator
    if (company.cashConversionCycle != null &&
        company.cashConversionCycle! < 30) {
      indicators.add(_buildIndicatorChip('Fast CCC', Colors.green));
    }

    if (indicators.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: indicators.take(3).toList(), // Show max 3 indicators
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

  // Enhanced risk badge
  Widget _buildRiskBadge() {
    final riskLevel = company.riskLevel;
    Color riskColor;

    switch (riskLevel.toLowerCase()) {
      case 'high':
        riskColor = AppTheme.lossRed;
        break;
      case 'medium':
        riskColor = Colors.orange;
        break;
      case 'low':
        riskColor = AppTheme.profitGreen;
        break;
      default:
        riskColor = AppTheme.textSecondary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: riskColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
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
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: riskColor,
            ),
          ),
        ],
      ),
    );
  }
}
