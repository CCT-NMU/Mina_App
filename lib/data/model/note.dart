class Note {
  final int? id;
  final String? userId; // Optional userId for multi-user support
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    this.id,
    this.userId, // Optional userId for multi-user support
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // ── SQLite ⇆ Dart ───────────────────────────────────────────────
  factory Note.fromMap(Map<String, Object?> map) => Note(
        id: map['id'] as int,
        userId: map['user_id'] as String?, // Optional userId
        title: map['title'] as String,
        content: map['content'] as String,
        createdAt: map['created_at'] as DateTime,
        updatedAt: map['updated_at'] as DateTime,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'user_id': userId, // Optional userId
        'title': title,
        'content': content,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  Note copyWith({
    int? id,
    String? userId,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Note(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  static List<Note> fromJson(note) {
    return (note as List).map((item) => Note.fromMap(item)).toList();
  }
}
