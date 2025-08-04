import 'package:flutter/material.dart';
import 'dart:convert';
import '../services/database_service.dart';
import '../models/company.dart';
import '../models/saved_filter.dart';
import 'company_detail_screen.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final DatabaseService _databaseService = DatabaseService();

  // Filter controllers
  final TextEditingController _minMarketCapController = TextEditingController();
  final TextEditingController _maxMarketCapController = TextEditingController();
  final TextEditingController _minPEController = TextEditingController();
  final TextEditingController _maxPEController = TextEditingController();
  final TextEditingController _minROCEController = TextEditingController();
  final TextEditingController _maxROCEController = TextEditingController();
  final TextEditingController _minROEController = TextEditingController();
  final TextEditingController _maxROEController = TextEditingController();
  final TextEditingController _minDividendYieldController =
      TextEditingController();
  final TextEditingController _maxDividendYieldController =
      TextEditingController();

  List<Company> _filteredCompanies = [];
  List<SavedFilter> _savedFilters = [];
  bool _isFiltering = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedFilters();
  }

  @override
  void dispose() {
    _minMarketCapController.dispose();
    _maxMarketCapController.dispose();
    _minPEController.dispose();
    _maxPEController.dispose();
    _minROCEController.dispose();
    _maxROCEController.dispose();
    _minROEController.dispose();
    _maxROEController.dispose();
    _minDividendYieldController.dispose();
    _maxDividendYieldController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedFilters() async {
    try {
      final filters = await _databaseService.getAllSavedFilters();
      setState(() {
        _savedFilters = filters;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackBar('Error loading saved filters: $e', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter Companies',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        elevation: 2,
        shadowColor: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, size: 26),
            onPressed: _saveCurrentFilter,
            tooltip: 'Save Filter',
            padding: const EdgeInsets.all(12),
          ),
          IconButton(
            icon: const Icon(Icons.clear, size: 26),
            onPressed: _clearFilters,
            tooltip: 'Clear All',
            padding: const EdgeInsets.all(12),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                if (_savedFilters.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Container(
                      height: 80,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _savedFilters.length,
                        itemBuilder: (context, index) {
                          final filter = _savedFilters[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: AnimatedScale(
                              scale: 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: InputChip(
                                label: Text(
                                  filter.name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                selectedColor: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2),
                                onPressed: () => _loadFilter(filter),
                                deleteIcon: const Icon(Icons.close, size: 18),
                                onDeleted: () => _deleteSavedFilter(filter),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.2)),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: Divider(height: 1)),
                ],
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildFilterSection(
                          'Market Cap (in Crores)',
                          _minMarketCapController,
                          _maxMarketCapController,
                          'Enter value in crores',
                        ),
                        _buildFilterSection(
                          'P/E Ratio',
                          _minPEController,
                          _maxPEController,
                          'Price-to-Earnings ratio',
                        ),
                        _buildFilterSection(
                          'ROCE (%)',
                          _minROCEController,
                          _maxROCEController,
                          'Return on Capital Employed',
                        ),
                        _buildFilterSection(
                          'ROE (%)',
                          _minROEController,
                          _maxROEController,
                          'Return on Equity',
                        ),
                        _buildFilterSection(
                          'Dividend Yield (%)',
                          _minDividendYieldController,
                          _maxDividendYieldController,
                          'Annual dividend yield',
                        ),
                        const SizedBox(height: 24),
                        AnimatedScale(
                          scale: _isFiltering ? 0.95 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: ElevatedButton(
                            onPressed: _isFiltering ? null : _applyFilters,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            child: _isFiltering
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Text('Filtering...',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  )
                                : const Text('Apply Filters',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_filteredCompanies.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        'Results (${_filteredCompanies.length} companies)',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final company = _filteredCompanies[index];
                        return _buildCompanyCard(company);
                      },
                      childCount: _filteredCompanies.length,
                    ),
                  ),
                ],
              ],
            ),
    );
  }

  Widget _buildFilterSection(
    String title,
    TextEditingController minController,
    TextEditingController maxController,
    String helperText,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              helperText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: minController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Min',
                      hintText: '0',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: maxController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Max',
                      hintText: 'No limit',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyCard(Company company) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompanyDetailScreen(company: company),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      company.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      company.symbol,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
              if (company.currentPrice != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${company.currentPrice!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                    if (company.marketCap != null)
                      Text(
                        '₹${company.marketCap!.toStringAsFixed(0)}Cr',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _applyFilters() async {
    setState(() {
      _isFiltering = true;
    });

    try {
      final filteredCompanies = await _databaseService.getFilteredCompanies(
        minMarketCap: _parseDouble(_minMarketCapController.text),
        maxMarketCap: _parseDouble(_maxMarketCapController.text),
        minPE: _parseDouble(_minPEController.text),
        maxPE: _parseDouble(_maxPEController.text),
        minROCE: _parseDouble(_minROCEController.text),
        maxROCE: _parseDouble(_maxROCEController.text),
        minROE: _parseDouble(_minROEController.text),
        maxROE: _parseDouble(_maxROEController.text),
        minDividendYield: _parseDouble(_minDividendYieldController.text),
        maxDividendYield: _parseDouble(_maxDividendYieldController.text),
      );

      setState(() {
        _filteredCompanies = filteredCompanies;
      });
      _showSnackBar('Filters applied successfully', Colors.green);
    } catch (e) {
      _showSnackBar('Error applying filters: $e', Colors.red);
    } finally {
      setState(() {
        _isFiltering = false;
      });
    }
  }

  double? _parseDouble(String text) {
    if (text.isEmpty) return null;
    final value = double.tryParse(text);
    if (value != null && value >= 0) return value;
    return null;
  }

  Future<void> _saveCurrentFilter() async {
    final nameController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.save, size: 24, color: Colors.blue),
            SizedBox(width: 12),
            Text('Save Filter',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          ],
        ),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Filter Name',
            hintText: 'Enter a name for this filter',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel', style: TextStyle(fontSize: 16)),
            style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save', style: TextStyle(fontSize: 16)),
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );

    if (result == true && nameController.text.isNotEmpty) {
      try {
        final filter = SavedFilter.fromData(
          name: nameController.text,
          minMarketCap: _parseDouble(_minMarketCapController.text),
          maxMarketCap: _parseDouble(_maxMarketCapController.text),
          minPE: _parseDouble(_minPEController.text),
          maxPE: _parseDouble(_maxPEController.text),
          minROCE: _parseDouble(_minROCEController.text),
          maxROCE: _parseDouble(_maxROCEController.text),
          minROE: _parseDouble(_minROEController.text),
          maxROE: _parseDouble(_maxROEController.text),
          minDividendYield: _parseDouble(_minDividendYieldController.text),
          maxDividendYield: _parseDouble(_maxDividendYieldController.text),
          createdAt: DateTime.now(),
        );

        await _databaseService.saveFilter(filter);
        await _loadSavedFilters();
        _showSnackBar('Filter saved successfully', Colors.green);
      } catch (e) {
        _showSnackBar('Error saving filter: $e', Colors.red);
      }
    }
  }

  void _loadFilter(SavedFilter filter) {
    setState(() {
      _minMarketCapController.text = filter.minMarketCap?.toString() ?? '';
      _maxMarketCapController.text = filter.maxMarketCap?.toString() ?? '';
      _minPEController.text = filter.minPE?.toString() ?? '';
      _maxPEController.text = filter.maxPE?.toString() ?? '';
      _minROCEController.text = filter.minROCE?.toString() ?? '';
      _maxROCEController.text = filter.maxROCE?.toString() ?? '';
      _minROEController.text = filter.minROE?.toString() ?? '';
      _maxROEController.text = filter.maxROE?.toString() ?? '';
      _minDividendYieldController.text =
          filter.minDividendYield?.toString() ?? '';
      _maxDividendYieldController.text =
          filter.maxDividendYield?.toString() ?? '';
    });
    _showSnackBar('Filter "${filter.name}" loaded', Colors.blue);
  }

  Future<void> _deleteSavedFilter(SavedFilter filter) async {
    try {
      await _databaseService.deleteSavedFilter(filter.id);
      await _loadSavedFilters();
      _showSnackBar('Filter "${filter.name}" deleted', Colors.green);
    } catch (e) {
      _showSnackBar('Error deleting filter: $e', Colors.red);
    }
  }

  void _clearFilters() {
    setState(() {
      _minMarketCapController.clear();
      _maxMarketCapController.clear();
      _minPEController.clear();
      _maxPEController.clear();
      _minROCEController.clear();
      _maxROCEController.clear();
      _minROEController.clear();
      _maxROEController.clear();
      _minDividendYieldController.clear();
      _maxDividendYieldController.clear();
      _filteredCompanies.clear();
    });
    _showSnackBar('Filters cleared', Colors.blue);
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 14)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
