// lib/screens/main_navigation.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';
import 'filter_screen.dart';
import 'home_screen.dart';
import 'scraping_screen.dart';
import 'settings_screen.dart';
import 'watchlist_screen.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class MainNavigation extends ConsumerWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    final screens = [
      const HomeScreen(),
      const WatchlistScreen(),
      const FilterScreen(),
      const ScrapingScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) =>
            ref.read(selectedIndexProvider.notifier).state = index,
        backgroundColor: AppTheme.getCardBackground(context),
        selectedItemColor: AppTheme.primaryGreen,
        unselectedItemColor: AppTheme.getTextSecondary(context),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list_outlined),
            activeIcon: Icon(Icons.filter_list),
            label: 'Filter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_download_outlined),
            activeIcon: Icon(Icons.cloud_download),
            label: 'Scraping',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
