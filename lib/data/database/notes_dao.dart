import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/model/note.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [AppNotes])
class AppNotesDao extends DatabaseAccessor<AppDatabase>
    with _$AppNotesDaoMixin {
  AppNotesDao(AppDatabase db) : super(db);

  // Mapping from Drift data class to custom model
  Note fromDrift(AppNote row) => Note(
        id: row.id,
        title: row.title,
        content: row.content,
        createdAt: DateTime.parse(row.createdAt),
        updatedAt: DateTime.parse(row.updatedAt),
      );

  // Mapping from custom model to Drift companion
  AppNotesCompanion toDrift(Note note) => AppNotesCompanion(
        id: note.id != null ? Value(note.id!) : const Value.absent(),
        title: Value(note.title),
        content: Value(note.content),
        createdAt: Value(note.createdAt.toIso8601String()),
        updatedAt: Value(note.updatedAt.toIso8601String()),
      );

  Future<int> insertNote(Note note) => into(appNotes).insert(toDrift(note));

  Future<List<Note>> getAllNotes() async {
    final rows = await select(appNotes).get();
    return rows.map(fromDrift).toList();
  }

  Future<Note?> getNoteById(int id) async {
    final row = await (select(appNotes)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : fromDrift(row);
  }

  Future<bool> updateNote(Note note) => update(appNotes).replace(toDrift(note));

  Future<int> deleteNoteById(int id) =>
      (delete(appNotes)..where((tbl) => tbl.id.equals(id))).go();
}
