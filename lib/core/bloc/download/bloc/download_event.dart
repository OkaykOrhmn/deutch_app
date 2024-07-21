part of 'download_bloc.dart';

sealed class DownloadEvent extends Equatable {
  const DownloadEvent();

  @override
  List<Object> get props => [];
}

class DownloadMedia extends DownloadEvent {
  final String url;
  final List<String> names;

  const DownloadMedia({required this.url, required this.names});
}
