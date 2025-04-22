import 'package:assignment_3/blocs/add_note_bloc/add_note_bloc.dart';
import 'package:assignment_3/blocs/delete_note/delete_note_bloc.dart';
import 'package:assignment_3/blocs/get_note_bloc/get_note_bloc.dart';
import 'package:assignment_3/blocs/update_note/update_note_bloc.dart';
import 'package:assignment_3/screens/add_note_screen.dart';
import 'package:assignment_3/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'All';
  final List<String> filterOptions = ['All', 'Work', 'Personal', 'Study'];
  @override
  void initState() {
    getAllNotes();
    super.initState();
  }

  void getAllNotes() {
    BlocProvider.of<GetNoteBloc>(context).add(GetNoteEventGetAll());
  }

  @override
  Widget build(BuildContext context) {
    void filterNotes(String filter) {
      if (filter == 'All') {
        getAllNotes();
      } else {
        BlocProvider.of<GetNoteBloc>(context).add(GetNoteEventFilter(filter));
      }
    }

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("NoteIt"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
            child: DropdownButtonHideUnderline(
              child: BlocBuilder<GetNoteBloc, GetNoteState>(
                builder: (context, state) {
                  String dropdownValue = 'All';

                  if (state is GetNoteLoaded && state.category != null) {
                    dropdownValue = state.category!;
                  }
                  return DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_sharp),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        selectedFilter = newValue;
                        filterNotes(selectedFilter);
                      }
                    },
                    items: filterOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddNoteBloc, AddNoteState>(
            listener: (context, listenState) {
              if (listenState is AddNoteSuccess) {
                getAllNotes(); //should refetch WORKS
              }
            },
          ),
          BlocListener<DeleteNoteBloc, DeleteNoteState>(
            listener: (context, listenStateDelete) {
              if (listenStateDelete is DeleteNoteSuccess) {
                getAllNotes(); //should refetch WORKS
              }
            },
          ),
          BlocListener<UpdateNoteBloc, UpdateNoteState>(
            listener: (context, listenStateUpdate) {
              if (listenStateUpdate is UpdateNoteSuccess) {
                print('we herd it');
                getAllNotes(); //should refetch
              }
            },
          ),
        ],
        child: BlocBuilder<GetNoteBloc, GetNoteState>(
          builder: (context, state) {
            if (state is GetNoteLoaded) {
              if (state.notes.isEmpty) {
                return const Center(
                  child: Text('No notes found'),
                );
              } else {
                final sortedNotes = [...state.notes];
                sortedNotes.sort((a, b) {
                  if (a.pinned == b.pinned) return 0;
                  return a.pinned ? -1 : 1;
                });
                return Center(
                  child: GridView.builder(
                      itemCount: sortedNotes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, i) {
                        return NoteCard(note: sortedNotes[i]);
                      }),
                );
              }
            } else {
              return const Text('loading');
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
          backgroundColor: Colors.pink.shade100,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNoteScreen(addOrUpdate: 'Add'),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    ));
  }
}
