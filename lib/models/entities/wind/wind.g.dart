// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
  direction: json['Direction'] == null
      ? null
      : WindDirection.fromJson(json['Direction'] as Map<String, dynamic>),
  speed: json['Speed'] == null
      ? null
      : UnitValueDetail.fromJson(json['Speed'] as Map<String, dynamic>),
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
