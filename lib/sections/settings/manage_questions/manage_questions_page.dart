import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/methods/get_questions_data.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import 'filter_buttons.dart';

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

          List<QuestionModel> filteredQuestions = snapshot.data?.toList() ?? [];

          final c = editState.currentQuestion;
          if (c.syllabus != null) {
            filteredQuestions.retainWhere(
              (e) => e.syllabus == c.syllabus,
            );
          }

          if (c.units?.isNotEmpty ?? false) {
            filteredQuestions.retainWhere((e) =>
                e.units?.any((unit) => c.units!.contains(unit)) ?? false);
          }

          if (c.subunits?.isNotEmpty ?? false) {
            filteredQuestions.retainWhere((e) =>
                e.subunits?.any((unit) => c.subunits!.contains(unit)) ?? false);
          }

          if (c.questionType != null) {
            filteredQuestions
                .retainWhere((e) => e.questionType == c.questionType);
          }

          if (c.tags?.isNotEmpty ?? false) {
            filteredQuestions.retainWhere((e) =>
                e.tags?.any((tag) => c.tags!.contains(tag)) ??
                false);
          }
          return CustomScrollView(
            slivers: [
              // Fixed top container
              SliverAppBar(
                collapsedHeight: kToolbarHeight * 2,
                expandedHeight: 0,
                flexibleSpace: FilterButtons(),
                automaticallyImplyLeading: false,
                pinned:
                    true, // Keeps the app bar fixed at the top// Height of the expanded app bar
              ),

              // Scrollable list of questions
              if (filteredQuestions.isNotEmpty) ...[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      QuestionModel q = filteredQuestions[index];
                      return ExpansionTile(
                        expandedAlignment: Alignment.centerLeft,
                        title: Container(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          child: HtmlWidget(q.question ?? ''),
                        ),
                        trailing: IconButton(
                          onPressed: () {

                            editNotifier..updateCurrentQuestion(q)
                            ..setNumberOfMultiAnswers(q, q.answers?.length ?? 4);


                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddQuestionPage(
                                    editQuestion: true,
                                  ),
                                ),
                              );


                          },
                          icon: Icon(
                            Icons.edit_outlined,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...q.answers?.map((a) => Row(
                                          children: [
                                            HtmlWidget(a.answer),
                                            Text(
                                                '    Correct: ${a.isCorrect.toString()}'),
                                          ],
                                        )) ??
                                    [],
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    'Units are ${q.units?.map((e) => e.name)}'),
                                Text(
                                    'Subunits are ${q.subunits?.map((e) => e.name)}'),
                                Text(
                                    'Tags are ${q.tags?.map((e) => e.name)}')
                              ],
                            ),
                          )
                        ],
                      );
                    },
                    childCount: filteredQuestions.length,
                  ),
                ),
              ],
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddQuestionPage(),
              ),
            );
          },
          label: Icon(Icons.add_outlined)),
    );
  }
}
