// lib/features/home/presentation/providers/scraping_providers.dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/scraping_service.dart';
import '../../../../models/scraping/scraping_models.dart';

// Service provider
final scrapingServiceProvider = Provider<ScrapingService>((ref) {
  return ScrapingService();
});

// ULTRA-MINIMAL State notifier - FCM handles everything
class ScrapingNotifier extends StateNotifier<ScrapingState> {
  final Ref ref;

  ScrapingNotifier(this.ref) : super(const ScrapingState()) {
    // No initial loading - keep it simple
  }

  Future<String> startScraping({
    int maxPages = 50,
    bool clearExisting = true,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final service = ref.read(scrapingServiceProvider);
      final message = await service.startScraping(maxPages: maxPages);

      // Job started successfully
      state = state.copyWith(isLoading: false);

      // Cloud Function will send FCM notification when job completes
      return message;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// Main provider
final scrapingNotifierProvider =
    StateNotifierProvider<ScrapingNotifier, ScrapingState>((ref) {
  return ScrapingNotifier(ref);
});

// SIMPLIFIED providers - no queue status needed
final isScrapingLoadingProvider = Provider<bool>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.isLoading;
});

final scrapingErrorProvider = Provider<String?>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.error;
});

final hasScrapingErrorProvider = Provider<bool>((ref) {
  final scrapingState = ref.watch(scrapingNotifierProvider);
  return scrapingState.error != null;
});
