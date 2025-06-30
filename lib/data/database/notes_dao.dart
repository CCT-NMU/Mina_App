import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/note.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [AppNotes])
class AppNotesDao extends DatabaseAccessor<AppDatabase>
    with _$AppNotesDaoMixin {
  AppNotesDao(AppDatabase db) : super(db);

  /// Inserts a Note model and returns the generated id.
  Future<int> insertNoteFromModel(Note note) async {
    final companion = AppNotesCompanion.insert(
      userId: note.userId!,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
    );
    final id = await into(appNotes).insert(companion);
    return id;
  }

  Future<List<Note>> getNotes(String userId) async {
    final rows = await (select(appNotes)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
    return rows.map(appNoteToNote).toList();
  }

  Future<Note?> getNoteById(int id, String userId) async {
    final query = select(appNotes)
      ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId));
    final result = await query.getSingleOrNull();
    if (result == null) {
      return null;
    }
    return appNoteToNote(result);
  }

  Future<bool> updateNote(Note note) async {
    final appNote = noteToAppNote(note);
    return update(appNotes).replace(appNote);
  }

  Future<int> deleteNote(int id, String userId) => (delete(appNotes)
        ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId)))
      .go();

  AppNote noteToAppNote(Note note) {
    return AppNote(
      id: note.id!,
      userId: note.userId!,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
    );
  }

  Note appNoteToNote(AppNote appNote) {
    return Note(
      id: appNote.id,
      userId: appNote.userId,
      title: appNote.title,
      content: appNote.content,
      createdAt: appNote.createdAt,
      updatedAt: appNote.updatedAt,
    );
  }
}
