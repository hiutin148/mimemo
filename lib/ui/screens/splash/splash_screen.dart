import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';
import 'package:mimemo/router/app_router.gr.dart';
import 'package:mimemo/ui/screens/splash/splash_cubit.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => SplashCubit(
            appSettingRepository: locator<AppSettingRepository>(),
            mainCubit: context.read<MainCubit>(),
          )..init(),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, bool?>(
      listener: (BuildContext context, bool? state) {
        if (state ?? false) {
          context.replaceRoute(const OnboardingRoute());
        } else if (state == false) {
          context.replaceRoute(const BottomNavRoute());
        }
      },
      child: const Scaffold(body: Center(child: Text('SPLASH'))),
    );
  }
}
