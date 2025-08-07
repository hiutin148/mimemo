import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message: ${message.messageId}');
}

class FcmService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  bool _isInitialized = false;
  String? _currentToken;
  NotificationSettings? _notificationSettings;
  static const String _tokenKey = 'fcm_token';

  Future<void> Function(Map<String, dynamic> data)? _onNotificationTapped;
  late StreamController<RemoteMessage> _foregroundMessageController;

  Stream<RemoteMessage> get onForegroundMessage => _foregroundMessageController.stream;

  bool get isInitialized => _isInitialized;

  NotificationSettings? get notificationSettings => _notificationSettings;

  Future<void> initialize({
    required Future<void> Function(Map<String, dynamic> data) onNotificationTapped,
  }) async {
    if (_isInitialized) {
      logger.i('FCM Service already initialized.');
      return;
    }

    try {
      _onNotificationTapped = onNotificationTapped;
      _foregroundMessageController = StreamController<RemoteMessage>.broadcast();

      _notificationSettings = await _messaging.requestPermission();

      _setupMessageHandlers();

      await _getAndSaveToken();

      _isInitialized = true;
      logger.i('FCM Service initialized successfully.');
    } on Exception catch (e) {
      logger.i('Failed to initialize FCM Service: $e');
    }
  }

  void _setupMessageHandlers() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      logger.i('Foreground message received: ${message.notification?.title}');
      _foregroundMessageController.add(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('Message opened from background: ${message.notification?.title}');
      _onNotificationTapped?.call(message.data);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    _messaging.onTokenRefresh.listen((token) {
      logger.i('Token refreshed.');
      _saveToken(token);
    });

    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        logger.i('Initial message received: ${message.notification?.title}');
        _onNotificationTapped?.call(message.data);
      }
    });
  }

  Future<String?> getToken() async {
    if (_currentToken != null) return _currentToken;

    _currentToken = await getSavedToken();
    if (_currentToken != null) return _currentToken;

    try {
      final token = await _messaging.getToken();
      if (token != null) {
        await _saveToken(token);
      }
      return token;
    } on Exception catch (e) {
      logger.i('Failed to get FCM token: $e');
      return null;
    }
  }

  Future<void> _getAndSaveToken() async {
    final token = await _messaging.getToken();
    if (token != null) {
      await _saveToken(token);
      logger.i('Initial FCM Token: $token');
    }
  }

  Future<void> _saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
      _currentToken = token;
    } on Exception catch (e) {
      logger.i('Failed to save FCM token: $e');
    }
  }

  Future<String?> getSavedToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } on Exception catch (e) {
      logger.i('Failed to get saved token: $e');
      return null;
    }
  }

  Future<void> deleteToken() async {
    try {
      await _messaging.deleteToken();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      _currentToken = null;
      logger.i('FCM token deleted successfully.');
    } on Exception catch (e) {
      logger.i('Failed to delete FCM token: $e');
    }
  }

  void dispose() {
    _foregroundMessageController.close();
  }
}
