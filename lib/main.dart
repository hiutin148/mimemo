import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/const/app_theme.dart';
import 'package:mimemo/generated/l10n.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/router/app_router.dart';
import 'package:mimemo/services/geolocation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  initLocator();
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  WeatherApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => MainCubit(
                positionRepository: locator<PositionRepository>(),
                geoLocationService: locator<GeoLocationService>(),
                forecastRepository: locator<ForecastRepository>(),
                appSettingRepository: locator<AppSettingRepository>(),
              ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Weather App',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: AppTheme.themeData,
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
