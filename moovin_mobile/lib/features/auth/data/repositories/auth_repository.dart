import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/models/user.dart';
import '../../../../core/error/api_exception.dart';
import '../services/auth_service.dart';
import '../models/auth_response.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User?> getCurrentUser();
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await _service.login(email, password);
      final user = User(
        id: response.id,
        email: response.email,
        name: response.name,
        username: response.username,
        userType: response.userType,
        role: response.userType == 'Proprietario' 
            ? Role.proprietario 
            : response.userType == 'Inquilino' 
                ? Role.inquilino 
                : Role.admin,
        created: response.created,
        isActive: response.isActive,
        isStaff: response.isStaff,
      );

      // Salva user e token no SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_json', jsonEncode(user.toJson()));
      await prefs.setString('access_token', response.token ?? '');  // Assuma que API retorna 'token'

      return user;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Erro no repositório: $e');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user_json');
    if (userJson == null) return null;
    final map = jsonDecode(userJson) as Map<String, dynamic>;
    return User.fromJson(map);
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}