import 'package:flutter/material.dart';

import '../../../../models/company/company_model.dart';

class CompanyHeaderWidget extends StatelessWidget {
  final CompanyModel company;

  const CompanyHeaderWidget({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = (company.changePercent ?? 0) >= 0;
    final changeColor = isPositive ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main Row - Company Info and Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Side - Company Info
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Symbol
                    Text(
                      company.symbol ?? 'N/A',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                    ),
                    const SizedBox(height: 4),

                    // Company Name
                    Text(
                      company.name ?? 'Unknown Company',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 12),

                    // Exchange Codes
                    if (company.bseCode != null || company.nseCode != null)
                      Wrap(
                        spacing: 8,
                        children: [
                          if (company.nseCode != null)
                            _buildExchangeChip('NSE', company.nseCode!),
                          if (company.bseCode != null)
                            _buildExchangeChip('BSE', company.bseCode!),
                        ],
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
                      company.currentPrice != null
                          ? '₹${company.currentPrice!.toStringAsFixed(2)}'
                          : '₹--',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                    ),

                    const SizedBox(height: 8),

                    // Change Amount and Percentage
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: changeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: changeColor.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            company.changeAmount != null
                                ? '${isPositive ? '+' : ''}${company.changeAmount!.toStringAsFixed(2)}'
                                : '--',
                            style: TextStyle(
                              color: changeColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            company.changePercent != null
                                ? '${isPositive ? '+' : ''}${company.changePercent!.toStringAsFixed(2)}%'
                                : '--%',
                            style: TextStyle(
                              color: changeColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Bottom Row - Key Metrics
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  'Market Cap',
                  company.marketCap != null
                      ? '₹${_formatMarketCap(company.marketCap!)}'
                      : 'N/A',
                  Icons.pie_chart,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.grey[300],
              ),
              Expanded(
                child: _buildMetricItem(
                  'P/E Ratio',
                  company.stockPe != null
                      ? company.stockPe!.toStringAsFixed(2)
                      : 'N/A',
                  Icons.trending_up,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.grey[300],
              ),
              Expanded(
                child: _buildMetricItem(
                  'Book Value',
                  company.bookValue != null
                      ? '₹${company.bookValue!.toStringAsFixed(2)}'
                      : 'N/A',
                  Icons.account_balance,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeChip(String exchange, String code) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Text(
        '$exchange: $code',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.grey[600],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _formatMarketCap(double marketCap) {
    if (marketCap >= 100000) {
      return '${(marketCap / 100000).toStringAsFixed(1)}L Cr';
    } else if (marketCap >= 1000) {
      return '${(marketCap / 1000).toStringAsFixed(1)}K Cr';
    } else {
      return '${marketCap.toStringAsFixed(0)} Cr';
    }
  }
}
