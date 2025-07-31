import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../companies/presentation/providers/company_provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../companies/presentation/providers/market_summary_provider.dart';

class MarketSummaryCard extends ConsumerWidget {
  const MarketSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesState = ref.watch(companiesProvider);
    final marketSummary = ref.watch(marketSummaryProvider);

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Market Summary',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                if (companiesState.isLoading)
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            marketSummary.when(
              data: (summary) => Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryItem(
                          title: 'Total Stocks',
                          value: summary.totalStocks.toString(),
                          color: Theme.of(context).colorScheme.primary,
                          icon: Icons.business,
                        ),
                      ),
                      Expanded(
                        child: _SummaryItem(
                          title: 'Gainers',
                          value: summary.gainers.toString(),
                          color: AppTheme.primaryGreen,
                          icon: Icons.trending_up,
                        ),
                      ),
                      Expanded(
                        child: _SummaryItem(
                          title: 'Losers',
                          value: summary.losers.toString(),
                          color: AppTheme.primaryRed,
                          icon: Icons.trending_down,
                        ),
                      ),
                      Expanded(
                        child: _SummaryItem(
                          title: 'Unchanged',
                          value: summary.unchanged.toString(),
                          color: Colors.grey[600]!,
                          icon: Icons.trending_flat,
                        ),
                      ),
                    ],
                  ),
                  if (summary.lastUpdated != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 12,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Updated: ${_formatDateTime(summary.lastUpdated!)}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.error,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Failed to load market summary',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _SummaryItem({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
