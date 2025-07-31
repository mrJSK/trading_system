import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/company/company_model.dart';
import 'company_provider.dart';

// Market Summary Model
class MarketSummary {
  final int totalStocks;
  final int gainers;
  final int losers;
  final int unchanged;
  final DateTime? lastUpdated;
  final double totalMarketCap;
  final double averageChange;

  MarketSummary({
    required this.totalStocks,
    required this.gainers,
    required this.losers,
    required this.unchanged,
    this.lastUpdated,
    required this.totalMarketCap,
    required this.averageChange,
  });
}

// Market Summary Provider
final marketSummaryProvider = Provider<AsyncValue<MarketSummary>>((ref) {
  final companiesState = ref.watch(companiesProvider);

  return companiesState.when(
    data: (companies) {
      if (companies.isEmpty) {
        return AsyncValue.data(MarketSummary(
          totalStocks: 0,
          gainers: 0,
          losers: 0,
          unchanged: 0,
          totalMarketCap: 0,
          averageChange: 0,
        ));
      }

      final gainers = companies.where((c) => (c.changePercent ?? 0) > 0).length;
      final losers = companies.where((c) => (c.changePercent ?? 0) < 0).length;
      final unchanged =
          companies.where((c) => (c.changePercent ?? 0) == 0).length;

      final totalMarketCap = companies
          .where((c) => c.marketCap != null)
          .fold<double>(0, (sum, c) => sum + (c.marketCap ?? 0));

      final validChanges = companies
          .where((c) => c.changePercent != null)
          .map((c) => c.changePercent!)
          .toList();

      final averageChange = validChanges.isNotEmpty
          ? validChanges.reduce((a, b) => a + b) / validChanges.length
          : 0.0;

      // Get the most recent update time
      final lastUpdated = companies
          .where((c) => c.lastUpdated != null)
          .map((c) => c.lastUpdated!)
          .fold<DateTime?>(null, (latest, current) {
        if (latest == null) return current;
        return current.isAfter(latest) ? current : latest;
      });

      return AsyncValue.data(MarketSummary(
        totalStocks: companies.length,
        gainers: gainers,
        losers: losers,
        unchanged: unchanged,
        lastUpdated: lastUpdated,
        totalMarketCap: totalMarketCap,
        averageChange: averageChange,
      ));
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

// Additional derived providers for specific metrics
final gainersProvider = Provider<AsyncValue<List<CompanyModel>>>((ref) {
  final companiesState = ref.watch(companiesProvider);

  return companiesState.when(
    data: (companies) {
      final gainers = companies
          .where((c) => (c.changePercent ?? 0) > 0)
          .toList()
        ..sort(
            (a, b) => (b.changePercent ?? 0).compareTo(a.changePercent ?? 0));

      return AsyncValue.data(gainers);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final losersProvider = Provider<AsyncValue<List<CompanyModel>>>((ref) {
  final companiesState = ref.watch(companiesProvider);

  return companiesState.when(
    data: (companies) {
      final losers = companies.where((c) => (c.changePercent ?? 0) < 0).toList()
        ..sort(
            (a, b) => (a.changePercent ?? 0).compareTo(b.changePercent ?? 0));

      return AsyncValue.data(losers);
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final topGainersProvider = Provider<AsyncValue<List<CompanyModel>>>((ref) {
  final gainersState = ref.watch(gainersProvider);

  return gainersState.when(
    data: (gainers) => AsyncValue.data(gainers.take(10).toList()),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final topLosersProvider = Provider<AsyncValue<List<CompanyModel>>>((ref) {
  final losersState = ref.watch(losersProvider);

  return losersState.when(
    data: (losers) => AsyncValue.data(losers.take(10).toList()),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});
