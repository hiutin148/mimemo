import 'package:auto_route/annotations.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/entities/one_minute_cast/one_minute_cast.dart';
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart';
import 'package:mimemo/ui/screens/precipitation/precipitation_cubit.dart';
import 'package:mimemo/ui/widgets/app_icon.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

@RoutePage()
class PrecipitationScreen extends StatelessWidget {
  const PrecipitationScreen({
    required this.hourlyCubit,
    this.oneMinuteCast,
    super.key,
  });

  final OneMinuteCast? oneMinuteCast;
  final HourlyCubit hourlyCubit;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PrecipitationCubit(
            hourlyCubit: hourlyCubit,
            oneMinuteCast: oneMinuteCast,
          ),
        ),
        BlocProvider.value(
          value: hourlyCubit,
        ),
      ],
      child: const PrecipitationView(),
    );
  }
}

class PrecipitationView extends StatefulWidget {
  const PrecipitationView({super.key});

  @override
  State<PrecipitationView> createState() => _PrecipitationViewState();
}

class _PrecipitationViewState extends State<PrecipitationView> {
  late final PrecipitationCubit _cubit;
  late final MainCubit _mainCubit;
  List<Placemark> placemarks = [];

  late final List<MinuteColor> _minuteColors;
  static const double _itemWidth = 4;
  static const double _separateSpace = 2;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<PrecipitationCubit>()..init();
    _mainCubit = context.read<MainCubit>();

    _minuteColors = _mainCubit.state.minuteColors
        .where((element) => element.type?.toLowerCase() == 'rain')
        .toList();

