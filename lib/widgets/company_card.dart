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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.name,
                        style: const TextStyle(
                          fontSize: 16,
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
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildMarketCapChip(),
                        ],
                      ),
                      const SizedBox(height: 4),
                      if (company.sector != null)
                        Text(
                          company.sector!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                    ],
                  ),
                ),
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

            // Quality indicators row
            Row(
              children: [
                _buildQualityIndicators(),
                const Spacer(),
                _buildRiskBadge(),
              ],
            ),

            const SizedBox(height: 12),

            // Financial metrics row
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
                    'Debt/Eq',
                    company.debtToEquity?.toStringAsFixed(2) ?? 'N/A',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Growth metrics row (if available)
            if (company.salesGrowth3Y != null || company.profitGrowth3Y != null)
              Row(
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
                      'Quality',
                      '${company.qualityScore}/5',
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
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

    if (indicators.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: indicators.take(2).toList(), // Show max 2 indicators
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
