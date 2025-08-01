import 'package:flutter/material.dart';
import '../models/company_model.dart';

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
    final isPositive = company.changePercent >= 0;
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Text(
                          company.displayName,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey[700],
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getMarketCapColor().withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _getMarketCapColor().withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            _getMarketCapCategory(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getMarketCapColor(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          company.formattedPrice,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                        ),
                        const SizedBox(height: 4),
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
                        Text(
                          _formatChangeAmount(),
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
              Row(
                children: [
                  Expanded(
                    child: _buildMetricItem(
                      context,
                      'Market Cap',
                      _formatMarketCap(),
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
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Updated: ${_formatLastUpdated()}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 10,
                    ),
                  ),
                  if (!_isDataFresh())
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Stale',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
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

  String _getMarketCapCategory() {
    if (company.marketCap == null) return 'Unknown';
    if (company.marketCap! >= 20000) return 'Large Cap';
    if (company.marketCap! >= 5000) return 'Mid Cap';
    return 'Small Cap';
  }

  Color _getMarketCapColor() {
    final category = _getMarketCapCategory();
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

  String _formatMarketCap() {
    if (company.marketCap == null) return 'N/A';
    if (company.marketCap! >= 100000) {
      return '₹${(company.marketCap! / 100000).toStringAsFixed(0)}L Cr';
    } else if (company.marketCap! >= 1000) {
      return '₹${(company.marketCap! / 1000).toStringAsFixed(0)}K Cr';
    } else {
      return '₹${company.marketCap!.toStringAsFixed(0)} Cr';
    }
  }

  String _formatChangeAmount() {
    if (company.changeAmount == 0.0) return '₹0.00';
    final sign = company.changeAmount > 0 ? '+' : '';
    return '$sign₹${company.changeAmount.abs().toStringAsFixed(2)}';
  }

  String _formatLastUpdated() {
    try {
      final date = DateTime.parse(company.lastUpdated);
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

  bool _isDataFresh() {
    try {
      final date = DateTime.parse(company.lastUpdated);
      final now = DateTime.now();
      return now.difference(date).inHours < 24;
    } catch (e) {
      return false;
    }
  }
}
