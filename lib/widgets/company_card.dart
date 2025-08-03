// widgets/company_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/company_model.dart';
import '../screens/company_details_screen.dart';
import '../theme/app_theme.dart';

class CompanyCard extends ConsumerWidget {
  final CompanyModel company;

  const CompanyCard({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            // Enhanced header with company info and price
            _buildEnhancedHeader(),
            const SizedBox(height: 12),

            // Professional analysis scores
            _buildAnalysisScoresRow(),
            const SizedBox(height: 12),

            // Business overview (if available)
            if (company.businessOverview.isNotEmpty)
              _buildBusinessOverviewSection(),

            if (company.businessOverview.isNotEmpty) const SizedBox(height: 12),

            // Enhanced quality and efficiency indicators
            _buildQualityIndicatorsSection(),
            const SizedBox(height: 12),

            // Professional financial metrics grid
            _buildProfessionalMetricsGrid(),
            const SizedBox(height: 8),

            // Enhanced efficiency and risk metrics
            _buildEfficiencyRiskSection(),
            const SizedBox(height: 8),

            // Growth and profitability metrics
            _buildGrowthProfitabilityRow(),

            // Investment recommendation and highlights
            if (company.investmentHighlights.isNotEmpty ||
                company.calculatedInvestmentRecommendation != 'Hold')
              _buildInvestmentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company name with professional badges
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
                  _buildInvestmentGradeBadge(),
                ],
              ),
              const SizedBox(height: 4),
              // Symbol, market cap, and category
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
                  const SizedBox(width: 4),
                  _buildPiotroskiBadge(),
                ],
              ),
              const SizedBox(height: 4),
              // Sector and industry with enhanced display
              if (company.sector != null || company.industry != null)
                _buildSectorIndustryRow(),
            ],
          ),
        ),
        // Enhanced price section with target price
        _buildEnhancedPriceSection(),
      ],
    );
  }

  Widget _buildInvestmentGradeBadge() {
    final grade = company.calculatedInvestmentGrade;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _getGradeColor(grade).withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: _getGradeColor(grade).withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        grade,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: _getGradeColor(grade),
        ),
      ),
    );
  }

  Widget _buildPiotroskiBadge() {
    final score = company.calculatedPiotroskiScore.toInt();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: _getPiotroskiColor(score).withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: _getPiotroskiColor(score).withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        'P:$score',
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w600,
          color: _getPiotroskiColor(score),
        ),
      ),
    );
  }

  Widget _buildEnhancedPriceSection() {
    return Column(
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
        const SizedBox(height: 2),
        _buildPriceChangeChip(),
        const SizedBox(height: 2),
        if (company.calculatedGrahamNumber != null) _buildTargetPriceChip(),
        const SizedBox(height: 2),
        Text(
          company.formattedLastUpdated,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceChangeChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
    );
  }

  Widget _buildTargetPriceChip() {
    final graham = company.calculatedGrahamNumber!;
    final current = company.currentPrice ?? 0;
    final isUndervalued = current < graham;
    final margin = company.safetyMargin ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: (isUndervalued ? Colors.green : Colors.orange).withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color:
              (isUndervalued ? Colors.green : Colors.orange).withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        'T:₹${graham.toStringAsFixed(0)} (${margin.toStringAsFixed(0)}%)',
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.w500,
          color: isUndervalued ? Colors.green : Colors.orange,
        ),
      ),
    );
  }

  Widget _buildAnalysisScoresRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryGreen.withOpacity(0.05),
            AppTheme.primaryGreen.withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildScoreItem(
              'Quality',
              '${company.qualityScore}/5',
              _getQualityColor(company.qualityScore),
            ),
          ),
          Expanded(
            child: _buildScoreItem(
              'Overall',
              '${company.calculatedComprehensiveScore.toInt()}/100',
              _getComprehensiveColor(company.calculatedComprehensiveScore),
            ),
          ),
          Expanded(
            child: _buildScoreItem(
              'Altman Z',
              company.calculatedAltmanZScore.toStringAsFixed(1),
              _getAltmanColor(company.calculatedAltmanZScore),
            ),
          ),
          Expanded(
            child: _buildScoreItem(
              'Risk',
              company.calculatedRiskAssessment,
              _getRiskColor(company.calculatedRiskAssessment),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessOverviewSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.blue.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.business_center,
            size: 14,
            color: Colors.blue,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              company.businessOverview.length > 140
                  ? '${company.businessOverview.substring(0, 140)}...'
                  : company.businessOverview,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textPrimary,
                height: 1.3,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualityIndicatorsSection() {
    return Row(
      children: [
        Expanded(child: _buildQualityIndicators()),
        _buildRecommendationBadge(),
      ],
    );
  }

  Widget _buildQualityIndicators() {
    final indicators = <Widget>[];

    // Professional quality indicators
    if (company.isDebtFree) {
      indicators.add(_buildIndicatorChip('Debt Free', Colors.green));
    }

    if (company.calculatedPiotroskiScore >= 7) {
      indicators.add(_buildIndicatorChip('High Piotroski', Colors.blue));
    }

    if (company.calculatedROIC != null && company.calculatedROIC! > 15) {
      indicators.add(_buildIndicatorChip('High ROIC', Colors.purple));
    }

    if (company.paysDividends) {
      indicators.add(_buildIndicatorChip('Dividend', Colors.teal));
    }

    if (company.workingCapitalEfficiency == 'Excellent') {
      indicators.add(_buildIndicatorChip('Efficient WC', Colors.amber));
    }

    if (company.isGrowthStock) {
      indicators.add(_buildIndicatorChip('Growth', Colors.orange));
    }

    if (indicators.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 4,
      runSpacing: 4,
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

  Widget _buildRecommendationBadge() {
    final recommendation = company.calculatedInvestmentRecommendation;
    if (recommendation == 'Hold') return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getRecommendationColor(recommendation).withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _getRecommendationColor(recommendation).withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getRecommendationIcon(recommendation),
            size: 12,
            color: _getRecommendationColor(recommendation),
          ),
          const SizedBox(width: 4),
          Text(
            recommendation,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _getRecommendationColor(recommendation),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalMetricsGrid() {
    return Column(
      children: [
        // First row - Core valuation metrics
        Row(
          children: [
            Expanded(
              child: _buildMetric(
                'Market Cap',
                company.formattedMarketCap,
                Colors.blue,
              ),
            ),
            Expanded(
              child: _buildMetric(
                'P/E',
                company.stockPe?.toStringAsFixed(1) ?? 'N/A',
                _getPEColor(company.stockPe),
              ),
            ),
            Expanded(
              child: _buildMetric(
                'ROE',
                company.roe != null
                    ? '${company.roe!.toStringAsFixed(1)}%'
                    : 'N/A',
                _getROEColor(company.roe),
              ),
            ),
            Expanded(
              child: _buildMetric(
                'ROCE',
                company.roce != null
                    ? '${company.roce!.toStringAsFixed(1)}%'
                    : 'N/A',
                _getROCEColor(company.roce),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Second row - Advanced metrics
        Row(
          children: [
            Expanded(
              child: _buildMetric(
                'PEG',
                company.calculatedPEGRatio?.toStringAsFixed(2) ?? 'N/A',
                _getPEGColor(company.calculatedPEGRatio),
              ),
            ),
            Expanded(
              child: _buildMetric(
                'ROIC',
                company.calculatedROIC != null
                    ? '${company.calculatedROIC!.toStringAsFixed(1)}%'
                    : 'N/A',
                _getROICColor(company.calculatedROIC),
              ),
            ),
            Expanded(
              child: _buildMetric(
                'FCF Yield',
                company.calculatedFCFYield != null
                    ? '${company.calculatedFCFYield!.toStringAsFixed(1)}%'
                    : 'N/A',
                _getFCFYieldColor(company.calculatedFCFYield),
              ),
            ),
            Expanded(
              child: _buildMetric(
                'P/B',
                company.priceToBook?.toStringAsFixed(1) ?? 'N/A',
                _getPBColor(company.priceToBook),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEfficiencyRiskSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.orange.withOpacity(0.1),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.analytics, size: 12, color: Colors.orange),
              const SizedBox(width: 4),
              const Text(
                'Efficiency & Risk Metrics',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
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
              if (company.workingCapitalDays != null)
                Expanded(
                  child: _buildMiniMetric(
                    'WC Days',
                    company.workingCapitalDays!.toStringAsFixed(0),
                    _getWorkingCapitalColor(company.workingCapitalDays!),
                  ),
                ),
              if (company.interestCoverage != null)
                Expanded(
                  child: _buildMiniMetric(
                    'Int Cov',
                    '${company.interestCoverage!.toStringAsFixed(1)}x',
                    _getInterestCoverageColor(company.interestCoverage!),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthProfitabilityRow() {
    return Row(
      children: [
        Expanded(
          child: _buildMetric(
            'Sales Growth',
            company.salesGrowth3Y != null
                ? '${company.salesGrowth3Y!.toStringAsFixed(1)}%'
                : 'N/A',
            _getGrowthColor(company.salesGrowth3Y),
          ),
        ),
        Expanded(
          child: _buildMetric(
            'Profit Growth',
            company.profitGrowth3Y != null
                ? '${company.profitGrowth3Y!.toStringAsFixed(1)}%'
                : 'N/A',
            _getGrowthColor(company.profitGrowth3Y),
          ),
        ),
        Expanded(
          child: _buildMetric(
            'Div Yield',
            company.dividendYield != null
                ? '${company.dividendYield!.toStringAsFixed(1)}%'
                : 'N/A',
            _getDividendColor(company.dividendYield),
          ),
        ),
        Expanded(
          child: _buildMetric(
            'Asset Turn',
            company.assetTurnover?.toStringAsFixed(1) ?? 'N/A',
            _getAssetTurnoverColor(company.assetTurnover),
          ),
        ),
      ],
    );
  }

  Widget _buildInvestmentSection() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.amber.withOpacity(0.08),
                Colors.amber.withOpacity(0.03),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.amber.withOpacity(0.2),
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    size: 14,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Investment Insights',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber,
                    ),
                  ),
                  const Spacer(),
                  if (company.calculatedInvestmentRecommendation != 'Hold')
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: _getRecommendationColor(
                                company.calculatedInvestmentRecommendation)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        company.calculatedInvestmentRecommendation,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: _getRecommendationColor(
                              company.calculatedInvestmentRecommendation),
                        ),
                      ),
                    ),
                ],
              ),
              if (company.investmentHighlights.isNotEmpty) ...[
                const SizedBox(height: 6),
                ...company.investmentHighlights
                    .take(2)
                    .map((highlight) => Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 4,
                                height: 4,
                                margin: const EdgeInsets.only(top: 4),
                                decoration: BoxDecoration(
                                  color: _getHighlightColor(highlight.impact),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  highlight.description,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppTheme.textPrimary,
                                    height: 1.3,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        )),
              ],
              // Add financial strength summary
              if (company.calculatedMetrics?.strengthFactors?.isNotEmpty ==
                  true) ...[
                const SizedBox(height: 4),
                Text(
                  'Strengths: ${company.calculatedMetrics!.strengthFactors!.take(2).join(", ")}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // Enhanced helper methods
  Widget _buildMetric(String label, String value, Color? color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color ?? AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

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
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

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
          fontSize: 9,
          fontWeight: FontWeight.w500,
          color: _getMarketCapColor(),
        ),
      ),
    );
  }

  // Enhanced color helper methods
  Color _getGradeColor(String grade) {
    switch (grade.toUpperCase()) {
      case 'AAA':
      case 'AA':
        return Colors.green;
      case 'A':
      case 'BBB':
        return Colors.blue;
      case 'BB':
      case 'B':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  Color _getPiotroskiColor(int score) {
    if (score >= 7) return Colors.green;
    if (score >= 5) return Colors.blue;
    if (score >= 3) return Colors.orange;
    return Colors.red;
  }

  Color _getQualityColor(int score) {
    if (score >= 4) return Colors.green;
    if (score >= 3) return Colors.blue;
    if (score >= 2) return Colors.orange;
    return Colors.red;
  }

  Color _getComprehensiveColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.blue;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }

  Color _getAltmanColor(double score) {
    if (score > 3.0) return Colors.green;
    if (score > 1.8) return Colors.orange;
    return Colors.red;
  }

  Color _getRiskColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'very low':
      case 'low':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'high':
      case 'very high':
        return Colors.red;
      default:
        return AppTheme.textSecondary;
    }
  }

  Color _getPEColor(double? pe) {
    if (pe == null) return AppTheme.textSecondary;
    if (pe < 15) return Colors.green;
    if (pe < 25) return Colors.blue;
    if (pe < 35) return Colors.orange;
    return Colors.red;
  }

  Color _getROEColor(double? roe) {
    if (roe == null) return AppTheme.textSecondary;
    if (roe > 20) return Colors.green;
    if (roe > 15) return Colors.blue;
    if (roe > 10) return Colors.orange;
    return Colors.red;
  }

  Color _getROCEColor(double? roce) {
    if (roce == null) return AppTheme.textSecondary;
    if (roce > 20) return Colors.green;
    if (roce > 15) return Colors.blue;
    if (roce > 10) return Colors.orange;
    return Colors.red;
  }

  Color _getPEGColor(double? peg) {
    if (peg == null) return AppTheme.textSecondary;
    if (peg < 1.0) return Colors.green;
    if (peg < 2.0) return Colors.blue;
    if (peg < 3.0) return Colors.orange;
    return Colors.red;
  }

  Color _getROICColor(double? roic) {
    if (roic == null) return AppTheme.textSecondary;
    if (roic > 20) return Colors.green;
    if (roic > 15) return Colors.blue;
    if (roic > 10) return Colors.orange;
    return Colors.red;
  }

  Color _getFCFYieldColor(double? fcf) {
    if (fcf == null) return AppTheme.textSecondary;
    if (fcf > 10) return Colors.green;
    if (fcf > 5) return Colors.blue;
    if (fcf > 2) return Colors.orange;
    return Colors.red;
  }

  Color _getPBColor(double? pb) {
    if (pb == null) return AppTheme.textSecondary;
    if (pb < 1.5) return Colors.green;
    if (pb < 3.0) return Colors.blue;
    if (pb < 5.0) return Colors.orange;
    return Colors.red;
  }

  Color _getGrowthColor(double? growth) {
    if (growth == null) return AppTheme.textSecondary;
    if (growth > 20) return Colors.green;
    if (growth > 10) return Colors.blue;
    if (growth > 5) return Colors.orange;
    return Colors.red;
  }

  Color _getDividendColor(double? dividend) {
    if (dividend == null) return AppTheme.textSecondary;
    if (dividend > 4) return Colors.green;
    if (dividend > 2) return Colors.blue;
    if (dividend > 0) return Colors.orange;
    return AppTheme.textSecondary;
  }

  Color _getAssetTurnoverColor(double? turnover) {
    if (turnover == null) return AppTheme.textSecondary;
    if (turnover > 1.5) return Colors.green;
    if (turnover > 1.0) return Colors.blue;
    if (turnover > 0.5) return Colors.orange;
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

  Color _getWorkingCapitalColor(double days) {
    if (days < 30) return Colors.green;
    if (days < 60) return Colors.blue;
    if (days < 90) return Colors.orange;
    return Colors.red;
  }

  Color _getInterestCoverageColor(double coverage) {
    if (coverage > 5) return Colors.green;
    if (coverage > 2.5) return Colors.blue;
    if (coverage > 1.5) return Colors.orange;
    return Colors.red;
  }

  Color _getMarketCapColor() {
    if (company.marketCap == null) return AppTheme.textSecondary;
    if (company.marketCap! >= 20000) return Colors.blue;
    if (company.marketCap! >= 5000) return Colors.orange;
    return Colors.purple;
  }

  Color _getRecommendationColor(String recommendation) {
    switch (recommendation.toLowerCase()) {
      case 'strong buy':
        return Colors.green[700]!;
      case 'buy':
        return Colors.green;
      case 'hold':
        return Colors.orange;
      case 'sell':
        return Colors.red;
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData _getRecommendationIcon(String recommendation) {
    switch (recommendation.toLowerCase()) {
      case 'strong buy':
        return Icons.trending_up;
      case 'buy':
        return Icons.thumb_up;
      case 'hold':
        return Icons.pause;
      case 'sell':
        return Icons.trending_down;
      default:
        return Icons.help_outline;
    }
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
}
