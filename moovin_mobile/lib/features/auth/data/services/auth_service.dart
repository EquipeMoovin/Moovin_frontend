import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/api_exception.dart';
import '../models/auth_response.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/api/users/token',
        data: {'email': email, 'password': password},
      );
      // Debugging logs
      print('Resposta da API (JSON): ${response.data}');
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('Erro Dio: ${e.response?.data}');
      final message =
          e.response?.data['message'] ?? e.message ?? 'Falha no login';
      throw ApiException(message, code: e.response?.statusCode.toString());
    } catch (e) {
      print('Erro geral: $e');
      throw ApiException('Erro inesperado: $e');
    }
  }

  Future<Map<String, dynamic>> registerUser(
    Map<String, dynamic> userData,
  ) async {
    try {
      final userTypeMap = {
        'inquilino': 'Inquilino',
        'proprietario': 'Proprietario',
      };

      // Criar cópia dos dados e ajustar o user_type
      final adjustedUserData = Map<String, dynamic>.from(userData);
      final originalUserType = userData['user_type'] as String;
      adjustedUserData['user_type'] =
          userTypeMap[originalUserType] ?? originalUserType;

      // Debugging logs
      print(' Enviando dados: $adjustedUserData');

      final response = await _dio.post(
        '/api/users/register',
        data: adjustedUserData,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      // Debugging logs
      print(' Registro bem-sucedido!');
      print(' Status: ${response.statusCode}');
      print('Resposta: ${response.data}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;

        // Salvar dados do usuário
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('name', userData['name']);
        await prefs.setString('email', userData['email']);
        await prefs.setString('userType', adjustedUserData['user_type']);

        return Map<String, dynamic>.from(data);
      } else {
        throw ApiException(
          'Status de resposta inesperado: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print(' Erro Dio: ${e.response?.statusCode} - ${e.response?.data}');
      final message =
          e.response?.data['error'] ??
          e.response?.data['message'] ??
          e.message ??
          'Falha no registro';
      throw ApiException(message, code: e.response?.statusCode.toString());
    } catch (e) {
      if (e is ApiException) rethrow;
      print(' Erro geral: $e');
      throw ApiException('Erro inesperado: $e');
    }
  }

  Future<void> verifyEmail(String code, String email) async {
    try {
      print('🔍 Verificando email: $email com código: $code');
      final response = await _dio.post(
        '/api/users/verify-email-code/',
        data: {'email': email, 'code': code},
      );
      print('✅ Verificação bem-sucedida: ${response.data}');
    } on DioException catch (e) {
      print(
        '❌ Erro na verificação: ${e.response?.statusCode} - ${e.response?.data}',
      );
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          e.message ??
          'Falha na verificação';
      throw ApiException(message, code: e.response?.statusCode.toString());
    } catch (e) {
      print('❌ Erro geral na verificação: $e');
      throw ApiException('Erro inesperado: $e');
    }
  }

  Future<Map<String, dynamic>> requestEmailVerification(String email) async {
    try {
      print('📤 Solicitando código de verificação para: $email');

      final response = await _dio.post(
        '/api/users/request-email-verification/',
        data: {'email': email},
      );

      print('✅ Código solicitado com sucesso: ${response.data}');
      return Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      print(
        'Erro ao solicitar código: ${e.response?.statusCode} - ${e.response?.data}',
      );
      final message =
          e.response?.data['message'] ??
          e.response?.data['error'] ??
          e.message ??
          'Erro ao solicitar verificação';
      throw ApiException(message, code: e.response?.statusCode.toString());
    } catch (e) {
      print('❌ Erro geral: $e');
      throw ApiException('Erro inesperado: $e');
    }
  }

  Future<void> resendVerificationCode(String email) async {
    try {
      final response = await _dio.post(
        '/api/auth/resend-code', 
        data: {'email': email},
      );
      print('Código reenviado: ${response.data}');
    } on DioException catch (e) {
      print('Erro ao reenviar: ${e.response?.data}');
      final message =
          e.response?.data['message'] ??
          e.message ??
          'Falha ao reenviar código';
      throw ApiException(message, code: e.response?.statusCode.toString());
    } catch (e) {
      print('Erro geral ao reenviar: $e');
      throw ApiException('Erro inesperado: $e');
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    try {
      final response = await _dio.post(
        '/api/users/password-reset/',
        data: {'email': email, 'new_password': newPassword},
      );
      print('Senha redefinida com sucesso: ${response.data}');
    } on DioException catch (e) {
      print('Erro ao redefinir senha: ${e.response?.data}');
      throw ApiException('Erro ao redefinir senha: ${e.response?.data}');
    } catch (e) {
      print('Erro geral ao redefinir senha: $e');
      throw ApiException('Erro inesperado: $e');
    }
  }

  //Metodos de get e update do user necessarios no futuro.
}
