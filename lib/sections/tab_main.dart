import 'package:economics_app/sections/quizzes/custom_widgets/filter_button.dart';
import 'package:economics_app/sections/quizzes/question_home_page.dart';

import 'package:economics_app/sections/settings/settings_page.dart';
import 'package:flutter/material.dart';

import '../app/configs/constants.dart';
import 'diagrams/sections/all_diagrams_page.dart';

class TabBarMain extends StatefulWidget {
  const TabBarMain({super.key});

  @override
  State<TabBarMain> createState() => _TabBarMainState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _TabBarMainState extends State<TabBarMain> with TickerProviderStateMixin {
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
    final size = MediaQuery.of(context).size;
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
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              icon: Icon(Icons.question_answer_outlined),
            ),
            Tab(
              icon: Icon(Icons.ssid_chart_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          const QuestionHomePage(),
          AllDiagramsPage(),
        ],
      ),
    );
  }
}
