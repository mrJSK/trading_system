// widgets/search_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/fundamental_provider.dart';
import '../providers/company_provider.dart'; // Make sure this import is correct
import '../theme/app_theme.dart';

class CustomSearchBar extends ConsumerStatefulWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  ConsumerState<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends ConsumerState<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.borderColor),
        ),
        child: TextField(
          controller: _controller,
          onChanged: (value) {
            // Update search query in the provider
            ref.read(searchQueryProvider.notifier).state = value;

            // Debounce the search to avoid too many queries
            Future.delayed(const Duration(milliseconds: 500), () {
              if (_controller.text == value) {
                if (value.trim().isNotEmpty) {
                  ref
                      .read(companiesProvider.notifier)
                      .searchCompanies(value.trim());
                } else {
                  // If search is cleared, reload initial companies
                  ref.read(companiesProvider.notifier).loadInitialCompanies();
                }
              }
            });
          },
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              ref
                  .read(companiesProvider.notifier)
                  .searchCompanies(value.trim());
            } else {
              ref.read(companiesProvider.notifier).loadInitialCompanies();
            }
          },
          decoration: InputDecoration(
            hintText: 'Search company',
            prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon:
                        const Icon(Icons.clear, color: AppTheme.textSecondary),
                    onPressed: () {
                      _controller.clear();
                      ref.read(searchQueryProvider.notifier).state = '';
                      ref
                          .read(companiesProvider.notifier)
                          .loadInitialCompanies();
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintStyle:
                const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
