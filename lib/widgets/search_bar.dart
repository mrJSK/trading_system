// lib/widgets/search_bar.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String hintText;

  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search companies...',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.getBorderColor(context)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primaryGreen),
        ),
        filled: true,
        fillColor: AppTheme.getCardBackground(context),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
