import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:frontend/providers/document_repository_provider.dart';
import 'package:frontend/models/document_model.dart';
import 'package:frontend/repositories/socket_repository.dart';

class DocumentScreen extends ConsumerStatefulWidget {
  final String id;
  const DocumentScreen({Key? key, required this.id}) : super(key: key);
  @override
  ConsumerState<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends ConsumerState<DocumentScreen> {
  final TextEditingController nameController = TextEditingController(
    text: 'Untitled Document',
  );
  final QuillController quillController = QuillController.basic();
  final SocketRepository socketRepository = SocketRepository();

  @override
  void initState() {
    super.initState();
    socketRepository.joinRoom(widget.id);
    fetchDocumentData();
    socketRepository.changeListener((data) {
      quillController.compose(
        Delta.fromJson(data['delta']),
        quillController.selection,
        ChangeSource.remote,
      );
    });

    quillController.document.changes.listen((event) {
      if (event.source == ChangeSource.local) {
        final Map<String, dynamic> data = {
          'delta': event.change,
          'room': widget.id,
        };

        socketRepository.typing(data);
      }
    });
  }

  Future<void> fetchDocumentData() async {
    final result = await ref
        .read(documentRepositoryProvider)
        .getDocument(id: widget.id);

    if (result['success']) {
      final document = result['document'];

      setState(() {
        nameController.text = document.title;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    quillController.dispose();
    super.dispose();
  }

  Future<void> nameDocument(String name) async {
    final result = await ref
        .read(documentRepositoryProvider)
        .nameDocuments(id: widget.id, title: name);
    if (!mounted) return;
    if (result['success']) {
      final DocumentModel updatedDocument = result['document'];
      print(updatedDocument.title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade800, width: 0.1),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.lock, size: 16, color: Colors.white),
              label: const Text('Share', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(26, 115, 232, 1),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Row(
            children: [
              Image.asset('assets/logo/docs-logo.png', height: 30, width: 23),
              const SizedBox(width: 10),
              SizedBox(
                width: 180,
                child: TextField(
                  controller: nameController,
                  onSubmitted: (value) {
                    if (value.trim().isNotEmpty) {
                      nameDocument(value.trim());
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromRGBO(26, 115, 232, 1),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 10),

            QuillSimpleToolbar(
              controller: quillController,
              config: const QuillSimpleToolbarConfig(),
            ),

            Expanded(
              child: SizedBox(
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: QuillEditor.basic(
                      controller: quillController,
                      config: const QuillEditorConfig(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
