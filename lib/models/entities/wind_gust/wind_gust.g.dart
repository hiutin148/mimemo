// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind_gust.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WindGust _$WindGustFromJson(Map<String, dynamic> json) => WindGust(
  speed:
      json['Speed'] == null
          ? null
          : UnitValue.fromJson(json['Speed'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WindGustToJson(WindGust instance) => <String, dynamic>{
  'Speed': instance.speed,
};
