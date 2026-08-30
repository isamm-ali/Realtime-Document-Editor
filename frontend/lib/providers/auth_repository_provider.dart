import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/repositories/auth_repository.dart';
import 'package:frontend/repositories/local_storage_repository.dart';
import 'package:frontend/services/auth_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    authService: AuthService(),
    localStorage: LocalStorageRepository(),
  );
});