part of 'audio_bloc.dart';

@immutable
sealed class AudioEvent {}

class GetAudio extends AudioEvent {
  final String url;
  final BooksModel booksModel;
  final CoursesModel coursesModel;

  GetAudio(
      {required this.url,
      required this.booksModel,
      required this.coursesModel});
}

class PauseAudio extends AudioEvent {}

class ResumeAudio extends AudioEvent {}

class RestartAudio extends AudioEvent {}

class StopAudio extends AudioEvent {}

class ForwardAudio extends AudioEvent {}

class BackwardAudio extends AudioEvent {}

class RepeatAudio extends AudioEvent {}

class MoveAudio extends AudioEvent {
  final Duration position;

  MoveAudio({required this.position});
}
