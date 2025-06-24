// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to\nAccuWeather`
  String get welcomeTonaccuweather {
    return Intl.message(
      'Welcome to\nAccuWeather',
      name: 'welcomeTonaccuweather',
      desc: '',
      args: [],
    );
  }

  /// `Get the world's most accurate\nweather forecasts`
  String get getTheWorldsMostAccuratenweatherForecasts {
    return Intl.message(
      'Get the world\'s most accurate\nweather forecasts',
      name: 'getTheWorldsMostAccuratenweatherForecasts',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Hyperlocal Forecasts`
  String get hyperlocalForecasts {
    return Intl.message(
      'Hyperlocal Forecasts',
      name: 'hyperlocalForecasts',
      desc: '',
      args: [],
    );
  }

  /// `Get precise weather for your exact location`
  String get getPreciseWeatherForYourExactLocation {
    return Intl.message(
      'Get precise weather for your exact location',
      name: 'getPreciseWeatherForYourExactLocation',
      desc: '',
      args: [],
    );
  }

  /// `Hourly & Daily Forecasts`
  String get hourlyDailyForecasts {
    return Intl.message(
      'Hourly & Daily Forecasts',
      name: 'hourlyDailyForecasts',
      desc: '',
      args: [],
    );
  }

  /// `Plan ahead with detailed 15-day forecasts`
  String get planAheadWithDetailed15dayForecasts {
    return Intl.message(
      'Plan ahead with detailed 15-day forecasts',
      name: 'planAheadWithDetailed15dayForecasts',
      desc: '',
      args: [],
    );
  }

  /// `Severe Weather Alerts`
  String get severeWeatherAlerts {
    return Intl.message(
      'Severe Weather Alerts',
      name: 'severeWeatherAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Stay safe with real-time weather warnings`
  String get staySafeWithRealtimeWeatherWarnings {
    return Intl.message(
      'Stay safe with real-time weather warnings',
      name: 'staySafeWithRealtimeWeatherWarnings',
      desc: '',
      args: [],
    );
  }

  /// `Interactive Radar`
  String get interactiveRadar {
    return Intl.message(
      'Interactive Radar',
      name: 'interactiveRadar',
      desc: '',
      args: [],
    );
  }

  /// `Track storms with our advanced radar maps`
  String get trackStormsWithOurAdvancedRadarMaps {
    return Intl.message(
      'Track storms with our advanced radar maps',
      name: 'trackStormsWithOurAdvancedRadarMaps',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueT {
    return Intl.message('Continue', name: 'continueT', desc: '', args: []);
  }

  /// `Enable Location Access`
  String get enableLocationAccess {
    return Intl.message(
      'Enable Location Access',
      name: 'enableLocationAccess',
      desc: '',
      args: [],
    );
  }

  /// `Allow AccuWeather to access your location to provide hyperlocal weather forecasts and severe weather alerts for your area.`
  String get allowAccuweatherToAccessYourLocationToProvideHyperlocalWeather {
    return Intl.message(
      'Allow AccuWeather to access your location to provide hyperlocal weather forecasts and severe weather alerts for your area.',
      name: 'allowAccuweatherToAccessYourLocationToProvideHyperlocalWeather',
      desc: '',
      args: [],
    );
  }

  /// `Precise local forecasts`
  String get preciseLocalForecasts {
    return Intl.message(
      'Precise local forecasts',
      name: 'preciseLocalForecasts',
      desc: '',
      args: [],
    );
  }

  /// `Real-time weather alerts`
  String get realtimeWeatherAlerts {
    return Intl.message(
      'Real-time weather alerts',
      name: 'realtimeWeatherAlerts',
      desc: '',
      args: [],
    );
  }

  /// `Interactive radar maps`
  String get interactiveRadarMaps {
    return Intl.message(
      'Interactive radar maps',
      name: 'interactiveRadarMaps',
      desc: '',
      args: [],
    );
  }

  /// `Allow Location Access`
  String get allowLocationAccess {
    return Intl.message(
      'Allow Location Access',
      name: 'allowLocationAccess',
      desc: '',
      args: [],
    );
  }

  /// `Stay Alert & Prepared`
  String get stayAlertPrepared {
    return Intl.message(
      'Stay Alert & Prepared',
      name: 'stayAlertPrepared',
      desc: '',
      args: [],
    );
  }

  /// `Get notified about severe weather conditions, daily forecasts, and important weather updates to keep you and your family safe.`
  String get onboarding_notificationMessage {
    return Intl.message(
      'Get notified about severe weather conditions, daily forecasts, and important weather updates to keep you and your family safe.',
      name: 'onboarding_notificationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Daily Weather Summary`
  String get dailyWeatherSummary {
    return Intl.message(
      'Daily Weather Summary',
      name: 'dailyWeatherSummary',
      desc: '',
      args: [],
    );
  }

  /// `Rain & Snow Notifications`
  String get rainSnowNotifications {
    return Intl.message(
      'Rain & Snow Notifications',
      name: 'rainSnowNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Enable Notifications`
  String get enableNotifications {
    return Intl.message(
      'Enable Notifications',
      name: 'enableNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Not Now`
  String get notNow {
    return Intl.message('Not Now', name: 'notNow', desc: '', args: []);
  }

  /// `You're All Set!`
  String get youreAllSet {
    return Intl.message(
      'You\'re All Set!',
      name: 'youreAllSet',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Mimemo! You're now ready to experience the world's most accurate weather forecasts.`
  String get welcome {
    return Intl.message(
      'Welcome to Mimemo! You\'re now ready to experience the world\'s most accurate weather forecasts.',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Start Using App`
  String get startUsingApp {
    return Intl.message(
      'Start Using App',
      name: 'startUsingApp',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
