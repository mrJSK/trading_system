// lib/widgets/top_performers_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/company_model.dart';
import '../providers/company_provider.dart';
import '../screens/company_details_screen.dart';
import '../theme/app_theme.dart';
import 'company_card.dart';

class TopPerformersSection extends ConsumerWidget {
  const TopPerformersSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topPerformersAsync = ref.watch(topPerformersProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Top Performers',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Navigate to all top performers
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: topPerformersAsync.when(
            data: (companies) => ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: companies.length.clamp(0, 10),
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 280,
                  child: CompanyCard(
                    company: companies[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompanyDetailsScreen(
                          symbol: companies[index].symbol,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text(
                'Error loading top performers',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.getTextSecondary(context),
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final topPerformersProvider = FutureProvider<List<CompanyModel>>((ref) async {
  return await ref
      .read(companyNotifierProvider.notifier)
      .getTopPerformers(limit: 10);
});
