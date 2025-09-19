// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyResponse _$PropertyResponseFromJson(Map<String, dynamic> json) =>
    PropertyResponse(
      owner: (json['owner'] as num).toInt(),
      idProperty: json['id_property'] as String,
      propertyType:
          $enumDecodeNullable(_$PropertyTypeEnumMap, json['property_type']) ??
          PropertyType.unknown,
      zipCode: json['zip_code'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      number: json['number'] as String?,
      noNumber: json['no_number'] as bool,
      bedrooms: (json['bedrooms'] as num).toInt(),
      bathrooms: (json['bathrooms'] as num).toInt(),
      area: (json['area'] as num).toDouble(),
      rent: (json['rent'] as num).toDouble(),
      airConditioning: json['air_conditioning'] as bool,
      garage: json['garage'] as bool,
      pool: json['pool'] as bool,
      furnished: json['furnished'] as bool,
      petFriendly: json['pet_friendly'] as bool,
      nearbyMarket: json['nearby_market'] as bool,
      nearbyBus: json['nearby_bus'] as bool,
      internet: json['internet'] as bool,
      description: json['description'] as String?,
      additionalRules: json['additional_rules'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$PropertyResponseToJson(PropertyResponse instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'id_property': instance.idProperty,
      'property_type': _$PropertyTypeEnumMap[instance.propertyType]!,
      'zip_code': instance.zipCode,
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'number': instance.number,
      'no_number': instance.noNumber,
      'bedrooms': instance.bedrooms,
      'bathrooms': instance.bathrooms,
      'area': instance.area,
      'rent': instance.rent,
      'air_conditioning': instance.airConditioning,
      'garage': instance.garage,
      'pool': instance.pool,
      'furnished': instance.furnished,
      'pet_friendly': instance.petFriendly,
      'nearby_market': instance.nearbyMarket,
      'nearby_bus': instance.nearbyBus,
      'internet': instance.internet,
      'description': instance.description,
      'additional_rules': instance.additionalRules,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$PropertyTypeEnumMap = {
  PropertyType.apartamento: 'Apartamento',
  PropertyType.casa: 'Casa',
  PropertyType.kitnet: 'Kitnet',
  PropertyType.unknown: 'unknown',
};
