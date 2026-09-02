import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupState {
  final String username;
  final String email;
  final String password;
  final String pfp;

  const SignupState({
    this.username = '',
    this.email = '',
    this.password = '',
    this.pfp = '',
  });

  SignupState copyWith({
    String? username,
    String? email,
    String? password,
    String? pfp,
  }) {
    return SignupState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      pfp: pfp ?? this.pfp,
    );
  }
}

class SignupNotifier extends Notifier<SignupState> {
  @override
  SignupState build() {
    return const SignupState();
  }

  void setCredentials({
    required String username,
    required String email,
    required String password,
  }) {
    state = state.copyWith(
      username: username.trim(),
      email: email.trim().toLowerCase(),
      password: password,
    );
  }

  void setUsername(String username) {
    state = state.copyWith(username: username);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setPfp(String pfp) {
    state = state.copyWith(pfp: pfp);
  }

  void reset() {
    state = const SignupState();
  }
}

final signupProvider = NotifierProvider<SignupNotifier, SignupState>(
  SignupNotifier.new,
);
