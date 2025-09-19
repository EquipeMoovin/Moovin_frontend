// lib/features/property/data/models/property_response.dart
import 'package:json_annotation/json_annotation.dart';
import '../../../../core/models/property.dart';
// import 'property_photo_response.dart';

part 'property_response.g.dart';

@JsonSerializable()
class PropertyResponse {
  final int owner;

  @JsonKey(name: 'id_property') // Mapeia 'id_property' do JSON para idProperty
  final String idProperty;

  @JsonKey(name: 'property_type', defaultValue: PropertyType.unknown)
  final PropertyType propertyType;

  @JsonKey(name: 'zip_code')
  final String zipCode;

  final String state;
  final String city;
  final String street;
  final String? number;

  @JsonKey(name: 'no_number')
  final bool noNumber;

  final int bedrooms;
  final int bathrooms;
  final double area;
  final double rent;

  @JsonKey(name: 'air_conditioning')
  final bool airConditioning;

  final bool garage;
  final bool pool;
  final bool furnished;

  @JsonKey(name: 'pet_friendly')
  final bool petFriendly;

  @JsonKey(name: 'nearby_market')
  final bool nearbyMarket;

  @JsonKey(name: 'nearby_bus')
  final bool nearbyBus;

  final bool internet;
  final String? description;

  @JsonKey(name: 'additional_rules')
  final String? additionalRules;

  final String status;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  // // O source 'photos_blob' no serializer define o nome da chave no JSON
  // @JsonKey(name: 'photosBlob')
  // final List<PropertyPhotoResponse> photosBlob;

  const PropertyResponse({
    required this.owner,
    required this.idProperty,
    required this.propertyType,
    required this.zipCode,
    required this.state,
    required this.city,
    required this.street,
    this.number,
    required this.noNumber,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.rent,
    required this.airConditioning,
    required this.garage,
    required this.pool,
    required this.furnished,
    required this.petFriendly,
    required this.nearbyMarket,
    required this.nearbyBus,
    required this.internet,
    this.description,
    this.additionalRules,
    required this.status,
    required this.createdAt,
    // required this.photosBlob,
  });

  factory PropertyResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyResponseToJson(this);
}