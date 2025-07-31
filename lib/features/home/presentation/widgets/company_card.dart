import 'package:flutter/material.dart';
import '../../../../models/company/company_model.dart';

class CompanyCard extends StatelessWidget {
  final CompanyModel company;
  final VoidCallback onTap;

  const CompanyCard({
    super.key,
    required this.company,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = (company.changePercent ?? 0) >= 0;
    final changeColor = isPositive ? Colors.green : Colors.red;
    final changeIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Top Row - Company Info and Price
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side - Company Info
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Symbol
                        Text(
                          company.symbol,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 4),

                        // Company Name
                        Text(
                          company.name,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[700],
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 8),

                        // Market Cap Category
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getMarketCapColor(company.marketCapCategory)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  _getMarketCapColor(company.marketCapCategory)
                                      .withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            company.marketCapCategory,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color:
                                  _getMarketCapColor(company.marketCapCategory),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right Side - Price Info
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Current Price
                        Text(
                          company.formattedPrice,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                        ),

                        const SizedBox(height: 4),

                        // Change Container
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: changeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                changeIcon,
                                size: 12,
                                color: changeColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                company.formattedChange,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: changeColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 2),

                        // Change Amount
                        Text(
                          company.formattedChangeAmount,
                          style: TextStyle(
                            fontSize: 11,
                            color: changeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Bottom Row - Key Metrics
              Row(
                children: [
                  Expanded(
                    child: _buildMetricItem(
                      context,
                      'Market Cap',
                      company.formattedMarketCap,
                      Icons.pie_chart_outline,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.grey[300],
                  ),
                  Expanded(
                    child: _buildMetricItem(
                      context,
                      'P/E',
                      company.stockPe?.toStringAsFixed(1) ?? 'N/A',
                      Icons.trending_up,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 30,
                    color: Colors.grey[300],
                  ),
                  Expanded(
                    child: _buildMetricItem(
                      context,
                      'ROE',
                      company.roe != null
                          ? '${company.roe!.toStringAsFixed(1)}%'
                          : 'N/A',
                      Icons.donut_large,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Color _getMarketCapColor(String category) {
    switch (category) {
      case 'Large Cap':
        return Colors.blue;
      case 'Mid Cap':
        return Colors.orange;
      case 'Small Cap':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}
