part of 'add_note_bloc.dart';

@immutable
abstract class AddNoteEvent extends Equatable {
  const AddNoteEvent();

  @override
  List<Object> get props => [];
}

class AddNote extends AddNoteEvent {
  final Note note;

  const AddNote({required this.note});

  @override
  List<Object> get props => [note];
}
