import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/connectivity_service.dart';

class StatusIndicator extends ConsumerWidget {
  final bool isScrapingActive;

  const StatusIndicator({
    super.key,
    required this.isScrapingActive,
    required bool isActive,
    required ConnectivityStatus connectivityStatus,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatus = ref.watch(connectivityProvider);

    return GestureDetector(
      onTap: () async {
        // Force connectivity check when tapped
        await ref.read(connectivityProvider.notifier).forceCheck();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _getStatusColor(connectivityStatus, isScrapingActive)
              .withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _getStatusColor(connectivityStatus, isScrapingActive),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (connectivityStatus == ConnectivityStatus.checking)
              SizedBox(
                width: 6,
                height: 6,
                child: CircularProgressIndicator(
                  strokeWidth: 1,
                  color: Colors.orange,
                ),
              )
            else
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: _getStatusColor(connectivityStatus, isScrapingActive),
                  shape: BoxShape.circle,
                ),
              ),
            const SizedBox(width: 4),
            Text(
              _getStatusText(connectivityStatus, isScrapingActive),
              style: TextStyle(
                color: _getStatusColor(connectivityStatus, isScrapingActive),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(
      ConnectivityStatus connectivityStatus, bool isScrapingActive) {
    if (connectivityStatus == ConnectivityStatus.checking) return Colors.orange;
    if (connectivityStatus == ConnectivityStatus.offline) return Colors.red;
    return isScrapingActive ? Colors.green : Colors.amber;
  }

  String _getStatusText(
      ConnectivityStatus connectivityStatus, bool isScrapingActive) {
    if (connectivityStatus == ConnectivityStatus.checking) return 'Checking';
    if (connectivityStatus == ConnectivityStatus.offline) return 'Offline';
    return isScrapingActive ? 'Live' : 'Online (Paused)';
  }
}
