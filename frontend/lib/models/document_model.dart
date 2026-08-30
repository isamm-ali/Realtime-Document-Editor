class DocumentModel {
  final String id;
  final String uid;
  final String title;
  final List<dynamic> content;

  DocumentModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.content,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['_id'],
      uid: json['uid'],
      title: json['title'],
      content: json['content'] ?? [],
    );
  }
}