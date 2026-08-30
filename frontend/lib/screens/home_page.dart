import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/providers/auth_repository_provider.dart';
import 'package:frontend/providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const new({super.key});

  Future<void> signOut(WidgetRef ref) async {
    await ref.read(authRepositoryProvider).signOut();
    ref.read(userProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              signOut(ref);
            },
            icon: Icon(Icons.add, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
