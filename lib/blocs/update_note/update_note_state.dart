part of 'update_note_bloc.dart';

abstract class UpdateNoteState extends Equatable {
  const UpdateNoteState();

  @override
  List<Object> get props => [];
}

final class UpdateNoteInitial extends UpdateNoteState {}

final class UpdateNoteLoading extends UpdateNoteState {}

final class UpdateNoteSuccess extends UpdateNoteState {
  final Note note;

  const UpdateNoteSuccess({required this.note});

  @override
  List<Object> get props => [note];
}

final class UpdateNoteFailure extends UpdateNoteState {
  final String error;

  const UpdateNoteFailure({required this.error});

  @override
  List<Object> get props => [error];
}
