import 'package:assignment_3/blocs/add_note_bloc/add_note_bloc.dart';
import 'package:assignment_3/blocs/update_note/update_note_bloc.dart';
import 'package:assignment_3/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNoteScreen extends StatefulWidget {
  final String addOrUpdate;
  final Note? note;
  const AddNoteScreen({super.key, required this.addOrUpdate, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String selectedCategory = 'Work'; // Default category
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void updateNote() {
    context.read<UpdateNoteBloc>().add(UpdateNote(
        note: Note(
            pinned: widget.note!.pinned,
            id: widget.note!.id,
            title: titleController.text,
            content: contentController.text,
            category: selectedCategory)));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.note!.title} updated successfully!'),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  void addNote(BuildContext context) {
    if (titleController.text.isEmpty || contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    if (selectedCategory.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    context.read<AddNoteBloc>().add(AddNote(
        note: Note(
            id: '',
            title: titleController.text,
            content: contentController.text,
            pinned: false,
            category: selectedCategory)));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${titleController.text} added successfully!'),
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context); // Close the screen after adding the note
  }

  @override
  void dispose() {
    // Clean up controllers
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.addOrUpdate == 'Update' && widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
      selectedCategory = widget.note!.category;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('${widget.addOrUpdate} Note'),
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
                selectedCategory = newValue!;
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
              backgroundColor: Colors.pink.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              if (widget.addOrUpdate == 'Add') {
                addNote(context);
              } else {
                updateNote();
              }
            },
            child: Text(
              widget.addOrUpdate == 'Add' ? 'Save' : 'Update',
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
