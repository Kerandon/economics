import 'package:just_audio/just_audio.dart';

import 'enums/audio_clip.dart';

class AudioManager {
  static void playAudio(AudioClip clip) {
    print('play audio ${clip.name}');
    final player = AudioPlayer();
    player.setAsset('assets/audio/${clip.name}.mp3');
    player.play();
  }
}
