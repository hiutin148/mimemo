import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:timezone/data/latest.dart' as tz;

/// Singleton service class for handling local notifications
/// Provides optimized performance and follows Flutter best practices
class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  Completer<bool>? _initCompleter;
  bool _isInitialized = false;

  /// Initialize the notification service
  /// Returns true if initialization was successful
  Future<bool> initialize({
    String? defaultIcon,
    String? defaultSound,
    void Function(NotificationResponse)? onNotificationTap,
    void Function(NotificationResponse)? onBackgroundNotificationTap,
  }) async {
    if (_isInitialized) return true;

    // Prevent multiple initialization attempts
    if (_initCompleter != null) {
      return _initCompleter!.future;
    }

    _initCompleter = Completer<bool>();

    try {
      // Initialize timezone data
      tz.initializeTimeZones();

      // Android initialization settings
      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );

      // iOS initialization settings
      const iosSettings = DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
      );

      // Linux initialization settings
      const linuxSettings = LinuxInitializationSettings(
        defaultActionName: 'Open notification',
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
        linux: linuxSettings,
      );

      final initialized = await _notifications.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onBackgroundNotificationTap,
      );

      if (initialized ?? false) {
        _isInitialized = true;
        _initCompleter!.complete(true);
        return true;
      } else {
        _initCompleter!.complete(false);
        return false;
      }
    } on Exception catch (e) {
      debugPrint('NotificationService: Initialization failed - $e');
      _initCompleter!.complete(false);
      return false;
    }
  }

  /// Show an instant notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationPriority priority = NotificationPriority.defaultPriority,
    String? channelId,
    String? channelName,
    String? channelDescription,
    String? icon,
    String? sound,
    bool enableVibration = true,
    bool enableLights = true,
    Color? ledColor,
    List<int>? vibrationPattern,
  }) async {
    if (!_isInitialized) {
      throw StateError('NotificationService must be initialized first');
    }

    try {
      final androidDetails = AndroidNotificationDetails(
        channelId ?? 'default_channel',
        channelName ?? 'Default Channel',
        channelDescription:
            channelDescription ?? 'Default notification channel',
        importance: _mapPriorityToImportance(priority),
        priority: _mapToAndroidPriority(priority),
        icon: icon,
        sound: sound != null
            ? RawResourceAndroidNotificationSound(sound)
            : null,
        enableVibration: enableVibration,
        enableLights: enableLights,
        ledColor: ledColor,
        vibrationPattern: vibrationPattern != null
            ? Int64List.fromList(vibrationPattern)
            : null,
        playSound: sound != null,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _notifications.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: details,
        payload: payload,
      );
    } catch (e) {
      logger.e('NotificationService: Failed to show notification - $e');
      rethrow;
    }
  }

  /// Helper method to map priority to Android importance
  Importance _mapPriorityToImportance(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.min:
        return Importance.min;
      case NotificationPriority.low:
        return Importance.low;
      case NotificationPriority.defaultPriority:
        return Importance.defaultImportance;
      case NotificationPriority.high:
        return Importance.high;
      case NotificationPriority.max:
        return Importance.max;
    }
  }

  /// Helper method to map priority to Android priority
  Priority _mapToAndroidPriority(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.min:
        return Priority.min;
      case NotificationPriority.low:
        return Priority.low;
      case NotificationPriority.defaultPriority:
        return Priority.defaultPriority;
      case NotificationPriority.high:
        return Priority.high;
      case NotificationPriority.max:
        return Priority.max;
    }
  }


  /// Dispose resources
  void dispose() {
    _initCompleter = null;
  }
}

/// Enum for notification priority levels
enum NotificationPriority {
  min,
  low,
  defaultPriority,
  high,
  max,
}
