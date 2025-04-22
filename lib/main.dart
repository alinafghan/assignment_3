import 'package:assignment_3/blocs/add_note_bloc/add_note_bloc.dart';
import 'package:assignment_3/blocs/delete_note/delete_note_bloc.dart';
import 'package:assignment_3/blocs/get_note_bloc/get_note_bloc.dart';
import 'package:assignment_3/blocs/update_note/update_note_bloc.dart';
import 'package:assignment_3/repositories/note_repository.dart';
import 'package:assignment_3/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetNoteBloc>(
          create: (_) => GetNoteBloc(repository: NoteRepository()),
        ),
        BlocProvider<AddNoteBloc>(
          create: (_) => AddNoteBloc(repository: NoteRepository()),
        ),
        BlocProvider<UpdateNoteBloc>(
          create: (_) => UpdateNoteBloc(repository: NoteRepository()),
        ),
        BlocProvider<DeleteNoteBloc>(
          create: (_) => DeleteNoteBloc(repository: NoteRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
