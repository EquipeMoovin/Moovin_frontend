import 'package:json_annotation/json_annotation.dart';
part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final int? id;
  final String email;
  final String name;
  final String username;
  final String userType;
  final String? token;  
  final DateTime created;
  final bool isActive;
  final bool isStaff;

  const AuthResponse({
    this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.userType,
    this.token,
    required this.created,
    required this.isActive,
    required this.isStaff,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}