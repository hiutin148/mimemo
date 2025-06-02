// Daily Screen
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/ui/screens/bottom_nav/bottom_nav_screen.dart';


class DailyPage extends StatelessWidget {
  const DailyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('7-Day Forecast', style: TextStyle(color: Colors.white)),
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
          itemCount: WeatherData.dailyForecast.length,
          itemBuilder: (context, index) {
            final day = WeatherData.dailyForecast[index];
            final dayName = WeatherData.getDayNames()[index];

            return Container(
              margin: EdgeInsets.only(bottom: 12),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          dayName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        WeatherData.getWeatherIcon(day['Day']['Icon']),
                        style: TextStyle(fontSize: 32),
                      ),
                      Gap( 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${day['Temperature']['Maximum']['Value']}°',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${day['Temperature']['Minimum']['Value']}°',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap( 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          day['Day']['IconPhrase'],
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        '${day['Day']['PrecipitationProbability']}% chance of rain',
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
