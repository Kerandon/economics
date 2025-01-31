import 'package:economics_app/app/utils/models/course.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/filter_button.dart';
import 'package:economics_app/sections/quizzes/question_home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';

import 'package:economics_app/sections/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app/configs/constants.dart';
import 'diagrams/sections/all_diagrams_page.dart';

class TabBarMain extends ConsumerStatefulWidget {
  const TabBarMain({super.key});

  @override
  ConsumerState<TabBarMain> createState() => _TabBarMainState();
}

class _TabBarMainState extends ConsumerState<TabBarMain>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final startQuizNotifier = ref.read(startQuizProvider.notifier);
    return Scaffold(
      drawer: const SettingsPage(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Excel at Economics'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: size.width * kPageIndentHorizontal),
            child: const QuizFilterButton(),
          ),
        ],
        bottom: TabBar(
          onTap: (index) {
            if (index == 0) {
              startQuizNotifier.setCourse(
                Course(
                  name: kIBEconomics,
                  units: [],
                ),
              );
            } else if (index == 1) {
              startQuizNotifier.setCourse(
                Course(
                  name: kIGCSEEconomics,
                  units: [],
                ),
              );
            }
          },
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: kIBEconomics,
            ),
            Tab(
              text: kIGCSEEconomics,
            ),
            Tab(text: kDiagrams),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          const QuestionHomePage(),
          const QuestionHomePage(),
          AllDiagramsPage(),
        ],
      ),
    );
  }
}
