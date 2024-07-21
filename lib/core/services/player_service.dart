import 'package:audioplayers/audioplayers.dart';

class PlayerService {
  AudioPlayer player = AudioPlayer();

  Future<void> initialize({required final String src}) async {
    await player.setReleaseMode(ReleaseMode.stop);
    await player.play(UrlSource(src));
  }
}
