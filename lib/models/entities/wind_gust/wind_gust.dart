import 'package:json_annotation/json_annotation.dart';
import 'package:mimemo/models/entities/temperature/unit_value.dart';

part 'wind_gust.g.dart';

@JsonSerializable()
class WindGust {

  WindGust({
    this.speed,
  });

  factory WindGust.fromJson(Map<String, dynamic> json) =>
      _$WindGustFromJson(json);
  @JsonKey(name: 'Speed')
  final UnitValue? speed;

  Map<String, dynamic> toJson() => _$WindGustToJson(this);
}
