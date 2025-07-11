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
  ];
}
