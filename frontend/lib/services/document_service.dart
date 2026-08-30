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
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception(data['message'] ?? 'Failed to create document');
  }
}