part of 'delete_note_bloc.dart';

abstract class DeleteNoteEvent extends Equatable {
  const DeleteNoteEvent();

  @override
  List<Object> get props => [];
}

class DeleteNote extends DeleteNoteEvent {
  final String noteId;

  const DeleteNote({required this.noteId});

  @override
  List<Object> get props => [noteId];
}
