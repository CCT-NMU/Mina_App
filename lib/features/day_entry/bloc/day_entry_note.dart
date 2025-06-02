import 'package:flutter/material.dart';

Future<String?> showNotesPopup({
  required BuildContext context,
  required String initialNote,
}) {
  final controller = TextEditingController(text: initialNote);

  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Edit Notes",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Add any additional notes here...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                FilledButton(
                  child: const Text("Save"),
                  onPressed: () => Navigator.pop(context, controller.text),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
