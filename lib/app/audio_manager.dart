import 'dart:math';

import 'package:economics_app/app/utils/helper_methods/get_asset_files.dart';
import 'package:just_audio/just_audio.dart';

class AudioManager {
  static void playAudio(String path) {
    final player = AudioPlayer();
    player.setAsset(path);
    player.play();
  }

  static void playRandomAudio(String path) {
    getAssetFiles(path).then((List<String> files) async {
      final r = Random().nextInt(files.length);
      final path = files[r];
      final player = AudioPlayer();

      await player.setAsset(path);
      await player.play();
    });
  }
}
