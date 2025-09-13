import 'package:moovin_mobile/core/error/api_exception.dart';
import '../../data/repositories/auth_repository.dart';
import '/../../core/models/user.dart';

class LoginUseCase {
  final AuthRepository repository;

  const LoginUseCase(this.repository);

  Future<User> execute(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      throw ApiException('Email e senha são obrigatórios');
    }
    if (!email.contains('@')) {
      throw ApiException('Email inválido');
    }
    return repository.login(email, password);
  }
}