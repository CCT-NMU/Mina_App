/// lib/ui/notes_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/repositories/note_repository.dart';
import 'package:mina_app/services/auth_service/platform/supabase_auth_service.dart';
import '/data/model/note.dart';
import 'note_editor_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late Future<List<Note>> _notesFuture;
  late NoteRepository noteRepository;
  late String userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the database from Provider
    noteRepository = NoteRepository();
    final authService = SupabaseAuthService();
    userId = authService.currentUserId!;
    _reload();
  }

  void _reload() => _notesFuture = noteRepository.getAllNotes(userId);

  Future<void> _openEditor([Note? note]) async {
    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => NoteEditorView(note: note)),
    );
    if (changed == true && mounted) {
      _reload();
      setState(() {}); // Refresh the notes list
    }
  }

  Future<void> _delete(Note n) async {
    await noteRepository.deleteNote(n.id!, userId);
    if (mounted) {
      _reload();
    }
  }

  void undoDeleteSnackBar(Note deletedNote, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Note deleted'),
        /*  action: SnackBarAction(
          label: 'Undo',
          onPressed: () async {
            await noteRepository.insertNote(deletedNote);
            _reload();
          },
        ), */
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes'), elevation: 2),
      body: FutureBuilder<List<Note>>(
        future: _notesFuture,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var notes = snap.data!;
          if (notes.isEmpty) {
            return const Center(child: Text('No notes yet. Tap + to add one.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: notes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              var n = notes[i];
              return Dismissible(
                key: ValueKey(n.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  _delete(n);
                  undoDeleteSnackBar(n, context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    tileColor: Colors.deepPurple[50],
                    title: Text(n.title.isEmpty ? 'Untitled' : n.title),
                    onTap: () => _openEditor(n),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openEditor(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
