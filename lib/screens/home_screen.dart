import 'package:assignment_3/blocs/add_note_bloc/add_note_bloc.dart';
import 'package:assignment_3/blocs/get_note_bloc/get_note_bloc.dart';
import 'package:assignment_3/repositories/note_repository.dart';
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
  @override
  void initState() {
    BlocProvider.of<GetNoteBloc>(context).add(GetNoteEventGetAll());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("NoteIt"),
      ),
      body: BlocBuilder<GetNoteBloc, GetNoteState>(
        builder: (context, state) {
          if (state is GetNoteLoaded) {
            if (state.notes.isEmpty) {
              return const Center(
                child: Text('No notes found'),
              );
            } else {
              return Center(
                child: GridView.builder(
                    itemCount: state.notes.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, i) {
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
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start, // aligns children to the left
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    state.notes[i].title,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Text(
                                                    state.notes[i].category,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              state.notes[i].content,
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              },
                          child: NoteCard(note: state.notes[i]));
                    }),
              );
            }
          } else {
            return const Text('loading');
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) =>
                      AddNoteBloc(repository: NoteRepository()),
                  child: const AddNoteScreen(),
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    ));
  }
}
