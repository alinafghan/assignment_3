part of 'add_note_bloc.dart';

@immutable
abstract class AddNoteState {}

final class AddNoteInitial extends AddNoteState {}

class AddNoteLoading extends AddNoteState {}

class AddNoteSuccess extends AddNoteState {
  final Note note;

  AddNoteSuccess({required this.note});
}

class AddNoteFailure extends AddNoteState {
  final String error;

  AddNoteFailure(this.error);
}
