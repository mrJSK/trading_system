// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/company_provider.dart';
import '../../widgets/company_card.dart';
import '../../widgets/search_bar.dart';
import '../../widgets/top_performers_section.dart';
import '../../theme/app_theme.dart';
import '../../models/company_model.dart';
import 'company_details_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreCompanies();
    }
  }

  Future<void> _loadMoreCompanies() async {
    if (_isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    // Load more companies (this would be implemented in your provider)
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate loading

    if (mounted) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final companiesAsync = ref.watch(companyNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trading System'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(companyNotifierProvider),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchTextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),

          // Top Performers (if no search)
          if (_searchQuery.isEmpty) const TopPerformersSection(),

          // Companies List
          Expanded(
            child: companiesAsync.when(
              data: (companies) {
                final filteredCompanies = _searchQuery.isEmpty
                    ? companies
                    : companies
                        .where((c) =>
                            c.symbol
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()) ||
                            c.name
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()))
                        .toList();

                return ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount:
                      filteredCompanies.length + (_isLoadingMore ? 1 : 0),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index >= filteredCompanies.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return CompanyCard(
                      company: filteredCompanies[index],
                      onTap: () =>
                          _navigateToCompanyDetails(filteredCompanies[index]),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppTheme.getTextSecondary(context),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading companies',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(companyNotifierProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToCompanyDetails(CompanyModel company) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompanyDetailsScreen(symbol: company.symbol),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
