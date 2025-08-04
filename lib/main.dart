import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/theme_service.dart';
import 'services/database_service.dart';
import 'screens/home_screen.dart';
import 'screens/scraping_screen.dart';
import 'screens/filter_screen.dart';
import 'screens/watchlist_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize database
  await DatabaseService().isar;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeService(),
      child: Consumer<ThemeService>(
        builder: (context, themeService, child) {
          return MaterialApp(
            title: 'Stock Screener',
            theme: themeService.lightTheme,
            darkTheme: themeService.darkTheme,
            themeMode:
                themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: MainScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ScrapingScreen(),
    FilterScreen(),
    WatchlistScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_outlined),
            activeIcon: Icon(Icons.download),
            label: 'Scrape',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list_outlined),
            activeIcon: Icon(Icons.filter_list),
            label: 'Filter',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            activeIcon: Icon(Icons.bookmark),
            label: 'Watchlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
