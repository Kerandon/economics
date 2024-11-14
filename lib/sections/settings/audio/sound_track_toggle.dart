import 'package:economics_app/app/state/audio_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SoundTrackToggle extends ConsumerWidget {
  const SoundTrackToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioProvider);
    final audioNotifier = ref.read(audioProvider.notifier);
    return SwitchListTile(
        title: const Text('Soundtrack is on'),
        value: audioState.soundtrackIsOn,
        onChanged: (on) {
          audioNotifier.setSoundtrackIsOn(on);
        });
  }
}
