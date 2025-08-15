import 'package:hooks_riverpod/hooks_riverpod.dart';

class AudioStateManager {
  final bool soundtrackIsOn;

  AudioStateManager({required this.soundtrackIsOn});

  AudioStateManager copyWith({bool? soundtrackIsOn}) {
    return AudioStateManager(
      soundtrackIsOn: soundtrackIsOn ?? this.soundtrackIsOn,
    );
  }
}

class AudioNotifier extends StateNotifier<AudioStateManager> {
  AudioNotifier(super.state);

  void setSoundtrackIsOn(bool on) {
    state = state.copyWith(soundtrackIsOn: on);
  }
}

final audioProvider = StateNotifierProvider<AudioNotifier, AudioStateManager>(
  (ref) => AudioNotifier(AudioStateManager(soundtrackIsOn: true)),
);
