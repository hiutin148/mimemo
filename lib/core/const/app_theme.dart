import 'package:flutter/material.dart';

import 'package:mimemo/core/const/app_colors.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    primarySwatch: AppColors.createMaterialColor(AppColors.primary),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      // Display
      displayLarge: TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        height: 64 / 57,
        color: Colors.white,
      ),
      displayMedium: TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        height: 52 / 45,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 44 / 36,
        color: Colors.white,
      ),

      // Headline
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        height: 40 / 32,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        height: 36 / 28,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        height: 32 / 24,
        color: Colors.white,
      ),

      // Title
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 28 / 22,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: Colors.white,

        fontWeight: FontWeight.w400,
        height: 20 / 14,
      ),

      // Body
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        color: Colors.white,
      ),

      // Label
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        color: Colors.white,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 16 / 12,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        height: 16 / 11,
        color: Colors.white,
      ),
    ),
  );
}
