import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/models/user.dart';
import '../../../../core/error/api_exception.dart';
import '../services/auth_service.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await _service.login(email, password);
      // Converte model para entity (User)
      final user = User(
        id: response.id,
        email: response.email,
        name: response.name,
        username: response.username,
        userType: response.userType,
        role: response.userType == 'Proprietario' 
            ? Role.proprietario 
            : response.userType == 'Inquilino' 
                ? Role.inquilino 
                : Role.admin,
        created: response.created,
        isActive: response.isActive,
        isStaff: response.isStaff,
      );
      // Cache do user (salve como JSON para persistência)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', user.toJson().toString());
      return user;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Erro no repositório: $e');
    }
  }
}