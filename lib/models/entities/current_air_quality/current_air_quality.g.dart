// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_air_quality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrentAirQuality _$CurrentAirQualityFromJson(Map<String, dynamic> json) =>
    CurrentAirQuality(
      success: json['success'] as bool?,
      status: json['status'] as String?,
      version: (json['version'] as num?)?.toInt(),
      data:
          json['data'] == null
              ? null
              : AirQualityData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentAirQualityToJson(CurrentAirQuality instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'version': instance.version,
      'data': instance.data?.toJson(),
    };

AirQualityData _$AirQualityDataFromJson(Map<String, dynamic> json) =>
    AirQualityData(
      date: json['date'] as String?,
      epochDate: (json['epochDate'] as num?)?.toInt(),
      overallIndex: (json['overallIndex'] as num?)?.toDouble(),
      overallPlumeLabsIndex:
          (json['overallPlumeLabsIndex'] as num?)?.toDouble(),
      dominantPollutant: json['dominantPollutant'] as String?,
      category: json['category'] as String?,
      categoryColor: json['categoryColor'] as String?,
      hazardStatement: json['hazardStatement'] as String?,
      link: json['link'] as String?,
      pollutants:
          (json['pollutants'] as List<dynamic>?)
              ?.map((e) => Pollutant.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$AirQualityDataToJson(AirQualityData instance) =>
    <String, dynamic>{
      'date': instance.date,
      'epochDate': instance.epochDate,
      'overallIndex': instance.overallIndex,
      'overallPlumeLabsIndex': instance.overallPlumeLabsIndex,
      'dominantPollutant': instance.dominantPollutant,
      'category': instance.category,
      'categoryColor': instance.categoryColor,
      'hazardStatement': instance.hazardStatement,
      'link': instance.link,
      'pollutants': instance.pollutants?.map((e) => e.toJson()).toList(),
    };

Pollutant _$PollutantFromJson(Map<String, dynamic> json) => Pollutant(
  type: json['type'] as String?,
  name: json['name'] as String?,
  plumeLabsIndex: (json['plumeLabsIndex'] as num?)?.toDouble(),
  concentration:
      json['concentration'] == null
          ? null
          : Concentration.fromJson(
            json['concentration'] as Map<String, dynamic>,
          ),
  source: json['source'] as String?,
);

Map<String, dynamic> _$PollutantToJson(Pollutant instance) => <String, dynamic>{
  'type': instance.type,
  'name': instance.name,
  'plumeLabsIndex': instance.plumeLabsIndex,
  'concentration': instance.concentration,
  'source': instance.source,
};

Concentration _$ConcentrationFromJson(Map<String, dynamic> json) =>
    Concentration(
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      unitType: (json['unitType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ConcentrationToJson(Concentration instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
      'unitType': instance.unitType,
    };
