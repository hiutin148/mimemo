import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/enums/aqi.dart';
import 'package:mimemo/router/app_router.gr.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/air_quality_chart.dart';
import 'package:mimemo/ui/screens/home/widgets/rain_condition_chart.dart';
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart';
import 'package:mimemo/ui/widgets/app_button.dart';
import 'package:mimemo/ui/widgets/app_icon.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CurrentConditionGaugeChart extends StatefulWidget {
  const CurrentConditionGaugeChart({super.key});

  @override
  State<CurrentConditionGaugeChart> createState() => _CurrentConditionGaugeChartState();
}

class _CurrentConditionGaugeChartState extends State<CurrentConditionGaugeChart> {
  static const String _rainConditionButtonText = '4 hours';
  static const String _airQualityButtonText = 'See more';
  static const String _airQualityTitle = 'Current air pollutants are';
  static const String _excellentLabel = 'EXCELLENT';
  static const String _dangerousLabel = 'DANGEROUS';

  // UI Constants
  static const double _chartHeight = 332;
  static const double _centerContentSize = 264;
  static const double _iconSize = 56;
  static const double _buttonWidth = 100;
  static const double _aqiBarWidth = 16;
  static const double _aqiBarHeight = 10;
  static const double _indicatorDotWidth = 28;
  static const double _indicatorDotHeight = 3;

  int _currentTab = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSwitch(int newTab) {
    if (_currentTab != newTab) {
      setState(() => _currentTab = newTab);
    }
  }

  String get _currentButtonText =>
      _currentTab == 0 ? _rainConditionButtonText : _airQualityButtonText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: _buildContent,
      buildWhen: (previous, current) {
        return previous.currentConditions != current.currentConditions ||
            previous.currentConditionsStatus != current.currentConditionsStatus ||
            previous.airQuality != current.airQuality ||
            previous.airQualityStatus != current.airQualityStatus ||
            previous.oneMinuteCast != current.oneMinuteCast ||
            previous.oneMinuteCastStatus != current.oneMinuteCastStatus;
      },
    );
  }

  Widget _buildContent(BuildContext context, HomeState state) {
    return Center(
      child: Column(
        children: [
          _buildHeader(context, state),
          _buildChartSection(context, state),
          const Gap(16),
          _buildFooter(context),
          const Gap(16),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HomeState state) {
    return SizedBox(
      height: 48,
      child: _currentTab == 0
          ? _buildRainHeader(context, state)
          : _buildAirQualityHeader(context, state),
    );
  }

  Widget _buildRainHeader(BuildContext context, HomeState state) {
    final phrase = state.oneMinuteCast?.summary?.phrase60 ?? '';
    return Text(phrase, style: context.textTheme.titleMedium?.white.w400);
  }

  Widget _buildAirQualityHeader(BuildContext context, HomeState state) {
    final category = state.airQuality?.data?.category ?? '';
    return Column(
      children: [
        Text(
          _airQualityTitle,
          style: context.textTheme.titleMedium?.white.w400,
        ),
        Text(category, style: context.textTheme.titleMedium?.white.w700),
      ],
    );
  }

  Widget _buildChartSection(BuildContext context, HomeState state) {
    return SizedBox(
      height: _chartHeight,
      child: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onTabSwitch,
            children: const [RainConditionChart(), AirQualityChart()],
          ),
          _buildCenterContent(context, state),
        ],
      ),
    );
  }

  Widget _buildCenterContent(BuildContext context, HomeState state) {
    return Center(
      child: SizedBox(
        width: _centerContentSize,
        height: _centerContentSize,
        child: _buildWeatherInfo(context, state),
      ),
    );
  }

  Widget _buildWeatherInfo(BuildContext context, HomeState state) {
    final currentConditions = state.currentConditions;
    final temperature = currentConditions?.temperature?.metric?.value;
    final unit = currentConditions?.temperature?.metric?.unit ?? '';
    final temperatureText = temperature != null ? '$temperature °$unit' : '';
    final realFeel = currentConditions?.realFeelTemperature?.metric?.value ?? '';
    final icon = currentConditions?.weatherIcon ?? 0;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppIcon(icon: Utils.getIconAsset(icon), size: _iconSize),
          Text(
            temperatureText,
            style: context.textTheme.headlineLarge?.w700.white,
          ),
          Text(
            'RealFeel $realFeel°',
            style: context.textTheme.bodyMedium?.white,
          ),
          const Gap(16),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return AppButton(
      width: _buttonWidth,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      onPressed: () {
        if (_currentTab == 0) {
          context.pushRoute(
            PrecipitationRoute(
              hourlyCubit: context.read<HourlyCubit>(),
              oneMinuteCast: context.read<HomeCubit>().state.oneMinuteCast,
            ),
          );
        } else if (_currentTab == 1) {
          context.pushRoute(
            AirQualityRoute(
              homeCubit: context.read<HomeCubit>(),
            ),
          );
        }
      },
      child: Row(
        spacing: 2,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _currentButtonText,
            style: context.textTheme.bodyMedium?.white,
          ),
          const Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return SizedBox(
      height: 48,
      child: _currentTab == 0 ? _buildRainFooter(context) : _buildAirQualityFooter(context),
    );
  }

  Widget _buildRainFooter(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, DateTime>(
      builder: (context, lastUpdate) {
        final lastUpdateTime = lastUpdate.toFormatedString(DateFormatPattern.time);
        return Text(
          'Last updated at $lastUpdateTime',
          style: context.textTheme.bodyMedium?.white.w400,
        );
      },
      selector: (state) => state.lastUpdate ?? DateTime.now(),
    );
  }

  Widget _buildAirQualityFooter(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, DateTime>(
      builder: (context, lastUpdate) {
        final lastUpdateTime = lastUpdate.toFormatedString(DateFormatPattern.time);
        return Column(
          spacing: 4,
          children: [
            _buildAqiScale(context),
            Text('Last updated at $lastUpdateTime', style: context.textTheme.bodyMedium?.white.w400),
          ],
        );
      },
      selector: (state) => state.lastUpdate ?? DateTime.now(),
    );
  }

  Widget _buildAqiScale(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Expanded(
          child: Text(
            _excellentLabel,
            style: context.textTheme.bodySmall?.white,
            textAlign: TextAlign.right,
          ),
        ),
        _buildAqiColorBar(),
        Expanded(
          child: Text(
            _dangerousLabel,
            style: context.textTheme.bodySmall?.white,
          ),
        ),
      ],
    );
  }

  Widget _buildAqiColorBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Row(
        children: Aqi.values
            .map(
              (aqi) => Container(
                width: _aqiBarWidth,
                height: _aqiBarHeight,
                color: aqi.color,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: _currentTab,
      count: 2,
      effect: const WormEffect(
        dotWidth: _indicatorDotWidth,
        dotHeight: _indicatorDotHeight,
      ),
    );
  }
}
