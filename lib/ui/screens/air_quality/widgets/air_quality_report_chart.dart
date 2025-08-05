import 'package:flutter/material.dart';
import 'package:mimemo/ui/screens/air_quality/widgets/air_quality_report_painter.dart';

class AirQualityReportChart extends StatelessWidget {
  const AirQualityReportChart({required this.height, required this.value, super.key});

  final double height;
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: AirQualityReportPainter(
          value: value,
        ),
        child: const SizedBox(),
      ),
    );
  }
}
