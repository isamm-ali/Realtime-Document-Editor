import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/repositories/document_repository.dart';
import 'package:frontend/repositories/local_storage_repository.dart';
import 'package:frontend/services/document_service.dart';

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  return DocumentRepository(
    documentService: DocumentService(),
    localStorage: LocalStorageRepository(),
  );
});