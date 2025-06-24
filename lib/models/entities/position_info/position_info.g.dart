// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionInfo _$PositionInfoFromJson(Map<String, dynamic> json) => PositionInfo(
  version: (json['Version'] as num?)?.toInt(),
  key: json['Key'] as String?,
  type: json['Type'] as String?,
  rank: (json['Rank'] as num?)?.toInt(),
  localizedName: json['LocalizedName'] as String?,
  englishName: json['EnglishName'] as String?,
  primaryPostalCode: json['PrimaryPostalCode'] as String?,
  region:
      json['Region'] == null
          ? null
          : Region.fromJson(json['Region'] as Map<String, dynamic>),
  country:
      json['Country'] == null
          ? null
          : Country.fromJson(json['Country'] as Map<String, dynamic>),
  administrativeArea:
      json['AdministrativeArea'] == null
          ? null
          : AdministrativeArea.fromJson(
            json['AdministrativeArea'] as Map<String, dynamic>,
          ),
  timeZone:
      json['TimeZone'] == null
          ? null
          : TimeZone.fromJson(json['TimeZone'] as Map<String, dynamic>),
  geoPosition:
      json['GeoPosition'] == null
          ? null
          : GeoPosition.fromJson(json['GeoPosition'] as Map<String, dynamic>),
  isAlias: json['IsAlias'] as bool?,
  parentCity:
      json['ParentCity'] == null
          ? null
          : ParentCity.fromJson(json['ParentCity'] as Map<String, dynamic>),
  supplementalAdminAreas: json['SupplementalAdminAreas'] as List<dynamic>?,
  dataSets:
      (json['DataSets'] as List<dynamic>?)?.map((e) => e as String).toList(),
  details:
      json['Details'] == null
          ? null
          : Details.fromJson(json['Details'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PositionInfoToJson(PositionInfo instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'Key': instance.key,
      'Type': instance.type,
      'Rank': instance.rank,
      'LocalizedName': instance.localizedName,
      'EnglishName': instance.englishName,
      'PrimaryPostalCode': instance.primaryPostalCode,
      'Region': instance.region?.toJson(),
      'Country': instance.country?.toJson(),
      'AdministrativeArea': instance.administrativeArea?.toJson(),
      'TimeZone': instance.timeZone?.toJson(),
      'GeoPosition': instance.geoPosition?.toJson(),
      'IsAlias': instance.isAlias,
      'ParentCity': instance.parentCity?.toJson(),
      'SupplementalAdminAreas': instance.supplementalAdminAreas,
      'DataSets': instance.dataSets,
      'Details': instance.details?.toJson(),
    };

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
  key: json['Key'] as String?,
  stationCode: json['StationCode'] as String?,
  stationGmtOffset: (json['StationGmtOffset'] as num?)?.toDouble(),
  bandMap: json['BandMap'] as String?,
  climo: json['Climo'] as String?,
  localRadar: json['LocalRadar'] as String?,
  mediaRegion: json['MediaRegion'] as String?,
  metar: json['Metar'] as String?,
  nxMetro: json['NXMetro'] as String?,
  nxState: json['NXState'] as String?,
  population: (json['Population'] as num?)?.toInt(),
  primaryWarningCountyCode: json['PrimaryWarningCountyCode'] as String?,
  primaryWarningZoneCode: json['PrimaryWarningZoneCode'] as String?,
  satellite: json['Satellite'] as String?,
  synoptic: json['Synoptic'] as String?,
  marineStation: json['MarineStation'] as String?,
  marineStationGmtOffset: (json['MarineStationGMTOffset'] as num?)?.toDouble(),
  videoCode: json['VideoCode'] as String?,
  locationStem: json['LocationStem'] as String?,
  partnerId: json['PartnerID'] as String?,
  sources:
      (json['Sources'] as List<dynamic>?)
          ?.map((e) => Source.fromJson(e as Map<String, dynamic>))
          .toList(),
  canonicalPostalCode: json['CanonicalPostalCode'] as String?,
  canonicalLocationKey: json['CanonicalLocationKey'] as String?,
);

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
  'Key': instance.key,
  'StationCode': instance.stationCode,
  'StationGmtOffset': instance.stationGmtOffset,
  'BandMap': instance.bandMap,
  'Climo': instance.climo,
  'LocalRadar': instance.localRadar,
  'MediaRegion': instance.mediaRegion,
  'Metar': instance.metar,
  'NXMetro': instance.nxMetro,
  'NXState': instance.nxState,
  'Population': instance.population,
  'PrimaryWarningCountyCode': instance.primaryWarningCountyCode,
  'PrimaryWarningZoneCode': instance.primaryWarningZoneCode,
  'Satellite': instance.satellite,
  'Synoptic': instance.synoptic,
  'MarineStation': instance.marineStation,
  'MarineStationGMTOffset': instance.marineStationGmtOffset,
  'VideoCode': instance.videoCode,
  'LocationStem': instance.locationStem,
  'PartnerID': instance.partnerId,
  'Sources': instance.sources,
  'CanonicalPostalCode': instance.canonicalPostalCode,
  'CanonicalLocationKey': instance.canonicalLocationKey,
};

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
  dataType: json['DataType'] as String?,
  source: json['Source'] as String?,
  sourceId: (json['SourceId'] as num?)?.toInt(),
);

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
  'DataType': instance.dataType,
  'Source': instance.source,
  'SourceId': instance.sourceId,
};

