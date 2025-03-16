import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question_page.dart';
import 'package:economics_app/sections/settings/manage_questions/question_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/methods/get_questions_data.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import '../../tab_main.dart';
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
            filteredQuestions.retainWhere(
                (e) => e.tags?.any((tag) => c.tags!.contains(tag)) ?? false);
          }

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
                  child: Text('${filteredQuestions.length} questions', style: Theme.of(context).textTheme.titleMedium,),
                ),
              ),
              // Scrollable list of questions
              if (filteredQuestions.isNotEmpty) ...[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      QuestionModel q = filteredQuestions[index];
                      return QuestionTile(q: q);
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
