// ignore_for_file: library_private_types_in_public_api

import 'package:audioplayers/audioplayers.dart';
import 'package:deutch_app/core/bloc/audio/audio_bloc.dart';
import 'package:deutch_app/core/routes/route_paths.dart';
import 'package:deutch_app/core/utils/tools.dart';
import 'package:deutch_app/data/model/books_model.dart';
import 'package:deutch_app/data/model/courses_args.dart';
import 'package:deutch_app/data/model/courses_model.dart';
import 'package:deutch_app/main.dart';
import 'package:deutch_app/ui/theme/colors.dart';
import 'package:deutch_app/ui/theme/design_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';

class PlayerBar extends StatefulWidget {
  final BooksModel booksModel;
  final CoursesModel coursesModel;
  const PlayerBar(
      {super.key, required this.booksModel, required this.coursesModel});

  @override
  _PlayerBarState createState() => _PlayerBarState();
}

class _PlayerBarState extends State<PlayerBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(RoutePaths.course,
                arguments: CoursesArgs(
                    id: AudioBloc.coursesModel.id!,
                    bookId: AudioBloc.booksModel.id!,
                    booksModel: AudioBloc.booksModel));
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ClipRRect(
                  borderRadius: DesignConfig.mediumBorderRadius,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      AudioBloc.booksModel.imageUrl ??
                          'https://inspiring-kepler-lhd1x7olv.storage.c2.liara.space/deutch/images/a11.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18,
                      child: Marquee(
                        text:
                            "${widget.booksModel.name.toString()}, Chapter ${widget.coursesModel.chapter ?? 0}: ${widget.coursesModel.name}",
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        accelerationCurve: Curves.linear,
                        blankSpace: 34.0,
                      ),
                    ),
                    Text(
                      Tools.getAudioName(AudioBloc.url),
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    StreamBuilder<Duration?>(
                        stream: AudioBloc.audioPlayer.onPositionChanged,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            AudioBloc.position = snapshot.data!;
                          }
                          return LinearProgressIndicator(
                            value: state is AudioSuccess
                                ? (AudioBloc.position.inSeconds /
                                    AudioBloc.duration!.inSeconds)
                                : 0,
                            backgroundColor: lightColor100,
                            color: widget.booksModel.color == null
                                ? primaryColor
                                : Color(int.parse(
                                    widget.booksModel.color.toString())),
                            minHeight: 4,
                          );
                        })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 4, 4, 4),
                child: InkWell(
                  onTap: () {
                    if (state is AudioInitial) {
                      return;
                    }
                    if (AudioBloc.audioPlayer.state == PlayerState.completed ||
                        AudioBloc.audioPlayer.state == PlayerState.stopped) {
                      context.read<AudioBloc>().add(GetAudio(
                          url: AudioBloc.url,
                          booksModel: widget.booksModel,
                          coursesModel: widget.coursesModel));

                      return;
                    }
                    if (state is AudioSuccess) {
                      if (AudioBloc.audioPlayer.state == PlayerState.playing) {
                        context.read<AudioBloc>().add(PauseAudio());
                      } else {
                        context.read<AudioBloc>().add(ResumeAudio());
                      }
                    }
                  },
                  child: StreamBuilder<PlayerState>(
                      stream: AudioBloc.audioPlayer.onPlayerStateChanged,
                      builder: (context, snapshot) {
                        return AudioBloc.audioPlayer.state ==
                                PlayerState.playing
                            ? const Icon(CupertinoIcons.pause_fill)
                            : const Icon(CupertinoIcons.play_arrow_solid);
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
                child: InkWell(
                  onTap: () {
                    context.read<AudioBloc>().add(StopAudio());
                    isShowPlayer.value = false;
                  },
                  child: const Icon(CupertinoIcons.xmark),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
