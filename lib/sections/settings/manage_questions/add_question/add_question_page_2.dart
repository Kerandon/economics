import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/topic_tag.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question/add_question_button.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question/number_of_answers_buttons.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question/question_type_buttons.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question/questions_and_answers.dart';
import 'package:economics_app/sections/settings/manage_questions/add_question/subunit_buttons.dart';

import 'package:economics_app/sections/settings/manage_questions/add_question/unit_buttons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';
import 'course_buttons.dart';

class AddQuestionPage2 extends ConsumerStatefulWidget {
  const AddQuestionPage2({super.key});

  @override
  ConsumerState<AddQuestionPage2> createState() => _AddQuestionPage2State();
}

class _AddQuestionPage2State extends ConsumerState<AddQuestionPage2> {
  bool _initNumberOfAnswers = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    if (!_initNumberOfAnswers) {
      _initNumberOfAnswers = true;

      List<AnswerModel> answers = [];
      for (int i = 0; i < editState.numberOfAnswers; i++) {
        answers.add(AnswerModel(
          "",
          isCorrect: i == 0,
        ));
      }
      WidgetsBinding.instance.addPostFrameCallback((t) {
        editNotifier.updateCurrentQuestion(
          editState.currentQuestion.copyWith(
            questionType:
                editState.currentQuestion.questionType ?? QuestionType.multi,
            topicTag: editState.currentQuestion.topicTag ??
                TopicTag.multipleChoiceQuestions,
            course: editState.currentQuestion.course ?? editState.courses.first,
            unit: editState.currentQuestion.unit ??
                editState.courses.first.units.first,
            subunit: editState.currentQuestion.subunit ??
                editState.courses.first.units.first.subunits.first,
            answers: answers,
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * kPageIndentHorizontal,
            vertical: size.height * kPageIndentVertical,
          ),
          child: Column(
            children: [
              QuestionTypeButtons(),
              CourseButtons(),
              UnitButtons(),
              SubunitButtons(),
              NumberOfAnswersButtons(),
              QuestionsAndAnswers(),
              AddQuestionButton(),
            ],
          ),
        ),
      ),
    );
  }
}
