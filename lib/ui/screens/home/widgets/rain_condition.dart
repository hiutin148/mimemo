import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/extension/string_extension.dart';

class RainConditionChart extends StatelessWidget {
  final double value;
  final double minValue;
  final double maxValue;
  final String centerText;
  final String subtitle;
  final List<Color> colors;
  final double strokeWidth;
  final double size;

  const RainConditionChart({
    super.key,
    required this.value,
    this.minValue = 0,
    this.maxValue = 100,
    this.centerText = '',
    this.subtitle = '',
    this.colors = const [Colors.red, Colors.orange, Colors.yellow, Colors.green],
    this.strokeWidth = 4.0,
    this.size = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final colors =
            state.minuteColors
                .map((e) {
                  if (e.type?.toLowerCase() == "rain") {
                    return e.hex?.hexToColor;
                  }
                  return null;
                })
                .whereType<Color>()
                .toList();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: size,
            height: size,
            child: CustomPaint(
              painter: RainConditionPainter(
                value: value,
                minValue: minValue,
                maxValue: maxValue,
                colors: colors,
                strokeWidth: strokeWidth,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (centerText.isNotEmpty)
                      Text(
                        centerText,
                        style: TextStyle(
                          fontSize: size * 0.15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    if (subtitle.isNotEmpty)
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: size * 0.06, color: Colors.white70),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class RainConditionPainter extends CustomPainter {
  final double value;
  final double minValue;
  final double maxValue;
  final List<Color> colors;
  final double strokeWidth;

  RainConditionPainter({
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.colors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    const totalAngle = 360.0 * math.pi / 180.0;
    const startAngle = 270.0 * math.pi / 180.0;

    // Number of segments and gap configuration
    const segmentCount = 60;

    // Calculate segment angle accounting for gaps
    final individualSegmentAngle = strokeWidth * math.pi / 180.0;
    final totalSegmentAngle = individualSegmentAngle * segmentCount;
    final totalGapAngle = totalAngle - totalSegmentAngle;
    final gapAngle = totalGapAngle / segmentCount;

    // Draw segments
    for (int i = 0; i < segmentCount; i++) {
      final segmentStartAngle = startAngle + (i * (individualSegmentAngle + gapAngle));
      final segmentProgress = i / (segmentCount - 1);

      // Determine color based on progress
      Color segmentColor;

      segmentColor = _getColorForProgress(segmentProgress);

      // Calculate line positions (from inner radius to outer radius)
      final innerRadius = radius - strokeWidth * 4;
      final outerRadius = radius;

      final segmentMiddleAngle = segmentStartAngle;

      final startPoint = Offset(
        center.dx + innerRadius * math.cos(segmentMiddleAngle),
        center.dy + innerRadius * math.sin(segmentMiddleAngle),
      );

      final endPoint = Offset(
        center.dx + outerRadius * math.cos(segmentMiddleAngle),
        center.dy + outerRadius * math.sin(segmentMiddleAngle),
      );
      final progress = 0.10;
      final rectEndPoint = Offset(
        startPoint.dx * (1 - progress) + endPoint.dx * progress,
        startPoint.dy * (1 - progress) + endPoint.dy * progress,
      );
      // Draw segment as a line
      final adjustedColors = _getProgressiveColors(0.5);

      final paint =
          Paint()
            ..shader = ui.Gradient.linear(startPoint, endPoint, [Colors.red, Colors.blue], [0.1, 1])
            ..strokeWidth = strokeWidth
            ..strokeCap = StrokeCap.round;
      final backgroundPaint =
          Paint()
            ..color = Colors.purple.withValues(alpha: 0.1)
            ..strokeWidth = strokeWidth
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round;
      canvas.drawLine(startPoint, endPoint, backgroundPaint);

      canvas.drawLine(startPoint, rectEndPoint, paint);
      // canvas.drawRect(Rect.fromPoints(startPoint, endPoint), backgroundPaint);
    }

    // Draw min/max labels
    _drawLabels(canvas, size, center, radius);
  }

  Color _getColorForProgress(double progress) {
    if (colors.length < 2) return colors.first;

    final segmentSize = 1.0 / (colors.length - 1);
    final segmentIndex = (progress / segmentSize).floor();
    final localProgress = (progress % segmentSize) / segmentSize;

    if (segmentIndex >= colors.length - 1) {
      return colors.last;
    }

    return Color.lerp(colors[segmentIndex], colors[segmentIndex + 1], localProgress)!;
  }

  void _drawLabels(Canvas canvas, Size size, Offset center, double radius) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // Draw start value label
    textPainter.text = TextSpan(
      text: minValue.toInt().toString(),
      style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
    );
    textPainter.layout();

    final minLabelAngle = 270.0 * math.pi / 180.0;
    final minLabelOffset = Offset(
      center.dx + (radius + 20) * math.cos(minLabelAngle) - textPainter.width / 2,
      center.dy + (radius + 20) * math.sin(minLabelAngle) - textPainter.height / 2,
    );
    textPainter.paint(canvas, minLabelOffset);

    // Draw left value label
    textPainter.text = TextSpan(
      text: '15',
      style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
    );
    textPainter.layout();

    final leftLabelAngle = 0.0 * math.pi / 180.0;
    final leftLabelOffset = Offset(
      center.dx + (radius + 20) * math.cos(leftLabelAngle) - textPainter.width / 2,
      center.dy + (radius + 20) * math.sin(leftLabelAngle) - textPainter.height / 2,
    );
    textPainter.paint(canvas, leftLabelOffset);

    // Draw left value label
    textPainter.text = TextSpan(
      text: '30',
      style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
    );
    textPainter.layout();

    final bottomLabelAngle = 90.0 * math.pi / 180.0;
    final bottomLabelOffset = Offset(
      center.dx + (radius + 20) * math.cos(bottomLabelAngle) - textPainter.width / 2,
      center.dy + (radius + 20) * math.sin(bottomLabelAngle) - textPainter.height / 2,
    );
    textPainter.paint(canvas, bottomLabelOffset);

    // Draw left value label
    textPainter.text = TextSpan(
      text: '45',
      style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
    );
    textPainter.layout();

    final topLabelAngle = 180.0 * math.pi / 180.0;
    final topLabelOffset = Offset(
      center.dx + (radius + 20) * math.cos(topLabelAngle) - textPainter.width / 2,
      center.dy + (radius + 20) * math.sin(topLabelAngle) - textPainter.height / 2,
    );
    textPainter.paint(canvas, topLabelOffset);
  }

  List<Color> _getProgressiveColors(double progress) {
    if (colors.length <= 1) return colors;

    // Calculate how many color segments we should show
    final totalSegments = colors.length - 1;
    final progressSegments = totalSegments * progress;
    final completeSegments = progressSegments.floor();
    final partialSegment = progressSegments - completeSegments;

    List<Color> progressiveColors = [];

    // Add complete segments
    for (int i = 0; i <= completeSegments && i < colors.length; i++) {
      progressiveColors.add(colors[i]);
    }

    // Add partial segment if exists
    if (partialSegment > 0 && completeSegments + 1 < colors.length) {
      final startColor = colors[completeSegments];
      final endColor = colors[completeSegments + 1];
      final interpolatedColor = Color.lerp(startColor, endColor, partialSegment)!;
      progressiveColors.add(interpolatedColor);
    }

    // Ensure we have at least 2 colors for gradient
    if (progressiveColors.length == 1) {
      progressiveColors.add(progressiveColors[0]);
    }

    return progressiveColors;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
