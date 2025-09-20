import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<ResendVerificationCode>(_onResendVerificationCode);
    on<VerifyEmailSubmitted>(_onVerifyEmailSubmitted);
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
 
  Future<void> _onRegisterSubmitted(RegisterSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _repository.registerUser(event.userData);
      final prefs = await SharedPreferences.getInstance();
      final message = prefs.getString('register_message') ?? 'Cadastro realizado com sucesso!';
      emit(RegisterSuccess(message));
    } catch (e) {
      print('Erro no registro: $e');
      emit(RegisterError(e.toString()));
    }
  }

  Future<void> _onVerifyEmailSubmitted(VerifyEmailSubmitted event, Emitter<AuthState> emit) async {
    emit(Verifying());
    try {
      await _repository.verifyEmail(event.code);
      emit(const EmailVerified('Email verificado com sucesso!'));
    } catch (e) {
      print('Erro na verificação: $e');
      emit(EmailVerificationError(e.toString()));
    }
  }
  Future<void> _onResendVerificationCode(ResendVerificationCode event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _repository.resendVerificationCode(event.email);
      emit(const AuthSuccess('Código reenviado com sucesso!'));
    } catch (e) {
      print('Erro ao reenviar código: $e');
      emit(AuthError(e.toString()));
    }
  }

}