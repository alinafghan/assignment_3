import 'package:assignment_3/blocs/update_note/update_note_bloc.dart';
import 'package:assignment_3/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Note note;
  const UpdateNoteScreen({super.key, required this.note});

  @override
  State<UpdateNoteScreen> createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  void initState() {
    super.initState();
    // Initialize the content controller with the note's content
    contentController.text = widget.note.content;
    titleController.text = widget.note.title;
    selectedCategory = widget.note.category;
  }

  String selectedCategory = 'Work'; // Default category
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void updateNote() {
    context.read<UpdateNoteBloc>().add(UpdateNote(
        note: Note(
            pinned: widget.note.pinned,
            id: widget.note.id,
            title: titleController.text,
            content: contentController.text,
            category: selectedCategory)));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.note.title} updated successfully!'),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Clean up controllers
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Update Note'),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: contentController,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                labelText: 'Content',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                // Handle category selection
              },
              items: ['Work', 'Personal', 'Study'].map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 184, 141, 156),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              updateNote();
            },
            child: Text(
              'Update',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ],
      )),
    ));
  }
}
