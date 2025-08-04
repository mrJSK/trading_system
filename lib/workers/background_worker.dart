// // lib/workers/background_worker.dart
// //
// // Background worker entry point for WorkManager tasks
// // This file must be separate from services to avoid tree-shaking issues

// import 'dart:convert';

// import 'package:workmanager/workmanager.dart';
// import '../services/scraping_service.dart';
// import '../services/database_service.dart';
// import '../services/background_scraping_service.dart';

// /// Main entry point for WorkManager background tasks
// /// This function MUST be top-level and annotated to prevent tree-shaking
// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   print('🔄 [BACKGROUND] Background worker isolate started');

//   Workmanager().executeTask((taskName, inputData) async {
//     final taskId = inputData?['taskId']?.toString() ?? 'unknown';
//     print('🚀 [BACKGROUND] Starting task: $taskName (ID: $taskId)');
//     print('📋 [BACKGROUND] Input data: $inputData');

//     final stopwatch = Stopwatch()..start();

//     try {
//       bool result = false;

//       switch (taskName) {
//         case BackgroundScrapingService.scrapingTaskName:
//           print('📄 [BACKGROUND] Executing list scraping task');
//           result = await _performListScraping(inputData ?? {});
//           break;
//         case BackgroundScrapingService.dataScrapingTaskName:
//           print('🔍 [BACKGROUND] Executing data scraping task');
//           result = await _performDataScraping(inputData ?? {});
//           break;
//         default:
//           print('❌ [BACKGROUND] Unknown task name: $taskName');
//           result = false;
//       }

//       stopwatch.stop();
//       print(
//           '✅ [BACKGROUND] Task $taskName completed in ${stopwatch.elapsedMilliseconds}ms');
//       print('📊 [BACKGROUND] Task result: $result');

//       return result;
//     } catch (e) {
//       stopwatch.stop();
//       print(
//           '💥 [BACKGROUND] Task $taskName failed after ${stopwatch.elapsedMilliseconds}ms: $e');
//       print(
//           '📚 [BACKGROUND] Stack trace: ${StackTrace.current.toString().split('\n').take(5).join('\n')}');

//       await _updateScrapingStatus('error', {
//         'error': e.toString(),
//         'isActive': false,
//         'taskName': taskName,
//         'taskId': taskId,
//         'errorTime': DateTime.now().toIso8601String(),
//         'duration': stopwatch.elapsedMilliseconds,
//       });
//       return false;
//     }
//   });
// }

// /// List scraping implementation for background worker
// Future<bool> _performListScraping(Map<String, dynamic> input) async {
//   final int totalPages = input['totalPages'] as int? ?? 5;
//   final String taskId = input['taskId']?.toString() ?? 'unknown';

//   print('📄 [LIST SCRAPING] Starting list scraping task');
//   print('📊 [CONFIG] Total pages: $totalPages, Task ID: $taskId');

//   final stopwatch = Stopwatch()..start();
//   final scrapingService = ScrapingService();

//   int totalCompanies = 0;
//   final List<String> errors = [];

//   try {
//     // Log system info
//     scrapingService.logSystemInfo();

//     for (int page = 1; page <= totalPages; page++) {
//       final pageStopwatch = Stopwatch()..start();

//       print('📄 [PAGE $page] Starting page $page of $totalPages...');

//       // Check for cancellation
//       final progress = await _getCurrentProgress();
//       if (progress['isActive'] != true) {
//         print('🛑 [CANCELLED] Task cancelled by user at page $page');
//         return false;
//       }

//       // Update progress
//       await _updateScrapingStatus('list_scraping', {
//         'totalPages': totalPages,
//         'currentPage': page,
//         'companiesFound': totalCompanies,
//         'isActive': true,
//         'taskId': taskId,
//         'errors': errors,
//       });
//       print('📝 [PROGRESS] Updated progress for page $page');

//       try {
//         final companies = await scrapingService.scrapeCompanyList(page);
//         totalCompanies += companies.length;

