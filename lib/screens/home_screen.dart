import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/company.dart';
import 'company_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final TextEditingController _searchController = TextEditingController();
  List<Company> _companies = [];
  List<Company> _filteredCompanies = [];
  Map<String, int> _stats = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_filterCompanies);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final companies = await _databaseService.getAllCompanies();
      final stats = await _databaseService.getCompanyStats();

      setState(() {
        _companies = companies;
        _filteredCompanies = companies;
        _stats = stats;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  void _filterCompanies() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCompanies = _companies
          .where((company) =>
              company.name.toLowerCase().contains(query) ||
              company.symbol.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Screener'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Stats Cards
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          'Total Companies',
                          _stats['totalCompanies']?.toString() ?? '0',
                          Icons.business,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatCard(
                          'With Data',
                          _stats['companiesWithData']?.toString() ?? '0',
                          Icons.data_usage,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatCard(
                          'Watchlists',
                          _stats['totalWatchlists']?.toString() ?? '0',
                          Icons.bookmark,
                          Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search companies...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Companies List
                Expanded(
                  child: _filteredCompanies.isEmpty
                      ? const Center(
                          child: Text('No companies found'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: _filteredCompanies.length,
                          itemBuilder: (context, index) {
                            final company = _filteredCompanies[index];
                            return _buildCompanyCard(company);
                          },
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyCard(Company company) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(
          company.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(company.symbol),
        trailing: company.currentPrice != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${company.currentPrice!.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (company.marketCap != null)
                    Text(
                      '₹${company.marketCap!.toStringAsFixed(0)}Cr',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              )
            : null,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompanyDetailScreen(company: company),
            ),
          );
        },
      ),
    );
  }
}
