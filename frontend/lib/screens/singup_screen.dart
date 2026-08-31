import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/signup_provider.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/profilepic_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  static const _ink = Color(0xFF141414);
  static const _muted = Color(0xFF8A8A8A);
  static const _border = Color(0xFFE3E3E1);
  static const _fill = Color(0xFFFAFAF9);

  InputDecoration inputDecoration({
    required String hintText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: _muted, fontSize: 15),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: _fill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _ink, width: 1.4),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'SulfurDocs',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.4,
                          color: _ink,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.description_outlined, size: 26, color: _ink),
                    ],
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Create an account',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),

                  const SizedBox(height: 36),

                  TextField(
                    controller: usernameController,
                    style: const TextStyle(fontSize: 15, color: _ink),
                    decoration: inputDecoration(hintText: 'Choose a username'),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 15, color: _ink),
                    decoration: inputDecoration(hintText: 'Enter your email'),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    style: const TextStyle(fontSize: 15, color: _ink),
                    decoration: inputDecoration(
                      hintText: 'Set a password',
                      suffixIcon: IconButton(
                        splashRadius: 20,
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: _muted,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (usernameController.text.trim().isEmpty ||
                            emailController.text.trim().isEmpty ||
                            passwordController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("All fields are required"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        } else {
                          ref
                              .read(signupProvider.notifier)
                              .setUsername(usernameController.text.trim());
                          ref
                              .read(signupProvider.notifier)
                              .setEmail(emailController.text.trim());
                          ref
                              .read(signupProvider.notifier)
                              .setPassword(passwordController.text.trim());
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePic(),
                            ),
                          );
                        }
                      },
                      style:
                          ElevatedButton.styleFrom(
                            backgroundColor: _ink,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ).copyWith(
                            overlayColor: WidgetStateProperty.all(
                              Colors.white.withValues(alpha: 0.08),
                            ),
                          ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: _muted, fontSize: 13.5),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: _ink,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: _border,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
