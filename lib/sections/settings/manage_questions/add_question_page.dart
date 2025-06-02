import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/settings/manage_questions/add_explanation_box.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question_button.dart';
import 'package:economics_app/sections/settings/manage_questions/add_answers/answers_button.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question/question_button.dart';
import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import 'filter_buttons.dart';

class AddQuestionPage extends ConsumerStatefulWidget {
  const AddQuestionPage({super.key});

  @override
  ConsumerState<AddQuestionPage> createState() => AddQuestionPageState();
}

class AddQuestionPageState extends ConsumerState<AddQuestionPage> {
  bool _initNumberOfAnswers = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;

    if (!_initNumberOfAnswers && !editState.editExistingQuestion) {
      _initNumberOfAnswers = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (t) {
          editNotifier.updateCurrentQuestion(
            c.copyWith(
              questionTypes: [
                (c.questionTypes != null && c.questionTypes!.isNotEmpty)
                    ? c.questionTypes!.first
                    : QuestionType.multi
              ],
              syllabuses: [
                (c.syllabuses != null && c.syllabuses!.isNotEmpty)
                    ? c.syllabuses!.first
                    : (editState.syllabuses.isNotEmpty
                    ? editState.syllabuses.first
                    : throw Exception('No syllabus available'))
              ],
            ),
          );

        },
      );
    }

    bool isMulti = false;
    if(c.questionTypes?.isNotEmpty == true) {
      isMulti = c.questionTypes?[0] == QuestionType.multi;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              editNotifier.updateCurrentQuestion(c.copyWith(diagrams: []));
              Navigator.of(context).pushReplacement(
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => ManageQuestionsPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );

            },
            icon: Icon(
              Icons.arrow_back_outlined,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal,
            vertical: size.height * kPageIndentVertical),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              collapsedHeight: kToolbarHeight * 1.5,
              expandedHeight: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: FilterButtons(oneChoiceOnlyMode: true,),
              ),
              automaticallyImplyLeading: false,
              pinned:
                  true, // Keeps the app bar fixed at the top// Height of the expanded app bar
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  QuestionButton(
                    initialValue:
                        editState.editExistingQuestion ? c.question : null,
                  ),
                  AnswersButton(
                      initialAnswers: editState.editExistingQuestion
                          ? c.answers?.toList()
                          : null),
                  CustomDivider(),
                  if (isMulti) ...[
                    AddExplanationBox(),
                  ],
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: AddQuestionButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
