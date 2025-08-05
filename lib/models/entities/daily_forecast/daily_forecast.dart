import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mimemo/models/entities/temperature/unit_value.dart';
import 'package:mimemo/models/entities/unit_value_detail_range/unit_value_detail_range.dart';
import 'package:mimemo/models/entities/unit_value_range/unit_value_range.dart';
import 'package:mimemo/models/entities/wind/wind.dart';

part 'daily_forecast.g.dart';

@JsonSerializable()
class DailyForecast extends Equatable {
  const DailyForecast({this.headline, this.dailyForecasts});

  factory DailyForecast.fromJson(Map<String, dynamic> json) => _$DailyForecastFromJson(json);
  @JsonKey(name: 'Headline')
  final Headline? headline;

  @JsonKey(name: 'DailyForecasts')
  final List<ForecastDay>? dailyForecasts;

  Map<String, dynamic> toJson() => _$DailyForecastToJson(this);

  @override
  List<Object?> get props => [headline, dailyForecasts];
}

@JsonSerializable()
class Headline extends Equatable {
  const Headline({
    this.effectiveDate,
    this.effectiveEpochDate,
    this.severity,
    this.text,
    this.category,
    this.endDate,
    this.endEpochDate,
    this.mobileLink,
    this.link,
  });

  factory Headline.fromJson(Map<String, dynamic> json) => _$HeadlineFromJson(json);
  @JsonKey(name: 'EffectiveDate')
  final String? effectiveDate;

  @JsonKey(name: 'EffectiveEpochDate')
  final int? effectiveEpochDate;

  @JsonKey(name: 'Severity')
  final int? severity;

  @JsonKey(name: 'Text')
  final String? text;

  @JsonKey(name: 'Category')
  final String? category;

  @JsonKey(name: 'EndDate')
  final String? endDate;

  @JsonKey(name: 'EndEpochDate')
  final int? endEpochDate;

  @JsonKey(name: 'MobileLink')
  final String? mobileLink;

  @JsonKey(name: 'Link')
  final String? link;

  Map<String, dynamic> toJson() => _$HeadlineToJson(this);

  @override
  List<Object?> get props => [
    effectiveDate,
    effectiveEpochDate,
    severity,
    text,
    category,
    endDate,
    endEpochDate,
    mobileLink,
    link,
  ];
}

