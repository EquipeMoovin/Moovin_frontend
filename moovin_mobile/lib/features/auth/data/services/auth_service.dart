import 'package:dio/dio.dart';
import '../../../../core/error/api_exception.dart';
import '../models/auth_response.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<AuthResponse> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/login/',  // Ajuste o endpoint do seu Django (ex: com / no final)
        data: {'email': email, 'password': password},
      );
      // Assume que response.data é o User JSON
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      final message = e.response?.data['message'] ?? e.message ?? 'Falha no login';
      throw ApiException(message, code: e.response?.statusCode.toString());
    } catch (e) {
      throw ApiException('Erro inesperado: $e');
    }
  }
}