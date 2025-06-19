import 'package:mina_app/data/database/notes_dao.dart';
import 'package:mina_app/data/model/note.dart';

class NoteRepository {
  final AppNotesDao _notesDao;

  NoteRepository(this._notesDao);

  Future<List<Note>> getAllNotes() {
    return _notesDao.getAllNotes();
  }

  Future<Note?> getNoteById(int id) {
    return _notesDao.getNoteById(id);
  }

  Future<void> insertNote(Note note) {
    return _notesDao.insertNote(note);
  }

  Future<void> updateNote(Note note) {
    return _notesDao.updateNote(note);
  }

  Future<void> deleteNote(int id) {
    return _notesDao.deleteNoteById(id);
  }
}
