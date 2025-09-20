enum Role { proprietario, inquilino, admin }

class User {
  final int? id;
  final String email;
  final String name;
  final String username;
  final String userType;
  final Role role;
  final DateTime? created;
  final bool isActive;
  final bool isStaff;

  const User({
    this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.userType,
    required this.role,
    this.created,
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
        role = Role.admin;
    }

    return User(
      id: json['id'] as int?,
      email: json['email'] as String? ?? '',  // Fallback
      name: json['name'] as String? ?? '',
      username: json['username'] as String? ?? '',
      userType: userType,
      role: role,
      created: json['created'] != null 
          ? DateTime.tryParse(json['created'] as String) 
          : null,
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
      if (created != null) 'created': created!.toIso8601String(),
      'is_active': isActive,
      'is_staff': isStaff,
    };
  }
}