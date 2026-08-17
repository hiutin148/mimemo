import 'package:mimemo/core/const/config.dart';

class ApiClientEndpoints {
  // ----- Radar -----
  static const String radarEndpoint =
      '${Config.apiUrl}/maps/v1/radar/futureSIR/zxy/{dateTime}/{z}/{x}/{y}.png'
      '?colortable=off&display_mode=&display_products=&apikey=${Config.apiKey}';

  // ----- Satellite -----
  static const String cloudSatelliteEndpoint =
      '${Config.apiUrl}/maps/v1/satellite/globalColor/zxy/{dateTime}/{z}/{x}/{y}.png'
      '?display_mode=10&display_products=&apikey=${Config.apiKey}';

  static const String waterVaporEndpoint =
      '${Config.apiUrl}/maps/v1/satellite/globalWV/zxy/{dateTime}/{z}/{x}/{y}.png'
      '?display_mode=10&display_products=&apikey=${Config.apiKey}';

  // ----- Models -----
  static const String currentTemperatureEndpoint =
      '${Config.apiUrl}/maps/v1/models/gfs/zxy/{dateTime}/{z}/{x}/{y}.png'
      '?colortable=off&display_mode=&display_products=26-1010&apikey=${Config.apiKey}';

  // ----- Tropical / Hurricane -----
  static const String riskTropicalEndpoint =
      '${Config.apiUrl}/maps/v1/tropical/hurricane/zxy/{z}/{x}/{y}.png'
      '?categories=RISK_TO_LIFE_PROPERTY&apikey=${Config.apiKey}';

  static const String rainFallAmountsEndpoint =
      '${Config.apiUrl}/maps/v1/tropical/hurricane/zxy/{z}/{x}/{y}.png'
      '?categories=RAINFALL&apikey=${Config.apiKey}';

  static const String maximumSustainedWindsEndpoint =
      '${Config.apiUrl}/maps/v1/tropical/hurricane/zxy/{z}/{x}/{y}.png'
      '?categories=MAXIMUM_SUSTAINED_WINDS&apikey=${Config.apiKey}';

  static const String maximumWindGustsEndpoint =
      '${Config.apiUrl}/maps/v1/tropical/hurricane/zxy/{z}/{x}/{y}.png'
      '?categories=MAXIMUM_WIND_GUSTS&apikey=${Config.apiKey}';

  static const String stormSurgeEndpoint =
      '${Config.apiUrl}/maps/v1/tropical/hurricane/zxy/{z}/{x}/{y}.png'
      '?categories=STORM_SURGE&apikey=${Config.apiKey}';

  // ----- Alerts -----
  static const String watchesAndWarningsEndpoint =
      '${Config.apiUrl}/maps/v1/alerts/globalWarnings/zxy/{z}/{x}/{y}.png'
      '?borders=false&apikey=${Config.apiKey}';
}

extension RadarEndpointExt on String {
  String withDateTime(String dateTime) {
    return replaceAll('{dateTime}', dateTime);
  }
}