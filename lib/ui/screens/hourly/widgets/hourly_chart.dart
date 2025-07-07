import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/ui/screens/hourly/widgets/hourly_chart_painter.dart';

class HourlyChart extends StatefulWidget {
  const HourlyChart({required this.forecasts, super.key});

  final List<HourlyForecast> forecasts;

  @override
  State<HourlyChart> createState() => _HourlyChartState();
}

class _HourlyChartState extends State<HourlyChart> {
  late final ScrollController _scrollController;
  static const double _itemWidth = 68;
  final List<ui.Image> iconInfos = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    init();
    super.didChangeDependencies();
  }

  Future<void> init() async {
    for (var i = 0; i < widget.forecasts.length; i++) {
      final iconInfo = await getImageFromSvg(
        Utils.getIconAsset(widget.forecasts[i].weatherIcon ?? 0),
        24,
        20,
      );
      iconInfos.add(iconInfo);
    }
    setState(() {});
  }

  static Future<ui.Image> getImageFromSvg(String path, double width, double height) async {
    final svgData = await rootBundle.loadString(path);
    final svgLoader = SvgStringLoader(svgData);
    final pictureInfo = await vg.loadPicture(svgLoader, null);
    final picture = pictureInfo.picture;
    final originalSize = pictureInfo.size;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, width, height));

    final scale = min(width / originalSize.width, height / originalSize.height);
    final dx = (width - originalSize.width * scale) / 2;
    final dy = (height - originalSize.height * scale) / 2;

    canvas
      ..translate(dx, dy)
      ..scale(scale)
      ..drawPicture(picture);

    final image = await recorder.endRecording().toImage(width.ceil(), height.ceil());
    picture.dispose();
    return image;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification) {
                  Future.delayed(const Duration(milliseconds: 50), () {
                    if (!mounted) return;

                    final offset = _scrollController.offset;
                    final nearestIndex = (offset / _itemWidth).round();
                    final targetOffset = nearestIndex * _itemWidth;
                    final maxScroll = _scrollController.position.maxScrollExtent;

                    final clampedTarget = targetOffset.clamp(0.0, maxScroll);

                    if ((offset - clampedTarget).abs() > 0.5) {
                      _scrollController.animateTo(
                        clampedTarget,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut, // Changed from easeIn
                      );
                    }
                  });
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 400,
                  width: _itemWidth * widget.forecasts.length,
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: HourlyDoubleChartPainter<HourlyForecast>(
                      items: widget.forecasts,
                      itemWidth: _itemWidth,
                      itemHeight: constraints.maxHeight,
                      getFirstValue: (item) => item.temperature?.value ?? 0,
                      getFirstBottomLabel:
                          (item) =>
                              '${item.temperature?.value ?? 0}${CommonCharacters.degreeChar}',
                      getTime:
                          (item) =>
                              item.dateTime?.reformatDateString(
                                newFormat: DateFormatPattern.hour12,
                              ) ??
                              '',
                      getIcon: (item) => item.weatherIcon ?? 0,
                      iconInfos: iconInfos,
                    ),
                  ),
                ),
              ),
            ),
            ColoredBox(
              color: AppColors.green.withValues(alpha: 0.1),
              child: SizedBox(width: _itemWidth, height: constraints.maxHeight),
            ),
          ],
        );
      },
    );
  }
}
