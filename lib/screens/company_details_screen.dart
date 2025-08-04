// lib/screens/company/company_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/company_provider.dart';
import '../../models/company_model.dart';
import '../../theme/app_theme.dart';

// Provider for individual company details
final companyBySymbolProvider =
    FutureProvider.family<CompanyModel?, String>((ref, symbol) async {
  return await ref
      .read(companyNotifierProvider.notifier)
      .getCompanyBySymbol(symbol);
});

class CompanyDetailsScreen extends ConsumerWidget {
  final String symbol;

  const CompanyDetailsScreen({super.key, required this.symbol});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyAsync = ref.watch(companyBySymbolProvider(symbol));

    return Scaffold(
      appBar: AppBar(
        title: Text(symbol),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () => _addToWatchlist(context, symbol),
          ),
        ],
      ),
      body: companyAsync.when(
        data: (company) => company != null
            ? _buildCompanyDetails(context, company)
            : _buildNotFound(context),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildError(context, error.toString()),
      ),
    );
  }

  Widget _buildCompanyDetails(BuildContext context, CompanyModel company) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Company Header
          _buildCompanyHeader(context, company),
          const SizedBox(height: 24),

          // Key Metrics
          _buildKeyMetrics(context, company),
          const SizedBox(height: 24),

          // Pros and Cons
          if (company.pros.isNotEmpty || company.cons.isNotEmpty)
            _buildProsAndCons(context, company),
        ],
      ),
    );
  }

  Widget _buildCompanyHeader(BuildContext context, CompanyModel company) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                        company.symbol,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        company.displayName,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppTheme.getTextSecondary(context),
                                ),
                      ),
                      if (company.sector != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          company.sector!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${company.currentPrice?.toStringAsFixed(2) ?? 'N/A'}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: company.changePercent >= 0
                            ? AppTheme.profitGreen.withOpacity(0.1)
                            : AppTheme.lossRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            company.changePercent >= 0
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            size: 16,
                            color: company.changePercent >= 0
                                ? AppTheme.profitGreen
                                : AppTheme.lossRed,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${company.changePercent.toStringAsFixed(2)}%',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: company.changePercent >= 0
                                      ? AppTheme.profitGreen
                                      : AppTheme.lossRed,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (company.about != null) ...[
              const SizedBox(height: 16),
              Text(
                'About',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                company.about!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildKeyMetrics(BuildContext context, CompanyModel company) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Metrics',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.5,
          children: [
            _buildMetricCard(context, 'P/E Ratio',
                company.stockPe?.toStringAsFixed(1) ?? 'N/A'),
            _buildMetricCard(
                context,
                'ROE',
                company.roe != null
                    ? '${company.roe!.toStringAsFixed(1)}%'
                    : 'N/A'),
            _buildMetricCard(
                context,
                'ROCE',
                company.roce != null
                    ? '${company.roce!.toStringAsFixed(1)}%'
                    : 'N/A'),
            _buildMetricCard(context, 'Debt/Equity',
                company.debtToEquity?.toStringAsFixed(2) ?? 'N/A'),
            _buildMetricCard(context, 'Current Ratio',
                company.currentRatio?.toStringAsFixed(2) ?? 'N/A'),
            _buildMetricCard(context, 'Market Cap',
                _formatMarketCap(company.marketCap ?? 0)),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.getTextSecondary(context),
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProsAndCons(BuildContext context, CompanyModel company) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Analysis',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (company.pros.isNotEmpty)
              Expanded(child: _buildProsList(context, company.pros)),
            if (company.pros.isNotEmpty && company.cons.isNotEmpty)
              const SizedBox(width: 12),
            if (company.cons.isNotEmpty)
              Expanded(child: _buildConsList(context, company.cons)),
          ],
        ),
      ],
    );
  }

  Widget _buildProsList(BuildContext context, List<String> pros) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: AppTheme.profitGreen,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Strengths',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.profitGreen,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...pros.map((pro) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.only(top: 8, right: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.profitGreen,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          pro,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildConsList(BuildContext context, List<String> cons) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.trending_down,
                  color: AppTheme.lossRed,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Weaknesses',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.lossRed,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...cons.map((con) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.only(top: 8, right: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.lossRed,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          con,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppTheme.getTextSecondary(context),
          ),
          const SizedBox(height: 16),
          Text(
            'Company not found',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'The company $symbol could not be found',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.getTextSecondary(context),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppTheme.lossRed,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading company',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.getTextSecondary(context),
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatMarketCap(double marketCap) {
    if (marketCap >= 100000)
      return '${(marketCap / 1000).toStringAsFixed(0)}K Cr';
    if (marketCap >= 1000)
      return '${(marketCap / 1000).toStringAsFixed(1)}K Cr';
    return '${marketCap.toStringAsFixed(0)} Cr';
  }

  void _addToWatchlist(BuildContext context, String symbol) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $symbol to watchlist'),
        backgroundColor: AppTheme.profitGreen,
      ),
    );
  }
}
