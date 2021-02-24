import 'package:flutter/material.dart';
import 'package:notebook/view_model/note.dart';

Widget myPopMenu(Note note) {
  return PopupMenuButton(
    child: Icon(
      Icons.more_vert_sharp,
      color: Colors.white,
    ),
    onSelected: (value) {
      switch (value) {
        case 1:
          note.deleteAllNotes();
          break;
        case 2:
          note.sortByDate();
          break;
        case 3:
          note.sortByCategories();
      }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 1,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
          child: Text('Delete all notes'),
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
          child: Text('Sort by modified time'),
        ),
      ),
      PopupMenuItem(
        value: 3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
          child: Text('Sort by tabs'),
        ),
      ),
    ],
  );
}
