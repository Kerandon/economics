

import 'package:economics_app/app/syllabus_data/courses_data.dart';
import 'package:economics_app/sections/home_page/question_home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:economics_app/sections/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/enums/syllabus_enum.dart';

class TabBarMain extends ConsumerStatefulWidget {
  const TabBarMain({super.key});

  @override
  ConsumerState<TabBarMain> createState() => _TabBarMainState();
}

class _TabBarMainState extends ConsumerState<TabBarMain>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool _initHasRun = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: allSyllabuses.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final startQuizState = ref.watch(startQuizProvider);
    final startQuizNotifier = ref.read(startQuizProvider.notifier);
    if(!_initHasRun) {
      _initHasRun = true;
      _tabController.index = allSyllabuses.indexOf(startQuizState.syllabus);
    }
    return Scaffold(
      drawer: const SettingsPage(),
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        title: Text(
          'Excel at Economics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        bottom: TabBar(
          onTap: (index) {
            if (index == 0) {
              startQuizNotifier.setSyllabus(
              allSyllabuses[index]
              );
            } else if (index == 1) {
              startQuizNotifier.setSyllabus(
                  allSyllabuses[index]
              );
            }
          },
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: Syllabus.ib.name,
            ),
            Tab(
              text: Syllabus.igcse.name,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          const QuestionHomePage(),
          const QuestionHomePage(),
        ],
      ),
    );
  }
}
