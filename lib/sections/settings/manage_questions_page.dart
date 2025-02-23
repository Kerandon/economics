import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/settings/add_question/course_buttons.dart';
import 'package:economics_app/sections/settings/add_question/subunit_buttons.dart';
import 'package:economics_app/sections/settings/add_question/unit_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quizzes/methods/get_questions_data.dart';
import '../quizzes/quiz_state/edit_question_state.dart';

class ManageQuestionsPage extends ConsumerStatefulWidget {
  const ManageQuestionsPage({super.key});

  @override
  ConsumerState<ManageQuestionsPage> createState() =>
      _ManageQuestionsPageState();
}

class _ManageQuestionsPageState extends ConsumerState<ManageQuestionsPage> {
  late final Future<List<QuestionModel>> _questionsFuture;
  bool _questionsHaveBeenSet = false;

  @override
  void initState() {
    _questionsFuture = getQuestionsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Questions'),
      ),
      body: FutureBuilder<List<QuestionModel>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (!_questionsHaveBeenSet && snapshot.data != null) {
            _questionsHaveBeenSet = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              editNotifier
                  .setAllQuestions(snapshot.data as List<QuestionModel>);
            });
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return CustomScrollView(
            slivers: [
              // Fixed top container
              SliverAppBar(
                collapsedHeight: kToolbarHeight * 2,
                expandedHeight: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 10, child: CourseButtons()),
                        Expanded(flex: 10, child: UnitButtons()),
                        Expanded(flex: 10, child: SubunitButtons()),
                        // Expanded(flex: 10, child: QuestionTopicButtons()),
                        // Expanded(flex: 10, child: CustomTagsButtons()),
                        // Expanded(flex: 5, child: HLButton()),
                      ]),
                ),
                automaticallyImplyLeading: false,
                pinned:
                    true, // Keeps the app bar fixed at the top// Height of the expanded app bar
              ),

              // Scrollable list of questions
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      title: HtmlWidget(
                        editState.filteredQuestions[index].question ??
                            "No question",
                      ),
                    );
                  },
                  childCount: editState.filteredQuestions.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
