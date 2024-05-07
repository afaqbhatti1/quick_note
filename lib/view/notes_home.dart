import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_note/model/note_model.dart';
import 'package:quick_note/view%20model/notes_provider.dart';
import 'package:quick_note/view/notes_edit.dart';

class NotesHomePage extends StatelessWidget {
  NotesHomePage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick Notes'),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            onPressed: () {
              _searchController.clear();
              notesProvider.searchEnabled = false;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteEditScreen(
                    onSave: (newNote) {
                      notesProvider.addNote(newNote);
                    },
                  ),
                ),
              );
            },
            child: const Text('Create Note'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      notesProvider.searchNotes(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search by title or category',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
            notesProvider.notes.isNotEmpty
                ? Builder(builder: (context) {
                    List<Note> searchNoteList = notesProvider.notes ?? [];

                    if (notesProvider.searchEnabled) {
                      searchNoteList = notesProvider.notesList ?? [];
                    }
                    return searchNoteList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.only(bottom: 140),
                              itemCount: searchNoteList.length,
                              itemBuilder: (context, index) {
                                final note = searchNoteList[index];
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.sizeOf(context).height * 0.02,
                                    ),
                                    Text(
                                      "${note.category}:",
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        note.title,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(note.content),
                                      trailing: SizedBox(
                                        width: MediaQuery.sizeOf(context).width * 0.22,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            InkWell(
                                              child: const Icon(Icons.edit),
                                              onTap: () {
                                                notesProvider.searchEnabled = false;
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => NoteEditScreen(
                                                      note: note,
                                                      onSave: (updatedNote) {
                                                        notesProvider.updateNote(
                                                          updatedNote,
                                                          index,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            InkWell(
                                              child: const Icon(Icons.delete),
                                              onTap: () {
                                                notesProvider.deleteNote(index);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Text("No Note found"),
                          );
                  })
                : const Padding(
                    padding: EdgeInsets.only(top: 300.0),
                    child: Text(
                      "You don’t have any note",
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
