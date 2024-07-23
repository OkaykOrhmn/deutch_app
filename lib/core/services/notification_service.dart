import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:deutch_app/core/bloc/audio/audio_bloc.dart';
import 'package:deutch_app/core/gen/assets.gen.dart';
import 'package:deutch_app/core/routes/route_generator.dart';
import 'package:deutch_app/core/routes/route_paths.dart';
import 'package:deutch_app/data/model/audio_notification_model.dart';
import 'package:deutch_app/data/model/audios_model.dart';
import 'package:deutch_app/data/model/books_model.dart';
import 'package:deutch_app/data/model/courses_args.dart';
import 'package:deutch_app/data/model/courses_model.dart';
import 'package:deutch_app/main.dart';
import 'package:deutch_app/ui/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'media_player',
              channelGroupKey: 'media_player',
              channelName: 'Media player controller',
              channelDescription: 'Media player controller',
              defaultColor: primaryColor,
              ledColor: Colors.white,
              importance: NotificationImportance.Max,
              defaultPrivacy: NotificationPrivacy.Public,
              channelShowBadge: false,
              onlyAlertOnce: false,
              playSound: false,
              locked: true,
              criticalAlerts: true),
        ],
        // channelGroups: [
        //   NotificationChannelGroup(
        //       channelGroupKey: 'high_important_channel_group',
        //       channelGroupName: 'Group 1')
        // ],
        debug: true);
    await AwesomeNotifications()
        .isNotificationAllowed()
        .then((isAllowed) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    await AwesomeNotifications().setListeners(
        onActionReceivedMethod: onActionReceivedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod);
  }

  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print(
        "receivedAction.buttonKeyPressed: ${receivedAction.buttonKeyPressed}");
    print("receivedAction.buttonKeyInput: ${receivedAction.buttonKeyInput}");
    print("receivedAction.channelKey: ${receivedAction.channelKey}");

    if (receivedAction.channelKey == 'media_player') {
      if (receivedAction.buttonKeyPressed == "MEDIA_PLAY") {
        navigatorKey.currentContext!.read<AudioBloc>().add(ResumeAudio());
      }
      if (receivedAction.buttonKeyPressed == "MEDIA_PAUSE") {
        navigatorKey.currentContext!.read<AudioBloc>().add(PauseAudio());
      }
      if (receivedAction.buttonKeyPressed == "MEDIA_CLOSE") {
        navigatorKey.currentContext!.read<AudioBloc>().add(StopAudio());
      }
      if (receivedAction.buttonKeyPressed == "") {
        final payload = receivedAction.payload ?? {};
        if (payload['navigatie'] == 'true') {
          navigatorKey.currentState!.pushNamed(RoutePaths.course,
              arguments: CoursesArgs(
                  id: int.parse(payload['id'].toString()),
                  bookId: int.parse(payload['bookId'].toString()),
                  booksModel: AudioBloc.booksModel));

          //do something
        }
      }
    }
  }

  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // print(
    //     "receivedAction.buttonKeyPressed: ${receivedAction.buttonKeyPressed}");
    // if (receivedAction.buttonKeyPressed == 'cancelDownload') {
    //   downloadCancelToken.cancel();
    //   await AwesomeNotifications()
    //       .cancel(int.parse(receivedAction.payload!["id"].toString()));
    // }
  }

  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static void updateNotificationMediaPlayer(
    AudioNotificationModel data,
    AudioPlayer? mediaNow,
    Duration currentTrackPosition,
    Duration duration,
    NotificationPlayState playState,
  ) {
    if (mediaNow == null || playState == NotificationPlayState.stopped) {
      cancelNotification(data.id);
      return;
    }

    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: data.id,
            channelKey: 'media_player',
            category: NotificationCategory.Transport,
            title: data.title,
            body: data.body,
            duration: duration,
            progress: currentTrackPosition.inMilliseconds /
                duration.inMilliseconds *
                100,
            playbackSpeed: 1,
            playState: playState,
            summary: mediaNow.state == PlayerState.playing ? 'Now playing' : '',
            notificationLayout: NotificationLayout.MediaPlayer,
            payload: data.payload,
            // largeIcon: mediaNow.diskImagePath,
            color: Colors.purple.shade700,
            autoDismissible: false,
            locked: true,
            showWhen: false),
        actionButtons: [
          mediaNow.state == PlayerState.playing
              ? NotificationActionButton(
                  key: 'MEDIA_PAUSE',
                  icon: 'resource://drawable/res_ic_pause',
                  label: 'Pause',
                  autoDismissible: false,
                  showInCompactView: true,
                  actionType: ActionType.KeepOnTop)
              : NotificationActionButton(
                  key: 'MEDIA_PLAY',
                  icon: 'resource://drawable/res_ic_play',
                  label: 'Play',
                  autoDismissible: false,
                  showInCompactView: true,
                  actionType: ActionType.KeepOnTop),
          NotificationActionButton(
              key: 'MEDIA_CLOSE',
              icon: 'resource://drawable/res_ic_close',
              label: 'Close',
              autoDismissible: true,
              showInCompactView: true,
              actionType: ActionType.KeepOnTop)
        ]);
  }
}
