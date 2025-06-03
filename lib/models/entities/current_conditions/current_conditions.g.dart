// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_conditions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentConditions _$CurrentConditionsFromJson(
  Map<String, dynamic> json,
) => CurrentConditions(
  localObservationDateTime: json['LocalObservationDateTime'] as String?,
  epochTime: (json['EpochTime'] as num?)?.toInt(),
  weatherText: json['WeatherText'] as String?,
  weatherIcon: (json['WeatherIcon'] as num?)?.toInt(),
  hasPrecipitation: json['HasPrecipitation'] as bool?,
  precipitationType: json['PrecipitationType'] as String?,
  isDayTime: json['IsDayTime'] as bool?,
  temperature:
      json['Temperature'] == null
          ? null
          : Temperature.fromJson(json['Temperature'] as Map<String, dynamic>),
  realFeelTemperature:
      json['RealFeelTemperature'] == null
          ? null
          : RealFeelTemperature.fromJson(
            json['RealFeelTemperature'] as Map<String, dynamic>,
          ),
  realFeelTemperatureShade:
      json['RealFeelTemperatureShade'] == null
          ? null
          : RealFeelTemperature.fromJson(
            json['RealFeelTemperatureShade'] as Map<String, dynamic>,
          ),
  relativeHumidity: (json['RelativeHumidity'] as num?)?.toInt(),
  indoorRelativeHumidity: (json['IndoorRelativeHumidity'] as num?)?.toInt(),
  dewPoint:
      json['DewPoint'] == null
          ? null
          : Temperature.fromJson(json['DewPoint'] as Map<String, dynamic>),
  wind:
      json['Wind'] == null
          ? null
          : Wind.fromJson(json['Wind'] as Map<String, dynamic>),
  windGust:
      json['WindGust'] == null
          ? null
          : WindGust.fromJson(json['WindGust'] as Map<String, dynamic>),
  uvIndex: (json['UVIndex'] as num?)?.toInt(),
  uvIndexText: json['UVIndexText'] as String?,
  visibility:
      json['Visibility'] == null
          ? null
          : Visibility.fromJson(json['Visibility'] as Map<String, dynamic>),
  obstructionsToVisibility: json['ObstructionsToVisibility'] as String?,
  cloudCover: (json['CloudCover'] as num?)?.toInt(),
  ceiling:
      json['Ceiling'] == null
          ? null
          : Ceiling.fromJson(json['Ceiling'] as Map<String, dynamic>),
  pressure:
      json['Pressure'] == null
          ? null
          : Pressure.fromJson(json['Pressure'] as Map<String, dynamic>),
  pressureTendency:
      json['PressureTendency'] == null
          ? null
          : PressureTendency.fromJson(
            json['PressureTendency'] as Map<String, dynamic>,
          ),
  past24HourTemperatureDeparture:
      json['Past24HourTemperatureDeparture'] == null
          ? null
          : Temperature.fromJson(
            json['Past24HourTemperatureDeparture'] as Map<String, dynamic>,
          ),
  apparentTemperature:
      json['ApparentTemperature'] == null
          ? null
          : Temperature.fromJson(
            json['ApparentTemperature'] as Map<String, dynamic>,
          ),
  windChillTemperature:
      json['WindChillTemperature'] == null
          ? null
          : Temperature.fromJson(
            json['WindChillTemperature'] as Map<String, dynamic>,
          ),
  wetBulbTemperature:
      json['WetBulbTemperature'] == null
          ? null
          : Temperature.fromJson(
            json['WetBulbTemperature'] as Map<String, dynamic>,
          ),
  wetBulbGlobeTemperature:
      json['WetBulbGlobeTemperature'] == null
          ? null
          : Temperature.fromJson(
            json['WetBulbGlobeTemperature'] as Map<String, dynamic>,
          ),
  precip1hr:
      json['Precip1hr'] == null
          ? null
          : Precipitation.fromJson(json['Precip1hr'] as Map<String, dynamic>),
  precipitationSummary:
      json['PrecipitationSummary'] == null
          ? null
          : PrecipitationSummary.fromJson(
            json['PrecipitationSummary'] as Map<String, dynamic>,
          ),
  temperatureSummary:
      json['TemperatureSummary'] == null
          ? null
          : TemperatureSummary.fromJson(
            json['TemperatureSummary'] as Map<String, dynamic>,
          ),
  photos:
      (json['Photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e as Map<String, dynamic>))
          .toList(),
  mobileLink: json['MobileLink'] as String?,
  link: json['Link'] as String?,
);

Map<String, dynamic> _$CurrentConditionsToJson(CurrentConditions instance) =>
    <String, dynamic>{
      'LocalObservationDateTime': instance.localObservationDateTime,
      'EpochTime': instance.epochTime,
      'WeatherText': instance.weatherText,
      'WeatherIcon': instance.weatherIcon,
      'HasPrecipitation': instance.hasPrecipitation,
      'PrecipitationType': instance.precipitationType,
      'IsDayTime': instance.isDayTime,
      'Temperature': instance.temperature,
      'RealFeelTemperature': instance.realFeelTemperature,
      'RealFeelTemperatureShade': instance.realFeelTemperatureShade,
      'RelativeHumidity': instance.relativeHumidity,
      'IndoorRelativeHumidity': instance.indoorRelativeHumidity,
      'DewPoint': instance.dewPoint,
      'Wind': instance.wind,
      'WindGust': instance.windGust,
      'UVIndex': instance.uvIndex,
      'UVIndexText': instance.uvIndexText,
      'Visibility': instance.visibility,
      'ObstructionsToVisibility': instance.obstructionsToVisibility,
      'CloudCover': instance.cloudCover,
      'Ceiling': instance.ceiling,
      'Pressure': instance.pressure,
      'PressureTendency': instance.pressureTendency,
      'Past24HourTemperatureDeparture': instance.past24HourTemperatureDeparture,
      'ApparentTemperature': instance.apparentTemperature,
      'WindChillTemperature': instance.windChillTemperature,
      'WetBulbTemperature': instance.wetBulbTemperature,
      'WetBulbGlobeTemperature': instance.wetBulbGlobeTemperature,
      'Precip1hr': instance.precip1hr,
      'PrecipitationSummary': instance.precipitationSummary,
      'TemperatureSummary': instance.temperatureSummary,
      'Photos': instance.photos,
      'MobileLink': instance.mobileLink,
      'Link': instance.link,
    };

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => Temperature(
  metric:
      json['Metric'] == null
          ? null
          : TemperatureUnit.fromJson(json['Metric'] as Map<String, dynamic>),
  imperial:
      json['Imperial'] == null
          ? null
          : TemperatureUnit.fromJson(json['Imperial'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{'Metric': instance.metric, 'Imperial': instance.imperial};

TemperatureUnit _$TemperatureUnitFromJson(Map<String, dynamic> json) =>
    TemperatureUnit(
      value: (json['Value'] as num?)?.toDouble(),
      unit: json['Unit'] as String?,
      unitType: (json['UnitType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TemperatureUnitToJson(TemperatureUnit instance) =>
    <String, dynamic>{
      'Value': instance.value,
      'Unit': instance.unit,
      'UnitType': instance.unitType,
    };

RealFeelTemperature _$RealFeelTemperatureFromJson(Map<String, dynamic> json) =>
    RealFeelTemperature(
      metric:
          json['Metric'] == null
              ? null
              : RealFeelTemperatureUnit.fromJson(
                json['Metric'] as Map<String, dynamic>,
              ),
      imperial:
          json['Imperial'] == null
              ? null
              : RealFeelTemperatureUnit.fromJson(
                json['Imperial'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$RealFeelTemperatureToJson(
  RealFeelTemperature instance,
) => <String, dynamic>{
  'Metric': instance.metric,
  'Imperial': instance.imperial,
};

RealFeelTemperatureUnit _$RealFeelTemperatureUnitFromJson(
  Map<String, dynamic> json,
) => RealFeelTemperatureUnit(
  value: (json['Value'] as num?)?.toDouble(),
  unit: json['Unit'] as String?,
  unitType: (json['UnitType'] as num?)?.toInt(),
  phrase: json['Phrase'] as String?,
);

Map<String, dynamic> _$RealFeelTemperatureUnitToJson(
  RealFeelTemperatureUnit instance,
) => <String, dynamic>{
  'Value': instance.value,
  'Unit': instance.unit,
  'UnitType': instance.unitType,
  'Phrase': instance.phrase,
};

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
  direction:
      json['Direction'] == null
          ? null
          : WindDirection.fromJson(json['Direction'] as Map<String, dynamic>),
  speed:
      json['Speed'] == null
          ? null
          : WindSpeed.fromJson(json['Speed'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
  'Direction': instance.direction,
  'Speed': instance.speed,
};

WindDirection _$WindDirectionFromJson(Map<String, dynamic> json) =>
    WindDirection(
      degrees: (json['Degrees'] as num?)?.toInt(),
      localized: json['Localized'] as String?,
      english: json['English'] as String?,
    );

Map<String, dynamic> _$WindDirectionToJson(WindDirection instance) =>
    <String, dynamic>{
      'Degrees': instance.degrees,
      'Localized': instance.localized,
      'English': instance.english,
    };

WindSpeed _$WindSpeedFromJson(Map<String, dynamic> json) => WindSpeed(
  metric:
      json['Metric'] == null
          ? null
          : SpeedUnit.fromJson(json['Metric'] as Map<String, dynamic>),
  imperial:
      json['Imperial'] == null
          ? null
          : SpeedUnit.fromJson(json['Imperial'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WindSpeedToJson(WindSpeed instance) => <String, dynamic>{
  'Metric': instance.metric,
  'Imperial': instance.imperial,
};

SpeedUnit _$SpeedUnitFromJson(Map<String, dynamic> json) => SpeedUnit(
  value: (json['Value'] as num?)?.toDouble(),
  unit: json['Unit'] as String?,
  unitType: (json['UnitType'] as num?)?.toInt(),
);

Map<String, dynamic> _$SpeedUnitToJson(SpeedUnit instance) => <String, dynamic>{
  'Value': instance.value,
  'Unit': instance.unit,
  'UnitType': instance.unitType,
};

WindGust _$WindGustFromJson(Map<String, dynamic> json) => WindGust(
  speed:
      json['Speed'] == null
          ? null
          : WindSpeed.fromJson(json['Speed'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WindGustToJson(WindGust instance) => <String, dynamic>{
  'Speed': instance.speed,
};

Visibility _$VisibilityFromJson(Map<String, dynamic> json) => Visibility(
  metric:
      json['Metric'] == null
          ? null
          : DistanceUnit.fromJson(json['Metric'] as Map<String, dynamic>),
  imperial:
      json['Imperial'] == null
          ? null
          : DistanceUnit.fromJson(json['Imperial'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VisibilityToJson(Visibility instance) =>
    <String, dynamic>{'Metric': instance.metric, 'Imperial': instance.imperial};

DistanceUnit _$DistanceUnitFromJson(Map<String, dynamic> json) => DistanceUnit(
  value: (json['Value'] as num?)?.toDouble(),
  unit: json['Unit'] as String?,
  unitType: (json['UnitType'] as num?)?.toInt(),
);

Map<String, dynamic> _$DistanceUnitToJson(DistanceUnit instance) =>
    <String, dynamic>{
      'Value': instance.value,
      'Unit': instance.unit,
      'UnitType': instance.unitType,
    };

Ceiling _$CeilingFromJson(Map<String, dynamic> json) => Ceiling(
  metric:
      json['Metric'] == null
          ? null
          : DistanceUnit.fromJson(json['Metric'] as Map<String, dynamic>),
  imperial:
      json['Imperial'] == null
          ? null
          : DistanceUnit.fromJson(json['Imperial'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CeilingToJson(Ceiling instance) => <String, dynamic>{
  'Metric': instance.metric,
  'Imperial': instance.imperial,
};

Pressure _$PressureFromJson(Map<String, dynamic> json) => Pressure(
  metric:
      json['Metric'] == null
          ? null
          : PressureUnit.fromJson(json['Metric'] as Map<String, dynamic>),
  imperial:
      json['Imperial'] == null
          ? null
          : PressureUnit.fromJson(json['Imperial'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PressureToJson(Pressure instance) => <String, dynamic>{
  'Metric': instance.metric,
  'Imperial': instance.imperial,
};

PressureUnit _$PressureUnitFromJson(Map<String, dynamic> json) => PressureUnit(
  value: (json['Value'] as num?)?.toDouble(),
  unit: json['Unit'] as String?,
  unitType: (json['UnitType'] as num?)?.toInt(),
);

Map<String, dynamic> _$PressureUnitToJson(PressureUnit instance) =>
    <String, dynamic>{
      'Value': instance.value,
      'Unit': instance.unit,
      'UnitType': instance.unitType,
    };

PressureTendency _$PressureTendencyFromJson(Map<String, dynamic> json) =>
    PressureTendency(
      localizedText: json['LocalizedText'] as String?,
      code: json['Code'] as String?,
    );

Map<String, dynamic> _$PressureTendencyToJson(PressureTendency instance) =>
    <String, dynamic>{
      'LocalizedText': instance.localizedText,
      'Code': instance.code,
    };

Precipitation _$PrecipitationFromJson(Map<String, dynamic> json) =>
    Precipitation(
      metric:
          json['Metric'] == null
              ? null
              : PrecipitationUnit.fromJson(
                json['Metric'] as Map<String, dynamic>,
              ),
      imperial:
          json['Imperial'] == null
              ? null
              : PrecipitationUnit.fromJson(
                json['Imperial'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$PrecipitationToJson(Precipitation instance) =>
    <String, dynamic>{'Metric': instance.metric, 'Imperial': instance.imperial};

PrecipitationUnit _$PrecipitationUnitFromJson(Map<String, dynamic> json) =>
    PrecipitationUnit(
      value: (json['Value'] as num?)?.toDouble(),
      unit: json['Unit'] as String?,
      unitType: (json['UnitType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PrecipitationUnitToJson(PrecipitationUnit instance) =>
    <String, dynamic>{
      'Value': instance.value,
      'Unit': instance.unit,
      'UnitType': instance.unitType,
    };

PrecipitationSummary _$PrecipitationSummaryFromJson(
  Map<String, dynamic> json,
) => PrecipitationSummary(
  precipitation:
      json['Precipitation'] == null
          ? null
          : Precipitation.fromJson(
            json['Precipitation'] as Map<String, dynamic>,
          ),
  pastHour:
      json['PastHour'] == null
          ? null
          : Precipitation.fromJson(json['PastHour'] as Map<String, dynamic>),
  past3Hours:
      json['Past3Hours'] == null
          ? null
          : Precipitation.fromJson(json['Past3Hours'] as Map<String, dynamic>),
  past6Hours:
      json['Past6Hours'] == null
          ? null
          : Precipitation.fromJson(json['Past6Hours'] as Map<String, dynamic>),
  past9Hours:
      json['Past9Hours'] == null
          ? null
          : Precipitation.fromJson(json['Past9Hours'] as Map<String, dynamic>),
  past12Hours:
      json['Past12Hours'] == null
          ? null
          : Precipitation.fromJson(json['Past12Hours'] as Map<String, dynamic>),
  past18Hours:
      json['Past18Hours'] == null
          ? null
          : Precipitation.fromJson(json['Past18Hours'] as Map<String, dynamic>),
  past24Hours:
      json['Past24Hours'] == null
          ? null
          : Precipitation.fromJson(json['Past24Hours'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PrecipitationSummaryToJson(
  PrecipitationSummary instance,
) => <String, dynamic>{
  'Precipitation': instance.precipitation,
  'PastHour': instance.pastHour,
  'Past3Hours': instance.past3Hours,
  'Past6Hours': instance.past6Hours,
  'Past9Hours': instance.past9Hours,
  'Past12Hours': instance.past12Hours,
  'Past18Hours': instance.past18Hours,
  'Past24Hours': instance.past24Hours,
};

TemperatureSummary _$TemperatureSummaryFromJson(Map<String, dynamic> json) =>
    TemperatureSummary(
      past6HourRange:
          json['Past6HourRange'] == null
              ? null
              : TemperatureRange.fromJson(
                json['Past6HourRange'] as Map<String, dynamic>,
              ),
      past12HourRange:
          json['Past12HourRange'] == null
              ? null
              : TemperatureRange.fromJson(
                json['Past12HourRange'] as Map<String, dynamic>,
              ),
      past24HourRange:
          json['Past24HourRange'] == null
              ? null
              : TemperatureRange.fromJson(
                json['Past24HourRange'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$TemperatureSummaryToJson(TemperatureSummary instance) =>
    <String, dynamic>{
      'Past6HourRange': instance.past6HourRange,
      'Past12HourRange': instance.past12HourRange,
      'Past24HourRange': instance.past24HourRange,
    };

TemperatureRange _$TemperatureRangeFromJson(Map<String, dynamic> json) =>
    TemperatureRange(
      minimum:
          json['Minimum'] == null
              ? null
              : Temperature.fromJson(json['Minimum'] as Map<String, dynamic>),
      maximum:
          json['Maximum'] == null
              ? null
              : Temperature.fromJson(json['Maximum'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TemperatureRangeToJson(TemperatureRange instance) =>
    <String, dynamic>{'Minimum': instance.minimum, 'Maximum': instance.maximum};

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
  dateTaken: json['DateTaken'] as String?,
  source: json['Source'] as String?,
  description: json['Description'] as String?,
  portraitLink: json['PortraitLink'] as String?,
  landscapeLink: json['LandscapeLink'] as String?,
);

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
  'DateTaken': instance.dateTaken,
  'Source': instance.source,
  'Description': instance.description,
  'PortraitLink': instance.portraitLink,
  'LandscapeLink': instance.landscapeLink,
};
