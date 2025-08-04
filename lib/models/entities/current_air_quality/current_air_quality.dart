import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mimemo/models/entities/temperature/unit_value.dart';

part 'current_air_quality.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrentAirQuality extends Equatable {
  const CurrentAirQuality({this.success, this.status, this.version, this.data});

  factory CurrentAirQuality.fromJson(Map<String, dynamic> json) =>
      _$CurrentAirQualityFromJson(json);
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'version')
  final int? version;

  @JsonKey(name: 'data')
  final AirQualityData? data;

  Map<String, dynamic> toJson() => _$CurrentAirQualityToJson(this);

  @override
  List<Object?> get props => [success, status, version, data];
}

@JsonSerializable(explicitToJson: true)
class AirQualityData extends Equatable {
  const AirQualityData({
    this.date,
    this.epochDate,
    this.overallIndex,
    this.overallPlumeLabsIndex,
    this.dominantPollutant,
    this.category,
    this.categoryColor,
    this.hazardStatement,
    this.link,
    this.pollutants,
  });

  factory AirQualityData.fromJson(Map<String, dynamic> json) => _$AirQualityDataFromJson(json);
  @JsonKey(name: 'date')
  final String? date;

  @JsonKey(name: 'epochDate')
  final int? epochDate;

  @JsonKey(name: 'overallIndex')
  final double? overallIndex;

  @JsonKey(name: 'overallPlumeLabsIndex')
  final double? overallPlumeLabsIndex;

  @JsonKey(name: 'dominantPollutant')
  final String? dominantPollutant;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'categoryColor')
  final String? categoryColor;

  @JsonKey(name: 'hazardStatement')
  final String? hazardStatement;

  @JsonKey(name: 'link')
  final String? link;

  @JsonKey(name: 'pollutants')
  final List<Pollutant>? pollutants;

  Map<String, dynamic> toJson() => _$AirQualityDataToJson(this);

  @override
  List<Object?> get props => [
    date,
    epochDate,
    overallIndex,
    overallPlumeLabsIndex,
    dominantPollutant,
    category,
    categoryColor,
    hazardStatement,
    link,
    pollutants,
  ];
}

@JsonSerializable()
class Pollutant extends Equatable {
  const Pollutant({
    this.type,
    this.name,
    this.plumeLabsIndex,
    this.concentration,
    this.source,
  });

  factory Pollutant.fromJson(Map<String, dynamic> json) => _$PollutantFromJson(json);
  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'plumeLabsIndex')
  final double? plumeLabsIndex;

  @JsonKey(name: 'concentration')
  final UnitValueDetail? concentration;

  @JsonKey(name: 'source')
  final String? source;

  Map<String, dynamic> toJson() => _$PollutantToJson(this);

  @override
  List<Object?> get props => [
    type,
    name,
    plumeLabsIndex,
    concentration,
    source,
  ];
}
