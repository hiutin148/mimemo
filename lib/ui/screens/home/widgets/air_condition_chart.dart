import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/extension/string_extension.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';

class RainConditionChart extends StatelessWidget {
  const RainConditionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          return BlocBuilder<MainCubit, MainState>(
            builder: (context, mainState) {
              // Extract and process data once
              final rainData = _extractRainData(homeState, mainState);

              return Padding(
                padding: const EdgeInsets.all(28.0),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: CustomPaint(
                    painter: RainConditionPainter(
                      values: rainData.values,
                      minValue: 0,
                      maxValue: rainData.maxValue,
                      colors: rainData.colors,
                      strokeWidth: 6,
                    ),
                    child: Container(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  RainData _extractRainData(HomeState homeState, MainState mainState) {
    final values =
        homeState.oneMinuteCast?.intervals?.map((e) => e.dbz ?? 0.0).whereType<double>().toList() ??
        <double>[];

    final maxValue =
        mainState.minuteColors
            .lastWhereOrNull((element) => element.type?.toLowerCase() == 'rain')
            ?.endDbz ??
        95.0;

    return RainData(values: values, maxValue: maxValue, colors: mainState.minuteColors);
  }

  // Widget _buildCenterContent() {
  //   final centerText = '';
  //   final subtitle = '';
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         if (centerText.isNotEmpty)
  //           Text(
  //             centerText,
  //             style: TextStyle(
  //               fontSize: 250 * 0.15,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.white,
  //             ),
  //           ),
  //         if (subtitle.isNotEmpty)
  //           Text(subtitle, style: TextStyle(fontSize: 250 * 0.06, color: Colors.white70)),
  //       ],
  //     ),
  //   );
  // }
}

// Data class to hold processed rain data
class RainData {
  final List<double> values;
  final double maxValue;
  final List<MinuteColor> colors;

  const RainData({required this.values, required this.maxValue, required this.colors});
}

class RainConditionPainter extends CustomPainter {
  final List<double> values;
  final double minValue;
  final double maxValue;
  final List<MinuteColor> colors;
  final double strokeWidth;

  // Cache for expensive calculations
  static const double _totalAngle = 2 * math.pi;
  static const double _startAngle = 3 * math.pi / 2; // 270 degrees
  static const int _maxSegments = 60;

  // Pre-calculated label positions
  static const List<_LabelInfo> _labels = [
    _LabelInfo('Now', 3 * math.pi / 2),
    // _LabelInfo('15', 0),
    // _LabelInfo('30', math.pi / 2),
    // _LabelInfo('45', math.pi),
  ];

  RainConditionPainter({
    required this.values,
    required this.minValue,
    required this.maxValue,
    required this.colors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final segmentCount = math.min(values.length, _maxSegments);

    _drawSegments(canvas, center, radius, segmentCount);
    _drawLabels(canvas, center, radius);
  }

  void _drawSegments(Canvas canvas, Offset center, double radius, int segmentCount) {
    // Pre-calculate common values
    final innerRadius = radius - strokeWidth * 4;
    final individualSegmentAngle = strokeWidth * math.pi / 180.0;
    final totalSegmentAngle = individualSegmentAngle * segmentCount;
    final gapAngle = (_totalAngle - totalSegmentAngle) / segmentCount;
    final segmentStep = individualSegmentAngle + gapAngle;

    // Create background paint once
    final backgroundPaint =
        Paint()
          ..color = Colors.white24
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    for (int i = 0; i < segmentCount; i++) {
      final segmentAngle = _startAngle + (i * segmentStep);
      final cosAngle = math.cos(segmentAngle);
      final sinAngle = math.sin(segmentAngle);

      final startPoint = Offset(
        center.dx + innerRadius * cosAngle,
        center.dy + innerRadius * sinAngle,
      );

      final endPoint = Offset(center.dx + radius * cosAngle, center.dy + radius * sinAngle);

      // Draw background segment
      canvas.drawLine(startPoint, endPoint, backgroundPaint);

      // Draw progress segment
      final progress = (values[i] / maxValue).clamp(0.0, 1.0);
      if (progress > 0) {
        final progressEndPoint = Offset(
          startPoint.dx + (endPoint.dx - startPoint.dx) * progress,
          startPoint.dy + (endPoint.dy - startPoint.dy) * progress,
        );

        final gradientColors = _getProgressiveDbzGradient(progress);
        final progressPaint =
            Paint()
              ..shader = ui.Gradient.linear(
                startPoint,
                endPoint,
                gradientColors.colors,
                gradientColors.stops,
              )
              ..strokeWidth = strokeWidth
              ..strokeCap = StrokeCap.round;

        canvas.drawLine(startPoint, progressEndPoint, progressPaint);
      }
    }
  }

  void _drawLabels(Canvas canvas, Offset center, double radius) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    const textStyle = TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500);

    for (final label in _labels) {
      textPainter.text = TextSpan(text: label.text, style: textStyle);
      textPainter.layout();

      final labelOffset = Offset(
        center.dx + (radius + 20) * math.cos(label.angle) - textPainter.width / 2,
        center.dy + (radius + 20) * math.sin(label.angle) - textPainter.height / 2,
      );

      textPainter.paint(canvas, labelOffset);
    }
  }

  GradientInfo _getProgressiveDbzGradient(double progress) {
    if (colors.isEmpty) {
      return const GradientInfo([Color(0xFFFFFFFF)], [1.0]);
    }

    if (progress <= 0) {
      return const GradientInfo([Colors.transparent, Colors.transparent], [0.0, 1.0]);
    }

    final minDbz = colors.first.startDbz ?? 0.0;
    final maxDbz = colors.last.endDbz ?? 0.0;
    final dbzRange = maxDbz - minDbz;

    if (dbzRange <= 0) {
      final color = colors.first.hex?.hexToColor ?? Colors.white;
      return GradientInfo([color, color], [0.0, 1.0]);
    }

    final maxDbzProgress = minDbz + progress * dbzRange;
    final gradientColors = <Color>[];
    final gradientStops = <double>[];

    for (int i = 0; i < colors.length; i++) {
      final dbz = colors[i];
      final startDbz = dbz.startDbz ?? 0.0;
      final endDbz = dbz.endDbz ?? 0.0;
      final color = dbz.hex?.hexToColor ?? Colors.white;

      if (startDbz > maxDbzProgress) break;

      // Add start color and stop
      final startStop = ((startDbz - minDbz) / dbzRange).clamp(0.0, 1.0);
      gradientColors.add(color);
      gradientStops.add(startStop);

      if (endDbz > maxDbzProgress) {
        // Interpolate color for partial segment
        final partialProgress = (maxDbzProgress - startDbz) / (endDbz - startDbz);
        final interpolatedColor =
            Color.lerp(color, color, partialProgress.clamp(0.0, 1.0)) ?? color;

        gradientColors.add(interpolatedColor);
        gradientStops.add(((maxDbzProgress - minDbz) / dbzRange).clamp(0.0, 1.0));
        break;
      } else {
        // Add end color if it doesn't overlap with next segment
        final endStop = ((endDbz - minDbz) / dbzRange).clamp(0.0, 1.0);
        final isLast = i == colors.length - 1;
        final nextStart = isLast ? null : colors[i + 1].startDbz;

        if (isLast || endDbz != nextStart) {
          gradientColors.add(color);
          gradientStops.add(endStop);
        }
      }
    }

    // Ensure we have at least 2 colors for gradient
    if (gradientColors.length == 1) {
      gradientColors.add(gradientColors.first);
      gradientStops.add(1.0);
    }

    return GradientInfo(gradientColors, gradientStops);
  }

  @override
  bool shouldRepaint(covariant RainConditionPainter oldDelegate) {
    return values != oldDelegate.values ||
        maxValue != oldDelegate.maxValue ||
        colors != oldDelegate.colors ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}

// Helper classes for better organization
class _LabelInfo {
  final String text;
  final double angle;

  const _LabelInfo(this.text, this.angle);
}

class GradientInfo {
  final List<Color> colors;
  final List<double> stops;

  const GradientInfo(this.colors, this.stops);
}
