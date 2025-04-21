import 'package:assignment_3/models/note.dart';
import 'package:assignment_3/repositories/note_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_note_event.dart';
part 'update_note_state.dart';

class UpdateNoteBloc extends Bloc<UpdateNoteEvent, UpdateNoteState> {
  NoteRepository noteRepository = NoteRepository();
  UpdateNoteBloc({required NoteRepository repository})
      : noteRepository = repository,
        super(UpdateNoteInitial()) {
    on<UpdateNote>((event, emit) async {
      emit(UpdateNoteLoading());
      try {
        Note note = await noteRepository.updateNote(event.note);
        emit(UpdateNoteSuccess(note: note));
      } catch (e) {
        emit(UpdateNoteFailure(error: e.toString()));
      }
      // TODO: implement event handler
    });
  }
}
