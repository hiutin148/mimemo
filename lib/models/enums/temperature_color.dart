import 'dart:ui';

import 'package:mimemo/core/const/consts.dart';

enum TemperatureColor {
  blue(double.negativeInfinity, 10, AppColors.blue),
  green(10, 25, AppColors.green),
  yellow(26, 30, AppColors.yellow),
  orange(31, 35, AppColors.orange),
  red(36, 40, AppColors.red),
  purple(41, double.infinity, AppColors.purple);

  const TemperatureColor(this.min, this.max, this.color);

  final double min;
  final double max;
  final Color color;
}

extension TemperatureColorExtension on TemperatureColor {
  static (List<Color>, List<double>) getGradientColorsFromEnum(double minTemp, double maxTemp) {
    if (minTemp == maxTemp) return ([], []);
    final gradientColors = <Color>[];
    final gradientStops = <double>[];

    final totalRange = maxTemp - minTemp;

    for (final zone in TemperatureColor.values) {
      final zoneMin = zone.min;
      final zoneMax = zone.max;

      if (zoneMax < minTemp || zoneMin > maxTemp) continue;

      final start = zoneMin < minTemp ? minTemp : zoneMin;
      final end = zoneMax > maxTemp ? maxTemp : zoneMax;

      final startStop = (start - minTemp) / totalRange;
      final endStop = (end - minTemp) / totalRange;

      gradientColors.add(zone.color);
      gradientStops.add(startStop);

      // Avoid duplicate stops for a zero-width range
      if (endStop != startStop) {
        gradientColors.add(zone.color);
        gradientStops.add(endStop);
      }
    }

    return (gradientColors.reversed.toList(), gradientStops);
  }
}
