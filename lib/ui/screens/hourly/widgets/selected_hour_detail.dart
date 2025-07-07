import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart';
import 'package:mimemo/ui/widgets/app_icon.dart';

class SelectedHourDetail extends StatefulWidget {
  const SelectedHourDetail({super.key});

  @override
  State<SelectedHourDetail> createState() => _SelectedHourDetailState();
}

class _SelectedHourDetailState extends State<SelectedHourDetail>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyCubit, HourlyState>(
      buildWhen: (previous, current) =>
          previous.selectedForecast != current.selectedForecast,
      builder: (context, state) {
        final selectedForecast = state.selectedForecast;
        if (selectedForecast == null) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              _buildWeatherContent(context, selectedForecast),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWeatherContent(
    BuildContext context,
    HourlyForecast selectedForecast,
  ) {
    const isDay = true;

    return SliverPadding(
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          _buildTemperatureHeader(context, selectedForecast),
          const Gap(8),
          _buildPrecipitation(context, selectedForecast),
          const Gap(8),
          _buildDescription(context, selectedForecast, isDay),
          const Gap(16),
          ..._buildWeatherMetrics(selectedForecast, isDay),
        ]),
      ),
      padding: const EdgeInsets.all(16),
    );
  }

  Widget _buildTemperatureHeader(
    BuildContext context,
    HourlyForecast selectedForecast,
  ) {
    final iconData = selectedForecast.weatherIcon;
    final temperature =
        selectedForecast.temperature?.value?.toStringAsFixed(0) ?? '';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppIcon(icon: Utils.getIconAsset(iconData ?? 0), size: 54),
        const Gap(16),
        Text(
          temperature,
          style: context.textTheme.displayMedium?.w700.copyWith(
            color: Colors.black,
          ),
        ),
        Text(
          CommonCharacters.degreeChar,
          style: context.textTheme.displayMedium?.w700.copyWith(
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildPrecipitation(
    BuildContext context,
    HourlyForecast selectedForecast,
  ) {
    final rain = selectedForecast.rainProbability ?? 0;
    final snow = selectedForecast.snowProbability ?? 0;
    final ice = selectedForecast.iceProbability ?? 0;

    return Column(
      children: [
        if (rain > 0)
          _buildPrecipitationRow(
            'Rain probability',
            rain.toString(),
            Icons.water_drop_outlined,
          ),
        if (snow > 0)
          _buildPrecipitationRow(
            'Snow probability',
            snow.toString(),
            Icons.snowing,
          ),
        if (ice > 0)
          _buildPrecipitationRow(
            'Ice probability',
            ice.toString(),
            Icons.severe_cold,
          ),
      ],
    );
  }

  Widget _buildPrecipitationRow(String title, String value, IconData icon) {
    return Row(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.water_drop_outlined, color: Colors.black, size: 14),
        Text(
          '$title: $value%',
          style: context.textTheme.bodySmall?.copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildDescription(
    BuildContext context,
    HourlyForecast selectedForecast,
    bool isDay,
  ) {
    final longPhrase = selectedForecast.iconPhrase ?? '';

    return Text(
      ' $longPhrase',
      style: context.textTheme.bodyMedium?.copyWith(color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  List<Widget> _buildWeatherMetrics(
    HourlyForecast selectedForecast,
    bool isDay,
  ) {
    final metrics = <(String, String)>[];

    // Add temperature metrics
    _addTemperatureMetrics(metrics, selectedForecast, isDay);

    metrics
      ..add((
        'Humidity',
        '${selectedForecast.relativeHumidity}%',
      ))
      ..add((
        'Indoor humidity',
        '${selectedForecast.indoorRelativeHumidity}%',
      ))
      ..add((
        'UV index',
        '${selectedForecast.uvIndex}(${selectedForecast.uvIndexText})',
      ))
      ..add((
        'Wind',
        '${selectedForecast.wind?.direction?.localized} ${selectedForecast.wind?.speed?.value} ${selectedForecast.wind?.speed?.unit}',
      ))
      ..add((
        'Wind Gust',
        '${selectedForecast.windGust?.speed?.value ?? ''} ${selectedForecast.windGust?.speed?.unit ?? ''}',
      ));
    if (selectedForecast.rainProbability != null &&
        selectedForecast.rainProbability! > 0) {
      metrics.add((
        'Rain probability',
        '${selectedForecast.rainProbability} %',
      ));
    }
    if (selectedForecast.snowProbability != null &&
        selectedForecast.snowProbability! > 0) {
      metrics.add((
        'Snow probability',
        '${selectedForecast.snowProbability} %',
      ));
    }
    if (selectedForecast.iceProbability != null &&
        selectedForecast.iceProbability! > 0) {
      metrics.add((
        'Ice probability',
        '${selectedForecast.iceProbability} %',
      ));
    }
    metrics
      ..add(('Cloud cover', '${selectedForecast.cloudCover ?? ''} %'))
      ..add((
        'Dew point',
        '${selectedForecast.dewPoint?.value ?? ''} ${CommonCharacters.degreeChar}',
      ))
      ..add((
        'Visibility',
        '${selectedForecast.visibility?.value ?? ''} ${selectedForecast.visibility?.unit ?? ''}',
      ))
      ..add((
        'Ceiling',
        '${selectedForecast.ceiling?.value?.toStringAsFixed(0) ?? ''} ${selectedForecast.ceiling?.unit ?? ''}',
      ));

    return metrics
        .map((metric) => _buildInfoRow(metric.$1, metric.$2))
        .toList();
  }

  void _addTemperatureMetrics(
    List<(String, String)> metrics,
    HourlyForecast selectedForecast,
    bool isDay,
  ) {
    final realFeel =
        selectedForecast.realFeelTemperature?.value?.toStringAsFixed(0) ?? '';
    final realFeelShade =
        selectedForecast.realFeelTemperatureShade?.value?.toStringAsFixed(0) ??
        '';

    if (realFeel.isNotEmpty) {
      metrics.add(('RealFeel High', '$realFeel${CommonCharacters.degreeChar}'));
    }
    if (realFeelShade.isNotEmpty) {
      metrics.add((
        'RealFeel Shade High',
        '$realFeelShade${CommonCharacters.degreeChar}',
      ));
    }
  }

  Widget _buildInfoRow(String label, String value, {bool bottomBorder = true}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: bottomBorder
            ? const Border(
                bottom: BorderSide(color: Colors.black26, width: 0.5),
              )
            : const Border(top: BorderSide(color: Colors.black26, width: 0.5)),
      ),
      child: Row(
        spacing: 8,
        children: [
          Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(color: Colors.black),
          ),
          Expanded(
            child: Text(
              value,
              style: context.textTheme.bodyMedium?.w500.copyWith(
                color: Colors.black,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
