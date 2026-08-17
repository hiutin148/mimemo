import 'dart:async';

import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/services/fcm_service.dart';
import 'package:mimemo/services/local_notification_service.dart';
import 'package:mimemo/services/supabase_function_service.dart';

abstract class NotificationRepository {
  Future<void> initialize();

  Future<void> syncLocationKey(String? locationKey);

  void dispose();
}

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl({
    required this._fcmService,
    required this._localNotificationService,
    required this._supabaseFunctionService,
  });

  final FcmService _fcmService;
  final LocalNotificationService _localNotificationService;
  final SupabaseFunctionService _supabaseFunctionService;

  StreamSubscription<dynamic>? _fcmSubscription;

  @override
  Future<void> initialize() async {
    if (_fcmService.isInitialized) return;

    try {
      await _fcmService.initialize(onNotificationTapped: (data) async {});
      await _localNotificationService.initialize();

      final token = await _fcmService.getToken();
      if (token != null) {
        await _supabaseFunctionService.saveFcmToken(token);
      }

      await _fcmSubscription?.cancel();
      _fcmSubscription = _fcmService.onForegroundMessage.listen((message) {
        final notification = message.notification;
        if (notification != null) {
          _localNotificationService.showNotification(
            id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
            title: notification.title ?? '',
            body: notification.body ?? '',
          );
        }
      });
    } catch (e, stackTrace) {
      logger.e(
        'Failed to init notifications',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> syncLocationKey(String? locationKey) async {
    if (locationKey == null || locationKey.isEmpty) return;
    try {
      final token = await _fcmService.getSavedToken();
      if (token != null) {
        await _supabaseFunctionService.saveLocationKey(locationKey, token);
      }
    } catch (e) {
      logger.e('Failed to sync location key: $e');
    }
  }

  @override
  void dispose() {
    _fcmSubscription?.cancel();
  }
}
