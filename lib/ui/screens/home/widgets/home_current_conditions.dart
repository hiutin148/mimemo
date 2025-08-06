import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_cubit.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_tab.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/home_card.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

class HomeCurrentConditions extends StatelessWidget {
  const HomeCurrentConditions({super.key});

  void _onCardTap(BuildContext context) {
    final dailyCubit = context.read<DailyCubit>();
    final forecastDay = dailyCubit.state.dailyForecast?.dailyForecasts?.firstOrNull;
    dailyCubit.changeSelectedDay(forecastDay);
    context.read<BottomNavCubit>().switchTab(BottomNavTab.daily.index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.currentConditions != current.currentConditions ||
          previous.currentConditionsStatus != current.currentConditionsStatus,
      builder: (context, state) {
        final currentConditions = state.currentConditions;
        return HomeCard(
          title: 'Current conditions',
          onTap: () => _onCardTap(context),
          child: Column(
            spacing: 16,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      'Humidity',
                      '${currentConditions?.relativeHumidity?.toString() ?? ''}%',
                      Icons.water_drop,
                    ),
                  ),
                  Expanded(
                    child: _buildDetailItem(
                      'Wind Speed',
                      '${currentConditions?.wind?.speed?.metric?.value ?? ''} ${currentConditions?.wind?.speed?.metric?.unit ?? ''}',
                      Icons.air,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      'UV Index',
                      '${currentConditions?.uvIndex ?? ''} (${currentConditions?.uvIndexText ?? ''})',
                      Icons.wb_sunny,
                    ),
                  ),
                  Expanded(
                    child: _buildDetailItem(
                      'Visibility',
                      '${currentConditions?.visibility?.metric?.value ?? ''} ${currentConditions?.visibility?.metric?.unit ?? ''}',
                      Icons.visibility,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      'Pressure',
                      '${currentConditions?.pressure?.metric?.value ?? ''} ${currentConditions?.pressure?.metric?.unit ?? ''}',
                      Icons.speed,
                    ),
                  ),
                  Expanded(
                    child: _buildDetailItem(
                      'Cloud Cover',
                      '${currentConditions?.cloudCover ?? ''}%',
                      Icons.cloud,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 20),
        const Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
