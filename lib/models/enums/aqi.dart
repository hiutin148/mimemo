import 'dart:ui';

import 'package:mimemo/core/const/app_colors.dart';

enum Aqi {
  green(color: AppColors.airGood, min: 0, max: 50),
  yellow(color: AppColors.airModerate, min: 51, max: 100),
  orange(color: AppColors.airUnhealthyForSensitiveGroups, min: 101, max: 150),
  red(color: AppColors.airUnhealthy, min: 151, max: 200),
  purple(color: AppColors.airVeryUnhealthy, min: 201, max: 300),
  maroon(color: AppColors.airHazardous, min: 301, max: double.infinity);

  final Color color;
  final double min;
  final double max;

  const Aqi({required this.color, required this.min, required this.max});
}

extension AqiExtension on Aqi {
  /// Calculates the interpolated color for a given AQI value
  static Color getAQIColor(double aqiValue) {
    // Handle edge cases
    if (aqiValue < 0) return Aqi.green.color;
    if (aqiValue > 300) return Aqi.maroon.color;

    // Find the current AQI category
    Aqi? currentAqi;
    for (Aqi aqi in Aqi.values) {
      if (aqiValue >= aqi.min && aqiValue <= aqi.max) {
        currentAqi = aqi;
        break;
      }
    }

    if (currentAqi == null) return Aqi.maroon.color;

    // Find current AQI index
    int currentIndex = Aqi.values.indexOf(currentAqi);

    // If we're at the last category or at the exact minimum, return the category color
    if (currentIndex == Aqi.values.length - 1 || aqiValue == currentAqi.min) {
      return currentAqi.color;
    }

    // Get the next AQI category for interpolation
    Aqi nextAqi = Aqi.values[currentIndex + 1];

    // Calculate interpolation factor
    double rangeSize = currentAqi.max - currentAqi.min + 1;
    double positionInRange = aqiValue - currentAqi.min;
    double interpolationFactor = positionInRange / rangeSize;

    // Interpolate between current and next AQI colors
    return Color.lerp(currentAqi.color, nextAqi.color, interpolationFactor)
        ?? currentAqi.color;
  }

  /// Alternative implementation with smoother transitions
  static Color getAQIColorSmooth(double aqiValue) {
    // Handle edge cases
    if (aqiValue <= Aqi.green.min) return Aqi.green.color;
    if (aqiValue >= Aqi.maroon.min) return Aqi.maroon.color;

    // Find the two AQI categories to interpolate between
    for (int i = 0; i < Aqi.values.length - 1; i++) {
      Aqi currentAqi = Aqi.values[i];
      Aqi nextAqi = Aqi.values[i + 1];

      if (aqiValue >= currentAqi.min && aqiValue < nextAqi.min) {
        // Calculate interpolation factor based on position between range centers
        double currentCenter = (currentAqi.min + currentAqi.max) / 2;
        double nextCenter = (nextAqi.min + nextAqi.max) / 2;

        double totalDistance = nextCenter - currentCenter;
        double currentDistance = aqiValue - currentCenter;

        double interpolationFactor = (currentDistance / totalDistance).clamp(0.0, 1.0);

        return Color.lerp(currentAqi.color, nextAqi.color, interpolationFactor)
            ?? currentAqi.color;
      }
    }

    return Aqi.maroon.color;
  }

  /// Get the AQI category for a given value
  static Aqi getAQICategory(double aqiValue) {
    for (Aqi aqi in Aqi.values) {
      if (aqiValue >= aqi.min && aqiValue <= aqi.max) {
        return aqi;
      }
    }
    return Aqi.maroon; // Default to hazardous for values above 300
  }

  /// Get AQI category name for display purposes
  static String getAQICategoryName(double aqiValue) {
    const categoryNames = {
      Aqi.green: 'Good',
      Aqi.yellow: 'Moderate',
      Aqi.orange: 'Unhealthy for Sensitive Groups',
      Aqi.red: 'Unhealthy',
      Aqi.purple: 'Very Unhealthy',
      Aqi.maroon: 'Hazardous',
    };

    Aqi category = getAQICategory(aqiValue);
    return categoryNames[category] ?? 'Unknown';
  }
}
