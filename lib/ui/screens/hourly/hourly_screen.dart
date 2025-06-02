// Hourly Screen
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../bottom_nav/bottom_nav_screen.dart';

class HourlyPage extends StatelessWidget {
  const HourlyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hourly Forecast', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF4A90E2),
        elevation: 0,
        leading: Container(),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF1E3A8A)],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: WeatherData.hourlyForecast.length,
          itemBuilder: (context, index) {
            final hour = WeatherData.hourlyForecast[index];
            final dateTime = DateTime.parse(hour['DateTime']);
            final time = dateTime.hour;
            final displayTime =
                time == 12
                    ? '12 PM'
                    : time > 12
                    ? '${time - 12} PM'
                    : time == 0
                    ? '12 AM'
                    : '$time AM';

            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Text(
                    displayTime,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap( 20),
                  Text(
                    WeatherData.getWeatherIcon(hour['WeatherIcon']),
                    style: TextStyle(fontSize: 28),
                  ),
                  Gap( 20),
                  Expanded(
                    child: Text(
                      hour['IconPhrase'],
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${hour['Temperature']['Value']}°F',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${hour['PrecipitationProbability']}% chance',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