//         pageStopwatch.stop();
//         print(
//             '✅ [PAGE $page] Completed in ${pageStopwatch.elapsedMilliseconds}ms');
//         print(
//             '📊 [PAGE $page] Found ${companies.length} companies (total: $totalCompanies)');

//         // Add delay between pages
//         if (page < totalPages) {
//           print('⏳ [DELAY] Waiting 2s before next page...');
//           await Future.delayed(const Duration(seconds: 2));
//         }
//       } catch (e) {
//         pageStopwatch.stop();
//         final error = 'Page $page failed: $e';
//         errors.add(error);
//         print(
//             '❌ [PAGE $page] Error after ${pageStopwatch.elapsedMilliseconds}ms: $e');

//         // Continue with next page instead of failing completely
//         continue;
//       }
//     }

//     stopwatch.stop();

//     // Final status update
//     await _updateScrapingStatus('completed', {
//       'type': 'list_scraping',
//       'totalCompanies': totalCompanies,
//       'totalPages': totalPages,
//       'isActive': false,
//       'taskId': taskId,
//       'completedAt': DateTime.now().toIso8601String(),
//       'duration': stopwatch.elapsedMilliseconds,
//       'errors': errors,
//       'errorCount': errors.length,
//     });

//     print('🎯 [COMPLETED] List scraping completed in ${stopwatch}s');
//     print(
//         '📊 [SUMMARY] Total companies: $totalCompanies, Errors: ${errors.length}');

//     // Clean up
//     scrapingService.dispose();

//     return true;
//   } catch (e) {
//     stopwatch.stop();
//     print('💥 [CRITICAL] Critical error in list scraping: $e');

//     await _updateScrapingStatus('error', {
//       'type': 'list_scraping',
//       'error': 'Critical error: $e',
//       'isActive': false,
//       'taskId': taskId,
//       'errorTime': DateTime.now().toIso8601String(),
//       'duration': stopwatch.elapsedMilliseconds,
//       'companiesFound': totalCompanies,
//     });

//     scrapingService.dispose();
//     return false;
//   }
// }

// /// Data scraping implementation for background worker
// Future<bool> _performDataScraping(Map<String, dynamic> input) async {
//   final String taskId = input['taskId']?.toString() ?? 'unknown';

//   print('🔍 [DATA SCRAPING] Starting data scraping task');
//   print('🆔 [TASK ID] $taskId');

//   final stopwatch = Stopwatch()..start();
//   final db = DatabaseService();
//   final svc = ScrapingService();

//   int processed = 0;
//   int successful = 0;
//   final List<String> errors = [];

//   try {
//     // Get companies to process
//     final companies = await db.getAllCompanies();
//     print('📊 [COMPANIES] Found ${companies.length} companies to process');

//     if (companies.isEmpty) {
//       print('⚠️ [WARNING] No companies found for data scraping');
//       await _updateScrapingStatus('completed', {
//         'type': 'data_scraping',
//         'processed': 0,
//         'successful': 0,
//         'isActive': false,
//         'taskId': taskId,
//         'completedAt': DateTime.now().toIso8601String(),
//         'message': 'No companies found to process',
//       });
//       return true;
//     }

//     // Log system info
//     svc.logSystemInfo();

//     for (int i = 0; i < companies.length; i++) {
//       final company = companies[i];
//       final companyStopwatch = Stopwatch()..start();

//       print('🏢 [${i + 1}/${companies.length}] Processing: ${company.name}');

//       // Check for cancellation
//       final progress = await _getCurrentProgress();
//       if (progress['isActive'] != true) {
//         print(
//             '🛑 [CANCELLED] Data scraping cancelled by user at company ${i + 1}');
//         return false;
//       }

//       // Update progress
//       await _updateScrapingStatus('data_scraping', {
//         'current': i + 1,
//         'total': companies.length,
//         'companyName': company.name,
//         'successful': successful,
//         'processed': processed,
//         'isActive': true,
//         'taskId': taskId,
//         'errors': errors.length,
//       });

//       try {
//         final data = await svc.scrapeCompanyData(company);
//         companyStopwatch.stop();

