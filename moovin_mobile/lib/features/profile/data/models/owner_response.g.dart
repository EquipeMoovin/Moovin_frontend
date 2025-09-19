// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerResponse _$OwnerResponseFromJson(Map<String, dynamic> json) =>
    OwnerResponse(
      id: (json['id'] as num).toInt(),
      user: (json['user'] as num).toInt(),
      name: json['name'] as String,
      phone: json['phone'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      aboutMe: json['aboutMe'] as String?,
      revenueGenerated: (json['revenueGenerated'] as num?)?.toDouble(),
      rentedProperties: (json['rentedProperties'] as num?)?.toInt(),
      ratedByTenants: (json['ratedByTenants'] as num?)?.toDouble(),
      recommendedByTenants: (json['recommendedByTenants'] as num?)?.toInt(),
      fastResponder: json['fastResponder'] as bool?,
      properties: (json['properties'] as List<dynamic>)
          .map((e) => PropertyResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OwnerResponseToJson(OwnerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'name': instance.name,
      'phone': instance.phone,
      'city': instance.city,
      'state': instance.state,
      'aboutMe': instance.aboutMe,
      'revenueGenerated': instance.revenueGenerated,
      'rentedProperties': instance.rentedProperties,
      'ratedByTenants': instance.ratedByTenants,
      'recommendedByTenants': instance.recommendedByTenants,
      'fastResponder': instance.fastResponder,
      'properties': instance.properties,
    };