@JsonSerializable()
class ForecastDay extends Equatable {
  const ForecastDay({
    this.date,
    this.epochDate,
    this.sun,
    this.moon,
    this.temperature,
    this.realFeelTemperature,
    this.realFeelTemperatureShade,
    this.hoursOfSun,
    this.degreeDaySummary,
    this.airAndPollen,
    this.day,
    this.night,
    this.sources,
    this.mobileLink,
    this.link,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => _$ForecastDayFromJson(json);
  @JsonKey(name: 'Date')
  final String? date;

  @JsonKey(name: 'EpochDate')
  final int? epochDate;

  @JsonKey(name: 'Sun')
  final RiseSet? sun;

  @JsonKey(name: 'Moon')
  final Moon? moon;

  @JsonKey(name: 'Temperature')
  final UnitValueDetailRange? temperature;

  @JsonKey(name: 'RealFeelTemperature')
  final UnitValueDetailRange? realFeelTemperature;

  @JsonKey(name: 'RealFeelTemperatureShade')
  final UnitValueDetailRange? realFeelTemperatureShade;

  @JsonKey(name: 'HoursOfSun')
  final double? hoursOfSun;

  @JsonKey(name: 'DegreeDaySummary')
  final DegreeDaySummary? degreeDaySummary;

  @JsonKey(name: 'AirAndPollen')
  final List<AirAndPollen>? airAndPollen;

  @JsonKey(name: 'Day')
  final DayNight? day;

  @JsonKey(name: 'Night')
  final DayNight? night;

  @JsonKey(name: 'Sources')
  final List<String>? sources;

  @JsonKey(name: 'MobileLink')
  final String? mobileLink;

  @JsonKey(name: 'Link')
  final String? link;

  Map<String, dynamic> toJson() => _$ForecastDayToJson(this);

  @override
  List<Object?> get props => [
    date,
    epochDate,
    sun,
    moon,
    temperature,
    realFeelTemperature,
    realFeelTemperatureShade,
    hoursOfSun,
    degreeDaySummary,
    airAndPollen,
    day,
    night,
    sources,
    mobileLink,
    link,
  ];
}

@JsonSerializable()
class RiseSet extends Equatable {
  const RiseSet({this.rise, this.epochRise, this.set, this.epochSet});

  factory RiseSet.fromJson(Map<String, dynamic> json) => _$RiseSetFromJson(json);
  @JsonKey(name: 'Rise')
  final String? rise;

  @JsonKey(name: 'EpochRise')
  final int? epochRise;

  @JsonKey(name: 'Set')
  final String? set;

  @JsonKey(name: 'EpochSet')
  final int? epochSet;

  Map<String, dynamic> toJson() => _$RiseSetToJson(this);

  @override
  List<Object?> get props => [rise, epochRise, set, epochSet];
}

@JsonSerializable()
class Moon extends RiseSet {
  const Moon({super.rise, super.epochRise, super.set, super.epochSet, this.phase, this.age});

  factory Moon.fromJson(Map<String, dynamic> json) => _$MoonFromJson(json);
  @JsonKey(name: 'Phase')
  final String? phase;

  @JsonKey(name: 'Age')
  final int? age;

  @override
  Map<String, dynamic> toJson() => _$MoonToJson(this);

  @override
  List<Object?> get props => [rise, epochRise, set, epochSet, phase, age];
}

@JsonSerializable()
class DegreeDaySummary extends Equatable {
  const DegreeDaySummary({this.heating, this.cooling});

  factory DegreeDaySummary.fromJson(Map<String, dynamic> json) => _$DegreeDaySummaryFromJson(json);
  @JsonKey(name: 'Heating')
  final UnitValue? heating;

  @JsonKey(name: 'Cooling')
  final UnitValue? cooling;

  Map<String, dynamic> toJson() => _$DegreeDaySummaryToJson(this);

  @override
  List<Object?> get props => [heating, cooling];
}

@JsonSerializable()
class AirAndPollen extends Equatable {
  const AirAndPollen({this.name, this.value, this.category, this.categoryValue, this.type});

  factory AirAndPollen.fromJson(Map<String, dynamic> json) => _$AirAndPollenFromJson(json);
  @JsonKey(name: 'Name')
  final String? name;

  @JsonKey(name: 'Value')
  final int? value;

  @JsonKey(name: 'Category')
  final String? category;

  @JsonKey(name: 'CategoryValue')
  final int? categoryValue;

  @JsonKey(name: 'Type')
  final String? type;

  Map<String, dynamic> toJson() => _$AirAndPollenToJson(this);

  @override
  List<Object?> get props => [name, value, category, categoryValue, type];
}

@JsonSerializable()
class DayNight extends Equatable {
  const DayNight({
    this.icon,
    this.iconPhrase,
    this.hasPrecipitation,
    this.precipitationType,
    this.precipitationIntensity,
    this.shortPhrase,
    this.longPhrase,
    this.precipitationProbability,
    this.thunderstormProbability,
    this.rainProbability,
    this.snowProbability,
    this.iceProbability,
    this.wind,
    this.windGust,
    this.totalLiquid,
    this.rain,
    this.snow,
    this.ice,
    this.hoursOfPrecipitation,
    this.hoursOfRain,
    this.hoursOfSnow,
    this.hoursOfIce,
    this.cloudCover,
    this.evapotranspiration,
    this.solarIrradiance,
    this.relativeHumidity,
    this.wetBulbTemperature,
    this.wetBulbGlobeTemperature,
  });

  factory DayNight.fromJson(Map<String, dynamic> json) => _$DayNightFromJson(json);
  @JsonKey(name: 'Icon')
  final int? icon;

  @JsonKey(name: 'IconPhrase')
  final String? iconPhrase;

  @JsonKey(name: 'HasPrecipitation')
  final bool? hasPrecipitation;

  @JsonKey(name: 'PrecipitationType')
  final String? precipitationType;

  @JsonKey(name: 'PrecipitationIntensity')
  final String? precipitationIntensity;

  @JsonKey(name: 'ShortPhrase')
  final String? shortPhrase;

  @JsonKey(name: 'LongPhrase')
  final String? longPhrase;

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

  @JsonKey(name: 'Wind')
  final WindDetail? wind;

  @JsonKey(name: 'WindGust')
  final WindDetail? windGust;

  @JsonKey(name: 'TotalLiquid')
  final UnitValue? totalLiquid;

  @JsonKey(name: 'Rain')
  final UnitValue? rain;

  @JsonKey(name: 'Snow')
  final UnitValue? snow;

  @JsonKey(name: 'Ice')
  final UnitValue? ice;

  @JsonKey(name: 'HoursOfPrecipitation')
  final double? hoursOfPrecipitation;

  @JsonKey(name: 'HoursOfRain')
  final double? hoursOfRain;

  @JsonKey(name: 'HoursOfSnow')
  final double? hoursOfSnow;

  @JsonKey(name: 'HoursOfIce')
  final double? hoursOfIce;

  @JsonKey(name: 'CloudCover')
  final int? cloudCover;

  @JsonKey(name: 'Evapotranspiration')
  final UnitValue? evapotranspiration;

  @JsonKey(name: 'SolarIrradiance')
  final UnitValue? solarIrradiance;

  @JsonKey(name: 'RelativeHumidity')
  final RelativeHumidity? relativeHumidity;

  @JsonKey(name: 'WetBulbTemperature')
  final UnitValueRange? wetBulbTemperature;

  @JsonKey(name: 'WetBulbGlobeTemperature')
  final UnitValueRange? wetBulbGlobeTemperature;

  Map<String, dynamic> toJson() => _$DayNightToJson(this);

  @override
  List<Object?> get props => [
    icon,
    iconPhrase,
    hasPrecipitation,
    precipitationType,
    precipitationIntensity,
    shortPhrase,
    longPhrase,
    precipitationProbability,
    thunderstormProbability,
    rainProbability,
    snowProbability,
    iceProbability,
    wind,
    windGust,
    totalLiquid,
    rain,
    snow,
    ice,
    hoursOfPrecipitation,
    hoursOfRain,
    hoursOfSnow,
    hoursOfIce,
    cloudCover,
    evapotranspiration,
    solarIrradiance,
    relativeHumidity,
    wetBulbTemperature,
    wetBulbGlobeTemperature,
  ];
}

@JsonSerializable()
class RelativeHumidity extends Equatable {
  const RelativeHumidity({this.minimum, this.maximum, this.average});

  factory RelativeHumidity.fromJson(Map<String, dynamic> json) => _$RelativeHumidityFromJson(json);
  @JsonKey(name: 'Minimum')
  final int? minimum;

  @JsonKey(name: 'Maximum')
  final int? maximum;

  @JsonKey(name: 'Average')
  final int? average;

  Map<String, dynamic> toJson() => _$RelativeHumidityToJson(this);

  @override
  List<Object?> get props => [minimum, maximum, average];
}
