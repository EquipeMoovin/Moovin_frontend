import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';  // Para token

class ApiClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8000',  // Ajuste para sua URL Django
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Adiciona token de auth se disponível
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';  // Ou 'Token $token' para Django
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Lógica de refresh token (implemente se sua API tiver refresh endpoint)
            // Ex: await refreshToken();
            // Se falhar, limpe prefs e redirecione para login
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
          }
          // Log de erro (sem dados sensíveis em prod)
          print('Dio Error: ${error.message}');  // Use logger em prod
          handler.next(error);
        },
      ),
    );

    return dio;
  }
}