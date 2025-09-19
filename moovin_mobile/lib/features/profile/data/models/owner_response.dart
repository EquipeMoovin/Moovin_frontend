// lib/features/profile/data/models/owner_response.dart
import 'package:json_annotation/json_annotation.dart';

// Importe os modelos que acabamos de criar
import '../../../property/data/models/property_response.dart';
// import 'owner_photo_response.dart';

part 'owner_response.g.dart';

@JsonSerializable()
class OwnerResponse {
  final int id;
  final int user; 
  final String name;
  final String? phone;
  final String? city;
  final String? state;

  
  
  final String? aboutMe;
  final double? revenueGenerated;
  final int? rentedProperties;
  final double? ratedByTenants;
  final int? recommendedByTenants;
  final bool? fastResponder;

  // Mapeia os serializers aninhados para listas dos modelos
  final List<PropertyResponse> properties;
  // final List<OwnerPhotoResponse>? photos;

  const OwnerResponse({
    required this.id,
    required this.user,
    required this.name,
    this.phone,
    this.city,
    this.state,
    this.aboutMe,
    this.revenueGenerated,
    this.rentedProperties,
    this.ratedByTenants,
    this.recommendedByTenants,
    this.fastResponder,
    required this.properties,
    // this.photos,
  });

  factory OwnerResponse.fromJson(Map<String, dynamic> json) =>
      _$OwnerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerResponseToJson(this);
}