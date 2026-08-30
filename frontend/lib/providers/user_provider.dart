import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/auth_service.dart';

class UserState {
  final Map<String, dynamic>? user;
  const UserState({
    this.user,
  });
}

class UserNotifier extends Notifier<UserState> {
  @override
  UserState build() {
    return const UserState();
  }
  Future<void> getUserData() async {
    final user = await AuthService().getUserData(AuthService.baseUrl);

    state = UserState(
      user: user,
    );
  }
  void logout() {
    state = const UserState();
  }
}

final userProvider =
    NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);