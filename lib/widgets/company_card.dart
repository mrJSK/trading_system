// lib/widgets/company_card.dart
import 'package:flutter/material.dart';
import '../models/company_model.dart';
import '../theme/app_theme.dart';

class CompanyCard extends StatelessWidget {
  final CompanyModel company;
  final VoidCallback? onTap;
  final bool showDetails;

  const CompanyCard({
    super.key,
    required this.company,
    this.onTap,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          company.symbol,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        Text(
                          company.displayName,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹${company.currentPrice?.toStringAsFixed(2) ?? 'N/A'}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: company.changePercent >= 0
                              ? AppTheme.profitGreen.withOpacity(0.1)
                              : AppTheme.lossRed.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${company.changePercent.toStringAsFixed(2)}%',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: company.changePercent >= 0
                                        ? AppTheme.profitGreen
                                        : AppTheme.lossRed,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              if (showDetails) ...[
                const SizedBox(height: 12),
                _buildMetricsRow(context),
              ] else ...[
                const SizedBox(height: 8),
                _buildQuickMetrics(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickMetrics(BuildContext context) {
    return Row(
      children: [
        if (company.stockPe != null)
          _buildMetricChip(context, 'P/E', company.stockPe!.toStringAsFixed(1)),
        const SizedBox(width: 8),
        if (company.roe != null)
          _buildMetricChip(
              context, 'ROE', '${company.roe!.toStringAsFixed(1)}%'),
        const SizedBox(width: 8),
        if (company.marketCap != null)
          _buildMetricChip(
              context, 'MCap', _formatMarketCap(company.marketCap!)),
      ],
    );
  }

  Widget _buildMetricsRow(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: _buildMetricItem(context, 'P/E',
                    company.stockPe?.toStringAsFixed(1) ?? 'N/A')),
            Expanded(
                child: _buildMetricItem(
                    context,
                    'ROE',
                    company.roe != null
                        ? '${company.roe!.toStringAsFixed(1)}%'
                        : 'N/A')),
            Expanded(
                child: _buildMetricItem(
                    context,
                    'ROCE',
                    company.roce != null
                        ? '${company.roce!.toStringAsFixed(1)}%'
                        : 'N/A')),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
                child: _buildMetricItem(context, 'D/E',
                    company.debtToEquity?.toStringAsFixed(2) ?? 'N/A')),
            Expanded(
                child: _buildMetricItem(context, 'CR',
                    company.currentRatio?.toStringAsFixed(2) ?? 'N/A')),
            Expanded(
                child: _buildMetricItem(
                    context, 'MCap', _formatMarketCap(company.marketCap ?? 0))),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricChip(BuildContext context, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.getBorderColor(context),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label: $value',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }

  Widget _buildMetricItem(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.getTextSecondary(context),
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  String _formatMarketCap(double marketCap) {
    if (marketCap >= 100000)
      return '${(marketCap / 1000).toStringAsFixed(0)}K Cr';
    if (marketCap >= 1000)
      return '${(marketCap / 1000).toStringAsFixed(1)}K Cr';
    return '${marketCap.toStringAsFixed(0)} Cr';
  }
}
