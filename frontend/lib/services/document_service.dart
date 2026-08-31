import 'dart:convert';

import 'package:frontend/models/document_model.dart';
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
      body: jsonEncode({'createdAt': DateTime.now().millisecondsSinceEpoch}),
    );

    final responseData = jsonDecode(response.body);

    return {
      'success': response.statusCode == 200,
      'message': responseData['message'] ?? 'Something went wrong',
      'document': response.statusCode == 200 ? responseData : null,
    };
  }

  Future<Map<String, dynamic>> getDocuments(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/doc/me'),
      headers: {'Authorization': 'Bearer $token'},
    );

    final responseData = jsonDecode(response.body);

    List<DocumentModel> documents = [];

    if (response.statusCode == 200) {
      for (final document in responseData) {
        documents.add(DocumentModel.fromJson(document));
      }
    }

    return {
      'success': response.statusCode == 200,
      'message': response.statusCode == 200
          ? 'Documents fetched successfully'
          : 'Something went wrong',
      'documents': documents,
    };
  }
}
