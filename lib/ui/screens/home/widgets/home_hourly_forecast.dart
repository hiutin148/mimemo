import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/datetime_extension.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/widgets/app_icon.dart';

class HomeHourlyForecast extends StatelessWidget {
  const HomeHourlyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) {
        return previous.next12HoursForecast != current.next12HoursForecast ||
            previous.next12HoursForecastStatus != current.next12HoursForecastStatus;
      },
      builder: (context, state) {
        final next12HoursForecast = state.next12HoursForecast;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hourly Forecast',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    // TODO
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
                  ),
                ),
              ],
            ),
            const Gap(16),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: next12HoursForecast.length,
                itemBuilder: (context, index) {
                  final forecast = next12HoursForecast[index];
                  final dateTime = DateTime.tryParse(forecast.dateTime ?? '')?.toLocal();
                  final displayTime =
                      dateTime != null ? dateTime.toFormatedString(DateFormatPattern.hour12) : '';
                  final tem = forecast.temperature?.value?.toString() ?? '';
                  final unit = forecast.temperature?.unit ?? '';
                  return Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(8),
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
                            icon: Utils.getIconAsset(forecast.weatherIcon ?? 0),
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
              ),
            ),
          ],
        );
      },
    );
  }
}
