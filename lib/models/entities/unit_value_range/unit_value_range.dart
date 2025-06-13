import 'package:json_annotation/json_annotation.dart';
import 'package:mimemo/models/entities/temperature/unit_value.dart';

part 'unit_value_range.g.dart';

@JsonSerializable()
class UnitValueRange {
  UnitValueRange({this.minimum, this.maximum, this.average});

  factory UnitValueRange.fromJson(Map<String, dynamic> json) => _$UnitValueRangeFromJson(json);
  @JsonKey(name: 'Minimum')
  final UnitValue? minimum;

  @JsonKey(name: 'Maximum')
  final UnitValue? maximum;

  @JsonKey(name: 'Average')
  final UnitValue? average;

  Map<String, dynamic> toJson() => _$UnitValueRangeToJson(this);
}
