import 'dart:convert';
import 'dart:math';
import 'package:assignment_3/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteRepository {
  Future<Note> saveNote(Note note) async {
    String uniqueId = Random().nextInt(1000000).toString();
    note.id = uniqueId; // Assign a unique ID to the note
    SharedPreferences pref = await SharedPreferences.getInstance();
    String noteJson = jsonEncode(note.toJson());
    await pref.setString(note.id, noteJson);
    return note;
  }

  Future<void> deleteNote(String noteId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(noteId);
  }

  Future<Note> updateNote(Note note) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String noteJson = jsonEncode(note.toJson());
    await pref.setString(note.id, noteJson);
    print('Note updated: ${note.toJson()}');
    return note;
  }

  Future<Note?> getNoteById(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? noteJson = pref.getString(id);
    if (noteJson == null) return null;

    Map<String, dynamic> noteMap = jsonDecode(noteJson);
    return Note.fromJson(noteMap);
  }

  Future<List<Note>> getAllNotes() async {
    print('getAllNotes repo called');
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<Note> notes = [];
    for (String key in pref.getKeys()) {
      String? noteJson = pref.getString(key);
      try {
        if (noteJson != null) {
          final map = jsonDecode(noteJson);
          // Check if it's a valid note object
          if (map is Map<String, dynamic> &&
              map.containsKey('id') &&
              map.containsKey('title')) {
            notes.add(Note.fromJson(map));
          }
        }
      } catch (e) {
        // Skip invalid/non-note entries
      }
    }

    return notes;
  }
}
