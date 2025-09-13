// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  id: (json['id'] as num?)?.toInt(),
  email: json['email'] as String,
  name: json['name'] as String,
  username: json['username'] as String,
  userType: json['userType'] as String,
  token: json['token'] as String?,
  created: DateTime.parse(json['created'] as String),
  isActive: json['isActive'] as bool,
  isStaff: json['isStaff'] as bool,
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'username': instance.username,
      'userType': instance.userType,
      'token': instance.token,
      'created': instance.created,
      'isActive': instance.isActive,
      'isStaff': instance.isStaff,
    };
