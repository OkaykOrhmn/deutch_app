import 'package:deutch_app/core/bloc/audio/audio_bloc.dart';
import 'package:deutch_app/ui/theme/design_config.dart';
import 'package:deutch_app/ui/widgets/audio/player_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerComponent extends StatefulWidget {
  const PlayerComponent({
    super.key,
  });

  @override
  State<PlayerComponent> createState() => _PlayerComponentState();
}

class _PlayerComponentState extends State<PlayerComponent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        if (state is AudioSuccess || state is AudioLoading) {
          return Container(
            height: 72,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
                color: AudioBloc.booksModel.color != null
                    ? Color(int.parse(AudioBloc.booksModel.color.toString()))
                        .withOpacity(0.4)
                    : Colors.transparent,
                borderRadius: DesignConfig.highBorderRadius,
                boxShadow: DesignConfig.defaultShadow(context)),
            child: PlayerBar(
              booksModel: AudioBloc.booksModel,
              coursesModel: AudioBloc.coursesModel,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
