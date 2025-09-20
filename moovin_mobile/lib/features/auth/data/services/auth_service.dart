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
      final message = e.response?.data['message'] ?? e.message ?? 'Falha no login';
      throw ApiException(message, code: e.response?.statusCode.toString());
    } catch (e) {
      print('Erro geral: $e');
      throw ApiException('Erro inesperado: $e');
    }
  }

  Future<Map<String, dynamic>> registerUser(Map<String, dynamic> userData) async {
    try {
      
      final userTypeMap = {
        'inquilino': 'Inquilino',        
        'proprietario': 'Proprietario',  
      };
      
      // Criar cópia dos dados e ajustar o user_type
      final adjustedUserData = Map<String, dynamic>.from(userData);
      final originalUserType = userData['user_type'] as String;
      adjustedUserData['user_type'] = userTypeMap[originalUserType] ?? originalUserType;
      
      // Debugging logs
      print('📤 Enviando dados: $adjustedUserData');
      
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
        throw ApiException('Status de resposta inesperado: ${response.statusCode}');
      }
      
    } on DioException catch (e) {
      print(' Erro Dio: ${e.response?.statusCode} - ${e.response?.data}');
      final message = e.response?.data['error'] ?? 
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
  
  //Terminar implementação nas outras camadas...
  Future<Map<String, dynamic>> requestEmailVerification(String email) async {
    try {
      final response = await _dio.post(
        'api/users/request-email-verification/',
        data: {'email': email}, 
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data);
      } else {
        throw Exception(
          'Falha ao solicitar verificação de e-mail: ${response.statusCode} - ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        'Erro Dio na verificação de e-mail: ${e.response?.statusCode} - ${e.response?.data}',
      );
    } catch (e) {
      throw Exception('Erro inesperado na verificação de e-mail: $e');
    }
  }
}