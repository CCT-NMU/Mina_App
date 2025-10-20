import 'package:mina_app/data/database/connection/shared.dart' show constructDb;
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/database/notes_dao.dart';
import 'package:mina_app/data/model/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteRepository {
  Future<List<Note>> getAllNotes(String userId) async {
    //return _notesDao.getNotes(userId);
    final notes = await Supabase.instance.client
        .from('Notes')
        .select()
        .eq('user_id', userId);

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
        .eq('user_id', userId)
        .single()
        .then((data) => data != null ? Note.fromMap(data) : null);
  }

  Future<void> insertNote(Note note) async {
    try {
      await Supabase.instance.client.from('Notes').insert({
        'user_id': note.userId,
        'title': note.title,
        'content': note.content,
        'created_at': note.createdAt.toIso8601String(),
        'updated_at': note.updatedAt.toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to insert note: $e');
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      await Supabase.instance.client.from('Notes').update({
        'user_id': note.userId,
        'title': note.title,
        'content': note.content,
        'created_at': note.createdAt.toIso8601String(),
        'updated_at': note.updatedAt.toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  Future<void> deleteNote(int id, String userId) async {
    // return _notesDao.deleteNote(id, userId);
    try {
      await Supabase.instance.client
          .from('Notes')
          .delete()
          .eq('id', id)
          .eq('user_id', userId);
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }
}
