import 'package:json_annotation/json_annotation.dart';

part 'hourly_forecast.g.dart';

@JsonSerializable()
class HourlyForecast {
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
  final UnitValue? temperature;

  @JsonKey(name: 'RealFeelTemperature')
  final UnitValueWithPhrase? realFeelTemperature;

  @JsonKey(name: 'RealFeelTemperatureShade')
  final UnitValueWithPhrase? realFeelTemperatureShade;

  @JsonKey(name: 'WetBulbTemperature')
  final UnitValue? wetBulbTemperature;

  @JsonKey(name: 'WetBulbGlobeTemperature')
  final UnitValue? wetBulbGlobeTemperature;

  @JsonKey(name: 'DewPoint')
  final UnitValue? dewPoint;

  @JsonKey(name: 'Wind')
  final Wind? wind;

  @JsonKey(name: 'WindGust')
  final WindGust? windGust;

  @JsonKey(name: 'RelativeHumidity')
  final int? relativeHumidity;

  @JsonKey(name: 'IndoorRelativeHumidity')
  final int? indoorRelativeHumidity;

  @JsonKey(name: 'Visibility')
  final UnitValue? visibility;

  @JsonKey(name: 'Ceiling')
  final UnitValue? ceiling;

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
  final UnitValue? totalLiquid;

  @JsonKey(name: 'Rain')
  final UnitValue? rain;

  @JsonKey(name: 'Snow')
  final UnitValue? snow;

  @JsonKey(name: 'Ice')
  final UnitValue? ice;

  @JsonKey(name: 'CloudCover')
  final int? cloudCover;

  @JsonKey(name: 'Evapotranspiration')
  final UnitValue? evapotranspiration;

  @JsonKey(name: 'SolarIrradiance')
  final UnitValue? solarIrradiance;

  @JsonKey(name: 'AccuLumenBrightnessIndex')
  final double? accuLumenBrightnessIndex;

  @JsonKey(name: 'MobileLink')
  final String? mobileLink;

  @JsonKey(name: 'Link')
  final String? link;

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

  Map<String, dynamic> toJson() => _$HourlyForecastToJson(this);
}

@JsonSerializable()
class UnitValue {
  @JsonKey(name: 'Value')
  final double? value;

  @JsonKey(name: 'Unit')
  final String? unit;

  @JsonKey(name: 'UnitType')
  final int? unitType;

  const UnitValue({this.value, this.unit, this.unitType});

  factory UnitValue.fromJson(Map<String, dynamic> json) =>
      _$UnitValueFromJson(json);

  Map<String, dynamic> toJson() => _$UnitValueToJson(this);
}

@JsonSerializable()
class UnitValueWithPhrase extends UnitValue {
  final String? phrase;

  const UnitValueWithPhrase({
    super.value,
    super.unit,
    super.unitType,
    this.phrase,
  });

  factory UnitValueWithPhrase.fromJson(Map<String, dynamic> json) =>
      _$UnitValueWithPhraseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UnitValueWithPhraseToJson(this);
}

@JsonSerializable()
class Wind {
  final UnitValue? speed;
  final WindDirection? direction;

  const Wind({this.speed, this.direction});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class WindDirection {
  final int? degrees;
  final String? localized;
  final String? english;

  const WindDirection({this.degrees, this.localized, this.english});

  factory WindDirection.fromJson(Map<String, dynamic> json) =>
      _$WindDirectionFromJson(json);

  Map<String, dynamic> toJson() => _$WindDirectionToJson(this);
}

@JsonSerializable()
class WindGust {
  final UnitValue? speed;

  const WindGust({this.speed});

  factory WindGust.fromJson(Map<String, dynamic> json) =>
      _$WindGustFromJson(json);

  Map<String, dynamic> toJson() => _$WindGustToJson(this);
}
