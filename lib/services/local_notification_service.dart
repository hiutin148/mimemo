import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Singleton service class for handling local notifications
/// Provides optimized performance and follows Flutter best practices
class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  // Cache for notification settings to avoid repeated permission checks
  bool? _permissionsGranted;
  DateTime? _lastPermissionCheck;
  static const Duration _permissionCacheTimeout = Duration(minutes: 5);

  // Completer to ensure initialization happens only once
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
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

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
        initSettings,
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

  /// Request notification permissions (iOS/macOS)
  /// Uses caching to avoid repeated permission requests
  Future<bool> requestPermissions() async {
    if (!_isInitialized) {
      throw StateError('NotificationService must be initialized first');
    }

    // Check cache first
    if (_permissionsGranted != null &&
        _lastPermissionCheck != null &&
        DateTime.now().difference(_lastPermissionCheck!) < _permissionCacheTimeout) {
      return _permissionsGranted!;
    }

    try {
      if (Platform.isIOS || Platform.isMacOS) {
        final granted =
            await _notifications
                .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
                ?.requestPermissions(
                  alert: true,
                  badge: true,
                  sound: true,
                ) ??
            false;

        _permissionsGranted = granted;
        _lastPermissionCheck = DateTime.now();
        return granted;
      }

      // Android permissions are handled automatically
      _permissionsGranted = true;
      _lastPermissionCheck = DateTime.now();
      return true;
    } on Exception catch (e) {
      logger.e('NotificationService: Permission request failed - $e');
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
        channelDescription: channelDescription ?? 'Default notification channel',
        importance: _mapPriorityToImportance(priority),
        priority: _mapToAndroidPriority(priority),
        icon: icon,
        sound: sound != null ? RawResourceAndroidNotificationSound(sound) : null,
        enableVibration: enableVibration,
        enableLights: enableLights,
        ledColor: ledColor,
        vibrationPattern: vibrationPattern != null ? Int64List.fromList(vibrationPattern) : null,
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

      await _notifications.show(id, title, body, details, payload: payload);
    } catch (e) {
      logger.e('NotificationService: Failed to show notification - $e');
      rethrow;
    }
  }

  /// Schedule a notification for later
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
    NotificationPriority priority = NotificationPriority.defaultPriority,
    String? channelId,
    String? channelName,
    String? channelDescription,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    if (!_isInitialized) {
      throw StateError('NotificationService must be initialized first');
    }

    try {
      final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

      final androidDetails = AndroidNotificationDetails(
        channelId ?? 'scheduled_channel',
        channelName ?? 'Scheduled Notifications',
        channelDescription: channelDescription ?? 'Scheduled notification channel',
        importance: _mapPriorityToImportance(priority),
        priority: _mapToAndroidPriority(priority),
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

      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tzScheduledDate,
        details,
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: matchDateTimeComponents,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      logger.e('NotificationService: Failed to schedule notification - $e');
      rethrow;
    }
  }

  /// Schedule a periodic notification
  Future<void> schedulePeriodicNotification({
    required int id,
    required String title,
    required String body,
    required RepeatInterval repeatInterval,
    String? payload,
    NotificationPriority priority = NotificationPriority.defaultPriority,
    String? channelId,
    String? channelName,
    String? channelDescription,
  }) async {
    if (!_isInitialized) {
      throw StateError('NotificationService must be initialized first');
    }

    try {
      final androidDetails = AndroidNotificationDetails(
        channelId ?? 'periodic_channel',
        channelName ?? 'Periodic Notifications',
        channelDescription: channelDescription ?? 'Periodic notification channel',
        importance: _mapPriorityToImportance(priority),
        priority: _mapToAndroidPriority(priority),
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

      await _notifications.periodicallyShow(
        id,
        title,
        body,
        repeatInterval,
        details,
        payload: payload,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      logger.e('NotificationService: Failed to schedule periodic notification - $e');
      rethrow;
    }
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    if (!_isInitialized) return;

    try {
      await _notifications.cancel(id);
    } on Exception catch (e) {
      logger.e('NotificationService: Failed to cancel notification $id - $e');
    }
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    if (!_isInitialized) return;

    try {
      await _notifications.cancelAll();
    } on Exception catch (e) {
      logger.e('NotificationService: Failed to cancel all notifications - $e');
    }
  }

  /// Get pending notification requests
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    if (!_isInitialized) return [];

    try {
      return await _notifications.pendingNotificationRequests();
    } on Exception catch (e) {
      logger.e('NotificationService: Failed to get pending notifications - $e');
      return [];
    }
  }

  /// Get active notifications (Android only)
  Future<List<ActiveNotification>> getActiveNotifications() async {
    if (!_isInitialized || !Platform.isAndroid) return [];

    try {
      return await _notifications.getActiveNotifications();
    } on Exception catch (e) {
      logger.e('NotificationService: Failed to get active notifications - $e');
      return [];
    }
  }

  /// Create a notification channel (Android 8.0+)
  Future<void> createNotificationChannel({
    required String channelId,
    required String channelName,
    String? channelDescription,
    Importance importance = Importance.defaultImportance,
    bool enableVibration = true,
    bool enableLights = true,
    Color? ledColor,
    String? sound,
  }) async {
    if (!_isInitialized || !Platform.isAndroid) return;

    try {
      final androidChannel = AndroidNotificationChannel(
        channelId,
        channelName,
        description: channelDescription,
        importance: importance,
        enableVibration: enableVibration,
        enableLights: enableLights,
        ledColor: ledColor,
        sound: sound != null ? RawResourceAndroidNotificationSound(sound) : null,
      );

      await _notifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(androidChannel);
    } on Exception catch (e) {
      logger.e('NotificationService: Failed to create notification channel - $e');
    }
  }

  /// Delete a notification channel (Android 8.0+)
  Future<void> deleteNotificationChannel(String channelId) async {
    if (!_isInitialized || !Platform.isAndroid) return;

    try {
      await _notifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.deleteNotificationChannel(channelId);
    } on Exception catch (e) {
      logger.e('NotificationService: Failed to delete notification channel - $e');
    }
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    if (!_isInitialized) return false;

    try {
      if (Platform.isAndroid) {
        return await _notifications
                .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
                ?.areNotificationsEnabled() ??
            false;
      }
      return _permissionsGranted ?? false;
    } on Exception catch (e) {
      logger.e('NotificationService: Failed to check notification status - $e');
      return false;
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

  /// Clear cached permissions (useful for testing or when permissions change)
  void clearPermissionCache() {
    _permissionsGranted = null;
    _lastPermissionCheck = null;
  }

  /// Dispose resources
  void dispose() {
    // Clear caches
    clearPermissionCache();
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
