// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TenantResponse _$TenantResponseFromJson(Map<String, dynamic> json) =>
    TenantResponse(
      id: (json['id'] as num?)?.toInt(),
      user: (json['user'] as num?)?.toInt(),
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      city: json['city'] as String,
      state: json['state'] as String,
      aboutMe: json['about_me'] as String?,
      prefersApartment: json['prefers_apartment'] as bool,
      prefersSharedRent: json['prefers_shared_rent'] as bool,
      prefersStudio: json['prefers_studio'] as bool,
      acceptsPets: json['accepts_pets'] as bool,
      fastResponder: json['fast_responder'] as bool,
      favoritedProperties: (json['favorited_properties'] as num).toInt(),
      memberSince: DateTime.parse(json['member_since'] as String),
      ratedByLandlords: (json['rated_by_landlords'] as num).toDouble(),
      recommendedByLandlords: (json['recommended_by_landlords'] as num)
          .toDouble(),
    );

Map<String, dynamic> _$TenantResponseToJson(TenantResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'name': instance.name,
      'age': instance.age,
      'city': instance.city,
      'state': instance.state,
      'about_me': instance.aboutMe,
      'prefers_studio': instance.prefersStudio,
      'prefers_apartment': instance.prefersApartment,
      'prefers_shared_rent': instance.prefersSharedRent,
      'accepts_pets': instance.acceptsPets,
      'rated_by_landlords': instance.ratedByLandlords,
      'recommended_by_landlords': instance.recommendedByLandlords,
      'favorited_properties': instance.favoritedProperties,
      'fast_responder': instance.fastResponder,
      'member_since': instance.memberSince.toIso8601String(),
    };
