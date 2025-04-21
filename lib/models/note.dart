class Note {
  String id;
  String title;
  String content;
  String category;

  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.category});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'category': category,
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        category: json['category'],
      );
}
