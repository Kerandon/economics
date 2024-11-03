
import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../app/state/app_state.dart';
import 'edit_courses/edit_courses_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);
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
                title: const Text('Dark theme'),
                value: appState.isDarkTheme,
                onChanged: (on) {
                  appNotifier.setDarkTheme(on);
                }),
            ListTile(
              title: const Text('Create & update courses'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditCoursesPage()));
              },
            ),
            ListTile(
              title: const Text('Manage questions'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ManageQuestionsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
