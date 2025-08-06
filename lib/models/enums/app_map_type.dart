import 'package:mimemo/models/enums/map_type_group.dart';

enum AppMapType {
  radar(MapTypeGroup.radar, 'Radar'),
  // Tropical storms maps
  forecastEyePath(MapTypeGroup.tropical, 'Forecast Eye Path'),
  risk(MapTypeGroup.tropical, 'Risk for Life and Property'),
  rainfallAmounts(MapTypeGroup.tropical, 'Rain Fall Amounts'),
  forecastedMaximumSustainedWinds(
    MapTypeGroup.tropical,
    'Forecasted Maximum Sustained Winds',
  ),
  forecastedMaximumWindGusts(
    MapTypeGroup.tropical,
    'Forecasted Maximum Wind Gusts',
  ),
  stormSurge(MapTypeGroup.tropical, 'Storm Surge'),
  // Satellite view
  clouds(MapTypeGroup.satellite, 'Clouds'),
  colorEnhancedClouds(MapTypeGroup.satellite, 'Color Enhanced Clouds'),
  waterVapor(MapTypeGroup.satellite, 'Water Vapor'),
  // Current conditions
  temperature(MapTypeGroup.currentCondition, 'Temperature'),
  watchesAndWarnings(MapTypeGroup.currentCondition, 'Watches And Warnings'),
  // Forecast maps
  temperatureForecast(MapTypeGroup.forecast, 'Temperature Forecast');

  const AppMapType(this.group, this.title);

  final MapTypeGroup group;
  final String title;
}
