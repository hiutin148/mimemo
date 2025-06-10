// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_value_range.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitValueRange _$UnitValueRangeFromJson(Map<String, dynamic> json) =>
    UnitValueRange(
      minimum:
          json['Minimum'] == null
              ? null
              : UnitValue.fromJson(json['Minimum'] as Map<String, dynamic>),
      maximum:
          json['Maximum'] == null
              ? null
              : UnitValue.fromJson(json['Maximum'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UnitValueRangeToJson(UnitValueRange instance) =>
    <String, dynamic>{'Minimum': instance.minimum, 'Maximum': instance.maximum};
