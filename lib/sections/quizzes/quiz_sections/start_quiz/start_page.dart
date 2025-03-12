import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_number_of_questions_button.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_subunits_buttons.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_tags_button.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/start_quiz/start_units_button.dart';
import 'package:flutter/material.dart';
import '../../../tab_main.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TabBarMain(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        title: Text('Quiz settings'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            collapsedHeight: kToolbarHeight * 1.5,
            expandedHeight: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: StartUnitsButton(),
                  ),
                  Expanded(
                    flex: 10,
                    child: StartSubunitsButton(),
                  ),
                  Expanded(
                    flex: 10,
                    child: StartTagsButton(),
                  ),
                Expanded(
                flex: 10,
                child: StartNumberOfQuestionsButton(),
          ),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            pinned:
            true, // Keeps the app bar fixed at the top// Height of the expanded app bar
          ),
        ],
      ),
    );
  }
}