Region _$RegionFromJson(Map<String, dynamic> json) => Region(
  id: json['ID'] as String?,
  localizedName: json['LocalizedName'] as String?,
  englishName: json['EnglishName'] as String?,
);

Map<String, dynamic> _$RegionToJson(Region instance) => <String, dynamic>{
  'ID': instance.id,
  'LocalizedName': instance.localizedName,
  'EnglishName': instance.englishName,
};

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  id: json['ID'] as String?,
  localizedName: json['LocalizedName'] as String?,
  englishName: json['EnglishName'] as String?,
);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'ID': instance.id,
  'LocalizedName': instance.localizedName,
  'EnglishName': instance.englishName,
};

AdministrativeArea _$AdministrativeAreaFromJson(Map<String, dynamic> json) =>
    AdministrativeArea(
      id: json['ID'] as String?,
      localizedName: json['LocalizedName'] as String?,
      englishName: json['EnglishName'] as String?,
      level: (json['Level'] as num?)?.toInt(),
      localizedType: json['LocalizedType'] as String?,
      englishType: json['EnglishType'] as String?,
      countryId: json['CountryID'] as String?,
    );

Map<String, dynamic> _$AdministrativeAreaToJson(AdministrativeArea instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'LocalizedName': instance.localizedName,
      'EnglishName': instance.englishName,
      'Level': instance.level,
      'LocalizedType': instance.localizedType,
      'EnglishType': instance.englishType,
      'CountryID': instance.countryId,
    };

TimeZone _$TimeZoneFromJson(Map<String, dynamic> json) => TimeZone(
  code: json['Code'] as String?,
  name: json['Name'] as String?,
  gmtOffset: (json['GmtOffset'] as num?)?.toDouble(),
  isDaylightSaving: json['IsDaylightSaving'] as bool?,
  nextOffsetChange: json['NextOffsetChange'] as String?,
);

Map<String, dynamic> _$TimeZoneToJson(TimeZone instance) => <String, dynamic>{
  'Code': instance.code,
  'Name': instance.name,
  'GmtOffset': instance.gmtOffset,
  'IsDaylightSaving': instance.isDaylightSaving,
  'NextOffsetChange': instance.nextOffsetChange,
};

GeoPosition _$GeoPositionFromJson(Map<String, dynamic> json) => GeoPosition(
  latitude: (json['Latitude'] as num?)?.toDouble(),
  longitude: (json['Longitude'] as num?)?.toDouble(),
  elevation:
      json['Elevation'] == null
          ? null
          : Elevation.fromJson(json['Elevation'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GeoPositionToJson(GeoPosition instance) =>
    <String, dynamic>{
      'Latitude': instance.latitude,
      'Longitude': instance.longitude,
      'Elevation': instance.elevation,
    };

Elevation _$ElevationFromJson(Map<String, dynamic> json) => Elevation(
  metric:
      json['Metric'] == null
          ? null
          : UnitValue.fromJson(json['Metric'] as Map<String, dynamic>),
  imperial:
      json['Imperial'] == null
          ? null
          : UnitValue.fromJson(json['Imperial'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ElevationToJson(Elevation instance) => <String, dynamic>{
  'Metric': instance.metric,
  'Imperial': instance.imperial,
};

ParentCity _$ParentCityFromJson(Map<String, dynamic> json) => ParentCity(
  key: json['Key'] as String?,
  localizedName: json['LocalizedName'] as String?,
  englishName: json['EnglishName'] as String?,
);

Map<String, dynamic> _$ParentCityToJson(ParentCity instance) =>
    <String, dynamic>{
      'Key': instance.key,
      'LocalizedName': instance.localizedName,
      'EnglishName': instance.englishName,
    };
