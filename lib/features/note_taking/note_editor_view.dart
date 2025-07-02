import 'package:flutter/material.dart';
import 'package:mina_app/data/database/connection/shared.dart';
import 'package:mina_app/data/database/drift_database.dart';
import 'package:mina_app/data/repositories/note_repository.dart';
import 'package:mina_app/data/database/notes_dao.dart';
import 'package:mina_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import '/data/model/note.dart';

class NoteEditorView extends StatefulWidget {
  final Note? note; // null ⇒ new note
  const NoteEditorView({super.key, this.note});
  @override
  State<NoteEditorView> createState() => _NoteEditorViewState();
}

class _NoteEditorViewState extends State<NoteEditorView> {
  late final _titleCtrl = TextEditingController(text: widget.note?.title ?? '');
  late final _contentCtrl =
      TextEditingController(text: widget.note?.content ?? '');
  late NoteRepository noteRepository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final db = Provider.of<AppDatabase>(context, listen: false);
    noteRepository = NoteRepository(db);
  }

  Future<void> _save() async {
    final title = _titleCtrl.text.trim();
    final content = _contentCtrl.text.trim();
    if (title.isEmpty) return;

    final now = DateTime.now();
    final note = (widget.note ??
            Note(
              userId: AuthService().currentUser?.id,
              title: title,
              content: content,
              createdAt: now,
              updatedAt: now,
            ))
        .copyWith(title: title, content: content, updatedAt: now);

    if (note.id == null) {
      await noteRepository.insertNote(note);
    } else {
      await noteRepository.updateNote(note);
    }
    if (mounted) Navigator.pop(context, true); // tell caller to refresh
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Note'), elevation: 2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              // ── Title ─────────────────────────────────────────────
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: _titleCtrl,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add a title',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                    ),
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // ── Content ───────────────────────────────────────────
              Expanded(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: TextField(
                      controller: _contentCtrl,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write your note here...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      // expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // ── Buttons ───────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Cancel',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Save',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
