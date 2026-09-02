import 'package:frontend/repositories/local_storage_repository.dart';
import 'package:frontend/services/document_service.dart';

class DocumentRepository {
  final DocumentService documentService;
  final LocalStorageRepository localStorage;

  DocumentRepository({
    required this.documentService,
    required this.localStorage,
  });

  Future<Map<String, dynamic>> createDocument() async {
    final token = await localStorage.getToken();
    if (token == null) {
      throw Exception('User is not authenticated');
    }
    return await documentService.createDocument(token);
  }

  Future<Map<String, dynamic>> getDocuments() async {
    final token = await localStorage.getToken();
    if (token == null) {
      throw Exception('User is not authenticated');
    }
    return await documentService.getDocuments(token);
  }

  Future<Map<String, dynamic>> getDocument({required String id}) async {
    final token = await localStorage.getToken();

    if (token == null) {
      throw Exception('User is not authenticated');
    }

    return await documentService.getDocument(token, id);
  }

  Future<Map<String, dynamic>> nameDocuments({
    required String id,
    required String title,
  }) async {
    final token = await localStorage.getToken();

    if (token == null) {
      throw Exception('User is not authenticated');
    }

    return await documentService.nameDocuments(
      token: token,
      id: id,
      title: title,
    );
  }
}
