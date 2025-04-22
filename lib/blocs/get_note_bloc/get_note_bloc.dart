import 'package:assignment_3/models/note.dart';
import 'package:assignment_3/repositories/note_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_note_event.dart';
part 'get_note_state.dart';

class GetNoteBloc extends Bloc<GetNoteEvent, GetNoteState> {
  NoteRepository noteRepository = NoteRepository();
  GetNoteBloc({required NoteRepository repository})
      : noteRepository = repository,
        super(GetNoteInitial()) {
    on<GetNoteEventGetAll>((event, emit) async {
      emit(GetNoteLoading());
      try {
        List<Note> allNotes = await noteRepository.getAllNotes();
        emit(GetNoteLoaded(allNotes, 'All'));
      } catch (e) {
        emit(GetNoteError(e.toString()));
      }
    });
    on<GetNoteEventGetById>((event, emit) async {
      emit(GetNoteLoading());
      try {
        Note? note = await noteRepository.getNoteById(event.noteId);
        if (note != null) {
          emit(GetNoteLoadedById(note));
        } else {
          emit(GetNoteErrorById('Note not found'));
        }
      } catch (e) {
        emit(GetNoteError(e.toString()));
      }
    });
    on<GetNoteEventFilter>((event, emit) async {
      emit(GetNoteFilteredLoading());
      try {
        List<Note> allNotes = await noteRepository.getAllNotes();
        List<Note> filteredNotes = allNotes
            .where((note) =>
                note.category.toLowerCase() == event.filter.toLowerCase())
            .toList();
        emit(GetNoteLoaded(filteredNotes, event.filter));
      } catch (e) {
        emit(GetNoteError(e.toString()));
      }
    });
  }
}
