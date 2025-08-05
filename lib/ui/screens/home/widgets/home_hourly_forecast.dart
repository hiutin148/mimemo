import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/datetime_extension.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_cubit.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_tab.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/home_card.dart';
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart';
import 'package:mimemo/ui/widgets/app_icon.dart';
import 'package:mimemo/ui/widgets/app_inkwell.dart';

class HomeHourlyForecast extends StatelessWidget {
  const HomeHourlyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return previous.next12HoursForecast != current.next12HoursForecast ||
            previous.next12HoursForecastStatus !=
                current.next12HoursForecastStatus;
      },
      builder: (context, state) {
        final next12HoursForecast = state.next12HoursForecast;
        return HomeCard(
          title: 'Hourly Forecast',
          onTap: () {
            context.read<BottomNavCubit>().switchTab(BottomNavTab.hourly.index);
          },
          child: SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: next12HoursForecast.length,
              itemBuilder: (context, index) {
                final forecast = next12HoursForecast[index];
                final dateTime = DateTime.tryParse(
                  forecast.dateTime ?? '',
                )?.toLocal();
                final displayTime = dateTime != null
                    ? dateTime.toFormatedString(DateFormatPattern.hour12)
                    : '';
                final tem = forecast.temperature?.value?.toString() ?? '';
                final unit = forecast.temperature?.unit ?? '';
                return AppInkWell(
                  onTap: () {
                    context.read<BottomNavCubit>().switchTab(
                      BottomNavTab.hourly.index,
                    );
                    context.read<HourlyCubit>().selectForecast(forecast);
                  },
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  borderRadius: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.cardBackground,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        displayTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: AppIcon(
                          icon: Utils.getIconAsset(
                            forecast.weatherIcon ?? 0,
                          ),
                          size: 32,
                        ),
                      ),
                      Text(
                        '$tem °$unit',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Gap(12),
            ),
          ),
        );
      },
    );
  }
}
