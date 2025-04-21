import 'package:assignment_3/repositories/note_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_note_event.dart';
part 'delete_note_state.dart';

class DeleteNoteBloc extends Bloc<DeleteNoteEvent, DeleteNoteState> {
  NoteRepository noteRepository = NoteRepository();

  DeleteNoteBloc({required NoteRepository repository})
      : noteRepository = repository,
        super(DeleteNoteInitial()) {
    on<DeleteNote>((event, emit) {
      emit(DeleteNoteLoading());
      try {
        noteRepository.deleteNote(event.noteId);
        emit(DeleteNoteSuccess(message: "Note deleted successfully"));
      } catch (e) {
        emit(DeleteNoteFailure(e.toString()));
      }
    });
  }
}
