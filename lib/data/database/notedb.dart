import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../model/note.dart';

class NoteDb {
  NoteDb._();
  static final NoteDb instance = NoteDb._();

  static Database? _db;
  Future<Database> get _database async {
    if (_db != null) return _db!;
    final docsDir = await getApplicationDocumentsDirectory();
    final path = p.join(docsDir.path, 'notes.db'); //add proper name here
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        await db.execute('''
          CREATE TABLE notes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            content TEXT NOT NULL,
            created_at TEXT NOT NULL,
            updated_at TEXT NOT NULL
          )
        ''');
      },
    );
    return _db!;
  }

  // ── CRUD ────────────────────────────────────────────────────────
  Future<int> create(Note n) async {
    final db = await _database;
    return db.insert('notes', n.toMap());
  }

  Future<List<Note>> readAll() async {
    final db = await _database;
    final rows = await db.query('notes', orderBy: 'updated_at DESC');
    return rows.map(Note.fromMap).toList();
  }

  Future<int> update(Note n) async {
    final db = await _database;
    return db.update('notes', n.toMap(), where: 'id = ?', whereArgs: [n.id]);
  }

  Future<int> delete(int id) async {
    final db = await _database;
    return db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
