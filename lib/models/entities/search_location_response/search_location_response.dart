import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_location_response.g.dart';

@JsonSerializable()
class SearchLocationResponse extends Equatable {
  const SearchLocationResponse({this.meta, this.addresses});

  factory SearchLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchLocationResponseFromJson(json);

  final Meta? meta;
  final List<Address>? addresses;

  @override
  List<Object?> get props => [meta, addresses];
}

@JsonSerializable()
class Meta extends Equatable {
  const Meta({this.code});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
  final int? code;

  @override
  List<Object?> get props => [code];
}

@JsonSerializable()
class Address extends Equatable {
  const Address({
    this.addressLabel,
    this.city,
    this.country,
    this.countryCode,
    this.countryFlag,
    this.county,
    this.formattedAddress,
    this.geometry,
    this.latitude,
    this.longitude,
    this.state,
    this.layer,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  final String? addressLabel;
  final String? city;
  final String? country;
  final String? countryCode;
  final String? countryFlag;
  final String? county;
  final String? formattedAddress;
  final Geometry? geometry;
  final double? latitude;
  final double? longitude;
  final String? state;
  final String? layer;

  @override
  List<Object?> get props => [
    addressLabel,
    city,
    country,
    countryCode,
    countryFlag,
    county,
    formattedAddress,
    geometry,
    latitude,
    longitude,
    state,
    layer,
  ];
}

@JsonSerializable()
class Geometry extends Equatable {
  const Geometry({required this.type, required this.coordinates});

  factory Geometry.fromJson(Map<String, dynamic> json) => _$GeometryFromJson(json);

  final String? type;
  final List<double>? coordinates;

  @override
  List<Object?> get props => [type, coordinates];
}
