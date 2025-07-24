// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitValue _$UnitValueFromJson(Map<String, dynamic> json) => UnitValue(
  metric: json['Metric'] == null
      ? null
      : UnitValueDetail.fromJson(json['Metric'] as Map<String, dynamic>),
  imperial: json['Imperial'] == null
      ? null
      : UnitValueDetail.fromJson(json['Imperial'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UnitValueToJson(UnitValue instance) => <String, dynamic>{
  'Metric': instance.metric,
  'Imperial': instance.imperial,
};

UnitValueDetail _$UnitValueDetailFromJson(Map<String, dynamic> json) =>
    UnitValueDetail(
      value: (json['Value'] as num?)?.toDouble(),
      unit: json['Unit'] as String?,
      unitType: (json['UnitType'] as num?)?.toInt(),
      phrase: json['Phrase'] as String?,
    );

Map<String, dynamic> _$UnitValueDetailToJson(UnitValueDetail instance) =>
    <String, dynamic>{
      'Value': instance.value,
      'Unit': instance.unit,
      'UnitType': instance.unitType,
      'Phrase': instance.phrase,
    };
