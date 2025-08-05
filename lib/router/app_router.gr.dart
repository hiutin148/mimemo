// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i9;
import 'package:mimemo/models/entities/one_minute_cast/one_minute_cast.dart'
    as _i11;
import 'package:mimemo/ui/screens/air_quality/air_quality_screen.dart' as _i1;
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_screen.dart' as _i2;
import 'package:mimemo/ui/screens/home/home_cubit.dart' as _i8;
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart' as _i10;
import 'package:mimemo/ui/screens/onboarding/onboarding_screen.dart' as _i3;
import 'package:mimemo/ui/screens/precipitation/precipitation_screen.dart'
    as _i4;
import 'package:mimemo/ui/screens/search_location/search_location_screen.dart'
    as _i5;
import 'package:mimemo/ui/screens/splash/splash_screen.dart' as _i6;

/// generated route for
/// [_i1.AirQualityScreen]
class AirQualityRoute extends _i7.PageRouteInfo<AirQualityRouteArgs> {
  AirQualityRoute({
    required _i8.HomeCubit homeCubit,
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         AirQualityRoute.name,
         args: AirQualityRouteArgs(homeCubit: homeCubit, key: key),
         initialChildren: children,
       );

  static const String name = 'AirQualityRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AirQualityRouteArgs>();
      return _i1.AirQualityScreen(homeCubit: args.homeCubit, key: args.key);
    },
  );
}

class AirQualityRouteArgs {
  const AirQualityRouteArgs({required this.homeCubit, this.key});

  final _i8.HomeCubit homeCubit;

  final _i9.Key? key;

  @override
  String toString() {
    return 'AirQualityRouteArgs{homeCubit: $homeCubit, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AirQualityRouteArgs) return false;
    return homeCubit == other.homeCubit && key == other.key;
  }

  @override
  int get hashCode => homeCubit.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i2.BottomNavScreen]
class BottomNavRoute extends _i7.PageRouteInfo<void> {
  const BottomNavRoute({List<_i7.PageRouteInfo>? children})
    : super(BottomNavRoute.name, initialChildren: children);

  static const String name = 'BottomNavRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.BottomNavScreen();
    },
  );
}

/// generated route for
/// [_i3.OnboardingScreen]
class OnboardingRoute extends _i7.PageRouteInfo<void> {
  const OnboardingRoute({List<_i7.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i4.PrecipitationScreen]
class PrecipitationRoute extends _i7.PageRouteInfo<PrecipitationRouteArgs> {
  PrecipitationRoute({
    required _i10.HourlyCubit hourlyCubit,
    _i11.OneMinuteCast? oneMinuteCast,
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         PrecipitationRoute.name,
         args: PrecipitationRouteArgs(
           hourlyCubit: hourlyCubit,
           oneMinuteCast: oneMinuteCast,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'PrecipitationRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PrecipitationRouteArgs>();
      return _i4.PrecipitationScreen(
        hourlyCubit: args.hourlyCubit,
        oneMinuteCast: args.oneMinuteCast,
        key: args.key,
      );
    },
  );
}

class PrecipitationRouteArgs {
  const PrecipitationRouteArgs({
    required this.hourlyCubit,
    this.oneMinuteCast,
    this.key,
  });

  final _i10.HourlyCubit hourlyCubit;

  final _i11.OneMinuteCast? oneMinuteCast;

  final _i9.Key? key;

  @override
  String toString() {
    return 'PrecipitationRouteArgs{hourlyCubit: $hourlyCubit, oneMinuteCast: $oneMinuteCast, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PrecipitationRouteArgs) return false;
    return hourlyCubit == other.hourlyCubit &&
        oneMinuteCast == other.oneMinuteCast &&
        key == other.key;
  }

  @override
  int get hashCode =>
      hourlyCubit.hashCode ^ oneMinuteCast.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i5.SearchLocationScreen]
class SearchLocationRoute extends _i7.PageRouteInfo<SearchLocationRouteArgs> {
  SearchLocationRoute({
    required _i8.HomeCubit homeCubit,
    _i9.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         SearchLocationRoute.name,
         args: SearchLocationRouteArgs(homeCubit: homeCubit, key: key),
         initialChildren: children,
       );

  static const String name = 'SearchLocationRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SearchLocationRouteArgs>();
      return _i5.SearchLocationScreen(homeCubit: args.homeCubit, key: args.key);
    },
  );
}

class SearchLocationRouteArgs {
  const SearchLocationRouteArgs({required this.homeCubit, this.key});

  final _i8.HomeCubit homeCubit;

  final _i9.Key? key;

  @override
  String toString() {
    return 'SearchLocationRouteArgs{homeCubit: $homeCubit, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SearchLocationRouteArgs) return false;
    return homeCubit == other.homeCubit && key == other.key;
  }

  @override
  int get hashCode => homeCubit.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i6.SplashScreen]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashScreen();
    },
  );
}
