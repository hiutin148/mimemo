import 'package:json_annotation/json_annotation.dart';

part 'current_conditions.g.dart';

@JsonSerializable()
class CurrentConditions {
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
  final Temperature? temperature;

  @JsonKey(name: 'RealFeelTemperature')
  final RealFeelTemperature? realFeelTemperature;

  @JsonKey(name: 'RealFeelTemperatureShade')
  final RealFeelTemperature? realFeelTemperatureShade;

  @JsonKey(name: 'RelativeHumidity')
  final int? relativeHumidity;

  @JsonKey(name: 'IndoorRelativeHumidity')
  final int? indoorRelativeHumidity;

  @JsonKey(name: 'DewPoint')
  final Temperature? dewPoint;

  @JsonKey(name: 'Wind')
  final Wind? wind;

  @JsonKey(name: 'WindGust')
  final WindGust? windGust;

  @JsonKey(name: 'UVIndex')
  final int? uvIndex;

  @JsonKey(name: 'UVIndexText')
  final String? uvIndexText;

  @JsonKey(name: 'Visibility')
  final Visibility? visibility;

  @JsonKey(name: 'ObstructionsToVisibility')
  final String? obstructionsToVisibility;

  @JsonKey(name: 'CloudCover')
  final int? cloudCover;

  @JsonKey(name: 'Ceiling')
  final Ceiling? ceiling;

  @JsonKey(name: 'Pressure')
  final Pressure? pressure;

  @JsonKey(name: 'PressureTendency')
  final PressureTendency? pressureTendency;

  @JsonKey(name: 'Past24HourTemperatureDeparture')
  final Temperature? past24HourTemperatureDeparture;

  @JsonKey(name: 'ApparentTemperature')
  final Temperature? apparentTemperature;

  @JsonKey(name: 'WindChillTemperature')
  final Temperature? windChillTemperature;

  @JsonKey(name: 'WetBulbTemperature')
  final Temperature? wetBulbTemperature;

  @JsonKey(name: 'WetBulbGlobeTemperature')
  final Temperature? wetBulbGlobeTemperature;

  @JsonKey(name: 'Precip1hr')
  final Precipitation? precip1hr;

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

  Map<String, dynamic> toJson() => _$CurrentConditionsToJson(this);
}

@JsonSerializable()
class Temperature {
  @JsonKey(name: 'Metric')
  final TemperatureUnit? metric;

  @JsonKey(name: 'Imperial')
  final TemperatureUnit? imperial;

