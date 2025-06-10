import 'package:json_annotation/json_annotation.dart';
import 'package:mimemo/models/entities/temperature/unit_value.dart';
import 'package:mimemo/models/entities/wind/wind.dart';
import 'package:mimemo/models/entities/wind_gust/wind_gust.dart';

part 'hourly_forecast.g.dart';

@JsonSerializable()
class HourlyForecast {

  const HourlyForecast({
    this.dateTime,
    this.epochDateTime,
    this.weatherIcon,
    this.iconPhrase,
    this.hasPrecipitation,
    this.precipitationType,
    this.precipitationIntensity,
    this.isDaylight,
    this.temperature,
    this.realFeelTemperature,
    this.realFeelTemperatureShade,
    this.wetBulbTemperature,
    this.wetBulbGlobeTemperature,
    this.dewPoint,
    this.wind,
    this.windGust,
    this.relativeHumidity,
    this.indoorRelativeHumidity,
    this.visibility,
    this.ceiling,
    this.uvIndex,
    this.uvIndexText,
    this.precipitationProbability,
    this.thunderstormProbability,
    this.rainProbability,
    this.snowProbability,
    this.iceProbability,
    this.totalLiquid,
    this.rain,
    this.snow,
    this.ice,
    this.cloudCover,
    this.evapotranspiration,
    this.solarIrradiance,
    this.accuLumenBrightnessIndex,
    this.mobileLink,
    this.link,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) =>
      _$HourlyForecastFromJson(json);
  @JsonKey(name: 'DateTime')
  final String? dateTime;

  @JsonKey(name: 'EpochDateTime')
  final int? epochDateTime;

  @JsonKey(name: 'WeatherIcon')
  final int? weatherIcon;

  @JsonKey(name: 'IconPhrase')
  final String? iconPhrase;

  @JsonKey(name: 'HasPrecipitation')
  final bool? hasPrecipitation;

  @JsonKey(name: 'PrecipitationType')
  final String? precipitationType;

  @JsonKey(name: 'PrecipitationIntensity')
  final String? precipitationIntensity;

  @JsonKey(name: 'IsDaylight')
  final bool? isDaylight;

  @JsonKey(name: 'Temperature')
  final UnitValueDetail? temperature;

  @JsonKey(name: 'RealFeelTemperature')
  final UnitValueDetail? realFeelTemperature;

  @JsonKey(name: 'RealFeelTemperatureShade')
  final UnitValueDetail? realFeelTemperatureShade;

  @JsonKey(name: 'WetBulbTemperature')
  final UnitValueDetail? wetBulbTemperature;

  @JsonKey(name: 'WetBulbGlobeTemperature')
  final UnitValueDetail? wetBulbGlobeTemperature;

  @JsonKey(name: 'DewPoint')
  final UnitValueDetail? dewPoint;

  @JsonKey(name: 'Wind')
  final Wind? wind;

  @JsonKey(name: 'WindGust')
  final WindGust? windGust;

  @JsonKey(name: 'RelativeHumidity')
  final int? relativeHumidity;

  @JsonKey(name: 'IndoorRelativeHumidity')
  final int? indoorRelativeHumidity;

  @JsonKey(name: 'Visibility')
  final UnitValueDetail? visibility;

  @JsonKey(name: 'Ceiling')
  final UnitValueDetail? ceiling;

  @JsonKey(name: 'UVIndex')
  final int? uvIndex;

  @JsonKey(name: 'UVIndexText')
  final String? uvIndexText;

  @JsonKey(name: 'PrecipitationProbability')
  final int? precipitationProbability;

  @JsonKey(name: 'ThunderstormProbability')
  final int? thunderstormProbability;

  @JsonKey(name: 'RainProbability')
  final int? rainProbability;

  @JsonKey(name: 'SnowProbability')
  final int? snowProbability;

  @JsonKey(name: 'IceProbability')
  final int? iceProbability;

  @JsonKey(name: 'TotalLiquid')
  final UnitValueDetail? totalLiquid;

  @JsonKey(name: 'Rain')
  final UnitValueDetail? rain;

  @JsonKey(name: 'Snow')
  final UnitValueDetail? snow;

  @JsonKey(name: 'Ice')
  final UnitValueDetail? ice;

  @JsonKey(name: 'CloudCover')
  final int? cloudCover;

  @JsonKey(name: 'Evapotranspiration')
  final UnitValueDetail? evapotranspiration;

  @JsonKey(name: 'SolarIrradiance')
  final UnitValueDetail? solarIrradiance;

  @JsonKey(name: 'AccuLumenBrightnessIndex')
  final double? accuLumenBrightnessIndex;

  @JsonKey(name: 'MobileLink')
  final String? mobileLink;

  @JsonKey(name: 'Link')
  final String? link;

  Map<String, dynamic> toJson() => _$HourlyForecastToJson(this);
}
