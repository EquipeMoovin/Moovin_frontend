import 'package:json_annotation/json_annotation.dart';
part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final int? id;
  final String? email;  // Nullable agora
  final String? name;   // Nullable
  final String? username;
  final String? userType;
  final String? token;  // Para JWT
  final DateTime? created;  // Nullable, com fallback
  final bool? isActive;
  final bool? isStaff;

  const AuthResponse({
    this.id,
    this.email,
    this.name,
    this.username,
    this.userType,
    this.token,
    this.created,
    this.isActive,
    this.isStaff,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    // Fallbacks para nulls – isso evita o erro de subtipagem
    return AuthResponse(
      id: json['id'] as int?,
      email: json['email'] as String? ?? '',  // Se null, usa ''
      name: json['name'] as String? ?? '',    // Ajuste se o campo for 'first_name' + 'last_name' no Django
      username: json['username'] as String? ?? '',
      userType: json['user_type'] as String? ?? 'Admin',  // Fallback para role
      token: json['access'] as String? ?? json['token'] as String?,  // Para JWT (use 'access' se for simplejwt)
      created: json['created'] != null 
          ? DateTime.tryParse(json['created'] as String) 
          : null,
      isActive: json['is_active'] as bool? ?? true,
      isStaff: json['is_staff'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}