import 'package:economics_app/app/state/app_state.dart';
import 'package:economics_app/sections/articles/articles_pages/study_notes.dart';
import 'package:economics_app/sections/diagrams/all_diagrams_page.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../sections/quizzes/quiz_section/quiz_home_page.dart';
import '../../sections/settings/settings_page.dart';
import '../configs/constants.dart';
import 'custom_navigation_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appProvider);
    Widget page = const StudyNotes();
    if (appState.page == 0) {
      page = const StudyNotes();
    } else if (appState.page == 1) {
      page = const AllDiagramsPage();
    } else if (appState.page == 2) {
      page = const QuizHomePage();
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(kAppName),
        centerTitle: true,
      ),
      body: ExpandableTheme(
    data: ExpandableThemeData(
    animationDuration: Duration(milliseconds: kAnimationDuration),
    useInkWell: true,
    iconColor: Theme.of(context).colorScheme.primary,
    headerAlignment:
    ExpandablePanelHeaderAlignment.center,
    tapBodyToCollapse: true,),
          child: page),
      bottomNavigationBar: const CustomNavigationBar(),
      drawer: const SettingsPage(),
    );
  }
}
