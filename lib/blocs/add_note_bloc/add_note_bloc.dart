import 'package:assignment_3/models/note.dart';
import 'package:assignment_3/repositories/note_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'add_note_event.dart';
part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  NoteRepository noteRepository = NoteRepository();

  AddNoteBloc({required NoteRepository repository})
      : noteRepository = repository,
        super(AddNoteInitial()) {
    on<AddNote>((event, emit) async {
      emit(AddNoteLoading());
      try {
        Note note = await noteRepository.saveNote(event.note);
        emit(AddNoteSuccess(note: note));
      } catch (e) {
        emit(AddNoteFailure(e.toString()));
      }
    });
  }
}
