// lib/screens/settings/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/app_theme.dart';
import '../theme/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Theme Section
          _buildSection(
            context,
            'Appearance',
            [
              ListTile(
                leading: Icon(themeNotifier.currentThemeIcon),
                title: const Text('Theme'),
                subtitle: Text(themeNotifier.currentThemeName),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () => _showThemeDialog(context, ref),
              ),
            ],
          ),

          // App Information
          _buildSection(
            context,
            'About',
            [
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Version'),
                subtitle: Text('1.0.0'),
              ),
              ListTile(
                leading: const Icon(Icons.star_outline),
                title: const Text('Rate App'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Implement rating functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.feedback_outlined),
                title: const Text('Send Feedback'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Implement feedback functionality
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryGreen,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(
              context,
              ref,
              'Light',
              Icons.light_mode,
              ThemeMode.light,
            ),
            _buildThemeOption(
              context,
              ref,
              'Dark',
              Icons.dark_mode,
              ThemeMode.dark,
            ),
            _buildThemeOption(
              context,
              ref,
              'System',
              Icons.brightness_auto,
              ThemeMode.system,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref,
    String title,
    IconData icon,
    ThemeMode mode,
  ) {
    final currentTheme = ref.watch(themeProvider);
    final isSelected = currentTheme == mode;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppTheme.primaryGreen : null,
      ),
      title: Text(title),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: AppTheme.primaryGreen,
            )
          : null,
      onTap: () {
        ref.read(themeProvider.notifier).setTheme(mode);
        Navigator.pop(context);
      },
    );
  }
}
