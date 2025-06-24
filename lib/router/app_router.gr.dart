// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_screen.dart' as _i1;
import 'package:mimemo/ui/screens/onboarding/onboarding_screen.dart' as _i2;
import 'package:mimemo/ui/screens/precipitation/precipitation_screen.dart'
    as _i3;
import 'package:mimemo/ui/screens/splash/splash_screen.dart' as _i4;

/// generated route for
/// [_i1.BottomNavScreen]
class BottomNavRoute extends _i5.PageRouteInfo<void> {
  const BottomNavRoute({List<_i5.PageRouteInfo>? children})
    : super(BottomNavRoute.name, initialChildren: children);

  static const String name = 'BottomNavRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavScreen();
    },
  );
}

/// generated route for
/// [_i2.OnboardingScreen]
class OnboardingRoute extends _i5.PageRouteInfo<void> {
  const OnboardingRoute({List<_i5.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i3.PrecipitationScreen]
class PrecipitationRoute extends _i5.PageRouteInfo<void> {
  const PrecipitationRoute({List<_i5.PageRouteInfo>? children})
    : super(PrecipitationRoute.name, initialChildren: children);

  static const String name = 'PrecipitationRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.PrecipitationScreen();
    },
  );
}

/// generated route for
/// [_i4.SplashScreen]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashScreen();
    },
  );
}
