import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/router/app_router.dart';
import 'package:mimemo/services/geolocation_service.dart';

import 'generated/l10n.dart';

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
              ),
        ),
      ],
      child: MaterialApp.router(
        title: 'Weather App',
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
