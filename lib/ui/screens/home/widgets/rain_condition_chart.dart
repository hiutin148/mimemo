import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/models/entities/gradient_info/gradient_info.dart';
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
              final rainData = _extractRainData(homeState, mainState);

              return Padding(
                padding: const EdgeInsets.only(top: 28),
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: CustomPaint(
                    painter: RainConditionPainter(
                      values: rainData.values,
                      minValue: 0,
                      maxValue: rainData.maxValue,
                      colors:
                          rainData.colors
                              .where((element) => element.type?.toLowerCase() == 'rain')
                              .whereType<MinuteColor>()
                              .toList(),
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
}

// Data class to hold processed rain data
class RainData {
  const RainData({required this.values, required this.maxValue, required this.colors});

  final List<double> values;
  final double maxValue;
  final List<MinuteColor> colors;
}

class RainConditionPainter extends CustomPainter {
  RainConditionPainter({
    required this.values,
    required this.minValue,
    required this.maxValue,
    required this.colors,
    required this.strokeWidth,
  });

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
  static const List<_LabelInfo> _labels = [_LabelInfo('Now', 3 * math.pi / 2)];

  // Cache for paints and gradients
  Paint? _backgroundPaint;
  final Map<double, ui.Shader> _shaderCache = {};
  final Map<double, GradientInfo> _gradientCache = {};

  // Cache for trigonometric calculations
  final Map<int, _SegmentInfo> _segmentCache = {};

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final segmentCount = math.min(values.length, _maxSegments);

    // Initialize cached paints
    _initializePaints();

    _drawSegments(canvas, center, radius, segmentCount);
    _drawLabels(canvas, center, radius);
  }

  void _initializePaints() {
    _backgroundPaint ??=
        Paint()
          ..color = Colors.white24
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;
  }

  void _drawSegments(Canvas canvas, Offset center, double radius, int segmentCount) {
    // Pre-calculate common values
    final innerRadius = radius - strokeWidth * 4;
    final individualSegmentAngle = strokeWidth * math.pi / 180.0;
    final totalSegmentAngle = individualSegmentAngle * segmentCount;
    final gapAngle = (_totalAngle - totalSegmentAngle) / segmentCount;
    final segmentStep = individualSegmentAngle + gapAngle;

    // Pre-calculate all segment positions
    final segmentInfos = _calculateSegmentPositions(
      center,
      innerRadius,
      radius,
      segmentCount,
      segmentStep,
    );

    // Draw all segments
    for (var i = 0; i < segmentCount; i++) {
      final segmentInfo = segmentInfos[i];

      // Draw background segment
      canvas.drawLine(segmentInfo.startPoint, segmentInfo.endPoint, _backgroundPaint!);

      // Draw progress segment
      final progress = (values[i] / maxValue).clamp(0.0, 1.0);
      if (progress > 0) {
        _drawProgressSegment(canvas, segmentInfo, progress);
      }
    }
  }

  List<_SegmentInfo> _calculateSegmentPositions(
    Offset center,
    double innerRadius,
    double radius,
    int segmentCount,
    double segmentStep,
  ) {
    final segments = <_SegmentInfo>[];

    for (var i = 0; i < segmentCount; i++) {
      // Check cache first
      if (_segmentCache.containsKey(i)) {
        segments.add(_segmentCache[i]!);
        continue;
      }

      final segmentAngle = _startAngle + (i * segmentStep);
      final cosAngle = math.cos(segmentAngle);
      final sinAngle = math.sin(segmentAngle);

      final startPoint = Offset(
        center.dx + innerRadius * cosAngle,
        center.dy + innerRadius * sinAngle,
      );

      final endPoint = Offset(center.dx + radius * cosAngle, center.dy + radius * sinAngle);

      final segmentInfo = _SegmentInfo(startPoint, endPoint);
      _segmentCache[i] = segmentInfo;
      segments.add(segmentInfo);
    }

    return segments;
  }

  void _drawProgressSegment(Canvas canvas, _SegmentInfo segmentInfo, double progress) {
    final progressEndPoint = Offset(
      segmentInfo.startPoint.dx + (segmentInfo.endPoint.dx - segmentInfo.startPoint.dx) * progress,
      segmentInfo.startPoint.dy + (segmentInfo.endPoint.dy - segmentInfo.startPoint.dy) * progress,
    );

    final gradientInfo = _getCachedGradientInfo(progress);
    final shader = ui.Gradient.linear(
      segmentInfo.startPoint,
      segmentInfo.endPoint,
      gradientInfo.colors,
      gradientInfo.stops,
    );

    final progressPaint =
        Paint()
          ..shader = shader
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawLine(segmentInfo.startPoint, progressEndPoint, progressPaint);
  }

  GradientInfo _getCachedGradientInfo(double progress) {
    // Check cache first
    if (_gradientCache.containsKey(progress)) {
      return _gradientCache[progress]!;
    }

    final gradientInfo = Utils.getProgressiveDbzGradient(progress, colors);
    _gradientCache[progress] = gradientInfo;
    return gradientInfo;
  }

  void _drawLabels(Canvas canvas, Offset center, double radius) {
    // Use a single TextPainter and reuse it
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    const textStyle = TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500);

    for (final label in _labels) {
      textPainter
        ..text = TextSpan(text: label.text, style: textStyle)
        ..layout();

      final labelOffset = Offset(
        center.dx + (radius + 20) * math.cos(label.angle) - textPainter.width / 2,
        center.dy + (radius + 20) * math.sin(label.angle) - textPainter.height / 2,
      );

      textPainter.paint(canvas, labelOffset);
    }
  }

  @override
  bool shouldRepaint(covariant RainConditionPainter oldDelegate) {
    final shouldRepaint =
        values != oldDelegate.values ||
        maxValue != oldDelegate.maxValue ||
        colors != oldDelegate.colors ||
        strokeWidth != oldDelegate.strokeWidth;

    // Clear caches if we need to repaint
    if (shouldRepaint) {
      _shaderCache.clear();
      _gradientCache.clear();
      _segmentCache.clear();
      _backgroundPaint = null;
    }

    return shouldRepaint;
  }
}

// Helper classes for better organization
class _LabelInfo {
  const _LabelInfo(this.text, this.angle);

  final String text;
  final double angle;
}

class _SegmentInfo {
  const _SegmentInfo(this.startPoint, this.endPoint);

  final Offset startPoint;
  final Offset endPoint;
}
