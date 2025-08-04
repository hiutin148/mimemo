// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchLocationResponse _$SearchLocationResponseFromJson(
  Map<String, dynamic> json,
) => SearchLocationResponse(
  meta: json['meta'] == null
      ? null
      : Meta.fromJson(json['meta'] as Map<String, dynamic>),
  addresses: (json['addresses'] as List<dynamic>?)
      ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SearchLocationResponseToJson(
  SearchLocationResponse instance,
) => <String, dynamic>{'meta': instance.meta, 'addresses': instance.addresses};

Meta _$MetaFromJson(Map<String, dynamic> json) =>
    Meta(code: (json['code'] as num?)?.toInt());

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  'code': instance.code,
};

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  addressLabel: json['addressLabel'] as String?,
  city: json['city'] as String?,
  country: json['country'] as String?,
  countryCode: json['countryCode'] as String?,
  countryFlag: json['countryFlag'] as String?,
  county: json['county'] as String?,
  formattedAddress: json['formattedAddress'] as String?,
  geometry: json['geometry'] == null
      ? null
      : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  state: json['state'] as String?,
  layer: json['layer'] as String?,
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'addressLabel': instance.addressLabel,
  'city': instance.city,
  'country': instance.country,
  'countryCode': instance.countryCode,
  'countryFlag': instance.countryFlag,
  'county': instance.county,
  'formattedAddress': instance.formattedAddress,
  'geometry': instance.geometry,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'state': instance.state,
  'layer': instance.layer,
};

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
  type: json['type'] as String?,
  coordinates: (json['coordinates'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
  'type': instance.type,
  'coordinates': instance.coordinates,
};
