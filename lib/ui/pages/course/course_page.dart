// ignore_for_file: library_private_types_in_public_api

import 'package:audioplayers/audioplayers.dart';
import 'package:deutch_app/core/bloc/audio/audio_bloc.dart';
import 'package:deutch_app/core/bloc/audios/audios_bloc.dart';
import 'package:deutch_app/core/bloc/courses/courses_bloc.dart';
import 'package:deutch_app/core/utils/tools.dart';
import 'package:deutch_app/data/api/api_endpoints.dart';
import 'package:deutch_app/data/model/books_model.dart';
import 'package:deutch_app/data/model/courses_model.dart';
import 'package:deutch_app/ui/theme/colors.dart';
import 'package:deutch_app/ui/theme/design_config.dart';
import 'package:deutch_app/ui/theme/text_styles.dart';
import 'package:deutch_app/ui/widgets/loading/primary_loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursePage extends StatefulWidget {
  final BooksModel booksModel;
  const CoursePage({super.key, required this.booksModel});

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  final ScrollController scrollController = ScrollController();
  static ValueNotifier<bool> repeat = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: Tools.customeStatusBar(context: context),
        child: BlocBuilder<CoursesBloc, CoursesState>(
          builder: (context, courseState) {
            if (courseState is CoursesSuccess) {
              final course = courseState.response;
              context.read<AudiosBloc>().add(GETAllAudios(
                  url: course.audiosUrl.toString(),
                  bookId: widget.booksModel.id!,
                  courseId: course.id!));

              return BlocBuilder<AudioBloc, AudioState>(
                builder: (context, audioState) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 46,
                      ),
                      header(context, course),
                      const SizedBox(
                        height: 24,
                      ),
                      Expanded(
                        child: playList(course),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      playerHandler(context, audioState, course),
                      const SizedBox(
                        height: 64,
                      ),
                    ],
                  );
                },
              );
            } else {
              return PrimaryLoading(
                size: 18,
                color: Theme.of(context).black(),
              );
            }
          },
        ),
      ),
    );
  }

  Column playerHandler(
      BuildContext context, AudioState audioState, CoursesModel course) {
    return Column(
      children: [
        Text(
          Tools.getAudioName(AudioBloc.url),
          style: Theme.of(context).textTheme.titleBold,
        ),
        const SizedBox(
          height: 46,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.save_alt,
              size: 32,
            ),
            const SizedBox(
              width: 32,
            ),
            InkWell(
              onTap: () {
                context.read<AudioBloc>().add(BackwardAudio());
              },
              child: const Icon(
                Icons.replay_5,
                size: 32,
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            InkWell(
              onTap: () async {
                if (audioState is AudioInitial) {
                  return;
                }
                if (AudioBloc.audioPlayer.state == PlayerState.completed ||
                    AudioBloc.audioPlayer.state == PlayerState.stopped) {
                  context.read<AudioBloc>().add(GetAudio(
                      url: AudioBloc.url,
                      booksModel: widget.booksModel,
                      coursesModel: course));

                  return;
                }
                if (audioState is AudioSuccess) {
                  if (AudioBloc.audioPlayer.state == PlayerState.playing) {
                    context.read<AudioBloc>().add(PauseAudio());
                  } else {
                    context.read<AudioBloc>().add(ResumeAudio());
                  }
                }
              },
              child: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color(int.parse(widget.booksModel.color.toString()))
                                .withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 0,
                      )
                    ],
                    color:
                        Color(int.parse(widget.booksModel.color.toString()))),
                child: audioState is AudioLoading
                    ? const PrimaryLoading(
                        size: 16,
                      )
                    : StreamBuilder<PlayerState>(
                        stream: AudioBloc.audioPlayer.onPlayerStateChanged,
                        builder: (context, snapshot) {
                          return AudioBloc.audioPlayer.state ==
                                  PlayerState.playing
                              ? const Icon(
                                  CupertinoIcons.pause_fill,
                                  size: 16,
                                )
                              : const Icon(
                                  CupertinoIcons.play_arrow_solid,
                                  size: 16,
                                );
                        }),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            InkWell(
              onTap: () {
                context.read<AudioBloc>().add(ForwardAudio());
              },
              child: const Icon(
                Icons.forward_5,
                size: 32,
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            AnimatedBuilder(
                animation: repeat,
                builder: (context, child) {
                  return InkWell(
                    onTap: () async {
                      repeat.value = !repeat.value;
                      if (repeat.value) {
                        await AudioBloc.audioPlayer
                            .setReleaseMode(ReleaseMode.loop);
                      } else {
                        await AudioBloc.audioPlayer
                            .setReleaseMode(ReleaseMode.release);
                      }
                    },
                    child: Icon(
                      Icons.repeat,
                      size: 32,
                      color: repeat.value
                          ? Color(int.parse(widget.booksModel.color.toString()))
                          : Theme.of(context).black(),
                    ),
                  );
                }),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        StreamBuilder<Duration?>(
            stream: AudioBloc.audioPlayer.onPositionChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                AudioBloc.position = snapshot.data!;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Slider(
                      activeColor:
                          Color(int.parse(widget.booksModel.color.toString())),
                      inactiveColor: lightColor,
                      value: audioState is AudioSuccess
                          ? (AudioBloc.position.inSeconds /
                              AudioBloc.duration!.inSeconds)
                          : 0,
                      onChanged: (double value) {
                        if (audioState is AudioSuccess) {
                          final position =
                              value * AudioBloc.duration!.inMilliseconds;
                          AudioBloc.audioPlayer
                              .seek(Duration(milliseconds: position.round()));
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Tools.getFormatDuration(
                              AudioBloc.position.inSeconds)),
                          Text(Tools.getFormatDuration(
                              AudioBloc.duration!.inSeconds)),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
      ],
    );
  }

  Padding playList(CoursesModel course) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: BlocBuilder<AudiosBloc, AudiosState>(
        builder: (context, audiosState) {
          if (audiosState is AudiosSuccess) {
            final audios = audiosState.response.audios;
            return RawScrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              radius: DesignConfig.aHighBorderRadius,
              trackColor: lightColor,
              thumbColor: lightColor900,
              trackRadius: DesignConfig.aVeryHighBorderRadius,
              interactive: true,
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: audios!.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                          borderRadius: DesignConfig.mediumBorderRadius,
                          boxShadow: DesignConfig.defaultShadow(context),
                          color: Color(
                                  int.parse(widget.booksModel.color.toString()))
                              .withOpacity(0.4),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(Tools.getAudioName(audios[index])),
                            InkWell(
                              onTap: () {
                                context.read<AudioBloc>().add(GetAudio(
                                      url: ApiEndPoints.baseStorageURL +
                                          audios[index],
                                      booksModel: widget.booksModel,
                                      coursesModel: course,
                                    ));
                              },
                              child: AudioBloc.url ==
                                      ApiEndPoints.baseStorageURL +
                                          audios[index].toString()
                                  ? AudioBloc.audioPlayer.state ==
                                          PlayerState.playing
                                      ? const PrimaryLoading(size: 18)
                                      : const Icon(
                                          CupertinoIcons.pause_fill,
                                          size: 18,
                                        )
                                  : const Icon(
                                      CupertinoIcons.play_arrow_solid,
                                      size: 18,
                                    ),
                            )
                          ],
                        ));
                  },
                ),
              ),
            );
          } else {
            return const PrimaryLoading(size: 18);
          }
        },
      ),
    );
  }

  Column header(BuildContext context, CoursesModel course) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.music_note_list,
              size: 86,
            ),
            Text(
              "Hören Sie",
              style: Theme.of(context).textTheme.headerBold,
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          course.name.toString(),
          style: Theme.of(context).textTheme.titleBold,
        ),
        Text(course.description.toString(),
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Theme.of(context).descriptionColor())),
      ],
    );
  }
}
