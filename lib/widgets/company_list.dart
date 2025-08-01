// widgets/company_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/company_model.dart';
import '../providers/company_provider.dart';
import '../providers/fundamental_provider.dart';
import '../widgets/company_card.dart';
import '../widgets/empty_state.dart';

class CompanyList extends ConsumerStatefulWidget {
  const CompanyList({Key? key}) : super(key: key);

  @override
  ConsumerState<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends ConsumerState<CompanyList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Load initial companies when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final companiesNotifier = ref.read(companiesProvider.notifier);
      companiesNotifier.loadInitialCompanies();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.95) {
      // Load more companies when reaching 95% of scroll
      ref.read(companiesProvider.notifier).loadMoreCompanies();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fixed: Removed WidgetRef ref parameter
    final selectedFilter = ref.watch(selectedFundamentalProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    // If there's a selected fundamental filter, use the filtered companies
    if (selectedFilter != null) {
      return ref.watch(filteredCompaniesProvider).when(
            data: (companies) => _buildCompanyList(companies, isFiltered: true),
            loading: () => _buildLoadingState(),
            error: (error, stack) => _buildErrorState(error, () {
              ref.invalidate(filteredCompaniesProvider);
            }),
          );
    }

    // If there's a search query, show search results
    if (searchQuery.isNotEmpty) {
      return ref.watch(companiesProvider).when(
            data: (companies) =>
                _buildCompanyList(companies, isSearchResult: true),
            loading: () => _buildLoadingState(),
            error: (error, stack) => _buildErrorState(error, () {
              ref.read(companiesProvider.notifier).searchCompanies(searchQuery);
            }),
          );
    }

    // Default: show all companies with pagination
    return ref.watch(companiesProvider).when(
          data: (companies) => _buildCompanyList(companies, showLoadMore: true),
          loading: () => _buildLoadingState(),
          error: (error, stack) => _buildErrorState(error, () {
            ref.read(companiesProvider.notifier).refreshCompanies();
          }),
        );
  }

  Widget _buildCompanyList(
    List<CompanyModel> companies, {
    bool showLoadMore = false,
    bool isFiltered = false,
    bool isSearchResult = false,
  }) {
    if (companies.isEmpty) {
      String message;
      IconData icon;

      if (isSearchResult) {
        message = 'No companies found for your search';
        icon = Icons.search_off;
      } else if (isFiltered) {
        message = 'No companies match the selected filter';
        icon = Icons.filter_list_off;
      } else {
        message = 'No companies available';
        icon = Icons.business_outlined;
      }

      return EmptyState(
        message: message,
        icon: icon,
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        if (isFiltered) {
          ref.invalidate(filteredCompaniesProvider);
        } else if (isSearchResult) {
          final searchQuery = ref.read(searchQueryProvider);
          if (searchQuery.isNotEmpty) {
            await ref
                .read(companiesProvider.notifier)
                .searchCompanies(searchQuery);
          }
        } else {
          await ref.read(companiesProvider.notifier).refreshCompanies();
        }
      },
      child: ListView.builder(
        controller: showLoadMore ? _scrollController : null,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: showLoadMore ? companies.length + 1 : companies.length,
        itemBuilder: (context, index) {
          // Show loading indicator at the end for pagination
          if (showLoadMore && index == companies.length) {
            return _buildLoadMoreIndicator();
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: CompanyCard(company: companies[index]),
          );
        },
      ),
    );
  }

  Widget _buildLoadMoreIndicator() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text(
            'Loading companies...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error, VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Error: ${error.toString()}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
                const SizedBox(width: 16),
                TextButton.icon(
                  onPressed: () {
                    // Clear all filters and search
                    ref.read(selectedFundamentalProvider.notifier).state = null;
                    ref.read(searchQueryProvider.notifier).state = '';
                    ref.read(companiesProvider.notifier).loadInitialCompanies();
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear Filters'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
