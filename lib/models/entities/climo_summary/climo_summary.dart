import 'package:json_annotation/json_annotation.dart';
import 'package:mimemo/models/entities/temperature/unit_value.dart';
import 'package:mimemo/models/entities/unit_value_range/unit_value_range.dart';

part 'climo_summary.g.dart';

@JsonSerializable()
class ClimoSummary {

  ClimoSummary({
    this.actual,
    this.normal,
  });

  factory ClimoSummary.fromJson(Map<String, dynamic> json) => _$ClimoSummaryFromJson(json);
  @JsonKey(name: 'Actual')
  final ActualData? actual;

  @JsonKey(name: 'Normal')
  final NormalData? normal;

  Map<String, dynamic> toJson() => _$ClimoSummaryToJson(this);
}

@JsonSerializable()
class ActualData {

  ActualData({
    this.date,
    this.epochDate,
    this.actuals,
  });

  factory ActualData.fromJson(Map<String, dynamic> json) => _$ActualDataFromJson(json);
  @JsonKey(name: 'Date')
  final String? date;

  @JsonKey(name: 'EpochDate')
  final int? epochDate;

  @JsonKey(name: 'Actuals')
  final Actuals? actuals;

  Map<String, dynamic> toJson() => _$ActualDataToJson(this);
}

@JsonSerializable()
class NormalData {

  NormalData({
    this.date,
    this.epochDate,
    this.normals,
  });

  factory NormalData.fromJson(Map<String, dynamic> json) => _$NormalDataFromJson(json);
  @JsonKey(name: 'Date')
  final String? date;

  @JsonKey(name: 'EpochDate')
  final int? epochDate;

  @JsonKey(name: 'Normals')
  final Normals? normals;

  Map<String, dynamic> toJson() => _$NormalDataToJson(this);
}

@JsonSerializable()
class Actuals {

  Actuals({
    this.temperatures,
    this.degreeDays,
    this.precipitation,
    this.snowfall,
    this.snowDepth,
  });

  factory Actuals.fromJson(Map<String, dynamic> json) => _$ActualsFromJson(json);
  @JsonKey(name: 'Temperatures')
  final UnitValueRange? temperatures;

  @JsonKey(name: 'DegreeDays')
  final DegreeDays? degreeDays;

  @JsonKey(name: 'Precipitation')
  final UnitValue? precipitation;

  @JsonKey(name: 'Snowfall')
  final UnitValue? snowfall;

  @JsonKey(name: 'SnowDepth')
  final UnitValue? snowDepth;

  Map<String, dynamic> toJson() => _$ActualsToJson(this);
}

@JsonSerializable()
class Normals {

  Normals({
    this.temperatures,
    this.degreeDays,
    this.precipitation,
  });

  factory Normals.fromJson(Map<String, dynamic> json) => _$NormalsFromJson(json);
  @JsonKey(name: 'Temperatures')
  final UnitValueRange? temperatures;

  @JsonKey(name: 'DegreeDays')
  final DegreeDays? degreeDays;

  @JsonKey(name: 'Precipitation')
  final UnitValue? precipitation;

  Map<String, dynamic> toJson() => _$NormalsToJson(this);
}

@JsonSerializable()
class DegreeDays {

  DegreeDays({
    this.heating,
    this.cooling,
  });

  factory DegreeDays.fromJson(Map<String, dynamic> json) => _$DegreeDaysFromJson(json);
  @JsonKey(name: 'Heating')
  final UnitValue? heating;

  @JsonKey(name: 'Cooling')
  final UnitValue? cooling;

  Map<String, dynamic> toJson() => _$DegreeDaysToJson(this);
}
