import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/widgets/app_icon.dart';

class SelectedDayDetail extends StatefulWidget {
  const SelectedDayDetail({super.key});

  @override
  State<SelectedDayDetail> createState() => _SelectedDayDetailState();
}

class _SelectedDayDetailState extends State<SelectedDayDetail> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DailyCubit, DailyState, ForecastDay?>(
      builder: (context, selectedDay) {
        if (selectedDay == null) return const SliverToBoxAdapter(child: SizedBox.shrink());
        final uvIndex = selectedDay.airAndPollen?.firstWhereOrNull((element) => element.name == 'UVIndex');
        final windSpeed = selectedDay.day?.wind?.speed?.value;
        return SliverList(
          delegate: SliverChildListDelegate([
            TabBar(
              controller: _tabController,
              tabs: const [Tab(text: 'Day'), Tab(text: 'Night'), Tab(text: 'History')],
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(icon: Utils.getIconAsset(selectedDay.day?.icon ?? 0), size: 54),
                      const Gap(8),
                      Text(
                        selectedDay.temperature?.maximum?.value?.toStringAsFixed(0) ?? '',
                        style: context.textTheme.displayMedium?.w700.copyWith(color: Colors.black),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CommonCharacters.degreeChar,
                            style: context.textTheme.displayMedium?.w700.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'High',
                            style: context.textTheme.bodyMedium?.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Gap(8),
                  Row(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.water_drop_outlined, color: Colors.black, size: 14),
                      Text(
                        'Humidity: ${selectedDay.day?.relativeHumidity?.average ?? ''}%',
                        style: context.textTheme.bodySmall?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    ' ${selectedDay.day?.longPhrase ?? ''}',
                    style: context.textTheme.bodyMedium?.copyWith(color: Colors.black),
                  ),
                  const Gap(16),
                  _buildInfoRow(
                    'RealFeel High',
                    '${selectedDay.realFeelTemperature?.maximum?.value?.toStringAsFixed(0) ?? ''}${CommonCharacters.degreeChar}',
                  ),
                  _buildInfoRow(
                    'RealFeel Shade High',
                    '${selectedDay.realFeelTemperatureShade?.maximum?.value?.toStringAsFixed(0) ?? ''}${CommonCharacters.degreeChar}',
                  ),
                  _buildInfoRow(
                    'UV Index',
                    '${uvIndex?.value ?? ''}(${uvIndex?.category ?? ''})',
                  ),
                  _buildInfoRow(
                    'Wind',
                    '${selectedDay.realFeelTemperature?.maximum?.value?.toStringAsFixed(0) ?? ''}${CommonCharacters.degreeChar}',
                  ),
                  _buildInfoRow(
                    'RealFeel High',
                    '${selectedDay.realFeelTemperature?.maximum?.value?.toStringAsFixed(0) ?? ''}${CommonCharacters.degreeChar}',
                  ),
                ],
              ),
            ),
          ]),
        );
      },
      selector: (state) => state.selectedDay,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
      child: Row(
        spacing: 8,
        children: [
          Text(label, style: context.textTheme.bodySmall?.copyWith(color: Colors.black)),
          Expanded(
            child: Text(
              value,
              style: context.textTheme.bodyMedium?.w500.copyWith(color: Colors.black),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
