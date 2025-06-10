import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_cubit.dart';
import 'package:mimemo/ui/screens/daily/daily_screen.dart';
import 'package:mimemo/ui/screens/home/home_screen.dart';
import 'package:mimemo/ui/screens/hourly/hourly_screen.dart';
import 'package:mimemo/ui/screens/radar/radar_screen.dart';

@RoutePage()
class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => BottomNavCubit(), child: const BottomNavView());
  }
}

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      const HomeScreen(),
      const HourlyPage(),
      const DailyScreen(),
      const RadarPage(),
      MorePage(),
    ];
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return BlocSelector<MainCubit, MainState, PositionInfo?>(
          builder: (context, positionInfo) {
            final position = positionInfo?.localizedName ?? '';
            final city =
                positionInfo?.parentCity?.localizedName != null
                    ? ', ${positionInfo?.parentCity?.localizedName!}'
                    : '';

            return Scaffold(
              appBar: _buildAppBar(position, city),
              drawer: Container(),
              body: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: context.read<BottomNavCubit>().pageController,
                children: screens,
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
                  selectedItemColor: const Color(0xFF4A90E2),
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Colors.white,
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
          selector: (state) => state.positionInfo,
        );
      },
    );
  }

  AppBar _buildAppBar(String position, String city) {
    return AppBar(
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on, color: Colors.white, size: 20),
          const Gap(4),
          Text(
            '$position$city',
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// Mock API Data Structure
class WeatherData {
  static final Map<String, dynamic> currentConditions = {
    'WeatherText': 'Partly cloudy',
    'WeatherIcon': 3,
    'HasPrecipitation': false,
    'Temperature': {
      'Metric': {'Value': 22.2, 'Unit': 'C'},
      'Imperial': {'Value': 72.0, 'Unit': 'F'},
    },
    'RealFeelTemperature': {
      'Imperial': {'Value': 75.0, 'Unit': 'F'},
    },
    'RelativeHumidity': 65,
    'Wind': {
      'Speed': {
        'Imperial': {'Value': 8.1, 'Unit': 'mi/h'},
      },
    },
    'UVIndex': 6,
    'UVIndexText': 'High',
    'Visibility': {
      'Imperial': {'Value': 10.0, 'Unit': 'mi'},
    },
    'Pressure': {
      'Imperial': {'Value': 30.12, 'Unit': 'inHg'},
    },
    'CloudCover': 45,
  };

  static final List<Map<String, dynamic>> hourlyForecast = [
    {
      'DateTime': '2024-01-15T12:00:00',
      'WeatherIcon': 3,
      'IconPhrase': 'Partly sunny',
      'Temperature': {'Value': 72, 'Unit': 'F'},
      'PrecipitationProbability': 15,
    },
    {
      'DateTime': '2024-01-15T13:00:00',
      'WeatherIcon': 1,
      'IconPhrase': 'Sunny',
      'Temperature': {'Value': 74, 'Unit': 'F'},
      'PrecipitationProbability': 5,
    },
    {
      'DateTime': '2024-01-15T14:00:00',
      'WeatherIcon': 1,
      'IconPhrase': 'Sunny',
      'Temperature': {'Value': 76, 'Unit': 'F'},
      'PrecipitationProbability': 0,
    },
    {
      'DateTime': '2024-01-15T15:00:00',
      'WeatherIcon': 3,
      'IconPhrase': 'Partly sunny',
      'Temperature': {'Value': 75, 'Unit': 'F'},
      'PrecipitationProbability': 10,
    },
    {
      'DateTime': '2024-01-15T16:00:00',
      'WeatherIcon': 7,
      'IconPhrase': 'Cloudy',
      'Temperature': {'Value': 73, 'Unit': 'F'},
      'PrecipitationProbability': 25,
    },
    {
      'DateTime': '2024-01-15T17:00:00',
      'WeatherIcon': 12,
      'IconPhrase': 'Showers',
      'Temperature': {'Value': 71, 'Unit': 'F'},
      'PrecipitationProbability': 60,
    },
    {
      'DateTime': '2024-01-15T18:00:00',
      'WeatherIcon': 18,
      'IconPhrase': 'Rain',
      'Temperature': {'Value': 69, 'Unit': 'F'},
      'PrecipitationProbability': 80,
    },
    {
      'DateTime': '2024-01-15T19:00:00',
      'WeatherIcon': 12,
      'IconPhrase': 'Showers',
      'Temperature': {'Value': 67, 'Unit': 'F'},
      'PrecipitationProbability': 55,
    },
  ];

  static final List<Map<String, dynamic>> dailyForecast = [
    {
      'Date': '2024-01-15',
      'Day': {'Icon': 3, 'IconPhrase': 'Partly sunny', 'PrecipitationProbability': 25},
      'Night': {'Icon': 35, 'IconPhrase': 'Partly cloudy'},
      'Temperature': {
        'Maximum': {'Value': 76},
        'Minimum': {'Value': 62},
      },
    },
    {
      'Date': '2024-01-16',
      'Day': {'Icon': 1, 'IconPhrase': 'Sunny', 'PrecipitationProbability': 5},
      'Night': {'Icon': 33, 'IconPhrase': 'Clear'},
      'Temperature': {
        'Maximum': {'Value': 78},
        'Minimum': {'Value': 64},
      },
    },
    {
      'Date': '2024-01-17',
      'Day': {'Icon': 12, 'IconPhrase': 'Showers', 'PrecipitationProbability': 75},
      'Night': {'Icon': 12, 'IconPhrase': 'Showers'},
      'Temperature': {
        'Maximum': {'Value': 74},
        'Minimum': {'Value': 59},
      },
    },
    {
      'Date': '2024-01-18',
      'Day': {'Icon': 15, 'IconPhrase': 'Thunderstorms', 'PrecipitationProbability': 85},
      'Night': {'Icon': 15, 'IconPhrase': 'Thunderstorms'},
      'Temperature': {
        'Maximum': {'Value': 71},
        'Minimum': {'Value': 56},
      },
    },
    {
      'Date': '2024-01-19',
      'Day': {'Icon': 7, 'IconPhrase': 'Cloudy', 'PrecipitationProbability': 15},
      'Night': {'Icon': 38, 'IconPhrase': 'Mostly cloudy'},
      'Temperature': {
        'Maximum': {'Value': 69},
        'Minimum': {'Value': 54},
      },
    },
    {
      'Date': '2024-01-20',
      'Day': {'Icon': 3, 'IconPhrase': 'Partly sunny', 'PrecipitationProbability': 10},
      'Night': {'Icon': 35, 'IconPhrase': 'Partly cloudy'},
      'Temperature': {
        'Maximum': {'Value': 73},
        'Minimum': {'Value': 58},
      },
    },
    {
      'Date': '2024-01-21',
      'Day': {'Icon': 1, 'IconPhrase': 'Sunny', 'PrecipitationProbability': 0},
      'Night': {'Icon': 33, 'IconPhrase': 'Clear'},
      'Temperature': {
        'Maximum': {'Value': 77},
        'Minimum': {'Value': 61},
      },
    },
  ];

  static String getWeatherIcon(int iconNumber) {
    final icons = <int, String>{
      1: '☀️',
      3: '⛅',
      7: '☁️',
      12: '🌧️',
      15: '⛈️',
      18: '🌧️',
      33: '🌙',
      35: '🌙',
      38: '☁️',
    };
    return icons[iconNumber] ?? '☀️';
  }

  static List<String> getDayNames() {
    return ['Today', 'Tomorrow', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  }
}

// More Screen
class MorePage extends StatelessWidget {
  MorePage({super.key});

  final List<Map<String, dynamic>> menuItems = [
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
        leading: Container(),
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
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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
                    const Gap(8),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withValues(alpha: 0.7),
                      size: 16,
                    ),
                  ],
                ),
                onTap: () {
                  // Handle navigation to specific screens
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening ${item['title']}...'),
                      backgroundColor: const Color(0xFF4A90E2),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
