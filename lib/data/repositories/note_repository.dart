import 'package:mina_app/data/database/connection/shared.dart' show constructDb;
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/database/notes_dao.dart';
import 'package:mina_app/data/model/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteRepository {
  late final AppDatabase database;
  late final AppNotesDao _notesDao;

  NoteRepository(this.database) {
    _notesDao = database.appNotesDao;
  }

  Future<List<Note>> getAllNotes(String userId) async {
    //return _notesDao.getNotes(userId);
    final notes = await Supabase.instance.client
        .from('Notes')
        .select()
        .eq('userId', userId);

    if (notes == null || notes.isEmpty) {
      return [];
    }
    return notes.map((note) {
      return Note.fromMap(note);
    }).toList();
  }

  Future<Note?> getNoteById(int id, String userId) {
    // return _notesDao.getNoteById(id, userId);
    return Supabase.instance.client
        .from('Notes')
        .select()
        .eq('id', id)
        .eq('userId', userId)
        .single()
        .then((data) => data != null ? Note.fromMap(data) : null);
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
