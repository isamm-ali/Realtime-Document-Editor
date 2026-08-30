import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/providers/signup_provider.dart';

class AuthService {
  static const String baseUrl = 'http://localhost:5000';

  static Future<Map<String, dynamic>> signup(SignupState data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': data.username,
        'email': data.email,
        'password': data.password,
        'pfp': data.pfp,
      }),
    );
    final responseData = jsonDecode(response.body);
    return {
      'success': response.statusCode == 200,
      'message': responseData['message'] ?? 'Something went wrong',
    };
  }

  static Future<Map<String, dynamic>> signin({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signin'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    final responseData = jsonDecode(response.body);
    return {
      'success': response.statusCode == 200,
      'message': responseData['message'] ?? 'Something went wrong',
      'token': responseData['token'],
    };
  }

  Future<Map<String, dynamic>?> getUserData(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      return null;
    }
    final responseData = jsonDecode(response.body);
    return Map<String, dynamic>.from(responseData['user']);
  }

  Future<Map<String, dynamic>?> getStoredUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      return null;
    }
    return getUserData(token);
  }

}