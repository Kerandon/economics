import 'package:economics_app/app/enums/course_enum.dart';
import 'package:economics_app/sections/quizzes/question_home_page.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:economics_app/sections/settings/manage_questions/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../app/utils/models/course_model.dart';

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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final startQuizNotifier = ref.read(startQuizProvider.notifier);
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
              startQuizNotifier.setCourse(
                CourseModel(
                  course: CourseEnum.ib,
                  units: [],
                ),
              );
            } else if (index == 1) {
              startQuizNotifier.setCourse(
                CourseModel(
                  course: CourseEnum.igcse,
                  units: [],
                ),
              );
            }
          },
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: CourseEnum.ib.name,
            ),
            Tab(
              text: CourseEnum.igcse.name,
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
