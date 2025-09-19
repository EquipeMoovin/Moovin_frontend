import 'package:json_annotation/json_annotation.dart';

// import 'tenant_photo_response.dart';

part 'tenant_response.g.dart'; 

@JsonSerializable()
class TenantResponse {
  final int? id;
  final int? user;
  final String name;
  final int age;
  final String city;
  final String state;

  @JsonKey(name: 'about_me')
  final String? aboutMe;

  @JsonKey(name: 'prefers_studio')
  final bool prefersStudio;

  @JsonKey(name: 'prefers_apartment')
  final bool prefersApartment;

  @JsonKey(name: 'prefers_shared_rent')
  final bool prefersSharedRent;

  @JsonKey(name: 'accepts_pets')
  final bool acceptsPets;

  @JsonKey(name: 'rated_by_landlords')
  final double ratedByLandlords;

  @JsonKey(name: 'recommended_by_landlords')
  final double recommendedByLandlords;

  @JsonKey(name: 'favorited_properties')
  final int favoritedProperties;

  @JsonKey(name: 'fast_responder')
  final bool fastResponder;

  @JsonKey(name: 'member_since')
  final DateTime memberSince;

  // final List<TenantPhotoResponse>? photos;

  const TenantResponse({
    this.id,
    this.user,
    required this.name,
    required this.age,
    required this.city,
    required this.state,
    this.aboutMe, 
    required this.prefersApartment,
    required this.prefersSharedRent,
    required this.prefersStudio,
    required this.acceptsPets,
    required this.fastResponder,
    required this.favoritedProperties,
    required this.memberSince,
    required this.ratedByLandlords,
    required this.recommendedByLandlords,
    // this.photos, 
  });

  factory TenantResponse.fromJson(Map<String, dynamic> json) =>
      _$TenantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TenantResponseToJson(this);
}