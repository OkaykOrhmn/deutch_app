// ignore_for_file: library_private_types_in_public_api

import 'package:deutch_app/core/bloc/audio/audio_bloc.dart';
import 'package:deutch_app/main.dart';
import 'package:deutch_app/ui/theme/design_config.dart';
import 'package:deutch_app/ui/widgets/audio/player_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerNavbar extends StatefulWidget {
  const PlayerNavbar({super.key});

  @override
  _PlayerNavbarState createState() => _PlayerNavbarState();
}

class _PlayerNavbarState extends State<PlayerNavbar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        if (state is AudioSuccess || state is AudioLoading) {
          isShowPlayer.value = true;
        } else {
          isShowPlayer.value = false;
        }
        return AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
            height: state is AudioSuccess || state is AudioLoading ? 72 : 0,
            decoration: BoxDecoration(
              color: AudioBloc.booksModel.color != null
                  ? Color(int.parse(AudioBloc.booksModel.color.toString()))
                      .withOpacity(0.4)
                  : Colors.transparent,
              borderRadius: const BorderRadius.only(
                  topRight: DesignConfig.aVeryHighBorderRadius,
                  topLeft: DesignConfig.aVeryHighBorderRadius),
              boxShadow: DesignConfig.defaultShadow(context),
            ),
            padding: const EdgeInsets.all(8),
            child: PlayerBar(
              booksModel: AudioBloc.booksModel,
              coursesModel: AudioBloc.coursesModel,
            ));
      },
    );
  }
}
