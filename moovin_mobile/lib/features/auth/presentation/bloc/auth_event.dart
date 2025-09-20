import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class RegisterSubmitted extends AuthEvent {
  final Map<String, dynamic> userData;

  const RegisterSubmitted(this.userData);

  @override
  List<Object> get props => [userData];
}

class VerifyEmailSubmitted extends AuthEvent {
  final String code;

  const VerifyEmailSubmitted(this.code);

  @override
  List<Object> get props => [code];
}
class ResendVerificationCode extends AuthEvent {
  final String email;

  const ResendVerificationCode(this.email);

  @override
  List<Object> get props => [email];
}


class CheckAuthStatus extends AuthEvent {}