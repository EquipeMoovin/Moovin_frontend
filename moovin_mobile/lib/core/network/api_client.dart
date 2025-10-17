import 'package:dio/dio.dart';

class ApiClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8000',  // Substitua pela sua API
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Adicione token de auth aqui se necessário
          handler.next(options);
        },
        onError: (error, handler) {
          // Tratamento global: ex: retry em 503, log de erros
          if (error.response?.statusCode == 401) {
            // Lógica de refresh token (integre com SharedPreferences)
          }
          handler.next(error);
        },
      ),
    );

    return dio;
  }
}