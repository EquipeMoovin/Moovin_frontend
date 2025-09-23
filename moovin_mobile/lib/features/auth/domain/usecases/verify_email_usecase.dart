import '../../data/repositories/auth_repository.dart';

class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<void> call(String code, String email) async {
    print('🔧 VerifyEmailUseCase: Iniciando verificação');
    print('🔧 Email: $email, Código: $code');
    try {
      final result = await repository.verifyEmail(code, email);
      print('🔧 VerifyEmailUseCase: Verificação concluída com sucesso');
      return result;
    } catch (e) {
      print('🔧 VerifyEmailUseCase: Erro - $e');
      rethrow;
    }
  }
}
