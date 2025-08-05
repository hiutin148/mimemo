import 'dart:ui';

import 'package:mimemo/core/const/app_colors.dart';

enum Aqi {
  excellent(
    color: AppColors.airGood,
    min: 0,
    max: 19,
    description:
        'The air quality is ideal for most individuals; enjoy your normal outdoor activities.',
  ),
  fair(
    color: AppColors.airModerate,
    min: 20,
    max: 49,
    description:
        'The air quality is generally acceptable for most individuals. However, sensitive groups may experience minor to moderate symptoms from long-term exposure.',
  ),
  poor(
    color: AppColors.airPoor,
    min: 50,
    max: 99,
    description:
        'The air has reached a high level of pollution and is unhealthy for sensitive groups. Reduce time spent outside if you are feeling symptoms such as difficulty breathing or throat irritation.',
  ),
  unhealthy(
    color: AppColors.airUnhealthy,
    min: 100,
    max: 149,
    description:
        'Health effects can be immediately felt by sensitive groups. Healthy individuals may experience difficulty breathing and throat irritation with prolonged exposure. Limit outdoor activity.',
  ),
  veryUnhealthy(
    color: AppColors.airVeryUnhealthy,
    min: 150,
    max: 249,
    description:
        'Health effects will be immediately felt by sensitive groups and should avoid outdoor activity. Healthy individuals are likely to experience difficulty breathing and throat irritation; consider staying indoors and rescheduling outdoor activities.',
  ),
  dangerous(
    color: AppColors.airHazardous,
    min: 250,
    max: double.infinity,
    description:
        'Any exposure to the air, even for a few minutes, can lead to serious health effects on everybody. Avoid outdoor activities.',
  );

  const Aqi({required this.color, required this.min, required this.max, this.description});

  final Color color;
  final double min;
  final double max;
  final String? description;
}

extension AqiExtension on Aqi {
  /// Calculates the interpolated color for a given AQI value
  static Color getAQIColor(double aqiValue) {
    // Handle edge cases
    if (aqiValue <= Aqi.excellent.min) return Aqi.excellent.color;
    if (aqiValue >= Aqi.dangerous.min) return Aqi.dangerous.color;

    // Find the current AQI category
    Aqi? currentAqi;
    for (final aqi in Aqi.values) {
      if (aqiValue >= aqi.min && aqiValue <= aqi.max) {
        currentAqi = aqi;
        break;
      }
    }

    if (currentAqi == null) return Aqi.dangerous.color;

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
    return Aqi.dangerous; // Default to hazardous for values above 300
  }
}
