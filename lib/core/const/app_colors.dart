import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0XFF10061C);

  // AQI Basics for Ozone and Particle Pollution Colors
  static const Color airGood = Color(0XFF00E400);
  static const Color airModerate = Color(0XFFFFFF00);
  static const Color airUnhealthyForSensitiveGroups = Color(0XFFFF7E00);
  static const Color airUnhealthy = Color(0XFFFF0000);
  static const Color airVeryUnhealthy = Color(0XFF8F3F97);
  static const Color airHazardous = Color(0XFF7E0023);

  static MaterialColor createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final r = color.r;
    final g = color.g;
    final b = color.b;

    for (var i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.from(
        alpha: 1,
        red: r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        green: g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        blue: b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      );
    }
    return MaterialColor(color.toARGB32(), swatch);
  }
}
