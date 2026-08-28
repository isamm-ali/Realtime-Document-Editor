import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/screens/singup_screen.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
                  // Logo
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
                    'Welcome back',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),

                  const SizedBox(height: 36),

                  // Email
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 15, color: _ink),
                    decoration: inputDecoration(hintText: 'Enter your email'),
                  ),

                  const SizedBox(height: 12),

                  // Password
                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    style: const TextStyle(fontSize: 15, color: _ink),
                    decoration: inputDecoration(
                      hintText: 'Enter your password',
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

                  const SizedBox(height: 14),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: _ink,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Sign in button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (emailController.text.trim().isEmpty ||
                            passwordController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("All fields are required"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final result = await AuthService.signin(
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        );

                        if (!context.mounted) return;

                        if (!result['success']) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result['message'])),
                          );
                          return;
                        }

                        final prefs = await SharedPreferences.getInstance();

                        await prefs.setString('token', result['token']);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
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
                        'Sign In',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: _muted, fontSize: 13.5),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign up',
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
