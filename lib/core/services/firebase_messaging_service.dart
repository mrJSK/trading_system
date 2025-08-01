// lib/core/services/firebase_messaging_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Request notification permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Get FCM token for this device
      String? token = await _messaging.getToken();
      if (kDebugMode) {
        print('FCM Token: $token'); // Only for debugging
      }

      // Subscribe to job status topic
      await _messaging.subscribeToTopic('job_status');

      // Configure local notifications for foreground messages
      await _setupLocalNotifications();

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle notification taps when app is in background/terminated
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

      // Handle initial message if app was opened from notification
      RemoteMessage? initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationTap(initialMessage);
      }
    }
  }

  static Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _localNotifications.initialize(initializationSettings);
  }

  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    // Show local notification when app is in foreground
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'job_notifications',
      'Job Status Notifications',
      channelDescription: 'Notifications for job completion and failure',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformDetails =
        NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'Trading System',
      message.notification?.body ?? 'Job status update',
      platformDetails,
    );
  }

  static void _handleNotificationTap(RemoteMessage message) {
    // Handle what happens when user taps notification
    // You can navigate to specific screens based on message data
    if (kDebugMode) {
      print('Notification tapped: ${message.data}');
    }
  }

  static Future<String?> getToken() async {
    return await _messaging.getToken();
  }
}
