import 'package:json_annotation/json_annotation.dart';

part 'current_air_quality.g.dart';

@JsonSerializable(explicitToJson: true)
class CurrentAirQuality {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'version')
  final int? version;

  @JsonKey(name: 'data')
  final AirQualityData? data;

  CurrentAirQuality({this.success, this.status, this.version, this.data});

  factory CurrentAirQuality.fromJson(Map<String, dynamic> json) =>
      _$CurrentAirQualityFromJson(json);
  Map<String, dynamic> toJson() => _$CurrentAirQualityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AirQualityData {
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

  AirQualityData({
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

  factory AirQualityData.fromJson(Map<String, dynamic> json) =>
      _$AirQualityDataFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityDataToJson(this);
}

@JsonSerializable()
class Pollutant {
  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'plumeLabsIndex')
  final double? plumeLabsIndex;

  @JsonKey(name: 'concentration')
  final Concentration? concentration;

  @JsonKey(name: 'source')
  final String? source;

  Pollutant({
    this.type,
    this.name,
    this.plumeLabsIndex,
    this.concentration,
    this.source,
  });

  factory Pollutant.fromJson(Map<String, dynamic> json) =>
      _$PollutantFromJson(json);
  Map<String, dynamic> toJson() => _$PollutantToJson(this);
}

@JsonSerializable()
class Concentration {
  @JsonKey(name: 'value')
  final double? value;

  @JsonKey(name: 'unit')
  final String? unit;

  @JsonKey(name: 'unitType')
  final int? unitType;

  Concentration({this.value, this.unit, this.unitType});

  factory Concentration.fromJson(Map<String, dynamic> json) =>
      _$ConcentrationFromJson(json);
  Map<String, dynamic> toJson() => _$ConcentrationToJson(this);
}
