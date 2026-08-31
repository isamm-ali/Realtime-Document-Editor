import 'package:frontend/repositories/local_storage_repository.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/providers/signup_provider.dart';

class AuthRepository {
  final AuthService authService;
  final LocalStorageRepository localStorage;

  AuthRepository({required this.authService, required this.localStorage});

  Future<Map<String, dynamic>> signup(SignupState data) async {
    return await AuthService.signup(data);
  }

  Future<Map<String, dynamic>> signin({
    required String email,
    required String password,
  }) async {
    final result = await AuthService.signin(email: email, password: password);
    if (result['success']) {
      await localStorage.setToken(result['token']);
    }
    return result;
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final token = await localStorage.getToken();

    if (token == null) {
      return null;
    }

    final user = await authService.getUserData(token);

    if (user == null) {
      return null;
    }

    return {...user, 'token': token};
  }

  Future<void> signOut() async {
    await localStorage.removeToken();
  }
}
