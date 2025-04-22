import 'package:assignment_3/blocs/delete_note/delete_note_bloc.dart';
import 'package:assignment_3/blocs/update_note/update_note_bloc.dart';
import 'package:assignment_3/models/note.dart';
import 'package:assignment_3/screens/add_note_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteCard extends StatefulWidget {
  final Note note;
  const NoteCard({super.key, required this.note});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'work':
        return Colors.yellow.shade100;
      case 'study':
        return Colors.pink.shade100;
      case 'personal':
        return Colors.lightBlue.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  void _deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _confirmDelete(note);
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(Note note) {
    context.read<DeleteNoteBloc>().add(DeleteNote(noteId: note.id));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${note.title} deleted successfully!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _pinNote(Note note) {
    print(note.pinned);
    bool newPinnedState = !note.pinned; // this is the state you're sending
    print(newPinnedState);

    context.read<UpdateNoteBloc>().add(UpdateNote(
          note: Note(
            pinned: newPinnedState,
            id: note.id,
            title: note.title,
            content: note.content,
            category: note.category,
          ),
        ));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          newPinnedState
              ? '${note.title} pinned successfully!'
              : '${note.title} unpinned successfully!',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // aligns children to the left
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.note.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(widget.note.category),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            widget.note.category,
                            style: const TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.note.content,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      },
      child: Transform.rotate(
        angle: -0.05,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: _getCategoryColor(widget.note.category),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      widget.note.title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        widget.note.content,
                        style: const TextStyle(fontSize: 15),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.note.category,
                        style: const TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddNoteScreen(
                                        addOrUpdate: 'Update',
                                        note: widget.note),
                                  ),
                                );
                              },
                              child: const Icon(Icons.edit, size: 18),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                _deleteNote(widget.note);
                              },
                              child: const Icon(Icons.delete, size: 18),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                                onTap: () {
                                  _pinNote(widget.note);
                                },
                                child: Icon(
                                  widget.note.pinned
                                      ? Icons.push_pin
                                      : Icons.push_pin_outlined,
                                  size: 18,
                                )),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
