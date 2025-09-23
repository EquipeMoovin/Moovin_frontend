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
  Future<void> verifyEmail(String code, String email);
  Future<void> requestEmailVerification(String email);
  Future<void> resetPassword(String email, String newPassword);
  Future<void> resendVerificationCode(String email);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<void> registerUser(Map<String, dynamic> userData) async {
    try {
      final response = await _service.registerUser(userData);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        'register_message',
        response['message'] ?? 'Cadastro realizado! Verifique seu email',
      );
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Erro no registro: $e');
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
  Future<void> verifyEmail(String code, String email) async {
    try {
      await _service.verifyEmail(code, email);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('email_verified', true);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Erro na verificação: $e');
    }
  }

  @override
  Future<void> requestEmailVerification(String email) async {
    try {
      final response = await _service.requestEmailVerification(email);
      print('Código de verificação solicitado: $response');

      // Salva informação de que o código foi solicitado
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('verification_email', email);
      await prefs.setBool('verification_requested', true);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Erro ao solicitar código de verificação: $e');
    }
  }

  @override
  Future<void> resendVerificationCode(String email) async {
    try {
      await _service.resendVerificationCode(email);
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Erro ao reenviar código: $e');
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

  @override
  Future<void> resetPassword(String email, String newPassword) async {
    try {
      await _service.resetPassword(email, newPassword);
      print('Solicitação de recuperação de senha enviada');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Erro ao solicitar recuperação de senha: $e');
    }
  }
}
