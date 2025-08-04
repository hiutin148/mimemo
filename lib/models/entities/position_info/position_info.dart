import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mimemo/models/entities/temperature/unit_value.dart';

part 'position_info.g.dart';

@JsonSerializable(explicitToJson: true)
class PositionInfo extends Equatable {
  const PositionInfo({
    this.version,
    this.key,
    this.type,
    this.rank,
    this.localizedName,
    this.englishName,
    this.primaryPostalCode,
    this.region,
    this.country,
    this.administrativeArea,
    this.timeZone,
    this.geoPosition,
    this.isAlias,
    this.parentCity,
    this.supplementalAdminAreas,
    this.dataSets,
    this.details,
  });

  factory PositionInfo.fromJson(Map<String, dynamic> json) => _$PositionInfoFromJson(json);
  @JsonKey(name: 'Version')
  final int? version;

  @JsonKey(name: 'Key')
  final String? key;

  @JsonKey(name: 'Type')
  final String? type;

  @JsonKey(name: 'Rank')
  final int? rank;

  @JsonKey(name: 'LocalizedName')
  final String? localizedName;

  @JsonKey(name: 'EnglishName')
  final String? englishName;

  @JsonKey(name: 'PrimaryPostalCode')
  final String? primaryPostalCode;

  @JsonKey(name: 'Region')
  final Region? region;

  @JsonKey(name: 'Country')
  final Country? country;

  @JsonKey(name: 'AdministrativeArea')
  final AdministrativeArea? administrativeArea;

  @JsonKey(name: 'TimeZone')
  final TimeZone? timeZone;

  @JsonKey(name: 'GeoPosition')
  final GeoPosition? geoPosition;

  @JsonKey(name: 'IsAlias')
  final bool? isAlias;

  @JsonKey(name: 'ParentCity')
  final ParentCity? parentCity;

  @JsonKey(name: 'SupplementalAdminAreas')
  final List<dynamic>? supplementalAdminAreas;

  @JsonKey(name: 'DataSets')
  final List<String>? dataSets;

  @JsonKey(name: 'Details')
  final Details? details;

  Map<String, dynamic> toJson() => _$PositionInfoToJson(this);

  @override
  List<Object?> get props => [
    version,
    key,
    type,
    rank,
    localizedName,
    englishName,
    primaryPostalCode,
    region,
    country,
    administrativeArea,
    timeZone,
    geoPosition,
    isAlias,
    parentCity,
    supplementalAdminAreas,
    dataSets,
    details,
  ];
}

@JsonSerializable()
class Details extends Equatable {
  const Details({
    this.key,
    this.stationCode,
    this.stationGmtOffset,
    this.bandMap,
    this.climo,
    this.localRadar,
    this.mediaRegion,
    this.metar,
    this.nxMetro,
    this.nxState,
    this.population,
    this.primaryWarningCountyCode,
    this.primaryWarningZoneCode,
    this.satellite,
    this.synoptic,
    this.marineStation,
    this.marineStationGmtOffset,
    this.videoCode,
    this.locationStem,
    this.partnerId,
    this.sources,
    this.canonicalPostalCode,
    this.canonicalLocationKey,
  });

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);
  @JsonKey(name: 'Key')
  final String? key;

  @JsonKey(name: 'StationCode')
  final String? stationCode;

  @JsonKey(name: 'StationGmtOffset')
  final double? stationGmtOffset;

  @JsonKey(name: 'BandMap')
  final String? bandMap;

  @JsonKey(name: 'Climo')
  final String? climo;

  @JsonKey(name: 'LocalRadar')
  final String? localRadar;

  @JsonKey(name: 'MediaRegion')
  final String? mediaRegion;

  @JsonKey(name: 'Metar')
  final String? metar;

  @JsonKey(name: 'NXMetro')
  final String? nxMetro;

  @JsonKey(name: 'NXState')
  final String? nxState;

  @JsonKey(name: 'Population')
  final int? population;

  @JsonKey(name: 'PrimaryWarningCountyCode')
  final String? primaryWarningCountyCode;

  @JsonKey(name: 'PrimaryWarningZoneCode')
  final String? primaryWarningZoneCode;

  @JsonKey(name: 'Satellite')
  final String? satellite;

  @JsonKey(name: 'Synoptic')
  final String? synoptic;

  @JsonKey(name: 'MarineStation')
  final String? marineStation;

  @JsonKey(name: 'MarineStationGMTOffset')
  final double? marineStationGmtOffset;

  @JsonKey(name: 'VideoCode')
  final String? videoCode;

  @JsonKey(name: 'LocationStem')
  final String? locationStem;

  @JsonKey(name: 'PartnerID')
  final String? partnerId;

  @JsonKey(name: 'Sources')
  final List<Source>? sources;

  @JsonKey(name: 'CanonicalPostalCode')
  final String? canonicalPostalCode;

  @JsonKey(name: 'CanonicalLocationKey')
  final String? canonicalLocationKey;

  Map<String, dynamic> toJson() => _$DetailsToJson(this);

  @override
  List<Object?> get props => [
    key,
    stationCode,
    stationGmtOffset,
    bandMap,
    climo,
    localRadar,
    mediaRegion,
    metar,
    nxMetro,
    nxState,
    population,
    primaryWarningCountyCode,
    primaryWarningZoneCode,
    satellite,
    synoptic,
    marineStation,
    marineStationGmtOffset,
    videoCode,
    locationStem,
    partnerId,
    sources,
    canonicalPostalCode,
    canonicalLocationKey,
  ];
}

