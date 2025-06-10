import 'package:json_annotation/json_annotation.dart';
import 'package:mimemo/models/entities/temperature/unit_value.dart';
import 'package:mimemo/models/entities/unit_value_range/unit_value_range.dart';
import 'package:mimemo/models/entities/wind/wind.dart';
import 'package:mimemo/models/entities/wind_gust/wind_gust.dart';

part 'current_conditions.g.dart';

@JsonSerializable()
class CurrentConditions {

  CurrentConditions({
    this.localObservationDateTime,
    this.epochTime,
    this.weatherText,
    this.weatherIcon,
    this.hasPrecipitation,
    this.precipitationType,
    this.isDayTime,
    this.temperature,
    this.realFeelTemperature,
    this.realFeelTemperatureShade,
    this.relativeHumidity,
    this.indoorRelativeHumidity,
    this.dewPoint,
    this.wind,
    this.windGust,
    this.uvIndex,
    this.uvIndexText,
    this.visibility,
    this.obstructionsToVisibility,
    this.cloudCover,
    this.ceiling,
    this.pressure,
    this.pressureTendency,
    this.past24HourTemperatureDeparture,
    this.apparentTemperature,
    this.windChillTemperature,
    this.wetBulbTemperature,
    this.wetBulbGlobeTemperature,
    this.precip1hr,
    this.precipitationSummary,
    this.temperatureSummary,
    this.photos,
    this.mobileLink,
    this.link,
  });

  factory CurrentConditions.fromJson(Map<String, dynamic> json) =>
      _$CurrentConditionsFromJson(json);
  @JsonKey(name: 'LocalObservationDateTime')
  final String? localObservationDateTime;

  @JsonKey(name: 'EpochTime')
  final int? epochTime;

  @JsonKey(name: 'WeatherText')
  final String? weatherText;

  @JsonKey(name: 'WeatherIcon')
  final int? weatherIcon;

  @JsonKey(name: 'HasPrecipitation')
  final bool? hasPrecipitation;

  @JsonKey(name: 'PrecipitationType')
  final String? precipitationType;

  @JsonKey(name: 'IsDayTime')
  final bool? isDayTime;

  @JsonKey(name: 'Temperature')
  final UnitValue? temperature;

  @JsonKey(name: 'RealFeelTemperature')
  final UnitValue? realFeelTemperature;

  @JsonKey(name: 'RealFeelTemperatureShade')
  final UnitValue? realFeelTemperatureShade;

  @JsonKey(name: 'RelativeHumidity')
  final int? relativeHumidity;

  @JsonKey(name: 'IndoorRelativeHumidity')
  final int? indoorRelativeHumidity;

  @JsonKey(name: 'DewPoint')
  final UnitValue? dewPoint;

  @JsonKey(name: 'Wind')
  final Wind? wind;

  @JsonKey(name: 'WindGust')
  final WindGust? windGust;

  @JsonKey(name: 'UVIndex')
  final int? uvIndex;

  @JsonKey(name: 'UVIndexText')
  final String? uvIndexText;

  @JsonKey(name: 'Visibility')
  final UnitValue? visibility;

  @JsonKey(name: 'ObstructionsToVisibility')
  final String? obstructionsToVisibility;

  @JsonKey(name: 'CloudCover')
  final int? cloudCover;

  @JsonKey(name: 'Ceiling')
  final UnitValue? ceiling;

  @JsonKey(name: 'Pressure')
  final UnitValue? pressure;

  @JsonKey(name: 'PressureTendency')
  final PressureTendency? pressureTendency;

  @JsonKey(name: 'Past24HourTemperatureDeparture')
  final UnitValue? past24HourTemperatureDeparture;

  @JsonKey(name: 'ApparentTemperature')
  final UnitValue? apparentTemperature;

  @JsonKey(name: 'WindChillTemperature')
  final UnitValue? windChillTemperature;

  @JsonKey(name: 'WetBulbTemperature')
  final UnitValue? wetBulbTemperature;

  @JsonKey(name: 'WetBulbGlobeTemperature')
  final UnitValue? wetBulbGlobeTemperature;

  @JsonKey(name: 'Precip1hr')
  final UnitValue? precip1hr;

  @JsonKey(name: 'PrecipitationSummary')
  final PrecipitationSummary? precipitationSummary;

  @JsonKey(name: 'TemperatureSummary')
  final TemperatureSummary? temperatureSummary;

  @JsonKey(name: 'Photos')
  final List<Photo>? photos;

  @JsonKey(name: 'MobileLink')
  final String? mobileLink;

  @JsonKey(name: 'Link')
  final String? link;

  Map<String, dynamic> toJson() => _$CurrentConditionsToJson(this);
}

@JsonSerializable()
class PressureTendency {

  PressureTendency({this.localizedText, this.code});

  factory PressureTendency.fromJson(Map<String, dynamic> json) => _$PressureTendencyFromJson(json);
  @JsonKey(name: 'LocalizedText')
  final String? localizedText;

  @JsonKey(name: 'Code')
  final String? code;

  Map<String, dynamic> toJson() => _$PressureTendencyToJson(this);
}

@JsonSerializable()
class PrecipitationSummary {

  PrecipitationSummary({
    this.precipitation,
    this.pastHour,
    this.past3Hours,
    this.past6Hours,
    this.past9Hours,
    this.past12Hours,
    this.past18Hours,
    this.past24Hours,
  });

  factory PrecipitationSummary.fromJson(Map<String, dynamic> json) =>
      _$PrecipitationSummaryFromJson(json);
  @JsonKey(name: 'Precipitation')
  final UnitValue? precipitation;

  @JsonKey(name: 'PastHour')
  final UnitValue? pastHour;

  @JsonKey(name: 'Past3Hours')
  final UnitValue? past3Hours;

  @JsonKey(name: 'Past6Hours')
  final UnitValue? past6Hours;

  @JsonKey(name: 'Past9Hours')
  final UnitValue? past9Hours;

  @JsonKey(name: 'Past12Hours')
  final UnitValue? past12Hours;

  @JsonKey(name: 'Past18Hours')
  final UnitValue? past18Hours;

  @JsonKey(name: 'Past24Hours')
  final UnitValue? past24Hours;

  Map<String, dynamic> toJson() => _$PrecipitationSummaryToJson(this);
}

@JsonSerializable()
class TemperatureSummary {

  TemperatureSummary({this.past6HourRange, this.past12HourRange, this.past24HourRange});

  factory TemperatureSummary.fromJson(Map<String, dynamic> json) =>
      _$TemperatureSummaryFromJson(json);
  @JsonKey(name: 'Past6HourRange')
  final UnitValueRange? past6HourRange;

  @JsonKey(name: 'Past12HourRange')
  final UnitValueRange? past12HourRange;

  @JsonKey(name: 'Past24HourRange')
  final UnitValueRange? past24HourRange;

  Map<String, dynamic> toJson() => _$TemperatureSummaryToJson(this);
}

@JsonSerializable()
class Photo {

  Photo({this.dateTaken, this.source, this.description, this.portraitLink, this.landscapeLink});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  @JsonKey(name: 'DateTaken')
  final String? dateTaken;

  @JsonKey(name: 'Source')
  final String? source;

  @JsonKey(name: 'Description')
  final String? description;

  @JsonKey(name: 'PortraitLink')
  final String? portraitLink;

  @JsonKey(name: 'LandscapeLink')
  final String? landscapeLink;

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
