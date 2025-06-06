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
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final double r = color.r, g = color.g, b = color.b;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
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
