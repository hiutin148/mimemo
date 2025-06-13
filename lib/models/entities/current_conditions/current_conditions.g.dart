// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_conditions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentConditions _$CurrentConditionsFromJson(Map<String, dynamic> json) =>
    CurrentConditions(
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
              : UnitValue.fromJson(json['Temperature'] as Map<String, dynamic>),
      realFeelTemperature:
          json['RealFeelTemperature'] == null
              ? null
              : UnitValue.fromJson(
                json['RealFeelTemperature'] as Map<String, dynamic>,
              ),
      realFeelTemperatureShade:
          json['RealFeelTemperatureShade'] == null
              ? null
              : UnitValue.fromJson(
                json['RealFeelTemperatureShade'] as Map<String, dynamic>,
              ),
      relativeHumidity: (json['RelativeHumidity'] as num?)?.toInt(),
      indoorRelativeHumidity: (json['IndoorRelativeHumidity'] as num?)?.toInt(),
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
              : Wind.fromJson(json['WindGust'] as Map<String, dynamic>),
      uvIndex: (json['UVIndex'] as num?)?.toInt(),
      uvIndexText: json['UVIndexText'] as String?,
      visibility:
          json['Visibility'] == null
              ? null
              : UnitValue.fromJson(json['Visibility'] as Map<String, dynamic>),
      obstructionsToVisibility: json['ObstructionsToVisibility'] as String?,
      cloudCover: (json['CloudCover'] as num?)?.toInt(),
      ceiling:
          json['Ceiling'] == null
              ? null
              : UnitValue.fromJson(json['Ceiling'] as Map<String, dynamic>),
      pressure:
          json['Pressure'] == null
              ? null
              : UnitValue.fromJson(json['Pressure'] as Map<String, dynamic>),
      pressureTendency:
          json['PressureTendency'] == null
              ? null
              : PressureTendency.fromJson(
                json['PressureTendency'] as Map<String, dynamic>,
              ),
      past24HourTemperatureDeparture:
          json['Past24HourTemperatureDeparture'] == null
              ? null
              : UnitValue.fromJson(
                json['Past24HourTemperatureDeparture'] as Map<String, dynamic>,
              ),
      apparentTemperature:
          json['ApparentTemperature'] == null
              ? null
              : UnitValue.fromJson(
                json['ApparentTemperature'] as Map<String, dynamic>,
              ),
      windChillTemperature:
          json['WindChillTemperature'] == null
              ? null
              : UnitValue.fromJson(
                json['WindChillTemperature'] as Map<String, dynamic>,
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
      precip1hr:
          json['Precip1hr'] == null
              ? null
              : UnitValue.fromJson(json['Precip1hr'] as Map<String, dynamic>),
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

PrecipitationSummary _$PrecipitationSummaryFromJson(
  Map<String, dynamic> json,
) => PrecipitationSummary(
  precipitation:
      json['Precipitation'] == null
          ? null
          : UnitValue.fromJson(json['Precipitation'] as Map<String, dynamic>),
  pastHour:
      json['PastHour'] == null
          ? null
          : UnitValue.fromJson(json['PastHour'] as Map<String, dynamic>),
  past3Hours:
      json['Past3Hours'] == null
          ? null
          : UnitValue.fromJson(json['Past3Hours'] as Map<String, dynamic>),
  past6Hours:
      json['Past6Hours'] == null
          ? null
          : UnitValue.fromJson(json['Past6Hours'] as Map<String, dynamic>),
  past9Hours:
      json['Past9Hours'] == null
          ? null
          : UnitValue.fromJson(json['Past9Hours'] as Map<String, dynamic>),
  past12Hours:
      json['Past12Hours'] == null
          ? null
          : UnitValue.fromJson(json['Past12Hours'] as Map<String, dynamic>),
  past18Hours:
      json['Past18Hours'] == null
          ? null
          : UnitValue.fromJson(json['Past18Hours'] as Map<String, dynamic>),
  past24Hours:
      json['Past24Hours'] == null
          ? null
          : UnitValue.fromJson(json['Past24Hours'] as Map<String, dynamic>),
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
              : UnitValueRange.fromJson(
                json['Past6HourRange'] as Map<String, dynamic>,
              ),
      past12HourRange:
          json['Past12HourRange'] == null
              ? null
              : UnitValueRange.fromJson(
                json['Past12HourRange'] as Map<String, dynamic>,
              ),
      past24HourRange:
          json['Past24HourRange'] == null
              ? null
              : UnitValueRange.fromJson(
                json['Past24HourRange'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$TemperatureSummaryToJson(TemperatureSummary instance) =>
    <String, dynamic>{
      'Past6HourRange': instance.past6HourRange,
      'Past12HourRange': instance.past12HourRange,
      'Past24HourRange': instance.past24HourRange,
    };

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
