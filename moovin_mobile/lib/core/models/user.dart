// Enum interno para roles (mapeado de user_type)
enum Role { proprietario, inquilino, admin }

class User {
  final int? id;  //necessario ajuste a depender do backend
  final String email;
  final String name;
  final String username;
  final String userType;  
  final Role role; 
  final DateTime created;
  final bool isActive;
  final bool isStaff;

  const User({
    this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.userType,
    required this.role,
    required this.created,
    required this.isActive,
    required this.isStaff,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final userType = json['user_type'] as String? ?? '';
    Role role;
    switch (userType) {
      case 'Proprietario':
        role = Role.proprietario;
        break;
      case 'Inquilino':
        role = Role.inquilino;
        break;
      case 'Admin':
        role = Role.admin;
        break;
      default:
        role = Role.admin;  // Fallback
    }

    return User(
      id: json['id'] as int?,
      email: json['email'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      userType: userType,
      role: role,
      created: DateTime.parse(json['created'] as String),
      isActive: json['is_active'] as bool? ?? true,
      isStaff: json['is_staff'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'email': email,
      'name': name,
      'username': username,
      'user_type': userType,
      'created': created.toIso8601String(),
      'is_active': isActive,
      'is_staff': isStaff,
    };
  }
}