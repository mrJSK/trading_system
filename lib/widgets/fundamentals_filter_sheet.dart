import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filter_provider.dart';

class FundamentalsFilterSheet extends ConsumerStatefulWidget {
  const FundamentalsFilterSheet({super.key});

  @override
  ConsumerState<FundamentalsFilterSheet> createState() =>
      _FundamentalsFilterSheetState();
}

class _FundamentalsFilterSheetState
    extends ConsumerState<FundamentalsFilterSheet> {
  late TextEditingController _marketCapMinController;
  late TextEditingController _marketCapMaxController;
  late TextEditingController _peMinController;
  late TextEditingController _peMaxController;
  late String _selectedSort;
  late bool _sortDescending;
  late int _pageSize;

  @override
  void initState() {
    super.initState();
    final settings = ref.read(filterSettingsProvider);

    _marketCapMinController = TextEditingController(
      text: settings.marketCap.min?.toString() ?? '',
    );
    _marketCapMaxController = TextEditingController(
      text: settings.marketCap.max?.toString() ?? '',
    );
    _peMinController = TextEditingController(
      text: settings.pe.min?.toString() ?? '',
    );
    _peMaxController = TextEditingController(
      text: settings.pe.max?.toString() ?? '',
    );
    _selectedSort = settings.sortBy;
    _sortDescending = settings.sortDescending;
    _pageSize = settings.pageSize;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Fundamentals Filter',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {
                    ref.read(filterSettingsProvider.notifier).resetFilters();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.refresh,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  label: Text(
                    'Reset',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Filters Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Market Cap Filter
                  _buildRangeFilter(
                    context,
                    'Market Cap (Cr)',
                    _marketCapMinController,
                    _marketCapMaxController,
                    'Min Market Cap',
                    'Max Market Cap',
                    Icons.pie_chart,
                  ),

                  const SizedBox(height: 24),

                  // P/E Ratio Filter
                  _buildRangeFilter(
                    context,
                    'P/E Ratio',
                    _peMinController,
                    _peMaxController,
                    'Min P/E',
                    'Max P/E',
                    Icons.trending_up,
                  ),

                  const SizedBox(height: 24),

                  // Sort Options
                  _buildSectionHeader(context, 'Sort Options', Icons.sort),
                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withOpacity(0.2),
                      ),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedSort,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        prefixIcon: Icon(
                          Icons.sort_by_alpha,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                      ),
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'market_cap',
                          child: Text('Market Cap'),
                        ),
                        DropdownMenuItem(
                          value: 'current_price',
                          child: Text('Current Price'),
                        ),
                        DropdownMenuItem(
                          value: 'change_percent',
                          child: Text('Change %'),
                        ),
                        DropdownMenuItem(
                          value: 'stock_pe',
                          child: Text('P/E Ratio'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedSort = value!);
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withOpacity(0.2),
                      ),
                    ),
                    child: SwitchListTile(
                      title: Text(
                        'Descending Order',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Text(
                        'Higher values first',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                          fontSize: 12,
                        ),
                      ),
                      value: _sortDescending,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (value) {
                        setState(() => _sortDescending = value);
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Page Size
                  _buildSectionHeader(
                      context, 'Display Options', Icons.view_list),
                  const SizedBox(height: 12),

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withOpacity(0.2),
                      ),
                    ),
                    child: DropdownButtonFormField<int>(
                      value: _pageSize,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        prefixIcon: Icon(
                          Icons.format_list_numbered,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                        labelText: 'Companies per Page',
                        labelStyle: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                      ),
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 10, child: Text('10 companies')),
                        DropdownMenuItem(
                            value: 20, child: Text('20 companies')),
                        DropdownMenuItem(
                            value: 50, child: Text('50 companies')),
                        DropdownMenuItem(
                            value: 100, child: Text('100 companies')),
                      ],
                      onChanged: (value) {
                        setState(() => _pageSize = value!);
                      },
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),

          // Apply Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0.5,
                ),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _applyFilters,
                    icon: const Icon(Icons.check),
                    label: const Text('Apply Filters'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    label: const Text('Cancel'),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      foregroundColor: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 20,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ],
    );
  }

  Widget _buildRangeFilter(
    BuildContext context,
    String title,
    TextEditingController minController,
    TextEditingController maxController,
    String minHint,
    String maxHint,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.3),
                    ),
                  ),
                  child: TextField(
                    controller: minController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    decoration: InputDecoration(
                      hintText: minHint,
                      hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'to',
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.3),
                    ),
                  ),
                  child: TextField(
                    controller: maxController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    decoration: InputDecoration(
                      hintText: maxHint,
                      hintStyle: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.5),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    final notifier = ref.read(filterSettingsProvider.notifier);

    // Market Cap
    final marketCapMin = double.tryParse(_marketCapMinController.text);
    final marketCapMax = double.tryParse(_marketCapMaxController.text);
    notifier.updateMarketCapFilter(marketCapMin, marketCapMax);

    // P/E Ratio
    final peMin = double.tryParse(_peMinController.text);
    final peMax = double.tryParse(_peMaxController.text);
    notifier.updatePeFilter(peMin, peMax);

    // Sorting
    notifier.updateSorting(_selectedSort, _sortDescending);

    // Page Size
    notifier.updatePageSize(_pageSize);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _marketCapMinController.dispose();
    _marketCapMaxController.dispose();
    _peMinController.dispose();
    _peMaxController.dispose();
    super.dispose();
  }
}
