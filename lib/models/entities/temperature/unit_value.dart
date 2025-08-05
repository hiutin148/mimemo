import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_value.g.dart';

@JsonSerializable()
class UnitValue extends Equatable {
  const UnitValue({this.metric, this.imperial});

  factory UnitValue.fromJson(Map<String, dynamic> json) => _$UnitValueFromJson(json);
  @JsonKey(name: 'Metric')
  final UnitValueDetail? metric;

  @JsonKey(name: 'Imperial')
  final UnitValueDetail? imperial;

  Map<String, dynamic> toJson() => _$UnitValueToJson(this);

  @override
  List<Object?> get props => [metric, imperial];
}

@JsonSerializable()
class UnitValueDetail extends Equatable {
  const UnitValueDetail({this.value, this.unit, this.unitType, this.phrase});

  factory UnitValueDetail.fromJson(Map<String, dynamic> json) => _$UnitValueDetailFromJson(json);
  @JsonKey(name: 'Value')
  final double? value;

  @JsonKey(name: 'Unit')
  final String? unit;

  @JsonKey(name: 'UnitType')
  final int? unitType;

  @JsonKey(name: 'Phrase')
  final String? phrase;

  Map<String, dynamic> toJson() => _$UnitValueDetailToJson(this);

  @override
  List<Object?> get props => [value, unit, unitType, phrase];
}

@JsonSerializable()
class UnitValueDetailV2 extends Equatable {
  const UnitValueDetailV2({this.value, this.unit, this.unitType, this.phrase});

  factory UnitValueDetailV2.fromJson(Map<String, dynamic> json) => _$UnitValueDetailV2FromJson(json);
  @JsonKey(name: 'value')
  final double? value;

  @JsonKey(name: 'unit')
  final String? unit;

  @JsonKey(name: 'unitType')
  final int? unitType;

  @JsonKey(name: 'phrase')
  final String? phrase;

  Map<String, dynamic> toJson() => _$UnitValueDetailV2ToJson(this);

  @override
  List<Object?> get props => [value, unit, unitType, phrase];
}
