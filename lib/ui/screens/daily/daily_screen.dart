import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/daily_forecast/daily_forecast.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/screens/daily/widgets/bottom_sheet_bar.dart';
import 'package:mimemo/ui/screens/daily/widgets/daily_forecast_calendar.dart';
import 'package:mimemo/ui/screens/daily/widgets/daily_forecast_list.dart';
import 'package:mimemo/ui/screens/daily/widgets/selected_day_detail.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  State<DailyScreen> createState() => _DailyViewState();
}

class _DailyViewState extends State<DailyScreen> with SingleTickerProviderStateMixin {
  final BottomSheetBarController _bottomSheetBarController = BottomSheetBarController();

  int _currentTab = 0;

  void _onForecastItemPressed(ForecastDay? day) {
    context.read<DailyCubit>().changeSelectedDay(day);
    _bottomSheetBarController.expand();
  }

  void _onTabBarTap(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return BottomSheetBar(
              controller: _bottomSheetBarController,
              header: _buildBottomSheetHeader(context),
              bodyBottomPadding: _currentTab == 0 ? 48 : 0,
              body: _buildBottomSheetBarBody(),
              expandedSliver: const SelectedDayDetail(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBottomSheetBarBody() {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child:
              _currentTab == 0
                  ? DailyForecastList(onItemTap: _onForecastItemPressed)
                  : DailyForecastCalendar(onItemTap: _onForecastItemPressed),
            ),
          ],
        ),
        Positioned(right: 16, top: 16, child: _buildSwitchTabButton()),
      ],
    );
  }

  Widget _buildSwitchTabButton() {
    return IntrinsicWidth(
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(100),
        ),
        child: TabBar(
          indicator: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),
          padding: EdgeInsets.zero,
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: const EdgeInsets.symmetric(horizontal: 16),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
          labelStyle: context.textTheme.labelLarge,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          tabs: const [Tab(text: '15 days', height: 20), Tab(text: '45 days', height: 20)],
          onTap: _onTabBarTap,
        ),
      ),
    );
  }

  Widget _buildBottomSheetHeader(BuildContext context) {
    return BlocSelector<DailyCubit, DailyState, ForecastDay?>(
      builder: (context, selectedDay) {
        final selectedDate = selectedDay?.date ?? DateTime.now().toString();
        final displayDate = selectedDate.reformatDateString(
          newFormat: DateFormatPattern.weekDayAndDate,
        );
        return Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  displayDate ?? '',
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      selector: (state) => state.selectedDay,
    );
  }
}
