part of 'delete_note_bloc.dart';

abstract class DeleteNoteState extends Equatable {
  const DeleteNoteState();

  @override
  List<Object> get props => [];
}

final class DeleteNoteInitial extends DeleteNoteState {}

final class DeleteNoteLoading extends DeleteNoteState {}

final class DeleteNoteSuccess extends DeleteNoteState {
  final String message;

  const DeleteNoteSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class DeleteNoteFailure extends DeleteNoteState {
  final String error;

  const DeleteNoteFailure(this.error);

  @override
  List<Object> get props => [error];
}
