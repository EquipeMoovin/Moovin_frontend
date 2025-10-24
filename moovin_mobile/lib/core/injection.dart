import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'network/api_client.dart';
import '../features/auth/data/services/auth_service.dart';
import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  // Core
  sl.registerSingleton<Dio>(ApiClient.create());

  // Data layer
  sl.registerLazySingleton<AuthService>(() => AuthService(sl<Dio>()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<AuthService>()));

  // Domain
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()));
}