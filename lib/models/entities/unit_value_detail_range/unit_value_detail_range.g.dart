// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_value_detail_range.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitValueDetailRange _$UnitValueDetailRangeFromJson(
  Map<String, dynamic> json,
) => UnitValueDetailRange(
  minimum:
      json['Minimum'] == null
          ? null
          : UnitValueDetail.fromJson(json['Minimum'] as Map<String, dynamic>),
  maximum:
      json['Maximum'] == null
          ? null
          : UnitValueDetail.fromJson(json['Maximum'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UnitValueDetailRangeToJson(
  UnitValueDetailRange instance,
) => <String, dynamic>{
  'Minimum': instance.minimum,
  'Maximum': instance.maximum,
};
