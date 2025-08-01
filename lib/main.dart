// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Import your actual screens and services
import 'core/services/firebase_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/connectivity_service.dart';
import 'core/services/logger_service.dart'; // <- ADD THIS IMPORT
import 'core/theme/app_theme.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/home/presentation/screens/scraping_settings_screen.dart';
import 'features/home/presentation/screens/logs_screen.dart'; // <- ADD THIS IMPORT
import 'features/theme/presentation/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging service first
  LoggerService.initialize(); // <- ADD THIS
  LoggerService.info('🚀 Starting Trading Dashboard initialization...');

  print('🔥 Starting Trading Dashboard initialization...');

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
      home: const AppInitializationScreen(),
      // Add routes for navigation
      routes: {
        '/home': (context) => const HomeScreen(),
        '/scraping_settings': (context) => const ScrapingSettingsScreen(),
        '/logs': (context) => const LogsScreen(), // <- ADD THIS ROUTE
      },
    );
  }
}

class AppInitializationScreen extends StatefulWidget {
  const AppInitializationScreen({super.key});

  @override
  State<AppInitializationScreen> createState() =>
      _AppInitializationScreenState();
}

class _AppInitializationScreenState extends State<AppInitializationScreen> {
  String status = 'Initializing services...';
  bool isLoading = true;
  String? error;
  double progress = 0.0;
  bool cloudFunctionsWorking = false;
  String? functionError;

