// widgets/fundamental_tabs.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/fundamental_filter.dart';
import '../providers/fundamental_provider.dart';
import '../theme/app_theme.dart';

class FundamentalTabs extends ConsumerWidget {
  const FundamentalTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(selectedFundamentalProvider);

    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter by Fundamentals',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: FundamentalFilter.defaultFilters.length,
              itemBuilder: (context, index) {
                final filter = FundamentalFilter.defaultFilters[index];
                final isSelected = selectedFilter?.type == filter.type;

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(selectedFundamentalProvider.notifier).state =
                          isSelected ? null : filter;
                    },
                    child: Container(
                      width: 140,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryGreen
                            : AppTheme.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primaryGreen
                              : AppTheme.borderColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            filter.icon,
                            color: isSelected
                                ? Colors.white
                                : AppTheme.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            filter.title,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