  Temperature({
    this.metric,
    this.imperial,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureToJson(this);
}

@JsonSerializable()
class TemperatureUnit {
  @JsonKey(name: 'Value')
  final double? value;

  @JsonKey(name: 'Unit')
  final String? unit;

  @JsonKey(name: 'UnitType')
  final int? unitType;

  TemperatureUnit({
    this.value,
    this.unit,
    this.unitType,
  });

  factory TemperatureUnit.fromJson(Map<String, dynamic> json) =>
      _$TemperatureUnitFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureUnitToJson(this);
}

@JsonSerializable()
class RealFeelTemperature {
  @JsonKey(name: 'Metric')
  final RealFeelTemperatureUnit? metric;

  @JsonKey(name: 'Imperial')
  final RealFeelTemperatureUnit? imperial;

  RealFeelTemperature({
    this.metric,
    this.imperial,
  });

  factory RealFeelTemperature.fromJson(Map<String, dynamic> json) =>
      _$RealFeelTemperatureFromJson(json);

  Map<String, dynamic> toJson() => _$RealFeelTemperatureToJson(this);
}

@JsonSerializable()
class RealFeelTemperatureUnit {
  @JsonKey(name: 'Value')
  final double? value;

  @JsonKey(name: 'Unit')
  final String? unit;

  @JsonKey(name: 'UnitType')
  final int? unitType;

  @JsonKey(name: 'Phrase')
  final String? phrase;

  RealFeelTemperatureUnit({
    this.value,
    this.unit,
    this.unitType,
    this.phrase,
  });

  factory RealFeelTemperatureUnit.fromJson(Map<String, dynamic> json) =>
      _$RealFeelTemperatureUnitFromJson(json);

  Map<String, dynamic> toJson() => _$RealFeelTemperatureUnitToJson(this);
}

@JsonSerializable()
class Wind {
  @JsonKey(name: 'Direction')
  final WindDirection? direction;

  @JsonKey(name: 'Speed')
  final WindSpeed? speed;

  Wind({
    this.direction,
    this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) =>
      _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}

@JsonSerializable()
class WindDirection {
  @JsonKey(name: 'Degrees')
  final int? degrees;

  @JsonKey(name: 'Localized')
  final String? localized;

  @JsonKey(name: 'English')
  final String? english;

  WindDirection({
    this.degrees,
    this.localized,
    this.english,
  });

  factory WindDirection.fromJson(Map<String, dynamic> json) =>
      _$WindDirectionFromJson(json);

  Map<String, dynamic> toJson() => _$WindDirectionToJson(this);
}

@JsonSerializable()
class WindSpeed {
  @JsonKey(name: 'Metric')
  final SpeedUnit? metric;

  @JsonKey(name: 'Imperial')
  final SpeedUnit? imperial;

  WindSpeed({
    this.metric,
    this.imperial,
  });

  factory WindSpeed.fromJson(Map<String, dynamic> json) =>
      _$WindSpeedFromJson(json);

  Map<String, dynamic> toJson() => _$WindSpeedToJson(this);
}

@JsonSerializable()
class SpeedUnit {
  @JsonKey(name: 'Value')
  final double? value;

  @JsonKey(name: 'Unit')
  final String? unit;

  @JsonKey(name: 'UnitType')
  final int? unitType;

  SpeedUnit({
    this.value,
    this.unit,
    this.unitType,
  });

  factory SpeedUnit.fromJson(Map<String, dynamic> json) =>
      _$SpeedUnitFromJson(json);

  Map<String, dynamic> toJson() => _$SpeedUnitToJson(this);
}

@JsonSerializable()
class WindGust {
  @JsonKey(name: 'Speed')
  final WindSpeed? speed;

  WindGust({
    this.speed,
  });

  factory WindGust.fromJson(Map<String, dynamic> json) =>
      _$WindGustFromJson(json);

  Map<String, dynamic> toJson() => _$WindGustToJson(this);
}

@JsonSerializable()
class Visibility {
  @JsonKey(name: 'Metric')
  final DistanceUnit? metric;

  @JsonKey(name: 'Imperial')
  final DistanceUnit? imperial;

  Visibility({
    this.metric,
    this.imperial,
  });

  factory Visibility.fromJson(Map<String, dynamic> json) =>
      _$VisibilityFromJson(json);

  Map<String, dynamic> toJson() => _$VisibilityToJson(this);
}

@JsonSerializable()
class DistanceUnit {
  @JsonKey(name: 'Value')
  final double? value;

  @JsonKey(name: 'Unit')
  final String? unit;

  @JsonKey(name: 'UnitType')
  final int? unitType;

  DistanceUnit({
    this.value,
    this.unit,
    this.unitType,
  });

  factory DistanceUnit.fromJson(Map<String, dynamic> json) =>
      _$DistanceUnitFromJson(json);

  Map<String, dynamic> toJson() => _$DistanceUnitToJson(this);
}

@JsonSerializable()
class Ceiling {
  @JsonKey(name: 'Metric')
  final DistanceUnit? metric;

  @JsonKey(name: 'Imperial')
  final DistanceUnit? imperial;

  Ceiling({
    this.metric,
    this.imperial,
  });

  factory Ceiling.fromJson(Map<String, dynamic> json) =>
      _$CeilingFromJson(json);

  Map<String, dynamic> toJson() => _$CeilingToJson(this);
}

@JsonSerializable()
class Pressure {
  @JsonKey(name: 'Metric')
  final PressureUnit? metric;

  @JsonKey(name: 'Imperial')
  final PressureUnit? imperial;

  Pressure({
    this.metric,
    this.imperial,
  });

  factory Pressure.fromJson(Map<String, dynamic> json) =>
      _$PressureFromJson(json);

  Map<String, dynamic> toJson() => _$PressureToJson(this);
}

@JsonSerializable()
class PressureUnit {
  @JsonKey(name: 'Value')
  final double? value;

  @JsonKey(name: 'Unit')
  final String? unit;

  @JsonKey(name: 'UnitType')
  final int? unitType;

  PressureUnit({
    this.value,
    this.unit,
    this.unitType,
  });

  factory PressureUnit.fromJson(Map<String, dynamic> json) =>
      _$PressureUnitFromJson(json);

  Map<String, dynamic> toJson() => _$PressureUnitToJson(this);
}

@JsonSerializable()
class PressureTendency {
  @JsonKey(name: 'LocalizedText')
  final String? localizedText;

  @JsonKey(name: 'Code')
  final String? code;

  PressureTendency({
    this.localizedText,
    this.code,
  });

  factory PressureTendency.fromJson(Map<String, dynamic> json) =>
      _$PressureTendencyFromJson(json);

  Map<String, dynamic> toJson() => _$PressureTendencyToJson(this);
}

@JsonSerializable()
class Precipitation {
  @JsonKey(name: 'Metric')
  final PrecipitationUnit? metric;

  @JsonKey(name: 'Imperial')
  final PrecipitationUnit? imperial;

  Precipitation({
    this.metric,
    this.imperial,
  });

  factory Precipitation.fromJson(Map<String, dynamic> json) =>
      _$PrecipitationFromJson(json);

  Map<String, dynamic> toJson() => _$PrecipitationToJson(this);
}

@JsonSerializable()
class PrecipitationUnit {
  @JsonKey(name: 'Value')
  final double? value;

  @JsonKey(name: 'Unit')
  final String? unit;

  @JsonKey(name: 'UnitType')
  final int? unitType;

  PrecipitationUnit({
    this.value,
    this.unit,
    this.unitType,
  });

  factory PrecipitationUnit.fromJson(Map<String, dynamic> json) =>
      _$PrecipitationUnitFromJson(json);

  Map<String, dynamic> toJson() => _$PrecipitationUnitToJson(this);
}

@JsonSerializable()
class PrecipitationSummary {
  @JsonKey(name: 'Precipitation')
  final Precipitation? precipitation;

  @JsonKey(name: 'PastHour')
  final Precipitation? pastHour;

  @JsonKey(name: 'Past3Hours')
  final Precipitation? past3Hours;

  @JsonKey(name: 'Past6Hours')
  final Precipitation? past6Hours;

  @JsonKey(name: 'Past9Hours')
  final Precipitation? past9Hours;

  @JsonKey(name: 'Past12Hours')
  final Precipitation? past12Hours;

  @JsonKey(name: 'Past18Hours')
  final Precipitation? past18Hours;

  @JsonKey(name: 'Past24Hours')
  final Precipitation? past24Hours;

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

  Map<String, dynamic> toJson() => _$PrecipitationSummaryToJson(this);
}

@JsonSerializable()
class TemperatureSummary {
  @JsonKey(name: 'Past6HourRange')
  final TemperatureRange? past6HourRange;

  @JsonKey(name: 'Past12HourRange')
  final TemperatureRange? past12HourRange;

  @JsonKey(name: 'Past24HourRange')
  final TemperatureRange? past24HourRange;

  TemperatureSummary({
    this.past6HourRange,
    this.past12HourRange,
    this.past24HourRange,
  });

  factory TemperatureSummary.fromJson(Map<String, dynamic> json) =>
      _$TemperatureSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureSummaryToJson(this);
}

@JsonSerializable()
class TemperatureRange {
  @JsonKey(name: 'Minimum')
  final Temperature? minimum;

  @JsonKey(name: 'Maximum')
  final Temperature? maximum;

  TemperatureRange({
    this.minimum,
    this.maximum,
  });

  factory TemperatureRange.fromJson(Map<String, dynamic> json) =>
      _$TemperatureRangeFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureRangeToJson(this);
}

@JsonSerializable()
class Photo {
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

  Photo({
    this.dateTaken,
    this.source,
    this.description,
    this.portraitLink,
    this.landscapeLink,
  });

  factory Photo.fromJson(Map<String, dynamic> json) =>
      _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
