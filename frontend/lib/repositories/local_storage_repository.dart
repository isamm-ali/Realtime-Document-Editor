import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  Future<void> setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    return token;
  }
}