    _getPlacemarks();
  }

  Future<void> _getPlacemarks() async {
    final position = _mainCubit.state.positionInfo?.geoPosition;
    if (position?.latitude == null || position?.longitude == null) return;

    try {
      final result = await placemarkFromCoordinates(
          position!.latitude!,
          position.longitude!
      );

      if (mounted) {
        setState(() => placemarks = result);
      }
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MinuteCast')),
      body: BlocBuilder<PrecipitationCubit, PrecipitationState>(
        builder: _buildBody,
      ),
    );
  }

  Widget _buildBody(BuildContext context, PrecipitationState state) {
    final intervals = state.oneMinuteCast?.intervals ?? [];
    final selectedHour = state.selectedHour;
    final temp = selectedHour?.temperature?.value?.toStringAsFixed(0) ?? '';
    final realFeel = selectedHour?.realFeelTemperature?.value?.toStringAsFixed(0) ?? '';
    final unit = selectedHour?.temperature?.unit ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            const Text('Next 4 hours'),
            Text(state.oneMinuteCast?.summary?.longPhrase ?? ''),
            const SizedBox(height: 24),
            Expanded(
              child: Column(
                children: [
                  _buildHeaderRow(state, temp, realFeel, unit),
                  SizedBox(
                    height: constraints.maxHeight * 0.45,
                    child: _buildChartSection(state, intervals),
                  ),
                  _buildMinuteColors(),
                  const Gap(12),
                  _buildDetailLocation(),
                  const SizedBox(height: kBottomNavigationBarHeight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(PrecipitationState state, String temp, String realFeel, String unit) {
    final selectedMinute = state.selectedMinute;
    return Row(
      children: [
        const Gap(48),
        AppIcon(icon: Utils.getIconAsset(selectedMinute?.iconCode ?? 0)),
        const Gap(8),
        Text(selectedMinute?.shortPhrase ?? ''),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$temp °$unit', style: context.textTheme.bodyLarge),
            Text('RealFeel $realFeel°', style: context.textTheme.labelSmall),
          ],
        ),
      ],
    );
  }

  Widget _buildChartSection(PrecipitationState state, List<MinuteInterval> intervals) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 24),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.white, width: 0.5),
              top: BorderSide(color: AppColors.whiteBorderColor, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Spacer(),
                    Center(child: Text('Heavy')),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [Text('Light'), Gap(28)],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: _buildScrollableChart(intervals)),
            ],
          ),
        ),
        _buildGradientOverlay(),
        _buildCurrentTimeIndicator(state),
      ],
    );
  }

  Widget _buildGradientOverlay() {
    return Positioned(
      left: 60,
      top: 28,
      child: Container(
        height: 32,
        width: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.surface,
              AppColors.surface.withValues(alpha: 0.1),
            ],
            stops: const [0.25, 1],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailLocation() {
    if (placemarks.isEmpty) return const SizedBox.shrink();

    final placemark = placemarks.first;
    final street = placemark.street ?? '';
    final adminArea = placemark.administrativeArea ?? '';
    final subAdminArea = placemark.subAdministrativeArea ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 4,
            children: [
              const Icon(Icons.location_on, size: 20, color: Colors.white),
              Text('Precise position', style: context.textTheme.bodyLarge?.w600),
            ],
          ),
          if (street.isNotEmpty)
            Text(street, style: context.textTheme.bodyLarge?.w600),
          if (subAdminArea.isNotEmpty || adminArea.isNotEmpty)
            Text('$subAdminArea, $adminArea', style: context.textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildMinuteColors() {
    if (_minuteColors.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Text('Rain', style: context.textTheme.labelMedium),
            ..._minuteColors.map((e) => Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: e.hex?.hexToColor,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableChart(List<MinuteInterval> intervals) {
    if (intervals.isEmpty) return const SizedBox.shrink();

    final maxDbz = _minuteColors.lastOrNull?.endDbz ?? 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bufferPadding = constraints.maxWidth - _itemWidth - _separateSpace;

        return ScrollConfiguration(
          behavior: NoStretchBehavior(),
          child: ScrollablePositionedList.separated(
            padding: EdgeInsets.only(right: bufferPadding, left: 3),
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: intervals.length,
            itemBuilder: (context, index) => _buildChartItem(
              context,
              index,
              intervals[index],
              maxDbz,
              constraints.maxHeight,
            ),
            itemScrollController: _cubit.itemScrollController,
            scrollOffsetController: _cubit.scrollOffsetController,
            itemPositionsListener: _cubit.itemPositionsListener,
            scrollOffsetListener: _cubit.scrollOffsetListener,
            separatorBuilder: (context, index) => const SizedBox(width: _separateSpace),
          ),
        );
      },
    );
  }

  Widget _buildChartItem(
      BuildContext context,
      int index,
      MinuteInterval item,
      double maxDbz,
      double maxHeight,
      ) {
    final itemRatio = (item.dbz ?? 0) / maxDbz;
    final gradientInfo = Utils.getProgressiveDbzGradient(itemRatio, _minuteColors);

    return BlocBuilder<PrecipitationCubit, PrecipitationState>(
      builder: (context, state) {
        final intervalItem = state.oneMinuteCast?.intervals?[index];
        final itemTime = intervalItem?.startDateTime?.reformatDateString(
          newFormat: DateFormatPattern.time,
        );
        final isRoundOrHalfHour = (itemTime?.isRoundOrHalfHour ?? false) && index != 0;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 28,
                      width: _itemWidth,
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.white24),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 32),
                      height: maxHeight * itemRatio,
                      width: _itemWidth,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradientInfo.colors,
                          stops: gradientInfo.stops,
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isRoundOrHalfHour)
              Positioned(
                bottom: 0,
                left: -20,
                right: -20,
                top: 3.5,
                child: Column(
                  children: [
                    Text(
                      itemTime ?? '',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    const Expanded(
                      child: DottedLine(
                        direction: Axis.vertical,
                        dashColor: Colors.white24,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildCurrentTimeIndicator(PrecipitationState state) {
    final timeText = state.selectedMinute?.startDateTime?.reformatDateString(
      newFormat: DateFormatPattern.time,
    ) ?? '';

    if (timeText.isEmpty) return const SizedBox.shrink();

    return Positioned.fill(
      left: 60,
      child: IgnorePointer(
        child: Container(
          padding: const EdgeInsets.only(top: 28, left: 4),
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.white, width: 0.5),
            ),
          ),
          child: Text(
            timeText,
            style: context.textTheme.bodyMedium?.copyWith(
              color: AppColors.whiteBorderColor,
            ),
          ),
        ),
      ),
    );
  }
}

class NoStretchBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
