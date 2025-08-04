import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mimemo/models/entities/temperature/unit_value.dart';

part 'wind.g.dart';

@JsonSerializable()
class Wind extends Equatable {
  const Wind({this.direction, this.speed});

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
  @JsonKey(name: 'Direction')
  final WindDirection? direction;

  @JsonKey(name: 'Speed')
  final UnitValueDetail? speed;

  Map<String, dynamic> toJson() => _$WindToJson(this);

  @override
  List<Object?> get props => [direction, speed];
}

@JsonSerializable()
class WindDirection extends Equatable {
  const WindDirection({this.degrees, this.localized, this.english});

  factory WindDirection.fromJson(Map<String, dynamic> json) => _$WindDirectionFromJson(json);
  @JsonKey(name: 'Degrees')
  final int? degrees;

  @JsonKey(name: 'Localized')
  final String? localized;

  @JsonKey(name: 'English')
  final String? english;

  Map<String, dynamic> toJson() => _$WindDirectionToJson(this);

  @override
  List<Object?> get props => [degrees, localized, english];
}
