import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/models/document_model.dart';
import 'package:frontend/widgets/loader.dart';
import 'package:routemaster/routemaster.dart';
import 'package:frontend/providers/auth_repository_provider.dart';
import 'package:frontend/providers/document_repository_provider.dart';
import 'package:frontend/providers/user_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future<Map<String, dynamic>> documentsFuture;

  @override
  void initState() {
    super.initState();
    documentsFuture = ref.read(documentRepositoryProvider).getDocuments();
  }

  void refreshDocuments() {
    setState(() {
      documentsFuture = ref.read(documentRepositoryProvider).getDocuments();
    });
  }

  Future<void> signOut(WidgetRef ref) async {
    final authRepo = ref.read(authRepositoryProvider);
    await authRepo.signOut();
    if (!mounted) return;
    ref.read(userProvider.notifier).logout();
  }

  Future<void> createDocument(BuildContext context, WidgetRef ref) async {
    try {
      final result = await ref
          .read(documentRepositoryProvider)
          .createDocument();

      if (result['success']) {
        final document = result['document'];

        await Routemaster.of(context).push('/document/${document['_id']}');
        refreshDocuments();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => createDocument(context, ref),
            icon: const Icon(Icons.add, color: Colors.black),
          ),
          IconButton(
            onPressed: () => signOut(ref),
            icon: const Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),

      body: FutureBuilder<Map<String, dynamic>>(
        future: documentsFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No documents found'));
          }

          final documents = snapshot.data!['documents'] as List<DocumentModel>;

          if (documents.isEmpty) {
            return const Center(child: Text('No documents yet'));
          }

          return Center(
            child: Container(
              width: 600,
              margin: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final DocumentModel document = documents[index];

                  return SizedBox(
                    child: Card(
                      child: ListTile(
                        title: Text(
                          document.title,
                          style: TextStyle(fontSize: 17),
                        ),
                        onTap: () async {
                          await Routemaster.of(context)
                              .push('/document/${document.id}');
                          refreshDocuments();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
