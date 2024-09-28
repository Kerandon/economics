import 'package:economics_app/app/state/app_state.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../sections/diagrams/sections/all_diagrams_page.dart';
import '../../sections/quizzes/quiz_sections/quiz_home_page.dart';
import '../../sections/settings/settings_page.dart';
import '../configs/constants.dart';
import 'custom_navigation_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);
    Widget page = const QuizHomePage();
    if (appState.page == 0) {
      page = const QuizHomePage();
    } else if (appState.page == 1) {
      page = const AllDiagramsPage();
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(kAppName),
        centerTitle: true,
      ),
      body: ExpandableTheme(
        data: ExpandableThemeData(
          animationDuration: const Duration(milliseconds: 300),
          useInkWell: true,
          iconColor: Theme.of(context).colorScheme.primary,
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          tapBodyToCollapse: true,
        ),
        child: page,
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      drawer: const SettingsPage(),
    );
  }
}
