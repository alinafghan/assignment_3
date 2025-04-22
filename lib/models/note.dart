class Note {
  String id;
  String title;
  String content;
  String category;
  bool pinned;

  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.category,
      required this.pinned});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'category': category,
        'pinned': pinned,
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        category: json['category'],
        pinned: json['pinned'] ?? false,
      );
}
