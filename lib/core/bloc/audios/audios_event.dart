part of 'audios_bloc.dart';

sealed class AudiosEvent extends Equatable {
  const AudiosEvent();

  @override
  List<Object> get props => [];
}

class GETAllAudios extends AudiosEvent {
  final String url;
  final int bookId;
  final int courseId;

  const GETAllAudios(
      {required this.url, required this.bookId, required this.courseId});
}
