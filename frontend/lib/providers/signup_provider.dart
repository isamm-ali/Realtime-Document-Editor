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
}

class SignupNotifier extends Notifier<SignupState> {
  @override
  SignupState build() {
    return const SignupState();
  }

   void setUsername(String username) {
    state = SignupState(
      username: username,
      email: state.email,
      password: state.password,
      pfp: state.pfp,
    );
  }

  void setEmail(String email) {
    state = SignupState(
      username: state.username,
      email: email,
      password: state.password,
      pfp: state.pfp,
    );
  }

  void setPassword(String password) {
    state = SignupState(
      username: state.username,
      email: state.email,
      password: password,
      pfp: state.pfp,
    );
  }

  void setPfp(String pfp) {
    state = SignupState(
      username: state.username,
      email: state.email,
      password: state.password,
      pfp: pfp,
    );
  }
}

final signupProvider =
    NotifierProvider<SignupNotifier, SignupState>(
  SignupNotifier.new,
);