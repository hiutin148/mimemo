// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'minute_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MinuteColor _$MinuteColorFromJson(Map<String, dynamic> json) => MinuteColor(
  type: json['Type'] as String?,
  threshold: json['Threshold'] as String?,
  startDbz: (json['StartDbz'] as num?)?.toDouble(),
  endDbz: (json['EndDbz'] as num?)?.toDouble(),
  red: (json['Red'] as num?)?.toInt(),
  green: (json['Green'] as num?)?.toInt(),
  blue: (json['Blue'] as num?)?.toInt(),
  hex: json['Hex'] as String?,
);

Map<String, dynamic> _$MinuteColorToJson(MinuteColor instance) =>
    <String, dynamic>{
      'Type': instance.type,
      'Threshold': instance.threshold,
      'StartDbz': instance.startDbz,
      'EndDbz': instance.endDbz,
      'Red': instance.red,
      'Green': instance.green,
      'Blue': instance.blue,
      'Hex': instance.hex,
    };
