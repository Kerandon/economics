import 'dart:math';

import 'package:economics_app/app/utils/helper_methods/get_asset_files.dart';
import 'package:just_audio/just_audio.dart';

class AudioManager {
  final soundPlayer = AudioPlayer();
  final soundTrackPlayer = AudioPlayer();
  void playSoundTrack(String audio) {
    if (!soundTrackPlayer.playing) {
      soundTrackPlayer.setLoopMode(LoopMode.all);
      soundTrackPlayer.setVolume(0.30);
      soundTrackPlayer.setAsset('assets/audio/soundtracks/$audio.mp3');
      soundTrackPlayer.play();
    }
  }

  void stopSoundTrack() {
    if (soundTrackPlayer.playing) {
      soundTrackPlayer.stop();
    }
  }

  void playSound(String path) {
    soundPlayer.setAsset('assets/audio/$path.mp3');
    soundPlayer.play();
  }

  void playSoundRandomly(String path) {
    getAssetFiles('assets/audio/$path').then((List<String> files) async {
      final r = Random().nextInt(files.length);
      final path = files[r];

      await soundPlayer.setAsset(path);
      await soundPlayer.play();
    });
  }
}
