import '../../data/repositories/auth_repository.dart';

class ResetPasswordUsecase {
  final AuthRepository repository;

  ResetPasswordUsecase(this.repository);

  Future<void> call(String email, String newPassword) async {
    return await repository.resetPassword(email, newPassword);
  }
}
