import 'dart:convert';
import 'package:http/http.dart' as http;

class DocumentService {
  static const String baseUrl = 'http://localhost:5000';

  Future<Map<String, dynamic>> createDocument(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/doc/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      }),
    );

    final responseData = jsonDecode(response.body);

    return {
      'success': response.statusCode == 200,
      'message': responseData['message'] ?? 'Something went wrong',
      'document': response.statusCode == 200 ? responseData : null,
    };
  }
}