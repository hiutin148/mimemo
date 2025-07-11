import 'package:flutter/material.dart';

abstract final class AppColors {
  static const Color primary = Color(0XFF10061C);

  // Basic colors
  static const Color purple = Color(0XFF6a4c93);
  static const Color red = Color(0XFFff595e);
  static const Color orange = Color(0XFFf77f00);
  static const Color yellow = Color(0XFFffca3a);
  static const Color green = Color(0XFF8ac926);
  static const Color blue = Color(0XFF1982c4);

  // AQI Basics for Ozone and Particle Pollution Colors
  static const Color airGood = Color(0XFF00E400);
  static const Color airModerate = Color(0XFFFFFF00);
  static const Color airUnhealthyForSensitiveGroups = Color(0XFFFF7E00);
  static const Color airUnhealthy = Color(0XFFFF0000);
  static const Color airVeryUnhealthy = Color(0XFF8F3F97);
  static const Color airHazardous = Color(0XFF7E0023);

  // Common color
  static const Color cardBackground = Colors.white12;
  static const Color whiteBorderColor = Colors.white54;
  static const Color blackBorderColor = Colors.black26;

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
