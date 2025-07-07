import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/main.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/repositories/current_condition_repository.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/router/app_router.gr.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_cubit.dart';
import 'package:mimemo/ui/screens/daily/daily_cubit.dart';
import 'package:mimemo/ui/screens/daily/daily_screen.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/screens/home/home_screen.dart';
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart';
import 'package:mimemo/ui/screens/hourly/hourly_screen.dart';
import 'package:mimemo/ui/screens/radar/radar_screen.dart';

@RoutePage()
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> with RouteAware, WidgetsBindingObserver {
  late final DailyCubit _dailyCubit;
  late final MainCubit _mainCubit;
  late final HomeCubit _homeCubit;
  late final HourlyCubit _hourlyCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _mainCubit = context.read<MainCubit>();
    _dailyCubit = DailyCubit(
      forecastRepository: locator<ForecastRepository>(),
      mainCubit: _mainCubit,
    );
    _homeCubit = HomeCubit(
      forecastRepository: locator<ForecastRepository>(),
      mainCubit: _mainCubit,
      currentConditionRepository: locator<CurrentConditionRepository>(),
    );
    _hourlyCubit = HourlyCubit(
      dailyCubit: _dailyCubit,
      forecastRepository: locator<ForecastRepository>(),
      mainCubit: _mainCubit,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    refreshData();
    super.didPopNext();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      refreshData();
    }
  }

  Future<void> refreshData() async {
    await OverlayLoading.runWithLoading(
      context,
      () async {
        await _mainCubit.init();
      },
    );
    await Future.wait([
      _homeCubit.init(),
      _dailyCubit.init(),
      _hourlyCubit.init()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider(create: (_) => _homeCubit..init()),
        BlocProvider(create: (_) => _dailyCubit..init()),
        BlocProvider(create: (_) => _hourlyCubit..init()),
      ],
      child: const BottomNavView(),
    );
  }
}

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = const [
      HomeScreen(),
      HourlyScreen(),
      DailyScreen(),
      RadarPage(),
      MorePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      const HomeScreen(),
      const HourlyScreen(),
      const DailyScreen(),
      const RadarScreen(),
      MorePage(),
    ];
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return BlocSelector<MainCubit, MainState, PositionInfo?>(
          selector: (state) => state.positionInfo,
          builder: (context, positionInfo) {
            final position = positionInfo?.localizedName ?? '';
            final city = positionInfo?.parentCity?.localizedName != null
                ? ', ${positionInfo!.parentCity!.localizedName}'
                : '';

            return Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.surface,
                iconTheme: const IconThemeData(color: Colors.white),
                centerTitle: true,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0.5),
                  child: Container(color: AppColors.whiteBorderColor, height: 0.5),
                ),
                title: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    context.pushRoute(SearchLocationRoute(homeCubit: context.read<HomeCubit>()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, color: Colors.white, size: 20),
                      const Gap(4),
                      Text(
                        '$position$city',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              drawer: const SizedBox.shrink(),
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: context.read<BottomNavCubit>().pageController,
                children: _screens,
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: BottomNavigationBar(
                  currentIndex: state,
                  onTap: (index) => context.read<BottomNavCubit>().switchTab(index),
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Current'),
                    BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Hourly'),
                    BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Daily'),
                    BottomNavigationBarItem(icon: Icon(Icons.radar), label: 'Radar'),
                    BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  static const List<Map<String, dynamic>> _menuItems = [
    {
      'title': 'Severe Weather',
      'subtitle': 'Alerts and warnings',
      'icon': Icons.warning,
      'hasAlert': true,
    },
    {
      'title': 'Air Quality',
      'subtitle': 'Current air quality index',
      'icon': Icons.air,
      'hasAlert': false,
    },
    {
      'title': 'Allergy Tracker',
      'subtitle': 'Pollen and allergen levels',
      'icon': Icons.local_florist,
      'hasAlert': false,
    },
    {
      'title': 'Sun & Moon',
      'subtitle': 'Sunrise, sunset, moon phases',
      'icon': Icons.wb_sunny,
      'hasAlert': false,
    },
    {
      'title': 'Weather Maps',
      'subtitle': 'Temperature, precipitation maps',
      'icon': Icons.map,
      'hasAlert': false,
    },
    {
      'title': 'Weather Videos',
      'subtitle': 'Latest weather updates',
      'icon': Icons.play_circle,
      'hasAlert': false,
    },
    {
      'title': 'Historical Weather',
      'subtitle': 'Past weather data',
      'icon': Icons.history,
      'hasAlert': false,
    },
    {'title': 'Settings', 'subtitle': 'App preferences', 'icon': Icons.settings, 'hasAlert': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
        leading: const SizedBox.shrink(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF1E3A8A)],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _menuItems.length,
          itemBuilder: (context, index) => _MenuItemWidget(
            item: _menuItems[index],
            onTap: () => _showItemSnackBar(context, _menuItems[index]['title'].toString()),
          ),
        ),
      ),
    );
  }

  void _showItemSnackBar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $title...'),
        backgroundColor: const Color(0xFF4A90E2),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class _MenuItemWidget extends StatelessWidget {
  const _MenuItemWidget({required this.item, required this.onTap});

  final Map<String, dynamic> item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(item['icon'] as IconData, color: Colors.white, size: 24),
        ),
        title: Text(
          item['title'].toString(),
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          item['subtitle'].toString(),
          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 14),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item['hasAlert'] as bool)
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            if (item['hasAlert'] as bool) const Gap(8),
            Icon(Icons.arrow_forward_ios, color: Colors.white.withValues(alpha: 0.7), size: 16),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
