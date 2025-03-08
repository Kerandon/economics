import 'package:economics_app/app/utils/models/unit_model.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/settings/manage_questions/course_button.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question_page.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_tags_button.dart';
import 'package:economics_app/sections/settings/manage_questions/question_type_button.dart';
import 'package:economics_app/sections/settings/manage_questions/subunits_button.dart';
import 'package:economics_app/sections/settings/manage_questions/units_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/methods/get_questions_data.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';


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
          final f = editState.filterModel;
          if (c.course != null) {
            filteredQuestions.retainWhere(
              (e) => e.course == c.course,
            );
          }

          if (f.units?.isNotEmpty ?? false) {
            filteredQuestions.retainWhere((e) =>
                    e.course == c.course &&
                    (f.units?.contains(e.unit) ??
                        false) // Adjust if you're checking for units
                );
          }

          if (f.subunits?.isNotEmpty ?? false) {
            filteredQuestions.retainWhere((e) =>
                    e.course == c.course &&
                    (f.subunits?.contains(e.subunit) ??
                        false) // Adjust if you're checking for subUnits
                );
          }
          // if (f.topicTags?.isNotEmpty ?? false) {
          //   filteredQuestions.retainWhere((e) =>
          //           e.course == c.course &&
          //           (f.topicTags?.contains(e.topicTag) ??
          //               false) // Adjust if you're checking for subUnits
          //       );
          // }
          if (c.customTags?.isNotEmpty ?? false) {
            filteredQuestions.retainWhere(
              (e) =>
                  e.course == c.course &&
                  // Check if any of the customTags in `e` match any customTags in `c`
                  (e.customTags?.any(
                          (tag) => c.customTags?.contains(tag) ?? false) ??
                      false),
            );
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
                      Expanded(flex: 10, child: CourseButton()),
                      Expanded(flex: 10, child: UnitsButton()),
                      Expanded(flex: 10, child: SubunitsButton()),
                      Expanded( flex: 10, child: QuestionTypeButton()),
                      Expanded(flex: 10, child: CustomTagsButton()),


                    ],
                  ),
                ),
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
                        title: Container(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          child: HtmlWidget(q.question ?? ''),
                        ),
                        trailing: IconButton(
                          onPressed: () {

                            /// Need to repopulate Course with unit and subunits
                            for (var e in editState.courses) {
                              if (e.course == q.course?.course) {
                                List<UnitModel> s = [];
                                for (var u in e.units) {
                                  if (u == q.unit) {
                                    s = u.subunits.toList();
                                  }
                                }
                                q = q.copyWith(
                                  course: q.course?.copyWith(
                                    units: e.units,
                                  ),
                                  unit: UnitModel(
                                    name: q.unit?.name,
                                    subunits: [...s],
                                  ),
                                );
                              }
                            }


                            editNotifier.updateCurrentQuestion(q);

                            WidgetsBinding.instance.addPostFrameCallback(
                              (t) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AddQuestionPage(
                                      editQuestion: true,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.edit_outlined,
                          ),
                        ),
                        children: [
                          Column(
                            children: [
                              ...q.answers?.map((a) => HtmlWidget(a.answer)) ??
                                  [],
                            ],
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
