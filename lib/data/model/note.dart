class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  // ── SQLite ⇆ Dart ───────────────────────────────────────────────
  factory Note.fromMap(Map<String, Object?> map) => Note(
        id: map['id'] as int,
        title: map['title'] as String,
        content: map['content'] as String,
        createdAt: map['created_at'] as DateTime,
        updatedAt: map['updated_at'] as DateTime,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  Note copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
