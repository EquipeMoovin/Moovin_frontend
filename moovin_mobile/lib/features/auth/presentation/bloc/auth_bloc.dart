import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/injection.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../data/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final AuthRepository _repository;

  AuthBloc({LoginUseCase? loginUseCase, AuthRepository? repository})
      : _loginUseCase = loginUseCase ?? sl<LoginUseCase>(),
        _repository = repository ?? sl<AuthRepository>(),
        super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginSubmitted>(_onLoginSubmitted);
    // Adicione on<LogoutRequested> se precisar
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _repository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await _loginUseCase.execute(event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}