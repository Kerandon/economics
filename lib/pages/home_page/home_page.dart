import 'package:economics_app/pages/home_page/custom_navigation_bar.dart';
import 'package:economics_app/pages/home_page/study_notes_page.dart';
import 'package:economics_app/pages/quiz_page/quiz_page.dart';
import 'package:economics_app/pages/settings_page/settings_page.dart';
import 'package:economics_app/configs/constants.dart';
import 'package:economics_app/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        centerTitle: true,
      ),
      body: appState.page == 0 ? const StudyNotesPage() : const QuizPage(),
      bottomNavigationBar: const CustomNavigationBar(),
      drawer: const SettingsPage(),
    );
  }
}

