import 'dart:io';

import 'package:deutch_app/core/services/storage_handler.dart';
import 'package:deutch_app/data/repository/download_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  static String url = '';

  DownloadBloc() : super(DownloadInitial()) {
    on<DownloadEvent>((event, emit) async {
      Function(int, int)? _loadingNotification(
          int id, String path, String url) {
        return (count, total) async {
          final progress = ((count * 100) / total);
          if (count != total && (state as DownloadLoading).pr != progress) {
            emit(DownloadLoading(pr: progress / 10));
          }
        };
      }

      if (event is DownloadMedia) {
        DownloadBloc.url = event.url;
        emit(DownloadLoading(pr: 0));
        final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        try {
          final path = await StorageHandler.getMediaFileDir(url, event.names);
          if (path == null) {
            emit(DownloadFail(error: "لطفا دسترسی هارا تایید کنید!!"));
          } else {
            if (path != "exist") {
              await downloadRepository.getMedia(
                  url, path, _loadingNotification(id, path, url));
            }
            emit(DownloadSuccess(
                file: await StorageHandler.getMediaFileDirPath(
                    url, event.names)));
          }
        } catch (e) {
          String error = "خطا در برقراری ارتباط دوباره تلاش کنید!!";
          emit(DownloadFail(error: error));
        }
      }
    });
  }
}
