import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/models/enums/aqi.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';

class AirQualityChart extends StatelessWidget {
  const AirQualityChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          return BlocBuilder<MainCubit, MainState>(
            builder: (context, mainState) {
              final overallPlumeLabsIndex = homeState.airQuality?.data?.overallPlumeLabsIndex ?? 0;
              return Padding(
                padding: const EdgeInsets.only(top: 28),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: CustomPaint(
                    painter: AirQualityPainter(value: overallPlumeLabsIndex, strokeWidth: 6),
                    child: const SizedBox(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AirQualityPainter extends CustomPainter {

  AirQualityPainter({required this.value, required this.strokeWidth});
  final double value;
  final double strokeWidth;

  // Cache for expensive calculations
  static const double _endAngle = 9 * math.pi / 4;
  static const double _startAngle = 3 * math.pi / 4;
  static const int _maxSegments = 45;
  static const double _maxValue = 250;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const segmentCount = _maxSegments;

    _drawSegments(canvas, center, radius, segmentCount);
    _drawLabels(canvas, center, radius);
  }

  void _drawSegments(Canvas canvas, Offset center, double radius, int segmentCount) {
    final innerRadius = radius - strokeWidth * 4;
    const totalAngleSpan = _endAngle - _startAngle;
    const stepValue = _maxValue / _maxSegments;
    final valueIndex = (value / stepValue).round();
    final backgroundPaint =
        Paint()
          ..color = Colors.white24
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    for (var i = 0; i < segmentCount; i++) {
      final segmentAngle = _startAngle + (i * totalAngleSpan / (segmentCount - 1));

      final cosAngle = math.cos(segmentAngle);
      final sinAngle = math.sin(segmentAngle);

      final startPoint = Offset(
        center.dx + innerRadius * cosAngle,
        center.dy + innerRadius * sinAngle,
      );

      final endPoint = Offset(center.dx + radius * cosAngle, center.dy + radius * sinAngle);
      final segmentValue = i * stepValue;
      final segmentValueColor = AqiExtension.getAQIColor(segmentValue);
      final segmentValuePaint =
          Paint()
            ..color = segmentValueColor
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round;
      final segmentPaint = i <= valueIndex ? segmentValuePaint : backgroundPaint;

      canvas.drawLine(startPoint, endPoint, segmentPaint);
    }
  }

  void _drawLabels(Canvas canvas, Offset center, double radius) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    const textStyle = TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500);

    // First label ("0")
    textPainter..text = const TextSpan(text: '0', style: textStyle)
    ..layout();

    final startLabelHeight = textPainter.height;

    final labelOffset = Offset(
      center.dx + (radius - strokeWidth * 4) * math.cos(3 * math.pi / 4),
      center.dy + radius * math.sin(3 * math.pi / 4) - startLabelHeight / 2,
    );

    textPainter..paint(canvas, labelOffset)

    // Second label ("250+")
    ..text = const TextSpan(text: '250+', style: textStyle)
    ..layout();

    final endLabelWidth = textPainter.width;
    final endLabelHeight = textPainter.height;

    final endLabelOffset = Offset(
      center.dx + (radius - strokeWidth * 4) * math.cos(9 * math.pi / 4) - endLabelWidth,
      center.dy + radius * math.sin(9 * math.pi / 4) - endLabelHeight / 2,
    );

    textPainter.paint(canvas, endLabelOffset);
  }

  @override
  bool shouldRepaint(covariant AirQualityPainter oldDelegate) {
    return value != oldDelegate.value || strokeWidth != oldDelegate.strokeWidth;
  }
}

class GradientInfo {

  const GradientInfo(this.colors, this.stops);
  final List<Color> colors;
  final List<double> stops;
}
