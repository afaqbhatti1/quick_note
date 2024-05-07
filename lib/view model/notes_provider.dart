import 'package:flutter/material.dart';
import 'package:quick_note/model/note_model.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> notes = [];
  List<Note> notesList = [];

  bool searchEnabled = false;

  void addNote(Note newNote) {
    notes.add(newNote);
    notesList.add(newNote);
    notifyListeners();
  }

  void updateNote(Note updatedNote, int index) {
    notes[index] = updatedNote;
    notesList[index] = updatedNote;
    notifyListeners();
  }

  void deleteNote(int index) {
    notes.removeAt(index);
    notesList.removeAt(index);
    notifyListeners();
  }

  List<Note> searchNotes(String query) {
    notesList = notes.where((Note element) {
      return (element.title.isNotEmpty && element.title.toLowerCase().contains(query.toLowerCase())) ||
          (element.category.isNotEmpty && element.category.toLowerCase().contains(query.toLowerCase()));
    }).toList();

    searchEnabled = true;
    notifyListeners();

    return notesList;
  }
}
