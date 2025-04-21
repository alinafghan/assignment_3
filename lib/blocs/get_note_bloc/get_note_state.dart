part of 'get_note_bloc.dart';

sealed class GetNoteState extends Equatable {
  const GetNoteState();

  @override
  List<Object> get props => [];
}

final class GetNoteInitial extends GetNoteState {}

final class GetNoteLoading extends GetNoteState {}

final class GetNoteLoaded extends GetNoteState {
  final List<Note> notes;

  const GetNoteLoaded(this.notes);

  @override
  List<Object> get props => [notes];
}

final class GetNoteError extends GetNoteState {
  final String error;

  const GetNoteError(this.error);

  @override
  List<Object> get props => [error];
}

final class GetNoteLoadedById extends GetNoteState {
  final Note note;

  const GetNoteLoadedById(this.note);

  @override
  List<Object> get props => [note];
}

final class GetNoteErrorById extends GetNoteState {
  final String error;

  const GetNoteErrorById(this.error);

  @override
  List<Object> get props => [error];
}
