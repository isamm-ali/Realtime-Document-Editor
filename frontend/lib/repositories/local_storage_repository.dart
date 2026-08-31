import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  Future<void> setToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', token);
  }

  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }

  Future<void> removeToken() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove('token');
  }
}