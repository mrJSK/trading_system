// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'theme/app_theme.dart';
import 'screens/main_navigation.dart';
import 'services/firebase_messaging_service.dart';
import 'theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessagingService.initialize();

  runApp(const ProviderScope(child: TradingSystemApp()));
}

class TradingSystemApp extends ConsumerWidget {
  const TradingSystemApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Trading System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const MainNavigation(),
    );
  }
}
