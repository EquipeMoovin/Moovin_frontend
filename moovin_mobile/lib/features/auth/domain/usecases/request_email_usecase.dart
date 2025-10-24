import '../../data/repositories/auth_repository.dart';
class RequestEmailVerificationUseCase {
  final AuthRepository repository;

  RequestEmailVerificationUseCase(this.repository);

  Future<void> call(String email) async {
    return await repository.requestEmailVerification(email);
  }
}
