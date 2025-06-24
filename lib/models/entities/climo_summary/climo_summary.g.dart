// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'climo_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClimoSummary _$ClimoSummaryFromJson(Map<String, dynamic> json) => ClimoSummary(
  actual:
      json['Actual'] == null
          ? null
          : ActualData.fromJson(json['Actual'] as Map<String, dynamic>),
  normal:
      json['Normal'] == null
          ? null
          : NormalData.fromJson(json['Normal'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ClimoSummaryToJson(ClimoSummary instance) =>
    <String, dynamic>{'Actual': instance.actual, 'Normal': instance.normal};

ActualData _$ActualDataFromJson(Map<String, dynamic> json) => ActualData(
  date: json['Date'] as String?,
  epochDate: (json['EpochDate'] as num?)?.toInt(),
  actuals:
      json['Actuals'] == null
          ? null
          : Actuals.fromJson(json['Actuals'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActualDataToJson(ActualData instance) =>
    <String, dynamic>{
      'Date': instance.date,
      'EpochDate': instance.epochDate,
      'Actuals': instance.actuals,
    };

NormalData _$NormalDataFromJson(Map<String, dynamic> json) => NormalData(
  date: json['Date'] as String?,
  epochDate: (json['EpochDate'] as num?)?.toInt(),
  normals:
      json['Normals'] == null
          ? null
          : Normals.fromJson(json['Normals'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NormalDataToJson(NormalData instance) =>
    <String, dynamic>{
      'Date': instance.date,
      'EpochDate': instance.epochDate,
      'Normals': instance.normals,
    };

Actuals _$ActualsFromJson(Map<String, dynamic> json) => Actuals(
  temperatures:
      json['Temperatures'] == null
          ? null
          : UnitValueRange.fromJson(
            json['Temperatures'] as Map<String, dynamic>,
          ),
  degreeDays:
      json['DegreeDays'] == null
          ? null
          : DegreeDays.fromJson(json['DegreeDays'] as Map<String, dynamic>),
  precipitation:
      json['Precipitation'] == null
          ? null
          : UnitValue.fromJson(json['Precipitation'] as Map<String, dynamic>),
  snowfall:
      json['Snowfall'] == null
          ? null
          : UnitValue.fromJson(json['Snowfall'] as Map<String, dynamic>),
  snowDepth:
      json['SnowDepth'] == null
          ? null
          : UnitValue.fromJson(json['SnowDepth'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ActualsToJson(Actuals instance) => <String, dynamic>{
  'Temperatures': instance.temperatures,
  'DegreeDays': instance.degreeDays,
  'Precipitation': instance.precipitation,
  'Snowfall': instance.snowfall,
  'SnowDepth': instance.snowDepth,
};

Normals _$NormalsFromJson(Map<String, dynamic> json) => Normals(
  temperatures:
      json['Temperatures'] == null
          ? null
          : UnitValueRange.fromJson(
            json['Temperatures'] as Map<String, dynamic>,
          ),
  degreeDays:
      json['DegreeDays'] == null
          ? null
          : DegreeDays.fromJson(json['DegreeDays'] as Map<String, dynamic>),
  precipitation:
      json['Precipitation'] == null
          ? null
          : UnitValue.fromJson(json['Precipitation'] as Map<String, dynamic>),
);

Map<String, dynamic> _$NormalsToJson(Normals instance) => <String, dynamic>{
  'Temperatures': instance.temperatures,
  'DegreeDays': instance.degreeDays,
  'Precipitation': instance.precipitation,
};

DegreeDays _$DegreeDaysFromJson(Map<String, dynamic> json) => DegreeDays(
  heating:
      json['Heating'] == null
          ? null
          : UnitValue.fromJson(json['Heating'] as Map<String, dynamic>),
  cooling:
      json['Cooling'] == null
          ? null
          : UnitValue.fromJson(json['Cooling'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DegreeDaysToJson(DegreeDays instance) =>
    <String, dynamic>{'Heating': instance.heating, 'Cooling': instance.cooling};
