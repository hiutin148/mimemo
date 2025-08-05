// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyForecast _$DailyForecastFromJson(Map<String, dynamic> json) =>
    DailyForecast(
      headline: json['Headline'] == null
          ? null
          : Headline.fromJson(json['Headline'] as Map<String, dynamic>),
      dailyForecasts: (json['DailyForecasts'] as List<dynamic>?)
          ?.map((e) => ForecastDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyForecastToJson(DailyForecast instance) =>
    <String, dynamic>{
      'Headline': instance.headline,
      'DailyForecasts': instance.dailyForecasts,
    };

Headline _$HeadlineFromJson(Map<String, dynamic> json) => Headline(
  effectiveDate: json['EffectiveDate'] as String?,
  effectiveEpochDate: (json['EffectiveEpochDate'] as num?)?.toInt(),
  severity: (json['Severity'] as num?)?.toInt(),
  text: json['Text'] as String?,
  category: json['Category'] as String?,
  endDate: json['EndDate'] as String?,
  endEpochDate: (json['EndEpochDate'] as num?)?.toInt(),
  mobileLink: json['MobileLink'] as String?,
  link: json['Link'] as String?,
);

Map<String, dynamic> _$HeadlineToJson(Headline instance) => <String, dynamic>{
  'EffectiveDate': instance.effectiveDate,
  'EffectiveEpochDate': instance.effectiveEpochDate,
  'Severity': instance.severity,
  'Text': instance.text,
  'Category': instance.category,
  'EndDate': instance.endDate,
  'EndEpochDate': instance.endEpochDate,
  'MobileLink': instance.mobileLink,
  'Link': instance.link,
};

ForecastDay _$ForecastDayFromJson(Map<String, dynamic> json) => ForecastDay(
  date: json['Date'] as String?,
  epochDate: (json['EpochDate'] as num?)?.toInt(),
  sun: json['Sun'] == null
      ? null
      : RiseSet.fromJson(json['Sun'] as Map<String, dynamic>),
  moon: json['Moon'] == null
      ? null
      : Moon.fromJson(json['Moon'] as Map<String, dynamic>),
  temperature: json['Temperature'] == null
      ? null
      : UnitValueDetailRange.fromJson(
          json['Temperature'] as Map<String, dynamic>,
        ),
  realFeelTemperature: json['RealFeelTemperature'] == null
      ? null
      : UnitValueDetailRange.fromJson(
          json['RealFeelTemperature'] as Map<String, dynamic>,
        ),
  realFeelTemperatureShade: json['RealFeelTemperatureShade'] == null
      ? null
      : UnitValueDetailRange.fromJson(
          json['RealFeelTemperatureShade'] as Map<String, dynamic>,
        ),
  hoursOfSun: (json['HoursOfSun'] as num?)?.toDouble(),
  degreeDaySummary: json['DegreeDaySummary'] == null
      ? null
      : DegreeDaySummary.fromJson(
          json['DegreeDaySummary'] as Map<String, dynamic>,
        ),
  airAndPollen: (json['AirAndPollen'] as List<dynamic>?)
      ?.map((e) => AirAndPollen.fromJson(e as Map<String, dynamic>))
      .toList(),
  day: json['Day'] == null
      ? null
      : DayNight.fromJson(json['Day'] as Map<String, dynamic>),
  night: json['Night'] == null
      ? null
      : DayNight.fromJson(json['Night'] as Map<String, dynamic>),
  sources: (json['Sources'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  mobileLink: json['MobileLink'] as String?,
  link: json['Link'] as String?,
);

Map<String, dynamic> _$ForecastDayToJson(ForecastDay instance) =>
    <String, dynamic>{
      'Date': instance.date,
      'EpochDate': instance.epochDate,
      'Sun': instance.sun,
      'Moon': instance.moon,
      'Temperature': instance.temperature,
      'RealFeelTemperature': instance.realFeelTemperature,
      'RealFeelTemperatureShade': instance.realFeelTemperatureShade,
      'HoursOfSun': instance.hoursOfSun,
      'DegreeDaySummary': instance.degreeDaySummary,
      'AirAndPollen': instance.airAndPollen,
      'Day': instance.day,
      'Night': instance.night,
      'Sources': instance.sources,
      'MobileLink': instance.mobileLink,
      'Link': instance.link,
    };

RiseSet _$RiseSetFromJson(Map<String, dynamic> json) => RiseSet(
  rise: json['Rise'] as String?,
  epochRise: (json['EpochRise'] as num?)?.toInt(),
  set: json['Set'] as String?,
  epochSet: (json['EpochSet'] as num?)?.toInt(),
);

Map<String, dynamic> _$RiseSetToJson(RiseSet instance) => <String, dynamic>{
  'Rise': instance.rise,
  'EpochRise': instance.epochRise,
  'Set': instance.set,
  'EpochSet': instance.epochSet,
};

Moon _$MoonFromJson(Map<String, dynamic> json) => Moon(
  rise: json['Rise'] as String?,
  epochRise: (json['EpochRise'] as num?)?.toInt(),
  set: json['Set'] as String?,
  epochSet: (json['EpochSet'] as num?)?.toInt(),
  phase: json['Phase'] as String?,
  age: (json['Age'] as num?)?.toInt(),
);

Map<String, dynamic> _$MoonToJson(Moon instance) => <String, dynamic>{
  'Rise': instance.rise,
  'EpochRise': instance.epochRise,
  'Set': instance.set,
  'EpochSet': instance.epochSet,
  'Phase': instance.phase,
  'Age': instance.age,
};

DegreeDaySummary _$DegreeDaySummaryFromJson(Map<String, dynamic> json) =>
    DegreeDaySummary(
      heating: json['Heating'] == null
          ? null
          : UnitValue.fromJson(json['Heating'] as Map<String, dynamic>),
      cooling: json['Cooling'] == null
          ? null
          : UnitValue.fromJson(json['Cooling'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DegreeDaySummaryToJson(DegreeDaySummary instance) =>
    <String, dynamic>{'Heating': instance.heating, 'Cooling': instance.cooling};

AirAndPollen _$AirAndPollenFromJson(Map<String, dynamic> json) => AirAndPollen(
  name: json['Name'] as String?,
  value: (json['Value'] as num?)?.toInt(),
  category: json['Category'] as String?,
  categoryValue: (json['CategoryValue'] as num?)?.toInt(),
  type: json['Type'] as String?,
);

Map<String, dynamic> _$AirAndPollenToJson(AirAndPollen instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Value': instance.value,
      'Category': instance.category,
      'CategoryValue': instance.categoryValue,
      'Type': instance.type,
    };

DayNight _$DayNightFromJson(Map<String, dynamic> json) => DayNight(
  icon: (json['Icon'] as num?)?.toInt(),
  iconPhrase: json['IconPhrase'] as String?,
  hasPrecipitation: json['HasPrecipitation'] as bool?,
  precipitationType: json['PrecipitationType'] as String?,
  precipitationIntensity: json['PrecipitationIntensity'] as String?,
  shortPhrase: json['ShortPhrase'] as String?,
  longPhrase: json['LongPhrase'] as String?,
  precipitationProbability: (json['PrecipitationProbability'] as num?)?.toInt(),
  thunderstormProbability: (json['ThunderstormProbability'] as num?)?.toInt(),
  rainProbability: (json['RainProbability'] as num?)?.toInt(),
  snowProbability: (json['SnowProbability'] as num?)?.toInt(),
  iceProbability: (json['IceProbability'] as num?)?.toInt(),
  wind: json['Wind'] == null
      ? null
      : WindDetail.fromJson(json['Wind'] as Map<String, dynamic>),
  windGust: json['WindGust'] == null
      ? null
      : WindDetail.fromJson(json['WindGust'] as Map<String, dynamic>),
  totalLiquid: json['TotalLiquid'] == null
      ? null
      : UnitValue.fromJson(json['TotalLiquid'] as Map<String, dynamic>),
  rain: json['Rain'] == null
      ? null
      : UnitValue.fromJson(json['Rain'] as Map<String, dynamic>),
  snow: json['Snow'] == null
      ? null
      : UnitValue.fromJson(json['Snow'] as Map<String, dynamic>),
  ice: json['Ice'] == null
      ? null
      : UnitValue.fromJson(json['Ice'] as Map<String, dynamic>),
  hoursOfPrecipitation: (json['HoursOfPrecipitation'] as num?)?.toDouble(),
  hoursOfRain: (json['HoursOfRain'] as num?)?.toDouble(),
  hoursOfSnow: (json['HoursOfSnow'] as num?)?.toDouble(),
  hoursOfIce: (json['HoursOfIce'] as num?)?.toDouble(),
  cloudCover: (json['CloudCover'] as num?)?.toInt(),
  evapotranspiration: json['Evapotranspiration'] == null
      ? null
      : UnitValue.fromJson(json['Evapotranspiration'] as Map<String, dynamic>),
  solarIrradiance: json['SolarIrradiance'] == null
      ? null
      : UnitValue.fromJson(json['SolarIrradiance'] as Map<String, dynamic>),
  relativeHumidity: json['RelativeHumidity'] == null
      ? null
      : RelativeHumidity.fromJson(
          json['RelativeHumidity'] as Map<String, dynamic>,
        ),
  wetBulbTemperature: json['WetBulbTemperature'] == null
      ? null
      : UnitValueRange.fromJson(
          json['WetBulbTemperature'] as Map<String, dynamic>,
        ),
  wetBulbGlobeTemperature: json['WetBulbGlobeTemperature'] == null
      ? null
      : UnitValueRange.fromJson(
          json['WetBulbGlobeTemperature'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$DayNightToJson(DayNight instance) => <String, dynamic>{
  'Icon': instance.icon,
  'IconPhrase': instance.iconPhrase,
  'HasPrecipitation': instance.hasPrecipitation,
  'PrecipitationType': instance.precipitationType,
  'PrecipitationIntensity': instance.precipitationIntensity,
  'ShortPhrase': instance.shortPhrase,
  'LongPhrase': instance.longPhrase,
  'PrecipitationProbability': instance.precipitationProbability,
  'ThunderstormProbability': instance.thunderstormProbability,
  'RainProbability': instance.rainProbability,
  'SnowProbability': instance.snowProbability,
  'IceProbability': instance.iceProbability,
  'Wind': instance.wind,
  'WindGust': instance.windGust,
  'TotalLiquid': instance.totalLiquid,
  'Rain': instance.rain,
  'Snow': instance.snow,
  'Ice': instance.ice,
  'HoursOfPrecipitation': instance.hoursOfPrecipitation,
  'HoursOfRain': instance.hoursOfRain,
  'HoursOfSnow': instance.hoursOfSnow,
  'HoursOfIce': instance.hoursOfIce,
  'CloudCover': instance.cloudCover,
  'Evapotranspiration': instance.evapotranspiration,
  'SolarIrradiance': instance.solarIrradiance,
  'RelativeHumidity': instance.relativeHumidity,
  'WetBulbTemperature': instance.wetBulbTemperature,
  'WetBulbGlobeTemperature': instance.wetBulbGlobeTemperature,
};

RelativeHumidity _$RelativeHumidityFromJson(Map<String, dynamic> json) =>
    RelativeHumidity(
      minimum: (json['Minimum'] as num?)?.toInt(),
      maximum: (json['Maximum'] as num?)?.toInt(),
      average: (json['Average'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RelativeHumidityToJson(RelativeHumidity instance) =>
    <String, dynamic>{
      'Minimum': instance.minimum,
      'Maximum': instance.maximum,
      'Average': instance.average,
    };
