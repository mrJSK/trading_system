// widgets/search_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/company_provider.dart';
import '../theme/app_theme.dart';
import 'dart:async';

// Enhanced search providers
final searchQueryProvider = StateProvider<String>((ref) => '');
final searchSuggestionsProvider = StateProvider<List<String>>((ref) => []);
final searchHistoryProvider = StateProvider<List<String>>((ref) => []);
final isSearchFocusedProvider = StateProvider<bool>((ref) => false);

class CustomSearchBar extends ConsumerStatefulWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounceTimer;
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _focusNode.addListener(_onFocusChange);

    // Initialize with search query if exists
    final currentQuery = ref.read(searchQueryProvider);
    if (currentQuery.isNotEmpty) {
      _controller.text = currentQuery;
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _removeOverlay();
    _controller.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    ref.read(isSearchFocusedProvider.notifier).state = _focusNode.hasFocus;

    if (_focusNode.hasFocus) {
      _animationController.forward();
      _showSuggestions();
    } else {
      _animationController.reverse();
      _removeOverlay();
    }
  }

  void _showSuggestions() {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 32,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 55),
          child: _buildSuggestionsOverlay(),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    final isSearchFocused = ref.watch(isSearchFocusedProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSearchFocused
                        ? AppTheme.primaryGreen
                        : AppTheme.borderColor,
                    width: isSearchFocused ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSearchFocused
                          ? AppTheme.primaryGreen.withOpacity(0.1)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: isSearchFocused ? 8 : 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _buildEnhancedTextField(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEnhancedTextField() {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onChanged: _handleSearchChange,
      onSubmitted: _handleSearchSubmit,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search by symbol, name, sector or industry...',
        prefixIcon: Container(
          padding: const EdgeInsets.all(12),
          child: Icon(
            Icons.search,
            color: _focusNode.hasFocus
                ? AppTheme.primaryGreen
                : AppTheme.textSecondary,
            size: 20,
          ),
        ),
        suffixIcon: _buildSuffixActions(),
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: const TextStyle(
          color: AppTheme.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget? _buildSuffixActions() {
    final hasText = _controller.text.isNotEmpty;

    if (!hasText) return null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Voice search button (placeholder for future implementation)
        IconButton(
          icon: const Icon(Icons.mic, size: 18),
          color: AppTheme.textSecondary,
          onPressed: () {
            // Voice search functionality
            _showVoiceSearchDialog();
          },
          tooltip: 'Voice Search',
        ),
        // Clear button
        IconButton(
          icon: const Icon(Icons.clear, size: 18),
          color: AppTheme.textSecondary,
          onPressed: _clearSearch,
          tooltip: 'Clear Search',
        ),
      ],
    );
  }

  Widget _buildSuggestionsOverlay() {
    return Consumer(
      builder: (context, ref, child) {
        final suggestions = _generateSmartSuggestions();
        final searchHistory = ref.watch(searchHistoryProvider);

        if (suggestions.isEmpty && searchHistory.isEmpty) {
          return const SizedBox.shrink();
        }

        return Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (suggestions.isNotEmpty) ...[
                  _buildSectionHeader(
                      'Smart Suggestions', Icons.lightbulb_outline),
                  ...suggestions.map(
                      (suggestion) => _buildSuggestionItem(suggestion, true)),
                ],
                if (searchHistory.isNotEmpty) ...[
                  if (suggestions.isNotEmpty) const Divider(height: 1),
                  _buildSectionHeader('Recent Searches', Icons.history),
                  ...searchHistory
                      .take(3)
                      .map((query) => _buildHistoryItem(query)),
                ],
                _buildQuickActionsSection(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppTheme.textSecondary),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(String suggestion, bool isSmart) {
    return InkWell(
      onTap: () => _selectSuggestion(suggestion),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(
              isSmart ? Icons.auto_awesome : Icons.search,
              size: 16,
              color: isSmart ? AppTheme.primaryGreen : AppTheme.textSecondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                suggestion,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.north_west,
              size: 14,
              color: AppTheme.textSecondary.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String query) {
    return InkWell(
      onTap: () => _selectSuggestion(query),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.history, size: 16, color: AppTheme.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                query,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 14),
              color: AppTheme.textSecondary,
              onPressed: () => _removeFromHistory(query),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withOpacity(0.05),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Filters',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _buildQuickFilterChip('Quality Stocks', Icons.star),
              _buildQuickFilterChip('Debt Free', Icons.shield),
              _buildQuickFilterChip('High Growth', Icons.trending_up),
              _buildQuickFilterChip('Dividend Stocks', Icons.monetization_on),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFilterChip(String label, IconData icon) {
    return InkWell(
      onTap: () => _applyQuickFilter(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppTheme.primaryGreen.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 12, color: AppTheme.primaryGreen),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppTheme.primaryGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSearchChange(String value) {
    ref.read(searchQueryProvider.notifier).state = value;

    // Cancel previous timer
    _debounceTimer?.cancel();

    // Update suggestions immediately for better UX
    if (value.isNotEmpty) {
      _showSuggestions();
    }

    // Debounce the actual search
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (_controller.text == value && mounted) {
        if (value.trim().isNotEmpty) {
          _performSearch(value.trim());
        } else {
          ref.read(companyNotifierProvider.notifier).refreshCompanies();
        }
      }
    });
  }

  void _handleSearchSubmit(String value) {
    _debounceTimer?.cancel();
    if (value.trim().isNotEmpty) {
      _performSearch(value.trim());
      _addToHistory(value.trim());
    } else {
      ref.read(companyNotifierProvider.notifier).refreshCompanies();
    }
    _focusNode.unfocus();
  }

  void _performSearch(String query) {
    // Update search provider
    ref.read(searchQueryProvider.notifier).state = query;

    // Show loading indicator
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text('Searching for "$query"...'),
          ],
        ),
        backgroundColor: AppTheme.primaryGreen,
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    // Trigger search through provider
    ref.read(companyNotifierProvider.notifier).searchCompanies(query);
  }

  void _clearSearch() {
    _controller.clear();
    ref.read(searchQueryProvider.notifier).state = '';
    ref.read(companyNotifierProvider.notifier).refreshCompanies();
    _focusNode.unfocus();
  }

  void _selectSuggestion(String suggestion) {
    _controller.text = suggestion;
    _handleSearchSubmit(suggestion);
  }

  void _addToHistory(String query) {
    final history = ref.read(searchHistoryProvider);
    final newHistory =
        [query, ...history.where((h) => h != query)].take(5).toList();
    ref.read(searchHistoryProvider.notifier).state = newHistory;
  }

  void _removeFromHistory(String query) {
    final history = ref.read(searchHistoryProvider);
    ref.read(searchHistoryProvider.notifier).state =
        history.where((h) => h != query).toList();
  }

  void _applyQuickFilter(String filterLabel) {
    _focusNode.unfocus();

    // This would integrate with your filter system
    switch (filterLabel) {
      case 'Quality Stocks':
        _controller.text = 'quality stocks';
        break;
      case 'Debt Free':
        _controller.text = 'debt free';
        break;
      case 'High Growth':
        _controller.text = 'growth';
        break;
      case 'Dividend Stocks':
        _controller.text = 'dividend';
        break;
    }

    _handleSearchSubmit(_controller.text);
  }

  void _showVoiceSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.mic, color: AppTheme.primaryGreen),
            SizedBox(width: 8),
            Text('Voice Search'),
          ],
        ),
        content: const Text('Voice search functionality coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  List<String> _generateSmartSuggestions() {
    final query = _controller.text.toLowerCase();
    if (query.isEmpty) return [];

    // Smart suggestions based on common search patterns
    final suggestions = <String>[];

    // Symbol suggestions
    if (query.length <= 4) {
      suggestions.addAll([
        '${query.toUpperCase()} (Symbol)',
        'Companies starting with ${query.toUpperCase()}',
      ]);
    }

    // Sector/Industry suggestions
    final sectors = [
      'Technology',
      'Healthcare',
      'Finance',
      'Energy',
      'Consumer',
      'Industrial'
    ];
    for (final sector in sectors) {
      if (sector.toLowerCase().contains(query)) {
        suggestions.add('$sector sector companies');
      }
    }

    // Analysis-based suggestions
    if (query.contains('debt')) {
      suggestions.add('Debt-free companies');
    }
    if (query.contains('dividend')) {
      suggestions.add('High dividend yield stocks');
    }
    if (query.contains('growth')) {
      suggestions.add('High growth companies');
    }
    if (query.contains('quality')) {
      suggestions.add('Quality stocks (Piotroski ≥ 7)');
    }

    return suggestions.take(4).toList();
  }
}
