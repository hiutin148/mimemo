// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i8;
import 'package:mimemo/models/entities/one_minute_cast/one_minute_cast.dart'
    as _i6;
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_screen.dart' as _i1;
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart' as _i7;
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
class PrecipitationRoute extends _i5.PageRouteInfo<PrecipitationRouteArgs> {
  PrecipitationRoute({
    _i6.OneMinuteCast? oneMinuteCast,
    required _i7.HourlyCubit hourlyCubit,
    _i8.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         PrecipitationRoute.name,
         args: PrecipitationRouteArgs(
           oneMinuteCast: oneMinuteCast,
           hourlyCubit: hourlyCubit,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'PrecipitationRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrecipitationRouteArgs>();
      return _i3.PrecipitationScreen(
        oneMinuteCast: args.oneMinuteCast,
        hourlyCubit: args.hourlyCubit,
        key: args.key,
      );
    },
  );
}

class PrecipitationRouteArgs {
  const PrecipitationRouteArgs({
    this.oneMinuteCast,
    required this.hourlyCubit,
    this.key,
  });

  final _i6.OneMinuteCast? oneMinuteCast;

  final _i7.HourlyCubit hourlyCubit;

  final _i8.Key? key;

  @override
  String toString() {
    return 'PrecipitationRouteArgs{oneMinuteCast: $oneMinuteCast, hourlyCubit: $hourlyCubit, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PrecipitationRouteArgs) return false;
    return oneMinuteCast == other.oneMinuteCast &&
        hourlyCubit == other.hourlyCubit &&
        key == other.key;
  }

  @override
  int get hashCode =>
      oneMinuteCast.hashCode ^ hourlyCubit.hashCode ^ key.hashCode;
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
