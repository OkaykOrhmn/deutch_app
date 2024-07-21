part of 'download_bloc.dart';

sealed class DownloadState {}

final class DownloadInitial extends DownloadState {}

final class DownloadLoading extends DownloadState {
  final double pr;

  DownloadLoading({required this.pr});
}

final class DownloadSuccess extends DownloadState {
  final File? file;

  DownloadSuccess({required this.file});
}

final class DownloadFail extends DownloadState {
  final String error;

  DownloadFail({required this.error});
}
