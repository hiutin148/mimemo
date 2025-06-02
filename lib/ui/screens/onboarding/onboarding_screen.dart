import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/overlay_loading.dart';
import 'package:mimemo/core/extension/context_extension.dart';
import 'package:mimemo/core/extension/text_style_extension.dart';
import 'package:mimemo/generated/l10n.dart';
import 'package:mimemo/locator.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';
import 'package:mimemo/router/app_router.gr.dart';
import 'package:mimemo/ui/screens/onboarding/onboarding_cubit.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => OnboardingCubit(
            appSettingRepository: locator<AppSettingRepository>(),
          ),
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            WelcomeScreen(onNext: () => _nextPage()),
            FeaturesScreen(
              onNext: () => _nextPage(),
              onSkip: () => _skipToPermissions(),
            ),
            LocationPermissionScreen(
              onNext: () => _nextPage(),
              onSkip: () => _nextPage(),
            ),
            NotificationPermissionScreen(
              onNext: () => _nextPage(),
              onSkip: () => _nextPage(),
            ),
            GetStartedScreen(),
          ],
        ),
      ),
    );
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _skipToPermissions() {
    _pageController.animateToPage(
      2,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onNext;

  const WelcomeScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.black],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Gap(60),

              // AccuWeather Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'AccuWeather',
                    style: context.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Spacer(),
              Text(
                S.of(context).welcomeTonaccuweather,
                style: context.textTheme.headlineMedium?.w500.white,
                textAlign: TextAlign.center,
              ),

              Gap(16),

              Text(
                S.of(context).getTheWorldsMostAccuratenweatherForecasts,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 18,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(16),

              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF1E90FF),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    S.of(context).getStarted,
                    style: context.textTheme.bodyLarge?.w700,
                  ),
                ),
              ),

              Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturesScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const FeaturesScreen({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.black.withValues(alpha: 0.5),
            Colors.black,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(),
              // Features list
              Expanded(
                child: Column(
                  children: [
                    _buildFeatureItem(
                      context,
                      Icons.location_on,
                      S.of(context).hyperlocalForecasts,
                      S.of(context).getPreciseWeatherForYourExactLocation,
                      Color(0xFF00CED1),
                    ),
                    Gap(32),
                    _buildFeatureItem(
                      context,

                      Icons.access_time,
                      S.of(context).hourlyDailyForecasts,
                      S.of(context).planAheadWithDetailed15dayForecasts,
                      Color(0xFFFFD700),
                    ),
                    Gap(32),
                    _buildFeatureItem(
                      context,

                      Icons.warning,
                      S.of(context).severeWeatherAlerts,
                      S.of(context).staySafeWithRealtimeWeatherWarnings,
                      Color(0xFFFF6347),
                    ),
                    Gap(32),
                    _buildFeatureItem(
                      context,

                      Icons.radar,
                      S.of(context).interactiveRadar,
                      S.of(context).trackStormsWithOurAdvancedRadarMaps,
                      Color(0xFF32CD32),
                    ),
                  ],
                ),
              ),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF2F1B69),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    S.of(context).continueT,
                    style: context.textTheme.bodyLarge?.w700,
                  ),
                ),
              ),

              Gap(40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color iconColor,
  ) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.textTheme.titleMedium?.white),
              Gap(4),
              Text(description, style: context.textTheme.titleSmall?.white),
            ],
          ),
        ),
      ],
    );
  }
}

class LocationPermissionScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const LocationPermissionScreen({
    super.key,
    required this.onNext,
    required this.onSkip,
  });

  void _requestPermission(BuildContext context) async {
    await OverlayLoading.runWithLoading(
      context,
      () => context.read<MainCubit>().init(),
    );
    onNext.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.black.withValues(alpha: 0.5),
            Colors.black,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Gap(60),

              // Location icon illustration
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.location_on, size: 80, color: Colors.white),
                ),
              ),

              Gap(60),

              Text(
                S.of(context).enableLocationAccess,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              Gap(20),

              Text(
                S
                    .of(context)
                    .allowAccuweatherToAccessYourLocationToProvideHyperlocalWeather,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              Gap(40),

              // Benefits
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildBenefitItem(
                      context,
                      '🎯',
                      S.of(context).preciseLocalForecasts,
                    ),
                    Gap(12),
                    _buildBenefitItem(
                      context,
                      '⚡',
                      S.of(context).realtimeWeatherAlerts,
                    ),
                    Gap(12),
                    _buildBenefitItem(
                      context,
                      '🗺️',
                      S.of(context).interactiveRadarMaps,
                    ),
                  ],
                ),
              ),

              Spacer(),

              // Allow Location Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _requestPermission(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    S.of(context).allowLocationAccess,
                    style: context.textTheme.bodyLarge?.w700,
                  ),
                ),
              ),

              Gap(40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitItem(BuildContext context, String emoji, String text) {
    return Row(
      children: [
        Text(emoji, style: context.textTheme.titleLarge),
        Gap(12),
        Text(text, style: context.textTheme.titleMedium?.white),
      ],
    );
  }
}

class NotificationPermissionScreen extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const NotificationPermissionScreen({
    super.key,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.black54, Colors.black],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Gap(60),

              // Notification bell illustration
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Icon(Icons.notifications, size: 80, color: Colors.white),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              '!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Gap(60),

              Text(
                S.of(context).stayAlertPrepared,
                style: context.textTheme.headlineMedium?.white.w700,
                textAlign: TextAlign.center,
              ),

              Gap(20),

              Text(
                S.of(context).onboarding_notificationMessage,
                style: context.textTheme.titleMedium?.white,
                textAlign: TextAlign.center,
              ),

              Gap(40),

              // Notification types
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildNotificationItem(
                      context,
                      '⚠️',
                      S.of(context).severeWeatherAlerts,
                    ),
                    Gap(12),
                    _buildNotificationItem(
                      context,
                      '🌅',
                      S.of(context).dailyWeatherSummary,
                    ),
                    Gap(12),
                    _buildNotificationItem(
                      context,
                      '🌧️',
                      S.of(context).rainSnowNotifications,
                    ),
                  ],
                ),
              ),

              Spacer(),

              // Enable Notifications Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFFDC143C),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    S.of(context).enableNotifications,
                    style: context.textTheme.bodyLarge?.w700,
                  ),
                ),
              ),

              Gap(40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    String emoji,
    String text,
  ) {
    return Row(
      children: [
        Text(emoji, style: context.textTheme.titleLarge),
        Gap(12),
        Text(text, style: context.textTheme.titleMedium?.white),
      ],
    );
  }
}

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.black54, Colors.black],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Gap(80),

              // Success checkmark
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(Icons.check, size: 80, color: Colors.white),
                ),
              ),
              Gap(60),
              Text(
                S.of(context).youreAllSet,
                style: context.textTheme.headlineLarge?.white.w700,
                textAlign: TextAlign.center,
              ),
              Gap(20),
              Text(
                S.of(context).welcome,
                style: context.textTheme.titleMedium?.white,
                textAlign: TextAlign.center,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<OnboardingCubit>().setIsFirstOpen();
                    context.replaceRoute(BottomNavRoute());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(0xFF006400),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    S.of(context).startUsingApp,
                    style: context.textTheme.bodyLarge?.w700,
                  ),
                ),
              ),
              Gap(40),
            ],
          ),
        ),
      ),
    );
  }
}

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final path = Path();

    // Cloud shape
    path.addOval(Rect.fromCircle(center: Offset(20, 30), radius: 15));
    path.addOval(Rect.fromCircle(center: Offset(35, 25), radius: 20));
    path.addOval(Rect.fromCircle(center: Offset(55, 25), radius: 18));
    path.addOval(Rect.fromCircle(center: Offset(75, 30), radius: 15));
    path.addOval(Rect.fromCircle(center: Offset(45, 40), radius: 25));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