@JsonSerializable()
class Source extends Equatable {
  const Source({this.dataType, this.source, this.sourceId});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);
  @JsonKey(name: 'DataType')
  final String? dataType;

  @JsonKey(name: 'Source')
  final String? source;

  @JsonKey(name: 'SourceId')
  final int? sourceId;

  Map<String, dynamic> toJson() => _$SourceToJson(this);

  @override
  List<Object?> get props => [dataType, source, sourceId];
}

@JsonSerializable()
class Region extends Equatable {
  const Region({this.id, this.localizedName, this.englishName});

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  @JsonKey(name: 'ID')
  final String? id;

  @JsonKey(name: 'LocalizedName')
  final String? localizedName;

  @JsonKey(name: 'EnglishName')
  final String? englishName;

  Map<String, dynamic> toJson() => _$RegionToJson(this);

  @override
  List<Object?> get props => [id, localizedName, englishName];
}

@JsonSerializable()
class Country extends Equatable {
  const Country({this.id, this.localizedName, this.englishName});

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  @JsonKey(name: 'ID')
  final String? id;

  @JsonKey(name: 'LocalizedName')
  final String? localizedName;

  @JsonKey(name: 'EnglishName')
  final String? englishName;

  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  List<Object?> get props => [id, localizedName, englishName];
}

@JsonSerializable()
class AdministrativeArea extends Equatable {
  const AdministrativeArea({
    this.id,
    this.localizedName,
    this.englishName,
    this.level,
    this.localizedType,
    this.englishType,
    this.countryId,
  });

  factory AdministrativeArea.fromJson(Map<String, dynamic> json) =>
      _$AdministrativeAreaFromJson(json);
  @JsonKey(name: 'ID')
  final String? id;

  @JsonKey(name: 'LocalizedName')
  final String? localizedName;

  @JsonKey(name: 'EnglishName')
  final String? englishName;

  @JsonKey(name: 'Level')
  final int? level;

  @JsonKey(name: 'LocalizedType')
  final String? localizedType;

  @JsonKey(name: 'EnglishType')
  final String? englishType;

  @JsonKey(name: 'CountryID')
  final String? countryId;

  Map<String, dynamic> toJson() => _$AdministrativeAreaToJson(this);

  @override
  List<Object?> get props => [
    id,
    localizedName,
    englishName,
    level,
    localizedType,
    englishType,
    countryId,
  ];
}

@JsonSerializable()
class TimeZone extends Equatable {
  const TimeZone({
    this.code,
    this.name,
    this.gmtOffset,
    this.isDaylightSaving,
    this.nextOffsetChange,
  });

  factory TimeZone.fromJson(Map<String, dynamic> json) => _$TimeZoneFromJson(json);
  @JsonKey(name: 'Code')
  final String? code;

  @JsonKey(name: 'Name')
  final String? name;

  @JsonKey(name: 'GmtOffset')
  final double? gmtOffset;

  @JsonKey(name: 'IsDaylightSaving')
  final bool? isDaylightSaving;

  @JsonKey(name: 'NextOffsetChange')
  final String? nextOffsetChange;

  Map<String, dynamic> toJson() => _$TimeZoneToJson(this);

  @override
  List<Object?> get props => [
    code,
    name,
    gmtOffset,
    isDaylightSaving,
    nextOffsetChange,
  ];
}

@JsonSerializable()
class GeoPosition extends Equatable {
  const GeoPosition({this.latitude, this.longitude, this.elevation});

  factory GeoPosition.fromJson(Map<String, dynamic> json) => _$GeoPositionFromJson(json);
  @JsonKey(name: 'Latitude')
  final double? latitude;

  @JsonKey(name: 'Longitude')
  final double? longitude;

  @JsonKey(name: 'Elevation')
  final Elevation? elevation;

  Map<String, dynamic> toJson() => _$GeoPositionToJson(this);

  @override
  List<Object?> get props => [latitude, longitude, elevation];
}

@JsonSerializable()
class Elevation extends Equatable {
  const Elevation({this.metric, this.imperial});

  factory Elevation.fromJson(Map<String, dynamic> json) => _$ElevationFromJson(json);
  @JsonKey(name: 'Metric')
  final UnitValue? metric;

  @JsonKey(name: 'Imperial')
  final UnitValue? imperial;

  Map<String, dynamic> toJson() => _$ElevationToJson(this);

  @override
  List<Object?> get props => [metric, imperial];
}

@JsonSerializable()
class ParentCity extends Equatable {
  const ParentCity({this.key, this.localizedName, this.englishName});

  factory ParentCity.fromJson(Map<String, dynamic> json) => _$ParentCityFromJson(json);
  @JsonKey(name: 'Key')
  final String? key;

  @JsonKey(name: 'LocalizedName')
  final String? localizedName;

  @JsonKey(name: 'EnglishName')
  final String? englishName;

  Map<String, dynamic> toJson() => _$ParentCityToJson(this);

  @override
  List<Object?> get props => [key, localizedName, englishName];
}
