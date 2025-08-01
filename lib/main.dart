// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import your screens and theme
import 'core/theme/app_theme.dart';
import 'core/services/firebase_messaging_service.dart'; // <- FCM service instead
import 'features/home/presentation/screens/home_screen.dart';
import 'features/home/presentation/screens/scraping_settings_screen.dart';
import 'features/theme/presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize FCM notifications only
  await FirebaseMessagingService.initialize();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      title: 'Trading Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const HomeScreen(), // Direct to home - no complex initialization
      routes: {
        '/home': (context) => const HomeScreen(),
        '/scraping_settings': (context) => const ScrapingSettingsScreen(),
      },
    );
  }
}
