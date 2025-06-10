import 'package:json_annotation/json_annotation.dart';
import 'package:mimemo/models/entities/temperature/unit_value.dart';

part 'unit_value_detail_range.g.dart';

@JsonSerializable()
class UnitValueDetailRange {
  UnitValueDetailRange({this.minimum, this.maximum});

  factory UnitValueDetailRange.fromJson(Map<String, dynamic> json) =>
      _$UnitValueDetailRangeFromJson(json);
  @JsonKey(name: 'Minimum')
  final UnitValueDetail? minimum;

  @JsonKey(name: 'Maximum')
  final UnitValueDetail? maximum;

  Map<String, dynamic> toJson() => _$UnitValueDetailRangeToJson(this);
}
