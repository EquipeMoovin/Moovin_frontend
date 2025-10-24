import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'network/api_client.dart';
import '../features/auth/data/services/auth_service.dart';
import '../features/auth/data/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/verify_email_usecase.dart';
import '../features/auth/domain/usecases/request_email_usecase.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';  

final sl = GetIt.instance;

Future<void> setup() async {
  // Core
  sl.registerSingleton<Dio>(ApiClient.create());

  // Data layer - Auth
  sl.registerLazySingleton<AuthService>(() => AuthService(sl<Dio>()));

  // Repository - Auth
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl<AuthService>()));

  // Domain - UseCase
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<VerifyEmailUseCase>(() => VerifyEmailUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton<RequestEmailVerificationUseCase>(() => RequestEmailVerificationUseCase(sl<AuthRepository>()));
  // Presentation - BLoC (Novo: registre como factory para injeção)
  sl.registerFactory<AuthBloc>(() => AuthBloc(
    requestEmailVerificationUseCase: sl<RequestEmailVerificationUseCase>(),
    verifyEmailUseCase: sl<VerifyEmailUseCase>(),
    loginUseCase: sl<LoginUseCase>(),
    repository: sl<AuthRepository>(),  
  ));
}