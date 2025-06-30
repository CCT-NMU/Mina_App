import 'package:mina_app/data/database/connection/shared.dart' show constructDb;
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/database/notes_dao.dart';
import 'package:mina_app/data/model/note.dart';

class NoteRepository {
  late final AppDatabase database;
  late final AppNotesDao _notesDao;

  NoteRepository(this.database) {
    _notesDao = database.appNotesDao;
  }

  Future<List<Note>> getAllNotes(String userId) {
    return _notesDao.getNotes(userId);
  }

  Future<Note?> getNoteById(int id, String userId) {
    return _notesDao.getNoteById(id, userId);
  }

  Future<void> insertNote(Note note) {
    return _notesDao.insertNoteFromModel(note);
  }

  Future<void> updateNote(Note note) {
    return _notesDao.updateNote(note);
  }

  Future<void> deleteNote(int id, String userId) {
    return _notesDao.deleteNote(id, userId);
  }
}
