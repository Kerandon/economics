import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/custom_divider.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/settings/manage_questions/course_button.dart';
import 'package:economics_app/sections/settings/manage_questions/add_explanation_box.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question_button.dart';
import 'package:economics_app/sections/settings/manage_questions/answers_button.dart'
    show AnswersButton;
import 'package:economics_app/sections/settings/manage_questions/custom_tags_button.dart';
import 'package:economics_app/sections/settings/manage_questions/number_of_answers_button.dart';
import 'package:economics_app/sections/settings/manage_questions/question_button.dart';
import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:economics_app/sections/settings/manage_questions/question_type_button.dart';
import 'package:economics_app/sections/settings/manage_questions/unit_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import 'subunit_button.dart';

class AddQuestionPage extends ConsumerStatefulWidget {
  const AddQuestionPage({this.editQuestion = false, super.key});

  final bool editQuestion;

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

    if (!_initNumberOfAnswers && !widget.editQuestion) {
      _initNumberOfAnswers = true;
      WidgetsBinding.instance.addPostFrameCallback((t) {
        print('number of answers is ${c.answers?.length}');
        List<AnswerModel> answers = [];
        if (c.questionType == QuestionType.multi) {
          int target = c.answers?.length ?? 2;
          for (int i = 0; i < target; i++) {
            answers.add(AnswerModel(
              "",
              isCorrect: i == 0,
            ));
          }
        }else {
          answers = [c.answers?.first ?? AnswerModel("")];
        }
        editNotifier.updateCurrentQuestion(
          c.copyWith(
            questionType: c.questionType ?? QuestionType.multi,
            course: c.course ?? editState.courses.first,
            unit: c.unit ?? editState.courses.first.units.first,
            subunit:
                c.subunit ?? editState.courses.first.units.first.subunits.first,
            answers: answers,
          ),
        );
      });
    }

    final isMulti = c.questionType == QuestionType.multi;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ManageQuestionsPage(),
              ));
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
                title: Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: CourseButton(),
                    ),
                    Expanded(
                      flex: 10,
                      child: UnitButton(),
                    ),
                    Expanded(
                      flex: 10,
                      child: SubunitButton(),
                    ),
                    Expanded(
                      flex: 10,
                      child: QuestionTypeButton(),
                    ),
                    Expanded(
                      flex: 10,
                      child: CustomTagsButton(),
                    ),
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
              pinned:
                  true, // Keeps the app bar fixed at the top// Height of the expanded app bar
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  QuestionButton(
                    initialValue: widget.editQuestion ? c.question : null,
                  ),
                  if (isMulti) ...[
                    NumberOfAnswersButton(),
                  ],
                  AnswersButton(
                      initialAnswers:
                          widget.editQuestion ? c.answers?.toList() : null),
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
