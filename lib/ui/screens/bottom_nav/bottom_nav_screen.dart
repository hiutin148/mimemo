// bottom_nav_screen.dart
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/main.dart';
import 'package:mimemo/models/enums/load_status.dart';
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
import 'package:mimemo/ui/widgets/error_view.dart';

@RoutePage()
class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen>
    with RouteAware, WidgetsBindingObserver {
  late final DailyCubit _dailyCubit;
  late final MainCubit _mainCubit;
  late final HomeCubit _homeCubit;
  late final HourlyCubit _hourlyCubit;

  DateTime? _lastFetchTime;
  static const _refreshThreshold = Duration(minutes: 15);

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

    _initialLoad();
  }

  Future<void> _initialLoad() async {
    _lastFetchTime = DateTime.now();
    await _mainCubit.init();
    _homeCubit.init();
    _dailyCubit.init();
    _hourlyCubit.init();
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
    _dailyCubit.close();
    _homeCubit.close();
    _hourlyCubit.close();
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _checkAndRefreshData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _checkAndRefreshData();
    }
  }

  void _checkAndRefreshData() {
    if (_lastFetchTime == null ||
        DateTime.now().difference(_lastFetchTime!) > _refreshThreshold) {
      _lastFetchTime = DateTime.now();
      _mainCubit.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
        BlocProvider.value(value: _homeCubit),
        BlocProvider.value(value: _dailyCubit),
        BlocProvider.value(value: _hourlyCubit),
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
      RadarScreen(),
    ];
  }

  Widget _buildBody(MainState state, int bottomNavIndex) {
    if (state.loadStatus == LoadStatus.failure) {
      switch (state.errorType) {
        case MainErrorType.locationPermissionDenied:
          return ErrorView(
            message: state.errorMessage!,
            buttonText: 'Mở Cài Đặt Quyền',
            onAction: Geolocator.openAppSettings,
          );
        case MainErrorType.locationServiceDisabled:
          return ErrorView(
            message: state.errorMessage!,
            buttonText: 'Bật GPS',
            onAction: Geolocator.openLocationSettings,
          );
        case MainErrorType.networkError:
        default:
          return ErrorView(
            message: state.errorMessage ?? 'Lỗi không xác định',
            buttonText: 'Thử lại',
            onAction: () => context.read<MainCubit>().refresh(),
          );
      }
    }

    if (state.loadStatus == LoadStatus.loading && state.positionInfo == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return IndexedStack(
      index: bottomNavIndex,
      children: _screens,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        if (state.positionInfo != null &&
            state.errorType != MainErrorType.none) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Lỗi tải dữ liệu')),
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<BottomNavCubit, int>(
          builder: (context, bottomNavState) {
            final positionInfo = state.positionInfo;
            final position = positionInfo?.localizedName ?? 'Chọn vị trí';
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
                  child: Container(
                    color: AppColors.whiteBorderColor,
                    height: 0.5,
                  ),
                ),
                title: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    context.pushRoute(
                      SearchLocationRoute(homeCubit: context.read<HomeCubit>()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                      const Gap(4),
                      Text(
                        '$position$city',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Gap(4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              drawer: const SizedBox.shrink(),
              body: _buildBody(state, bottomNavState),
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
                  currentIndex: bottomNavState,
                  onTap: (index) =>
                      context.read<BottomNavCubit>().switchTab(index),
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Current',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.schedule),
                      label: 'Hourly',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_today),
                      label: 'Daily',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.radar),
                      label: 'Radar',
                    ),
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
