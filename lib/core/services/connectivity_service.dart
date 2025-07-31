import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'dart:async';

// Connectivity status provider
final connectivityProvider =
    StateNotifierProvider<ConnectivityNotifier, ConnectivityStatus>((ref) {
  return ConnectivityNotifier();
});

enum ConnectivityStatus {
  online,
  offline,
  checking,
}

class ConnectivityNotifier extends StateNotifier<ConnectivityStatus> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  late StreamSubscription<InternetStatus> _internetSubscription;
  final Connectivity _connectivity = Connectivity();
  final InternetConnection _internetConnection = InternetConnection();

  ConnectivityNotifier() : super(ConnectivityStatus.checking) {
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    // Check initial connectivity
    await _checkConnectivity();

    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) async {
        await _checkConnectivity();
      },
    );

    // Listen to actual internet connection changes
    _internetSubscription = _internetConnection.onStatusChange.listen(
      (InternetStatus status) {
        switch (status) {
          case InternetStatus.connected:
            state = ConnectivityStatus.online;
            break;
          case InternetStatus.disconnected:
            state = ConnectivityStatus.offline;
            break;
        }
      },
    );
  }

  Future<void> _checkConnectivity() async {
    state = ConnectivityStatus.checking;

    try {
      // First check if device has network adapter connection
      final connectivityResults = await _connectivity.checkConnectivity();

      if (connectivityResults.contains(ConnectivityResult.none)) {
        state = ConnectivityStatus.offline;
        return;
      }

      // Then check actual internet connectivity
      final hasInternet = await _internetConnection.hasInternetAccess;
      state =
          hasInternet ? ConnectivityStatus.online : ConnectivityStatus.offline;
    } catch (e) {
      print('Error checking connectivity: $e');
      state = ConnectivityStatus.offline;
    }
  }

  Future<void> forceCheck() async {
    await _checkConnectivity();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _internetSubscription.cancel();
    super.dispose();
  }
}
