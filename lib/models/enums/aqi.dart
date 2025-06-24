import 'dart:ui';

import 'package:mimemo/core/const/app_colors.dart';

enum Aqi {
  green(color: AppColors.airGood, min: 0, max: 50),
  yellow(color: AppColors.airModerate, min: 51, max: 100),
  orange(color: AppColors.airUnhealthyForSensitiveGroups, min: 101, max: 150),
  red(color: AppColors.airUnhealthy, min: 151, max: 200),
  purple(color: AppColors.airVeryUnhealthy, min: 201, max: 300),
  maroon(color: AppColors.airHazardous, min: 301, max: double.infinity);

  const Aqi({required this.color, required this.min, required this.max});

  final Color color;
  final double min;
  final double max;
}

extension AqiExtension on Aqi {
  /// Calculates the interpolated color for a given AQI value
  static Color getAQIColor(double aqiValue) {
    // Handle edge cases
    if (aqiValue <= Aqi.green.min) return Aqi.green.color;
    if (aqiValue >= Aqi.maroon.min) return Aqi.maroon.color;

    // Find the current AQI category
    Aqi? currentAqi;
    for (final aqi in Aqi.values) {
      if (aqiValue >= aqi.min && aqiValue <= aqi.max) {
        currentAqi = aqi;
        break;
      }
    }

    if (currentAqi == null) return Aqi.maroon.color;

    // Find current AQI index
    final currentIndex = Aqi.values.indexOf(currentAqi);

    // If we're at the last category or at the exact minimum, return the category color
    if (currentIndex == Aqi.values.length - 1 || aqiValue == currentAqi.min) {
      return currentAqi.color;
    }

    // Get the next AQI category for interpolation
    final nextAqi = Aqi.values[currentIndex + 1];

    // Calculate interpolation factor
    final rangeSize = currentAqi.max - currentAqi.min + 1;
    final positionInRange = aqiValue - currentAqi.min;
    final interpolationFactor = positionInRange / rangeSize;

    // Interpolate between current and next AQI colors
    return Color.lerp(currentAqi.color, nextAqi.color, interpolationFactor) ?? currentAqi.color;
  }

  /// Get the AQI category for a given value
  static Aqi getAQICategory(double aqiValue) {
    for (final aqi in Aqi.values) {
      if (aqiValue >= aqi.min && aqiValue <= aqi.max) {
        return aqi;
      }
    }
    return Aqi.maroon; // Default to hazardous for values above 300
  }
}
