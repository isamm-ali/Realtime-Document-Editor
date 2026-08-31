import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/auth_service.dart';

class UserState {
  final Map<String, dynamic>? user;
  final bool isLoading;
  const UserState({this.user, this.isLoading = true});
}

class UserNotifier extends Notifier<UserState> {
  @override
  UserState build() {
    return const UserState();
  }

  Future<void> getUserData() async {
    final user = await AuthService().getStoredUserData();

    state = UserState(user: user, isLoading: false);
  }

  void logout() {
    state = const UserState(user: null, isLoading: false);
  }
}

final userProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);
