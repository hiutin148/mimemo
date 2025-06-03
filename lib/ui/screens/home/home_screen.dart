import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/rain_condition.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_screen.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  @override
  Widget build(BuildContext context) {
    // final current = WeatherData.currentConditions;
    // final temp = current['Temperature']['Imperial']['Value'].toInt();

    return BlocSelector<MainCubit, MainState, PositionInfo?>(
      builder: (context, positionInfo) {
        final position = positionInfo?.localizedName ?? '';
        final city =
            positionInfo?.parentCity?.localizedName != null
                ? (', ${positionInfo?.parentCity?.localizedName!}')
                : '';
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF4A90E2),
            iconTheme: IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on, color: Colors.white, size: 20),
                Gap(4),
                Text(
                  '$position$city',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          drawer: Container(),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF4A90E2), Color(0xFF7BB3F0), Color(0xFFA8D0F5)],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: RainConditionChart(
                          value: 50,
                          minValue: 0,
                          maxValue: 100,
                          centerText: '${50}°',
                          subtitle: 'Temperature',
                          colors: [
                            Colors.red,
                            Colors.orange,
                            Colors.yellow,
                            Colors.green,
                            Colors.blue,
                          ],
                          strokeWidth: 4.0,
                          size: 250.0,
                        ),
                      ),
                      _buildCurrentWeather(),
                      Gap(30),
                      _buildHourlyPreview(),
                      Gap(30),
                      _buildWeatherDetails(),
                      Gap(30),
                      _buildDailyPreview(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      selector: (state) => state.positionInfo,
    );
  }

  Widget _buildCurrentWeather() {
    final current = WeatherData.currentConditions;
    final temp = current['Temperature']['Imperial']['Value'].toInt();
    final feelsLike = current['RealFeelTemperature']['Imperial']['Value'].toInt();

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(WeatherData.getWeatherIcon(current['WeatherIcon']), style: TextStyle(fontSize: 80)),
          Gap(16),
          Text(
            '$temp°',
            style: TextStyle(color: Colors.white, fontSize: 72, fontWeight: FontWeight.w300),
          ),
          Text(
            current['WeatherText'],
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w400),
          ),
          Gap(8),
          Text(
            'Feels like $feelsLike°',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildHourlyPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hourly Forecast',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap:
                  () => Navigator.of(
                    context,
                  ).pushReplacement(MaterialPageRoute(builder: (_) => BottomNavScreen())),
              child: Text(
                'View All',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
              ),
            ),
          ],
        ),
        Gap(16),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              final hour = WeatherData.hourlyForecast[index];
              final time = DateTime.parse(hour['DateTime']).hour;
              final displayTime =
                  time == 12
                      ? '12 PM'
                      : time > 12
                      ? '${time - 12} PM'
                      : time == 0
                      ? '12 AM'
                      : '$time AM';

              return Container(
                width: 80,
                margin: EdgeInsets.only(right: 12),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      displayTime,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      WeatherData.getWeatherIcon(hour['WeatherIcon']),
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      '${hour['Temperature']['Value']}°',
                      style: TextStyle(
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
  }

  Widget _buildWeatherDetails() {
    final current = WeatherData.currentConditions;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weather Details',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Gap(16),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Humidity',
                  '${current['RelativeHumidity']}%',
                  Icons.water_drop,
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  'Wind Speed',
                  '${current['Wind']['Speed']['Imperial']['Value']} mph',
                  Icons.air,
                ),
              ),
            ],
          ),
          Gap(16),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'UV Index',
                  '${current['UVIndex']} (${current['UVIndexText']})',
                  Icons.wb_sunny,
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  'Visibility',
                  '${current['Visibility']['Imperial']['Value']} mi',
                  Icons.visibility,
                ),
              ),
            ],
          ),
          Gap(16),
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  'Pressure',
                  '${current['Pressure']['Imperial']['Value']} inHg',
                  Icons.speed,
                ),
              ),
              Expanded(
                child: _buildDetailItem('Cloud Cover', '${current['CloudCover']}%', Icons.cloud),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.7), size: 20),
        Gap(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyPreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '7-Day Forecast',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              'View All',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14),
            ),
          ],
        ),
        Gap(16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children:
                WeatherData.dailyForecast.take(3).map((day) {
                  final index = WeatherData.dailyForecast.indexOf(day);
                  final dayName = WeatherData.getDayNames()[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            dayName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          WeatherData.getWeatherIcon(day['Day']['Icon']),
                          style: TextStyle(fontSize: 24),
                        ),
                        Gap(16),
                        Expanded(
                          flex: 2,
                          child: Text(
                            day['Day']['IconPhrase'],
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          '${day['Temperature']['Minimum']['Value']}°',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 16,
                          ),
                        ),
                        Gap(16),
                        Text(
                          '${day['Temperature']['Maximum']['Value']}°',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
