part of 'update_note_bloc.dart';

abstract class UpdateNoteEvent extends Equatable {
  const UpdateNoteEvent();

  @override
  List<Object> get props => [];
}

class UpdateNote extends UpdateNoteEvent {
  final Note note;

  const UpdateNote({required this.note});

  @override
  List<Object> get props => [note];
}
