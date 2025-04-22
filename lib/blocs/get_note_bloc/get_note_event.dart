part of 'get_note_bloc.dart';

abstract class GetNoteEvent extends Equatable {
  const GetNoteEvent();

  @override
  List<Object> get props => [];
}

class GetNoteEventGetAll extends GetNoteEvent {
  const GetNoteEventGetAll();

  @override
  List<Object> get props => [];
}

class GetNoteEventGetById extends GetNoteEvent {
  final String noteId;

  const GetNoteEventGetById(this.noteId);

  @override
  List<Object> get props => [noteId];
}

class GetNoteEventFilter extends GetNoteEvent {
  final String filter;

  const GetNoteEventFilter(this.filter);

  @override
  List<Object> get props => [filter];
}