  @override
  void initState() {
    super.initState();
    LoggerService.info('AppInitializationScreen initialized');
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      LoggerService.info('Starting comprehensive app initialization');

      // Step 1: Initialize Firebase
      setState(() {
        status = 'Connecting to Firebase...';
        progress = 0.15;
      });
      LoggerService.info('Step 1: Initializing Firebase');
      print('🔥 Initializing Firebase...');

      await Firebase.initializeApp();
      await Future.delayed(const Duration(milliseconds: 500));
      LoggerService.info('Firebase initialized successfully');
      print('✅ Firebase initialized successfully');

      // Step 2: Test Firebase Connection with better error handling
      setState(() {
        status = 'Testing Firebase connection...';
        progress = 0.3;
      });
      LoggerService.info('Step 2: Testing Firebase connection');
      print('🔍 Testing Firestore connection...');

      try {
        await FirebaseFirestore.instance
            .collection('system_status')
            .limit(1)
            .get()
            .timeout(const Duration(seconds: 10));
        LoggerService.info('Firestore connection successful');
        print('📊 Firestore connection successful');
      } catch (firestoreError) {
        LoggerService.warning(
            'Firestore connection issue (continuing), $firestoreError');
        print('⚠️ Firestore connection issue (continuing): $firestoreError');
        // Continue anyway - app can work without immediate Firestore access
      }

      await Future.delayed(const Duration(milliseconds: 500));

      // Step 3: Initialize Firebase Services
      setState(() {
        status = 'Setting up Firebase services...';
        progress = 0.5;
      });
      LoggerService.info('Step 3: Initializing Firebase services');
      print('⚙️ Initializing Firebase services...');

      try {
        await FirebaseService.initialize();
        LoggerService.info('Firebase services initialized successfully');
        print('✅ Firebase services initialized');
      } catch (serviceError) {
        LoggerService.warning(
            'Firebase services partial initialization, $serviceError');
        print('⚠️ Firebase services partial initialization: $serviceError');
        // Continue with reduced functionality
      }

      await Future.delayed(const Duration(milliseconds: 500));

      // Step 4: Initialize Notifications
      setState(() {
        status = 'Setting up notifications...';
        progress = 0.7;
      });
      LoggerService.info('Step 4: Initializing notification services');
      print('🔔 Initializing notification services...');

      try {
        await NotificationService.initialize();
        LoggerService.info('Notification services initialized successfully');
        print('✅ Notification services initialized');
      } catch (notificationError) {
        LoggerService.warning(
            'Notification services failed (continuing), $notificationError');
        print(
            '⚠️ Notification services failed (continuing): $notificationError');
        // Continue without notifications
      }

      await Future.delayed(const Duration(milliseconds: 500));

      // Step 5: Test Cloud Functions with enhanced error handling
      setState(() {
        status = 'Verifying cloud functions...';
        progress = 0.85;
      });
      LoggerService.info('Step 5: Testing cloud functions connectivity');
      print('🚀 Testing cloud functions connectivity...');

      try {
        await _testCloudFunctionConnectivity();
        cloudFunctionsWorking = true;
        LoggerService.info('Cloud functions are accessible and working');
        print('✅ Cloud functions are accessible and working');
      } catch (functionError) {
        this.functionError = functionError.toString();
        cloudFunctionsWorking = false;
        LoggerService.error('Cloud functions test failed', functionError);
        print('⚠️ Cloud functions test failed: $functionError');
        // Continue - app can still work with cached data
      }

      await Future.delayed(const Duration(milliseconds: 500));

      // Step 6: Complete
      setState(() {
        status = cloudFunctionsWorking
            ? 'All systems ready!'
            : 'Ready with limited functionality!';
        progress = 1.0;
        isLoading = false;
      });
      LoggerService.info(cloudFunctionsWorking
          ? 'App initialization completed successfully - all systems operational'
          : 'App initialization completed with limited functionality');
      print('🚀 App initialization completed successfully');

      // Auto-navigate after a brief delay
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        _navigateToHome();
      }
    } catch (e) {
      LoggerService.error('Critical initialization failed', e);
      print('❌ Critical initialization failed: $e');
      setState(() {
        error = _getErrorMessage(e);
        isLoading = false;
        progress = 0.0;
      });
    }
  }

  Future<void> _testCloudFunctionConnectivity() async {
    try {
      LoggerService.info('Testing cloud function with multiple methods');
      print('🧪 Testing cloud function with multiple methods...');

      // Method 1: Try HTTP request first (more reliable)
      try {
        LoggerService.debug('Attempting HTTP request to cloud function');
        final response = await http
            .post(
              Uri.parse(
                  'https://us-central1-trading-system-123.cloudfunctions.net/manual_scrape_trigger'),
              headers: {
                'Content-Type': 'application/json',
                'User-Agent': 'TradingDashboard/1.0',
              },
              body: jsonEncode({
                'test': true,
                'source': 'app_initialization',
                'timestamp': DateTime.now().toIso8601String(),
              }),
            )
            .timeout(const Duration(seconds: 15));

        LoggerService.debug('HTTP Response Status: ${response.statusCode}');
        LoggerService.debug('HTTP Response Body: ${response.body}');
        print('📡 HTTP Response Status: ${response.statusCode}');
        print('📡 HTTP Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['status'] == 'success') {
            LoggerService.info('Cloud function HTTP test successful');
            print('✅ Cloud function HTTP test successful');
            return;
          } else {
            throw Exception(
                'Function returned error: ${responseData['message']}');
          }
        } else if (response.statusCode == 500) {
          throw Exception(
              'Internal server error (500) - Function code has issues');
        } else {
          throw Exception('HTTP ${response.statusCode}: ${response.body}');
        }
      } catch (httpError) {
        LoggerService.warning(
            'HTTP test failed, trying Firebase callable, $httpError');
        print('⚠️ HTTP test failed: $httpError');

        // Method 2: Try Firebase Functions callable as fallback
        try {
          LoggerService.debug('Attempting Firebase callable as fallback');
          final callable = FirebaseFunctions.instance.httpsCallable(
            'manual_scrape_trigger',
            options: HttpsCallableOptions(
              timeout: const Duration(seconds: 15),
            ),
          );

          final result = await callable.call({
            'test': true,
            'source': 'app_initialization_fallback',
          });

          LoggerService.info(
              'Firebase callable test successful: ${result.data}');
          print('✅ Firebase callable test successful: ${result.data}');
          return;
        } catch (callableError) {
          LoggerService.error('Firebase callable test failed', callableError);
          print('⚠️ Firebase callable test failed: $callableError');
          throw Exception(
              'All connection methods failed. HTTP: $httpError, Callable: $callableError');
        }
      }
    } catch (e) {
      LoggerService.error('Cloud function connectivity test failed', e);
      print('❌ Cloud function connectivity test failed: $e');
      throw e;
    }
  }

  String _getErrorMessage(dynamic error) {
    final errorStr = error.toString().toLowerCase();

    if (errorStr.contains('network') || errorStr.contains('connection')) {
      return 'Network connection failed. Please check your internet connection and try again.';
    } else if (errorStr.contains('firebase') ||
        errorStr.contains('firestore')) {
      return 'Firebase connection failed. Please verify your configuration and internet connection.';
    } else if (errorStr.contains('timeout')) {
      return 'Connection timeout. Please check your network and try again.';
    } else if (errorStr.contains('permission')) {
      return 'Firebase permission denied. Please check your Firestore security rules.';
    } else if (errorStr.contains('api')) {
      return 'Firebase APIs not enabled. Please enable required APIs in Google Cloud Console.';
    } else if (errorStr.contains('defaultcredentialserror')) {
      return 'Firebase credentials issue detected. The app will work with limited functionality.';
    } else if (errorStr.contains('500') ||
        errorStr.contains('internal server')) {
      return 'Cloud functions have internal errors. Manual scraping may not work.';
    } else {
      return 'Initialization failed: ${error.toString()}';
    }
  }

  void _navigateToHome() {
    LoggerService.info('Navigating to home screen');
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void _showDetailedError() {
    LoggerService.info('Showing detailed error dialog');
    if (error == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Initialization Error Details'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Error Details:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                error!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (functionError != null) ...[
                const SizedBox(height: 12),
                Text(
                  'Function Error:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  functionError!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                      ),
                ),
              ],
              const SizedBox(height: 16),
              const Text(
                'Troubleshooting Tips:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('• Check your internet connection\n'
                  '• Verify Firebase project configuration\n'
                  '• Ensure Firestore security rules allow read access\n'
                  '• Make sure Firebase Functions are deployed correctly\n'
                  '• Check Firebase Functions logs for errors\n'
                  '• Wait a few minutes and try again'),
              const SizedBox(height: 16),
              // Add button to view logs
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogsScreen()),
                  );
                },
                icon: const Icon(Icons.article),
                label: const Text('View System Logs'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              LoggerService.info('Retrying app initialization');
              Navigator.pop(context);
              setState(() {
                isLoading = true;
                error = null;
                progress = 0.0;
                functionError = null;
              });
              _initializeApp();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showFunctionStatus() {
    LoggerService.info('Showing cloud functions status dialog');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cloud Functions Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  cloudFunctionsWorking ? Icons.check_circle : Icons.error,
                  color: cloudFunctionsWorking ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  cloudFunctionsWorking
                      ? 'Functions Working'
                      : 'Functions Have Issues',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cloudFunctionsWorking ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (cloudFunctionsWorking) ...[
              const Text('✅ Manual scraping available'),
              const Text('✅ Data fetching functional'),
              const Text('✅ Scheduled scraping active'),
              const Text('✅ Real-time updates working'),
            ] else ...[
              const Text('⚠️ Manual scraping may fail'),
              const Text('📱 App will use cached data'),
              const Text('🔄 Automatic retry in background'),
              const Text('📊 Limited functionality available'),
              if (functionError != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Error: $functionError',
                  style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                ),
              ],
            ],
            const SizedBox(height: 12),
            // Add button to view detailed logs
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogsScreen()),
                );
              },
              icon: const Icon(Icons.article),
              label: const Text('View System Logs'),
            ),
          ],
        ),
        actions: [
          if (!cloudFunctionsWorking)
            TextButton(
              onPressed: () async {
                LoggerService.info('Retesting cloud functions');
                Navigator.pop(context);
                setState(() {
                  status = 'Retesting cloud functions...';
                  progress = 0.85;
                  isLoading = true;
                });

                try {
                  await _testCloudFunctionConnectivity();
                  setState(() {
                    cloudFunctionsWorking = true;
                    functionError = null;
                    status = 'Cloud functions now working!';
                    isLoading = false;
                    progress = 1.0;
                  });
                  LoggerService.info('Cloud functions retest successful');
                } catch (e) {
                  setState(() {
                    functionError = e.toString();
                    cloudFunctionsWorking = false;
                    status = 'Functions still have issues';
                    isLoading = false;
                    progress = 1.0;
                  });
                  LoggerService.error('Cloud functions retest failed', e);
                }
              },
              child: const Text('Retry'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  Icons.trending_up,
                  size: 64,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 32),

              // App Title
              Text(
                'Trading Dashboard',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'NSE Stock Market Monitor',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
              ),
              const SizedBox(height: 48),

              // Loading/Error/Success States
              if (isLoading) ...[
                // Progress Indicator
                SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Theme.of(context).dividerColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            'Please wait...',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  status,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Show what's happening
                if (progress > 0.5) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Testing your deployed functions...',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ] else if (error != null) ...[
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Initialization Failed',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        LoggerService.info('Manual retry triggered');
                        setState(() {
                          isLoading = true;
                          error = null;
                          progress = 0.0;
                          functionError = null;
                        });
                        _initializeApp();
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _navigateToHome,
                      icon: const Icon(Icons.skip_next),
                      label: const Text('Skip'),
                    ),
                    // Add logs button
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogsScreen()),
                        );
                      },
                      icon: const Icon(Icons.article),
                      label: const Text('Logs'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: _showDetailedError,
                  child: const Text('Show Details'),
                ),
              ] else ...[
                Icon(
                  cloudFunctionsWorking ? Icons.check_circle : Icons.warning,
                  size: 64,
                  color: cloudFunctionsWorking ? Colors.green : Colors.amber,
                ),
                const SizedBox(height: 16),
                Text(
                  cloudFunctionsWorking ? 'Ready to Trade!' : 'Ready (Limited)',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            cloudFunctionsWorking ? Colors.green : Colors.amber,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  status,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _showFunctionStatus,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          (cloudFunctionsWorking ? Colors.green : Colors.amber)
                              .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            cloudFunctionsWorking ? Colors.green : Colors.amber,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              cloudFunctionsWorking
                                  ? Icons.cloud_done
                                  : Icons.cloud_off,
                              color: cloudFunctionsWorking
                                  ? Colors.green
                                  : Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              cloudFunctionsWorking
                                  ? 'Cloud Functions Ready'
                                  : 'Functions Have Issues',
                              style: TextStyle(
                                color: cloudFunctionsWorking
                                    ? Colors.green
                                    : Colors.amber.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cloudFunctionsWorking
                              ? 'All scraping features available'
                              : 'Manual scraping may not work - tap for details',
                          style: TextStyle(
                            color: cloudFunctionsWorking
                                ? Colors.green.shade700
                                : Colors.amber.shade800,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _navigateToHome,
                      icon: const Icon(Icons.dashboard),
                      label: const Text('Open Dashboard'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                    ),
                    // Add logs button for easy access
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogsScreen()),
                        );
                      },
                      icon: const Icon(Icons.article),
                      label: const Text('View Logs'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    LoggerService.info('AppInitializationScreen disposed');
    super.dispose();
  }
}
