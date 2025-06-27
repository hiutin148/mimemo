import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:mimemo/core/const/consts.dart';

class HourlyDoubleChartPainter<T> extends CustomPainter {
  HourlyDoubleChartPainter({
    required this.items,
    required this.itemWidth,
    required this.itemHeight,
    required this.iconInfos,
    this.getTime,
    this.getIcon,
    // First chart props
    this.getFirstValue,
    this.getFirstBottomLabel,
    this.getFirstTopLabel,
    this.showFirstGradient = false,
    // Second chart props
    this.getSecondValue,
    this.getSecondBottomLabel,
    this.getSecondTopLabel,
    this.showSecondGradient = false,
    super.repaint,
  });

  final List<T> items;
  final double itemWidth;
  final double itemHeight;
  final String Function(T item)? getTime;
  final int Function(T item)? getIcon;
  final List<ui.Image> iconInfos;

  // First chart props
  final double Function(T item)? getFirstValue;
  final String Function(T item)? getFirstBottomLabel;
  final String Function(T item)? getFirstTopLabel;
  final bool showFirstGradient;

  // Second chart props
  final double Function(T item)? getSecondValue;
  final String Function(T item)? getSecondBottomLabel;
  final String Function(T item)? getSecondTopLabel;
  final bool showSecondGradient;

  Paint pointPaint =
      Paint()
        ..color = Colors.white
        ..strokeWidth = 6
        ..style = PaintingStyle.fill;

  Paint linePaint =
      Paint()
        ..color = Colors.white
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final baseItemValue = getFirstValue?.call(items.first) ?? 0;
    final baseY = itemHeight / 2;
    final baseX = itemWidth / 2;
    const unitDiffY = 2;

    final linePath =
        Path()
          ..moveTo(0, baseY)
          ..lineTo(baseX, baseY);

    Offset? prevPoint;

    for (var i = 0; i < items.length; i++) {
      final itemValue = getFirstValue?.call(items[i]) ?? 0;
      final itemX = i * itemWidth + baseX;
      final itemY = (itemValue - baseItemValue) * unitDiffY + baseY;
      final currentPoint = Offset(itemX, itemY);
      handleChartLineItemPath(canvas, currentPoint, prevPoint, linePath, items[i]);

      const labelTextStyle = TextStyle(color: Colors.white, fontSize: 12);
      final textSpan = TextSpan(text: getTime?.call(items[i]), style: labelTextStyle);

      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();

      final textOffset = Offset(currentPoint.dx - textPainter.width / 2, 20);

      textPainter.paint(canvas, textOffset);

      if (i < iconInfos.length) {
        canvas.drawImage(iconInfos[i], Offset(currentPoint.dx - 12, 40), pointPaint);
      }

      if (i == items.length - 1) {
        linePath.lineTo(currentPoint.dx + itemWidth / 2, currentPoint.dy);
        drawGradientBackground(canvas, size, linePath, currentPoint);
      }
      prevPoint = currentPoint;
    }

    canvas.drawPath(linePath, linePaint);
  }

  void handleChartLineItemPath(
    Canvas canvas,
    Offset currentPoint,
    Offset? prevPoint,
    Path path,
    T item,
  ) {
    canvas.drawCircle(currentPoint, 4, pointPaint);

    if (prevPoint != null) {
      final controlPointX = (prevPoint.dx + currentPoint.dx) / 2;

      path.cubicTo(
        controlPointX,
        prevPoint.dy,
        controlPointX,
        currentPoint.dy,
        currentPoint.dx,
        currentPoint.dy,
      );
    }
    drawFirstChartLabels(canvas, currentPoint, item);
  }

  void drawGradientBackground(Canvas canvas, Size size, Path linePath, Offset lastPoint) {
    final fillPath =
        Path.from(linePath)
          ..lineTo(lastPoint.dx + itemWidth / 2, size.height)
          ..lineTo(0, size.height)
          ..close();

    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.blue.withValues(alpha: 0.4), AppColors.blue.withValues(alpha: 0.01)],
    );

    final fillPaint =
        Paint()
          ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
          ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);
  }

  void drawFirstChartLabels(Canvas canvas, Offset offset, T item) {
    final topLabelOffset = Offset(offset.dx, offset.dy - 12);
    final topLabel = getFirstTopLabel?.call(item);
    drawLabel(canvas, topLabelOffset, topLabel);

    final bottomLabelOffset = Offset(offset.dx, offset.dy + 12);
    final bottomLabel = getFirstBottomLabel?.call(item);
    drawLabel(canvas, bottomLabelOffset, bottomLabel);
  }

  void drawLabel(Canvas canvas, Offset offset, String? label, [TextStyle? textStyle]) {
    if (label == null) return;
    final labelTextStyle = textStyle ?? const TextStyle(color: Colors.white, fontSize: 12);
    final textSpan = TextSpan(text: label, style: labelTextStyle);

    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr)..layout();

    final textOffset = Offset(offset.dx - textPainter.width / 2, offset.dy);

    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
