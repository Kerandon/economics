import 'package:economics_app/app/custom_widgets/building_helper.dart';
import 'package:economics_app/app/enums/firebase_status.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question_page.dart';

import 'package:economics_app/sections/settings/manage_questions/question_tile.dart';
import 'package:economics_app/sections/settings/methods/delete_quiz_collection.dart';
import 'package:economics_app/sections/settings/methods/filter_questions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/methods/get_questions_data.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import '../../home_page/tab_main.dart';
import 'excel_manager/excel_manager.dart';
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
  List<QuestionModel> filteredQuestions = [];

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TabBarMain(),
              ),
            );
          },
        ),
        title: const Text('Manage Questions'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ExcelManager(),
                  ),
                );
              },
              icon: Icon(
                FontAwesomeIcons.solidFileExcel,
                color: Colors.green,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Quiz Collection?'),
                    content: const Text('Are you sure you want to delete the entire quiz collection? This cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(), // Cancel
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog first
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BuilderHelper(
                                future: deleteQuizCollection(context),
                                onComplete: (status) {
                                  String msg = 'Quiz collection successfully deleted';
                                  if (status == FirebaseStatus.error) {
                                    msg = 'Quiz collection not deleted';
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(msg)),
                                  );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) => ManageQuestionsPage()),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: const Text('Confirm', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },

              icon: const Icon(Icons.delete_forever, color: Colors.red),
            ),
          )
        ],
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

          filteredQuestions = snapshot.data?.toList() ?? [];

          final c = editState.currentQuestion;
          filteredQuestions =
              filterQuestions(questions: filteredQuestions.toList(), filter: c)
                  .toList();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                collapsedHeight: kToolbarHeight * 2,
                expandedHeight: 0,
                flexibleSpace: FilterButtons(),
                automaticallyImplyLeading: false,
                pinned:
                    true, // Keeps the app bar fixed at the top// Height of the expanded app bar
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${filteredQuestions.length} questions',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              // Scrollable list of questions
              if (filteredQuestions.isNotEmpty) ...[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      QuestionModel q = filteredQuestions[index];
                      return QuestionTile(
                        q: q,
                        pageOnPopupButtonExit: ManageQuestionsPage(),
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
            editNotifier.setEditExistingQuestion(false);
            editNotifier.updateCurrentQuestion(editState.currentQuestion);
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => AddQuestionPage(
                  pageOnBackButton: ManageQuestionsPage(),
                ),
              ),
            );
          },
          label: Icon(Icons.add_outlined)),
    );
  }
}
