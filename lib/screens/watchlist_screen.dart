// lib/screens/watchlist/watchlist_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/company_card.dart';
import '../../theme/app_theme.dart';
import '../providers/company_provider.dart';
import 'company_details_screen.dart';

final watchlistProvider =
    StateNotifierProvider<WatchlistNotifier, List<String>>((ref) {
  return WatchlistNotifier();
});

class WatchlistNotifier extends StateNotifier<List<String>> {
  WatchlistNotifier() : super([]);

  void addToWatchlist(String symbol) {
    if (!state.contains(symbol)) {
      state = [...state, symbol];
    }
  }

  void removeFromWatchlist(String symbol) {
    state = state.where((s) => s != symbol).toList();
  }

  bool isInWatchlist(String symbol) {
    return state.contains(symbol);
  }
}

class WatchlistScreen extends ConsumerWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlistSymbols = ref.watch(watchlistProvider);
    final companiesAsync = ref.watch(companyNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        actions: [
          Text(
            '${watchlistSymbols.length} companies',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.getTextSecondary(context),
                ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: watchlistSymbols.isEmpty
          ? _buildEmptyWatchlist(context)
          : companiesAsync.when(
              data: (companies) {
                final watchlistCompanies = companies
                    .where(
                        (company) => watchlistSymbols.contains(company.symbol))
                    .toList();

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: watchlistCompanies.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final company = watchlistCompanies[index];
                    return Dismissible(
                      key: Key(company.symbol),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: AppTheme.lossRed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        ref
                            .read(watchlistProvider.notifier)
                            .removeFromWatchlist(company.symbol);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${company.symbol} removed from watchlist'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                ref
                                    .read(watchlistProvider.notifier)
                                    .addToWatchlist(company.symbol);
                              },
                            ),
                          ),
                        );
                      },
                      child: CompanyCard(
                        company: company,
                        showDetails: true,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CompanyDetailsScreen(symbol: company.symbol),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            ),
    );
  }

  Widget _buildEmptyWatchlist(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 64,
            color: AppTheme.getTextSecondary(context),
          ),
          const SizedBox(height: 16),
          Text(
            'Your watchlist is empty',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Add companies to track their performance',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.getTextSecondary(context),
                ),
          ),
        ],
      ),
    );
  }
}
