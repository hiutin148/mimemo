import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/core/const/app_colors.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/current_air_quality/current_air_quality.dart';
import 'package:mimemo/models/enums/aqi.dart';
import 'package:mimemo/ui/screens/air_quality/widgets/air_quality_report_chart.dart';
import 'package:mimemo/ui/screens/air_quality/widgets/air_quality_scale.dart';
import 'package:mimemo/ui/screens/air_quality/widgets/pollutants_list.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

@RoutePage()
class AirQualityScreen extends StatelessWidget {
  const AirQualityScreen({required this.homeCubit, super.key});

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: homeCubit,
      child: const AirQualityView(),
    );
  }
}

class AirQualityView extends StatelessWidget {
  const AirQualityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeCubit, HomeState, CurrentAirQuality?>(
      builder: (context, airQuality) {
        final aqi = AqiExtension.getAQICategory(airQuality?.data?.overallPlumeLabsIndex ?? 0);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Air quality'),
            centerTitle: true,
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return AppRefreshIndicator(
                onRefresh: context.read<HomeCubit>().getAirQuality,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      spacing: 16,
                      children: [
                        AirQualityReportChart(
                          height: constraints.maxHeight * 0.4,
                          value: airQuality?.data?.overallPlumeLabsIndex ?? 0,
                        ),
                        _buildDescription(context, aqi, airQuality?.data?.category ?? ''),
                        PollutantsList(pollutants: airQuality?.data?.pollutants ?? []),
                        const Divider(
                          color: AppColors.whiteBorderColor,
                          height: 0.5,
                        ),
                        const AirQualityScale(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
      selector: (state) => state.airQuality,
    );
  }

  Widget _buildDescription(BuildContext context, Aqi aqi, String category) {
    return Column(
      spacing: 16,
      children: [
        Container(
          width: 40,
          height: 3,
          color: aqi.color,
        ),
        Text(
          category,
          style: context.textTheme.titleMedium?.w700,
        ),
        Text(
          aqi.description ?? '',
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}
