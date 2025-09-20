import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/models/user.dart';
import '../../../../core/error/api_exception.dart';
import '../services/auth_service.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> registerUser(Map<String, dynamic> userData);
  Future<User?> getCurrentUser();
  Future<void> logout();
  Future<void> requestEmailVerification(String email);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<void> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await _service.registerUser(userData);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('register_message', response['message'] ?? 'Cadastro realizado! Verifique seu email');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Erro no registro: $e');
    }
  }
  @override
  Future<void> requestEmailVerification(String email) async {
    try {
      final response = await _service.requestEmailVerification(email);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('verification_message', response['message'] ?? 'Verificação enviada!');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Erro ao solicitar verificação de e-mail: $e');
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await _service.login(email, password);
      final user = User(
        id: response.id,
        email: response.email ?? '',  
        name: response.name ?? '',
        username: response.username ?? '',
        userType: response.userType ?? 'Admin',
        role: response.userType == 'Proprietario' 
            ? Role.proprietario 
            : response.userType == 'Inquilino' 
                ? Role.inquilino 
                : Role.admin,
        created: response.created,
        isActive: response.isActive ?? true,
        isStaff: response.isStaff ?? false,
      );

      // Cache...
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_json', jsonEncode(user.toJson()));
      await prefs.setString('access_token', response.token ?? '');

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