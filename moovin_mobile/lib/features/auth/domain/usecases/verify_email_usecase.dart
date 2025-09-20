import '../../data/repositories/auth_repository.dart';

class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<void> call(String code,String email) async {
    return await repository.verifyEmail(code,email);
  }
}
