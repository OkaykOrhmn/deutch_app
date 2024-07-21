import 'dart:ui';

import 'package:deutch_app/ui/theme/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Tools {
  static String getFormatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes;
    final seconds = totalSeconds % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }

  static String getAudioName(String url) {
    String result = '';
    List<String> chars = [];
    for (int i = url.length - 1; i >= 0; i--) {
      if (url[i] == '/') {
        break;
      }
      chars.add(url[i]);
    }
    for (var element in chars.reversed) {
      result += element;
    }
    return result.replaceAll(".mp3", "");
  }

  static String getDownloadedFileName(String url) {
    String result = '';
    List<String> chars = [];
    for (int i = url.length - 1; i >= 0; i--) {
      if (url[i] == '/') {
        break;
      }
      chars.add(url[i]);
    }
    for (var element in chars.reversed) {
      result += element;
    }
    return result.replaceAll('%20', '');
  }

  static SystemUiOverlayStyle customeStatusBar(
      {required final BuildContext context, final Color? backgroundColor}) {
    return SystemUiOverlayStyle(
      statusBarColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      statusBarIconBrightness:
          context.read<ThemeBloc>().state.brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
    );
  }
}
