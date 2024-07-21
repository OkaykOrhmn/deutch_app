import 'package:audioplayers/audioplayers.dart';
import 'package:deutch_app/data/model/books_model.dart';
import 'package:deutch_app/data/model/courses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_event.dart';

part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  static AudioPlayer audioPlayer = AudioPlayer();
  static Duration? duration = Duration.zero;
  static Duration position = Duration.zero;
  static String url = 'Select Audio';
  static BooksModel booksModel = BooksModel();
  static CoursesModel coursesModel = CoursesModel();

  AudioBloc() : super(AudioInitial()) {
    on<AudioEvent>((event, emit) async {
      if (event is RepeatAudio) {}
      if (event is GetAudio) {
        emit(AudioLoading());
        try {
          await audioPlayer.play(UrlSource(event.url.toString()));
          duration = await audioPlayer.getDuration();
          url = event.url;
          booksModel = event.booksModel;
          coursesModel = event.coursesModel;
          emit(AudioSuccess());
        } catch (e) {
          emit(AudioFail());
        }
      }

      if (event is PauseAudio) {
        try {
          await audioPlayer.pause();
          emit(AudioSuccess());
        } catch (e) {
          emit(AudioFail());
        }
      }

      if (event is RestartAudio) {
        try {
          await audioPlayer.seek(Duration.zero);
          emit(AudioSuccess());
        } catch (e) {
          emit(AudioFail());
        }
      }

      if (event is ResumeAudio) {
        try {
          await audioPlayer.resume();
          emit(AudioSuccess());
        } catch (e) {
          emit(AudioFail());
        }
      }

      if (event is StopAudio) {
        try {
          await audioPlayer.stop();
          duration = Duration.zero;
          position = Duration.zero;
          url = 'Select Audio';
          booksModel = BooksModel();
          coursesModel = CoursesModel();
          emit(AudioStoped());
        } catch (e) {
          emit(AudioFail());
        }
      }

      if (event is ForwardAudio) {
        try {
          final positione = await audioPlayer.getCurrentPosition();
          if (positione!.inSeconds < duration!.inSeconds - 5) {
            final forward = Duration(seconds: positione.inSeconds + 5);
            await audioPlayer.seek(forward);
          }
          emit(AudioSuccess());
        } catch (e) {
          emit(AudioFail());
        }
      }

      if (event is BackwardAudio) {
        try {
          final positione = await audioPlayer.getCurrentPosition();
          if (positione!.inSeconds > 5) {
            final backward = Duration(seconds: positione.inSeconds - 5);
            await audioPlayer.seek(backward);
          }
          emit(AudioSuccess());
        } catch (e) {
          emit(AudioFail());
        }
      }

      if (event is MoveAudio) {
        try {
          await audioPlayer.seek(event.position);

          emit(AudioSuccess());
        } catch (e) {
          emit(AudioFail());
        }
      }
    });
  }
}
