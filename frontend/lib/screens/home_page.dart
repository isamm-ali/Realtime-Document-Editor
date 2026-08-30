import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:frontend/providers/auth_repository_provider.dart';
import 'package:frontend/providers/document_repository_provider.dart';
import 'package:frontend/providers/user_provider.dart';

class HomePage extends ConsumerWidget {
  const new({super.key});

  Future<void> signOut(WidgetRef ref) async {
    await ref.read(authRepositoryProvider).signOut();
    ref.read(userProvider.notifier).logout();
  }

  Future<void> createDocument(BuildContext context, WidgetRef ref) async {
    try {
      final result = await ref
          .read(documentRepositoryProvider)
          .createDocument();
      if (result['success']) {
        final document = result['document'];
        Routemaster.of(context).push('/document/${document['_id']}');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Failed to create document'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              createDocument(context, ref);
            },
            icon: Icon(Icons.add, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              signOut(ref);
            },
            icon: Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
