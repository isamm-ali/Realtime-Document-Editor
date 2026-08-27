import 'package:flutter_riverpod/flutter_riverpod.dart';

class SigninState {
  final String email;
  final String password;

  const SigninState({
    this.email = '',
    this.password = ''
  });
}

class SigninNotifier extends Notifier<SigninState> {
  @override
  SigninState build() {
    return const SigninState();
  }

  void setEmail(String email) {
    state = SigninState(
      email: email,
      password: state.password,
    );
  }

  void setPassword(String password) {
    state = SigninState(
      email: state.email,
      password: password,
    );
  }
}

final signinProvider =
    NotifierProvider<SigninNotifier, SigninState>(
  SigninNotifier.new,
);