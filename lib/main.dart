import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/firebase_options.dart';
import 'package:mimemo/generated/l10n.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/router/app_router.dart';
import 'package:mimemo/services/geolocation_service.dart';
import 'package:mimemo/services/supabase_function_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: Config.supabaseUrl,
    anonKey: Config.supabaseAnonKey,
  );
  unawaited(MobileAds.instance.initialize());
  unawaited(setupNotifications());
  Bloc.observer = AppBlocObserver();
  initLocator();
  runApp(WeatherApp());
}

Future<void> setupNotifications() async {
  final messaging = FirebaseMessaging.instance;

  await messaging.requestPermission();

  final fcmToken = await messaging.getToken();
  if (fcmToken != null) {
    logger.d('FCM Token: $fcmToken');
    await locator<SupabaseFunctionService>().saveFcmToken(fcmToken);
  }

  messaging.onTokenRefresh.listen(locator<SupabaseFunctionService>().saveFcmToken);
}

class WeatherApp extends StatelessWidget {
  WeatherApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MainCubit(
              positionRepository: locator<PositionRepository>(),
              geoLocationService: locator<GeoLocationService>(),
              forecastRepository: locator<ForecastRepository>(),
              supabaseFunctionService: locator<SupabaseFunctionService>(),
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
          routerConfig: _appRouter.config(navigatorObservers: () => [routeObserver]),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
