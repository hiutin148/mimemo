import 'package:json_annotation/json_annotation.dart';

part 'position_info.g.dart';

@JsonSerializable(explicitToJson: true)
class PositionInfo {
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

  PositionInfo({
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

  factory PositionInfo.fromJson(Map<String, dynamic> json) =>
      _$PositionInfoFromJson(json);
  Map<String, dynamic> toJson() => _$PositionInfoToJson(this);
}

@JsonSerializable()
class Details {
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

  Details({
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

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}

@JsonSerializable()
class Source {
  @JsonKey(name: 'DataType')
  final String? dataType;

  @JsonKey(name: 'Source')
  final String? source;

  @JsonKey(name: 'SourceId')
  final int? sourceId;

  Source({this.dataType, this.source, this.sourceId});

  factory Source.fromJson(Map<String, dynamic> json) =>
      _$SourceFromJson(json);
  Map<String, dynamic> toJson() => _$SourceToJson(this);
}


@JsonSerializable()
class Region {
  @JsonKey(name: 'ID')
  final String? id;

  @JsonKey(name: 'LocalizedName')
  final String? localizedName;

  @JsonKey(name: 'EnglishName')
  final String? englishName;

  Region({this.id, this.localizedName, this.englishName});

  factory Region.fromJson(Map<String, dynamic> json) => _$RegionFromJson(json);
  Map<String, dynamic> toJson() => _$RegionToJson(this);
}

@JsonSerializable()
class Country {
  @JsonKey(name: 'ID')
  final String? id;

  @JsonKey(name: 'LocalizedName')
  final String? localizedName;

  @JsonKey(name: 'EnglishName')
  final String? englishName;

  Country({this.id, this.localizedName, this.englishName});

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class AdministrativeArea {
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

  AdministrativeArea({
    this.id,
    this.localizedName,
    this.englishName,
    this.level,
    this.localizedType,
    this.englishType,
    this.countryId,
  });

  factory AdministrativeArea.fromJson(Map<String, dynamic> json) => _$AdministrativeAreaFromJson(json);
  Map<String, dynamic> toJson() => _$AdministrativeAreaToJson(this);
}

@JsonSerializable()
class TimeZone {
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

  TimeZone({
    this.code,
    this.name,
    this.gmtOffset,
    this.isDaylightSaving,
    this.nextOffsetChange,
  });

  factory TimeZone.fromJson(Map<String, dynamic> json) => _$TimeZoneFromJson(json);
  Map<String, dynamic> toJson() => _$TimeZoneToJson(this);
}

@JsonSerializable()
class GeoPosition {
  @JsonKey(name: 'Latitude')
  final double? latitude;

  @JsonKey(name: 'Longitude')
  final double? longitude;

  @JsonKey(name: 'Elevation')
  final Elevation? elevation;

  GeoPosition({this.latitude, this.longitude, this.elevation});

  factory GeoPosition.fromJson(Map<String, dynamic> json) => _$GeoPositionFromJson(json);
  Map<String, dynamic> toJson() => _$GeoPositionToJson(this);
}

@JsonSerializable()
class Elevation {
  @JsonKey(name: 'Metric')
  final UnitValue? metric;

  @JsonKey(name: 'Imperial')
  final UnitValue? imperial;

  Elevation({this.metric, this.imperial});

  factory Elevation.fromJson(Map<String, dynamic> json) => _$ElevationFromJson(json);
  Map<String, dynamic> toJson() => _$ElevationToJson(this);
}

@JsonSerializable()
class UnitValue {
  @JsonKey(name: 'Value')
  final double? value;

  @JsonKey(name: 'Unit')
  final String? unit;

  @JsonKey(name: 'UnitType')
  final int? unitType;

  UnitValue({this.value, this.unit, this.unitType});

  factory UnitValue.fromJson(Map<String, dynamic> json) => _$UnitValueFromJson(json);
  Map<String, dynamic> toJson() => _$UnitValueToJson(this);
}

@JsonSerializable()
class ParentCity {
  @JsonKey(name: 'Key')
  final String? key;

  @JsonKey(name: 'LocalizedName')
  final String? localizedName;

  @JsonKey(name: 'EnglishName')
  final String? englishName;

  ParentCity({this.key, this.localizedName, this.englishName});

  factory ParentCity.fromJson(Map<String, dynamic> json) => _$ParentCityFromJson(json);
  Map<String, dynamic> toJson() => _$ParentCityToJson(this);
}
