import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/auth_repository_provider.dart';

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
    state = UserState(user: state.user, isLoading: true);
    try {
      final user = await ref.read(authRepositoryProvider).getUserData();

      state = UserState(user: user, isLoading: false);
    } catch (_) {
      state = const UserState(user: null, isLoading: false);
    }
  }

  void setUser(Map<String, dynamic> user) {
    state = UserState(user: user, isLoading: false);
  }

  void logout() {
    state = const UserState(user: null, isLoading: false);
  }
}

final userProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);
