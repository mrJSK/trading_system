import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/company.dart';
import '../models/watchlist.dart';
import 'company_detail_screen.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  final DatabaseService _databaseService = DatabaseService();

  List<Watchlist> _watchlists = [];
  int _selectedWatchlistIndex = 0;
  List<Company> _watchlistCompanies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWatchlists();
  }

  Future<void> _loadWatchlists() async {
    try {
      final watchlists = await _databaseService.getAllWatchlists();
      setState(() {
        _watchlists = watchlists;
        _isLoading = false;
      });

      if (_watchlists.isNotEmpty) {
        _loadWatchlistCompanies(_watchlists[0].id);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading watchlists: $e')),
      );
    }
  }

  Future<void> _loadWatchlistCompanies(int watchlistId) async {
    try {
      final companies =
          await _databaseService.getWatchlistCompanies(watchlistId);
      setState(() {
        _watchlistCompanies = companies;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading companies: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlists'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createNewWatchlist,
            tooltip: 'Create Watchlist',
          ),
          if (_watchlists.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: _addCompanyToWatchlist,
              tooltip: 'Add Company',
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _watchlists.isEmpty
              ? _buildEmptyState()
              : Column(
                  children: [
                    // Watchlist Chips
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _watchlists.length,
                        itemBuilder: (context, index) {
                          final watchlist = _watchlists[index];
                          final isSelected = index == _selectedWatchlistIndex;

                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: InputChip(
                              label: Text(watchlist.name),
                              selected: isSelected,
                              onSelected: (selected) {
                                if (selected) {
                                  setState(() {
                                    _selectedWatchlistIndex = index;
                                  });
                                  _loadWatchlistCompanies(watchlist.id);
                                }
                              },
                              deleteIcon: const Icon(Icons.close, size: 16),
                              onDeleted: () => _deleteWatchlist(watchlist),
                            ),
                          );
                        },
                      ),
                    ),

                    const Divider(),

                    // Companies List
                    Expanded(
                      child: _watchlistCompanies.isEmpty
                          ? _buildEmptyWatchlistState()
                          : ListView.builder(
                              padding: const EdgeInsets.all(16),
                              itemCount: _watchlistCompanies.length,
                              itemBuilder: (context, index) {
                                final company = _watchlistCompanies[index];
                                return _buildCompanyCard(company);
                              },
                            ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.bookmark_outline,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No Watchlists Yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Create your first watchlist to track companies'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _createNewWatchlist,
            child: const Text('Create Watchlist'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWatchlistState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.business_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No Companies in Watchlist',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Add companies to track their performance'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _addCompanyToWatchlist,
            child: const Text('Add Company'),
          ),
        ],
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (company.currentPrice != null)
              Column(
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
              ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () => _removeCompanyFromWatchlist(company),
              tooltip: 'Remove from watchlist',
            ),
          ],
        ),
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

  Future<void> _createNewWatchlist() async {
    final nameController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Watchlist'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Watchlist Name',
            hintText: 'Enter a name for your watchlist',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Create'),
          ),
        ],
      ),
    );

    if (result == true && nameController.text.isNotEmpty) {
      try {
        final watchlist = Watchlist.fromData(
          name: nameController.text,
          createdAt: DateTime.now(),
        );

        await _databaseService.createWatchlist(watchlist);
        await _loadWatchlists();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Watchlist created successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating watchlist: $e')),
        );
      }
    }
  }

  Future<void> _addCompanyToWatchlist() async {
    final companies = await _databaseService.getAllCompanies();

    if (companies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No companies available. Scrape data first.')),
      );
      return;
    }

    final selectedCompany = await showDialog<Company>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Company'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              return ListTile(
                title: Text(company.name),
                subtitle: Text(company.symbol),
                trailing: company.currentPrice != null
                    ? Text('₹${company.currentPrice!.toStringAsFixed(2)}')
                    : null,
                onTap: () => Navigator.pop(context, company),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (selectedCompany != null && _watchlists.isNotEmpty) {
      try {
        final currentWatchlist = _watchlists[_selectedWatchlistIndex];
        await _databaseService.addCompanyToWatchlist(
          currentWatchlist.id,
          selectedCompany.id,
        );

        await _loadWatchlistCompanies(currentWatchlist.id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${selectedCompany.name} added to watchlist')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding company: $e')),
        );
      }
    }
  }

  Future<void> _removeCompanyFromWatchlist(Company company) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Company'),
        content: Text('Remove ${company.name} from this watchlist?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final currentWatchlist = _watchlists[_selectedWatchlistIndex];
        await _databaseService.removeCompanyFromWatchlist(
          currentWatchlist.id,
          company.id,
        );

        await _loadWatchlistCompanies(currentWatchlist.id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${company.name} removed from watchlist')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error removing company: $e')),
        );
      }
    }
  }

  Future<void> _deleteWatchlist(Watchlist watchlist) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Watchlist'),
        content: Text(
            'Delete "${watchlist.name}" watchlist? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _databaseService.deleteWatchlist(watchlist.id);
        await _loadWatchlists();

        // Reset selection if needed
        if (_selectedWatchlistIndex >= _watchlists.length) {
          setState(() {
            _selectedWatchlistIndex = 0;
            _watchlistCompanies.clear();
          });

          // Load companies for the new selected watchlist
          if (_watchlists.isNotEmpty) {
            _loadWatchlistCompanies(_watchlists[0].id);
          }
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${watchlist.name} deleted')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting watchlist: $e')),
        );
      }
    }
  }
}
