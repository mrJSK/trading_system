import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../models/company/company_model.dart';
import '../../../../core/theme/app_theme.dart';

class StockDetailScreen extends ConsumerWidget {
  final CompanyModel company;

  const StockDetailScreen({
    super.key,
    required this.company,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(company.symbol),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPriceCard(),
            const SizedBox(height: 16),
            _buildRatiosCard(),
            const SizedBox(height: 16),
            _buildAboutCard(),
            const SizedBox(height: 16),
            _buildProsConsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              company.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  company.formattedPrice,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: company.isGainer
                        ? AppTheme.primaryGreen.withOpacity(0.1)
                        : AppTheme.primaryRed.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    company.formattedChange,
                    style: TextStyle(
                      color: company.isGainer
                          ? AppTheme.primaryGreen
                          : AppTheme.primaryRed,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            if (company.highLow != null) ...[
              const SizedBox(height: 8),
              Text(
                'High/Low: ${company.highLow}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRatiosCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Key Ratios',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              children: [
                _buildRatioItem('Market Cap', company.formattedMarketCap),
                _buildRatioItem(
                    'P/E Ratio', company.stockPe?.toStringAsFixed(2) ?? 'N/A'),
                _buildRatioItem(
                    'Book Value',
                    company.bookValue != null
                        ? '₹${company.bookValue!.toStringAsFixed(2)}'
                        : 'N/A'),
                _buildRatioItem(
                    'Dividend Yield',
                    company.dividendYield != null
                        ? '${company.dividendYield!.toStringAsFixed(2)}%'
                        : 'N/A'),
                _buildRatioItem(
                    'ROCE',
                    company.roce != null
                        ? '${company.roce!.toStringAsFixed(2)}%'
                        : 'N/A'),
                _buildRatioItem(
                    'ROE',
                    company.roe != null
                        ? '${company.roe!.toStringAsFixed(2)}%'
                        : 'N/A'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatioItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutCard() {
    if (company.about == null || company.about!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              company.about!,
              style: const TextStyle(fontSize: 14),
            ),
            if (company.website != null) ...[
              const SizedBox(height: 8),
              Text(
                'Website: ${company.website}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProsConsCard() {
    if (company.pros.isEmpty && company.cons.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pros & Cons',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (company.pros.isNotEmpty) ...[
              const Text(
                'Pros',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryGreen,
                ),
              ),
              const SizedBox(height: 8),
              ...company.pros.map((pro) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppTheme.primaryGreen,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            pro,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
            if (company.cons.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Cons',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryRed,
                ),
              ),
              const SizedBox(height: 8),
              ...company.cons.map((con) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.cancel,
                          color: AppTheme.primaryRed,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            con,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
