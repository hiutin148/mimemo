// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyForecast _$HourlyForecastFromJson(
  Map<String, dynamic> json,
) => HourlyForecast(
  dateTime: json['DateTime'] as String?,
  epochDateTime: (json['EpochDateTime'] as num?)?.toInt(),
  weatherIcon: (json['WeatherIcon'] as num?)?.toInt(),
  iconPhrase: json['IconPhrase'] as String?,
  hasPrecipitation: json['HasPrecipitation'] as bool?,
  precipitationType: json['PrecipitationType'] as String?,
  precipitationIntensity: json['PrecipitationIntensity'] as String?,
  isDaylight: json['IsDaylight'] as bool?,
  temperature:
      json['Temperature'] == null
          ? null
          : UnitValue.fromJson(json['Temperature'] as Map<String, dynamic>),
  realFeelTemperature:
      json['RealFeelTemperature'] == null
          ? null
          : UnitValueWithPhrase.fromJson(
            json['RealFeelTemperature'] as Map<String, dynamic>,
          ),
  realFeelTemperatureShade:
      json['RealFeelTemperatureShade'] == null
          ? null
          : UnitValueWithPhrase.fromJson(
            json['RealFeelTemperatureShade'] as Map<String, dynamic>,
          ),
  wetBulbTemperature:
      json['WetBulbTemperature'] == null
          ? null
          : UnitValue.fromJson(
            json['WetBulbTemperature'] as Map<String, dynamic>,
          ),
  wetBulbGlobeTemperature:
      json['WetBulbGlobeTemperature'] == null
          ? null
          : UnitValue.fromJson(
            json['WetBulbGlobeTemperature'] as Map<String, dynamic>,
          ),
  dewPoint:
      json['DewPoint'] == null
          ? null
          : UnitValue.fromJson(json['DewPoint'] as Map<String, dynamic>),
  wind:
      json['Wind'] == null
          ? null
          : Wind.fromJson(json['Wind'] as Map<String, dynamic>),
  windGust:
      json['WindGust'] == null
          ? null
          : WindGust.fromJson(json['WindGust'] as Map<String, dynamic>),
  relativeHumidity: (json['RelativeHumidity'] as num?)?.toInt(),
  indoorRelativeHumidity: (json['IndoorRelativeHumidity'] as num?)?.toInt(),
  visibility:
      json['Visibility'] == null
          ? null
          : UnitValue.fromJson(json['Visibility'] as Map<String, dynamic>),
  ceiling:
      json['Ceiling'] == null
          ? null
          : UnitValue.fromJson(json['Ceiling'] as Map<String, dynamic>),
  uvIndex: (json['UVIndex'] as num?)?.toInt(),
  uvIndexText: json['UVIndexText'] as String?,
  precipitationProbability: (json['PrecipitationProbability'] as num?)?.toInt(),
  thunderstormProbability: (json['ThunderstormProbability'] as num?)?.toInt(),
  rainProbability: (json['RainProbability'] as num?)?.toInt(),
  snowProbability: (json['SnowProbability'] as num?)?.toInt(),
  iceProbability: (json['IceProbability'] as num?)?.toInt(),
  totalLiquid:
      json['TotalLiquid'] == null
          ? null
          : UnitValue.fromJson(json['TotalLiquid'] as Map<String, dynamic>),
  rain:
      json['Rain'] == null
          ? null
          : UnitValue.fromJson(json['Rain'] as Map<String, dynamic>),
  snow:
      json['Snow'] == null
          ? null
          : UnitValue.fromJson(json['Snow'] as Map<String, dynamic>),
  ice:
      json['Ice'] == null
          ? null
          : UnitValue.fromJson(json['Ice'] as Map<String, dynamic>),
  cloudCover: (json['CloudCover'] as num?)?.toInt(),
  evapotranspiration:
      json['Evapotranspiration'] == null
          ? null
          : UnitValue.fromJson(
            json['Evapotranspiration'] as Map<String, dynamic>,
          ),
  solarIrradiance:
      json['SolarIrradiance'] == null
          ? null
          : UnitValue.fromJson(json['SolarIrradiance'] as Map<String, dynamic>),
  accuLumenBrightnessIndex:
      (json['AccuLumenBrightnessIndex'] as num?)?.toDouble(),
  mobileLink: json['MobileLink'] as String?,
  link: json['Link'] as String?,
);

