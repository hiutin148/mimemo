// Radar Screen
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RadarPage extends StatelessWidget {
  const RadarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Radar', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF4A90E2),
        elevation: 0,
        leading: Container(),
        actions: [
          IconButton(icon: Icon(Icons.layers, color: Colors.white), onPressed: () {}),
          IconButton(icon: Icon(Icons.play_arrow, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4A90E2), Color(0xFF1E3A8A)],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.radar, size: 64, color: Colors.white.withValues(alpha: 0.6)),
                          Gap( 16),
                          Text(
                            'Weather Radar Map',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap( 8),
                          Text(
                            'New York Metro Area',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Mock radar elements
                    Positioned(
                      top: 100,
                      left: 100,
                      child: Container(
                        width: 60,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      right: 80,
                      child: Container(
                        width: 80,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.yellow.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRadarControl('Satellite', Icons.satellite_alt, false),
                  _buildRadarControl('Precipitation', Icons.grain, true),
                  _buildRadarControl('Temperature', Icons.thermostat, false),
                  _buildRadarControl('Wind', Icons.air, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadarControl(String label, IconData icon, bool isActive) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActive ? Colors.white.withValues(alpha: 0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        Gap( 8),
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