//         if (data != null) {
//           successful++;
//           print(
//               '✅ [${i + 1}] Success: ${company.name} (${companyStopwatch.elapsedMilliseconds}ms)');
//           print('📊 [DATA] Sector: ${data.sector}, ROCE: ${data.roce}%');
//         } else {
//           print(
//               '⚠️ [${i + 1}] No data extracted: ${company.name} (${companyStopwatch.elapsedMilliseconds}ms)');
//         }
//       } catch (e) {
//         companyStopwatch.stop();
//         final error = '${company.name}: $e';
//         errors.add(error);
//         print(
//             '❌ [${i + 1}] Error: ${company.name} (${companyStopwatch.elapsedMilliseconds}ms): $e');
//       }

//       processed++;

//       // Add delay between companies
//       if (i < companies.length - 1) {
//         await Future.delayed(const Duration(seconds: 3));
//       }
//     }

//     stopwatch.stop();

//     // Final status update
//     await _updateScrapingStatus('completed', {
//       'type': 'data_scraping',
//       'processed': processed,
//       'successful': successful,
//       'total': companies.length,
//       'isActive': false,
//       'taskId': taskId,
//       'completedAt': DateTime.now().toIso8601String(),
//       'duration': stopwatch.elapsedMilliseconds,
//       'errors': errors,
//       'errorCount': errors.length,
//       'successRate': processed > 0
//           ? (successful / processed * 100).toStringAsFixed(1)
//           : '0.0',
//     });

//     print('🎯 [COMPLETED] Data scraping completed in ${stopwatch}s');
//     print(
//         '📊 [SUMMARY] Processed: $processed, Successful: $successful, Errors: ${errors.length}');
//     print(
//         '📈 [SUCCESS RATE] ${processed > 0 ? (successful / processed * 100).toStringAsFixed(1) : '0.0'}%');

//     // Clean up
//     svc.dispose();

//     return true;
//   } catch (e) {
//     stopwatch.stop();
//     print('💥 [CRITICAL] Critical error in data scraping: $e');

//     await _updateScrapingStatus('error', {
//       'type': 'data_scraping',
//       'error': 'Critical error: $e',
//       'isActive': false,
//       'taskId': taskId,
//       'errorTime': DateTime.now().toIso8601String(),
//       'duration': stopwatch.elapsedMilliseconds,
//       'processed': processed,
//       'successful': successful,
//     });

//     svc.dispose();
//     return false;
//   }
// }

// // Helper functions for SharedPreferences access in background isolate
// Future<void> _updateScrapingStatus(
//     String status, Map<String, dynamic> progress) async {
//   try {
//     print('📝 [BG UPDATE] Updating status to: $status');
//     print('📊 [BG PROGRESS] Progress data: $progress');

//     // Note: In background isolate, we need to import shared_preferences
//     final SharedPreferences =
//         await import('package:shared_preferences/shared_preferences.dart');
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('scraping_status', status);
//     await prefs.setString('scraping_progress', jsonEncode(progress));

//     print('✅ [BG UPDATE] Status and progress updated successfully');
//   } catch (e) {
//     print('❌ [BG UPDATE] Error updating status: $e');
//   }
// }

// Future<Map<String, dynamic>> _getCurrentProgress() async {
//   try {
//     final SharedPreferences =
//         await import('package:shared_preferences/shared_preferences.dart');
//     final prefs = await SharedPreferences.getInstance();
//     final raw = prefs.getString('scraping_progress');

//     if (raw == null) {
//       return <String, dynamic>{};
//     }

//     final decoded = jsonDecode(raw);

//     if (decoded is Map) {
//       return Map<String, dynamic>.from(decoded);
//     } else {
//       print(
//           '⚠️ [BG CURRENT] Decoded data is not a Map: ${decoded.runtimeType}');
//       return <String, dynamic>{};
//     }
//   } catch (e) {
//     print('❌ [BG CURRENT] Error getting current progress: $e');
//     return <String, dynamic>{};
//   }
// }

// Future import(String s) async {}
