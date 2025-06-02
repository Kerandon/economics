import 'package:economics_app/sections/settings/audio/sound_track_toggle.dart';
import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/state/app_state.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkThemeState =
        ref.watch(appProvider.select((s) => s.isDarkTheme));

    final appNotifier = ref.read(appProvider.notifier);
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
          ),
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            SwitchListTile(
                title: Text(
                  'Dark theme',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                value: isDarkThemeState,
                onChanged: (on) {
                  appNotifier.setDarkTheme(on);
                }),
            ListTile(
              title: Text(
                'Manage Questions',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ManageQuestionsPage(),
                  ),
                );
              },
            ),
            const SoundTrackToggle(),
          ],
        ),
      ),
    );
  }
}
