import 'package:drift/drift.dart';
import 'package:mina_app/data/database/drift_database.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [AppNotes])
class AppNotesDao extends DatabaseAccessor<AppDatabase>
    with _$AppNotesDaoMixin {
  AppNotesDao(AppDatabase db) : super(db);

  insertNote(AppNote note) => into(appNotes).insert(note);

  Future<List<AppNote>> getNotes(String userId) async {
    final rows = await (select(appNotes)
          ..where((tbl) => tbl.userId.equals(userId)))
        .get();
    return rows;
  }

  Future<bool> updateNote(AppNote note) async {
    return update(appNotes).replace(note);
  }

  Future<int> deleteNote(int id, String userId) => (delete(appNotes)
        ..where((tbl) => tbl.id.equals(id) & tbl.userId.equals(userId)))
      .go();
}
