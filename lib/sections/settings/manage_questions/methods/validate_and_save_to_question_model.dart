
import 'package:economics_app/sections/settings/manage_questions/methods/send_question_to_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/building_helper.dart';
import '../../../../app/home/home_page.dart';
import '../../../../app/utils/mixins/unit_mixin.dart';
import '../../../quizzes/quiz_enums/question_type.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';
import '../add_question_form.dart';


void validateAndSaveToQuestionModel(
    {required BuildContext context,
      required GlobalKey<FormBuilderState> formKey,
      required EditQuestionState editState}) {
  final validated = formKey.currentState?.saveAndValidate();
  final fields = formKey.currentState!.fields;
  if (validated == true) {
    final u = fields[kUnit]!.widget.initialValue;
    final s = fields[kSubunit]!.widget.initialValue;
    final question = fields[kQuestion]?.value;
    final correctAnswer = fields[kCorrectAnswer]?.value;
    final incorrectAnswer1 = fields[kIncorrectAnswer1]?.value;
    final incorrectAnswer2 = fields[kIncorrectAnswer2]?.value;
    final incorrectAnswer3 = fields[kIncorrectAnswer3]?.value;
    final explanation = fields[kExplanation]?.value;

    final q = QuestionModel(
      type: QuestionType.multi,
      course: editState.course,
      unit: u as UnitMixin,
      subunit: s as UnitMixin,
      question: question,
      answers: [
        AnswerModel(
          correctAnswer,
          isCorrect: true,
        ),
        AnswerModel(
          incorrectAnswer1,
          isCorrect: false,
        ),
        AnswerModel(
          incorrectAnswer2,
          isCorrect: false,
        ),
        AnswerModel(
          incorrectAnswer3,
          isCorrect: false,
        ),
      ],
      explanation: explanation,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BuilderHelper(
            future: sendQuestionToFirebase(question: q),
            loadingText: 'Adding question...please wait a moment',
            onButtonPressed: {
              'Add another question': () {
                Navigator.of(context).pop();
                fields[kQuestion]!.reset();
                formKey.currentState!.reset();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddQuestionForm(),
                  ),
                );
              },
              'Close': () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            }),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Form not validated, correct errors & try again')));
  }
}
