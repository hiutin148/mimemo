import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AirQualityReportPainter extends CustomPainter {
  AirQualityReportPainter({required this.value, super.repaint});

  final double value;
  static const _segmentCount = 32;
  static const _maxValue = 250;
  static const double _startAngle = 3 * pi / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.height) / 2;
    final midRadius = (size.height - 24) / 2;
    final innerRadius = (size.height - 48) / 2;

    const totalSweep = 2 * pi;
    const segmentAngle = totalSweep / _segmentCount;
    final valueIndex = value / _maxValue * 32;
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final whitePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < _segmentCount; i++) {
      final currentAngle = _startAngle + (i * segmentAngle);
      final cosAngle = cos(currentAngle);
      final sinAngle = sin(currentAngle);

      final outerPoint = Offset(
        center.dx + radius * cosAngle,
        center.dy + radius * sinAngle,
      );
      final midPoint = Offset(
        center.dx + midRadius * cosAngle,
        center.dy + midRadius * sinAngle,
      );
      final innerPoint = Offset(
        center.dx + innerRadius * cosAngle,
        center.dy + innerRadius * sinAngle,
      );
      canvas.drawPoints(
        PointMode.points,
        [outerPoint, midPoint, innerPoint],
        i <= valueIndex ? whitePaint : paint,
      );
    }

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    const valueTextStyle = TextStyle(color: Colors.white, fontSize: 45, fontWeight: FontWeight.w600);

    final valueTextPainter = textPainter
      ..text = TextSpan(text: value.toStringAsFixed(0), style: valueTextStyle)
      ..layout();

    final valueTextOffset = Offset(
      center.dx - valueTextPainter.width / 2,
      center.dy - valueTextPainter.height / 2,
    );

    valueTextPainter.paint(canvas, valueTextOffset);

    const unitTextStyle = TextStyle(color: Colors.white, fontSize: 20);

    final unitTextPainter = textPainter
      ..text = const TextSpan(text: 'AQI', style: unitTextStyle)
      ..layout();

    final unitTextOffset = Offset(
      center.dx - unitTextPainter.width / 2,  // Fixed: use unitTextPainter.width
      center.dy + valueTextPainter.height / 2 + 8,
    );

    unitTextPainter.paint(canvas, unitTextOffset);
  }

  @override
  bool shouldRepaint(covariant AirQualityReportPainter oldDelegate) {
    return value != oldDelegate.value;
  }
}
