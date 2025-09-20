import 'package:equatable/equatable.dart';
import '../../../../core/models/user.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}
class AuthSuccess extends AuthState {
  final String message;

  const AuthSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class RegisterSuccess extends AuthState { 
  final String message;
  const RegisterSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RegisterError extends AuthState { 
  final String message;
  const RegisterError(this.message);

  @override
  List<Object> get props => [message];
}

// Estados para verificação de e-mail
class Verifying extends AuthState {
  @override
  List<Object> get props => [];
}
class EmailVerified extends AuthState {
  final String message;
  const EmailVerified(this.message);

  @override
  List<Object> get props => [message];
}
class EmailVerificationError extends AuthState {
  final String message;
  const EmailVerificationError(this.message);

  @override
  List<Object> get props => [message];
}


class AuthUnauthenticated extends AuthState {}  