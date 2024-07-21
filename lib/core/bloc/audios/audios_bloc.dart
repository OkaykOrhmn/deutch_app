import 'package:deutch_app/data/model/audios_model.dart';
import 'package:deutch_app/data/repository/audios_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audios_event.dart';
part 'audios_state.dart';

class AudiosBloc extends Bloc<AudiosEvent, AudiosState> {
  AudiosBloc() : super(AudiosInitial()) {
    on<AudiosEvent>((event, emit) async {
      if (event is GETAllAudios) {
        emit(AudiosLoading());
        try {
          AudiosModel response = await audiosRepository.getAllAudios(
              bookId: event.bookId, courseId: event.courseId, url: event.url);
          response.audios!.removeAt(0);
          emit(AudiosSuccess(response: response));
          // ignore: deprecated_member_use
        } on DioError {
          emit(AudiosFail());
        }
      }
    });
  }
}