Map<String, dynamic> _$HourlyForecastToJson(HourlyForecast instance) =>
    <String, dynamic>{
      'DateTime': instance.dateTime,
      'EpochDateTime': instance.epochDateTime,
      'WeatherIcon': instance.weatherIcon,
      'IconPhrase': instance.iconPhrase,
      'HasPrecipitation': instance.hasPrecipitation,
      'PrecipitationType': instance.precipitationType,
      'PrecipitationIntensity': instance.precipitationIntensity,
      'IsDaylight': instance.isDaylight,
      'Temperature': instance.temperature,
      'RealFeelTemperature': instance.realFeelTemperature,
      'RealFeelTemperatureShade': instance.realFeelTemperatureShade,
      'WetBulbTemperature': instance.wetBulbTemperature,
      'WetBulbGlobeTemperature': instance.wetBulbGlobeTemperature,
      'DewPoint': instance.dewPoint,
      'Wind': instance.wind,
      'WindGust': instance.windGust,
      'RelativeHumidity': instance.relativeHumidity,
      'IndoorRelativeHumidity': instance.indoorRelativeHumidity,
      'Visibility': instance.visibility,
      'Ceiling': instance.ceiling,
      'UVIndex': instance.uvIndex,
      'UVIndexText': instance.uvIndexText,
      'PrecipitationProbability': instance.precipitationProbability,
      'ThunderstormProbability': instance.thunderstormProbability,
      'RainProbability': instance.rainProbability,
      'SnowProbability': instance.snowProbability,
      'IceProbability': instance.iceProbability,
      'TotalLiquid': instance.totalLiquid,
      'Rain': instance.rain,
      'Snow': instance.snow,
      'Ice': instance.ice,
      'CloudCover': instance.cloudCover,
      'Evapotranspiration': instance.evapotranspiration,
      'SolarIrradiance': instance.solarIrradiance,
      'AccuLumenBrightnessIndex': instance.accuLumenBrightnessIndex,
      'MobileLink': instance.mobileLink,
      'Link': instance.link,
    };

UnitValue _$UnitValueFromJson(Map<String, dynamic> json) => UnitValue(
  value: (json['value'] as num?)?.toDouble(),
  unit: json['unit'] as String?,
  unitType: (json['unitType'] as num?)?.toInt(),
);

Map<String, dynamic> _$UnitValueToJson(UnitValue instance) => <String, dynamic>{
  'value': instance.value,
  'unit': instance.unit,
  'unitType': instance.unitType,
};

UnitValueWithPhrase _$UnitValueWithPhraseFromJson(Map<String, dynamic> json) =>
    UnitValueWithPhrase(
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      unitType: (json['unitType'] as num?)?.toInt(),
      phrase: json['phrase'] as String?,
    );

Map<String, dynamic> _$UnitValueWithPhraseToJson(
  UnitValueWithPhrase instance,
) => <String, dynamic>{
  'value': instance.value,
  'unit': instance.unit,
  'unitType': instance.unitType,
  'phrase': instance.phrase,
};

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
  speed:
      json['speed'] == null
          ? null
          : UnitValue.fromJson(json['speed'] as Map<String, dynamic>),
  direction:
      json['direction'] == null
          ? null
          : WindDirection.fromJson(json['direction'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
  'speed': instance.speed,
  'direction': instance.direction,
};

WindDirection _$WindDirectionFromJson(Map<String, dynamic> json) =>
    WindDirection(
      degrees: (json['degrees'] as num?)?.toInt(),
      localized: json['localized'] as String?,
      english: json['english'] as String?,
    );

Map<String, dynamic> _$WindDirectionToJson(WindDirection instance) =>
    <String, dynamic>{
      'degrees': instance.degrees,
      'localized': instance.localized,
      'english': instance.english,
    };

WindGust _$WindGustFromJson(Map<String, dynamic> json) => WindGust(
  speed:
      json['speed'] == null
          ? null
          : UnitValue.fromJson(json['speed'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WindGustToJson(WindGust instance) => <String, dynamic>{
  'speed': instance.speed,
};
