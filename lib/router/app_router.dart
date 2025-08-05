import 'package:auto_route/auto_route.dart';
import 'package:mimemo/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: OnboardingRoute.page),
    AutoRoute(page: BottomNavRoute.page),
    AutoRoute(page: PrecipitationRoute.page),
    CustomRoute<dynamic>(
      transitionsBuilder: TransitionsBuilders.slideBottom, // Example pre-built transition
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 350),
      page: SearchLocationRoute.page,
    ),
    AutoRoute(page: AirQualityRoute.page),
  ];
}
