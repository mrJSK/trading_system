import 'package:flutter/material.dart';
import '../models/company_model.dart';

class RatiosGridWidget extends StatelessWidget {
  final CompanyModel company;

  const RatiosGridWidget({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    final ratiosData = _buildRatiosData();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Key Financial Ratios',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Ratios Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: ratiosData.length,
              itemBuilder: (context, index) {
                final ratio = ratiosData[index];
                return _buildRatioCard(context, ratio);
              },
            ),
          ],
        ),
      ),
    );
  }

  List<RatioData> _buildRatiosData() {
    return [
      RatioData(
        label: 'P/E Ratio',
        value: company.stockPe,
        suffix: '',
        icon: Icons.trending_up,
        isGoodWhenHigh: false, // Lower P/E is generally better
      ),
      RatioData(
        label: 'Book Value',
        value: company.bookValue,
        suffix: '',
        icon: Icons.account_balance_wallet,
        isGoodWhenHigh: true,
        prefix: '₹',
      ),
      RatioData(
        label: 'Dividend Yield',
        value: company.dividendYield,
        suffix: '%',
        icon: Icons.payments,
        isGoodWhenHigh: true,
      ),
      RatioData(
        label: 'ROE',
        value: company.roe,
        suffix: '%',
        icon: Icons.pie_chart,
        isGoodWhenHigh: true,
      ),
      RatioData(
        label: 'ROCE',
        value: company.roce,
        suffix: '%',
        icon: Icons.donut_large,
        isGoodWhenHigh: true,
      ),
      RatioData(
        label: 'Face Value',
        value: company.faceValue,
        suffix: '',
        icon: Icons.confirmation_number,
        isGoodWhenHigh: null, // Neutral
        prefix: '₹',
      ),
    ];
  }

  Widget _buildRatioCard(BuildContext context, RatioData ratio) {
    final hasValue = ratio.value != null;
    final displayValue = hasValue
        ? '${ratio.prefix ?? ''}${ratio.value!.toStringAsFixed(ratio.suffix == '%' ? 1 : 2)}${ratio.suffix}'
        : 'N/A';

    Color? valueColor;
    if (hasValue && ratio.isGoodWhenHigh != null) {
      if (ratio.isGoodWhenHigh!) {
        valueColor = ratio.value! > 0 ? Colors.green[700] : Colors.red[700];
      } else {
        // For P/E ratio, lower is generally better, but we'll just use neutral color
        valueColor = Colors.blue[700];
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label with Icon
          Row(
            children: [
              Icon(
                ratio.icon,
                size: 16,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  ratio.label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Value
          Text(
            displayValue,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? Colors.black87,
                ),
          ),
        ],
      ),
    );
  }
}

class RatioData {
  final String label;
  final double? value;
  final String suffix;
  final String? prefix;
  final IconData icon;
  final bool? isGoodWhenHigh; // null means neutral

  RatioData({
    required this.label,
    required this.value,
    this.suffix = '',
    this.prefix,
    required this.icon,
    this.isGoodWhenHigh,
  });
}
