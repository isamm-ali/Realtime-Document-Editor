import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/screens/login_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(userProvider.notifier).getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);

    return MaterialApp(
      home: userState.user == null ? const LoginScreen() : const HomePage(),
    );
  }
}
