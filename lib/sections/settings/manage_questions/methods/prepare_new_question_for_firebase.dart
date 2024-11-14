import 'package:economics_app/sections/settings/manage_questions/methods/send_new_question_to_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/building_helper.dart';
import '../../../quizzes/quiz_enums/question_type.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';
import '../manage_questions_page.dart';

Future<void> prepareNewQuestionForFirebase({
  required BuildContext context,
  required GlobalKey<FormBuilderState> formKey,
  required EditQuestionState editState,
}) async {
  final fields = formKey.currentState!.fields;
  final u = editState.unit;
  final s = editState.subunit;
  final question = fields[kQuestion]?.value;
  final correctAnswer = fields[kCorrectAnswer]?.value;
  final incorrectAnswer1 = fields[kIncorrectAnswer1]?.value;
  final incorrectAnswer2 = fields[kIncorrectAnswer2]?.value;
  final incorrectAnswer3 = fields[kIncorrectAnswer3]?.value;
  final explanation = fields[kExplanation]?.value;

  final q = QuestionModel(
    type: QuestionType.multi,
    course: editState.course,
    unit: u,
    subunit: s,
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
        future: sendNewQuestionToFirebase(question: q),
        onComplete: () {
          // Check if the widget is still mounted before navigating
          if (context.mounted) {
            // Wrap the navigation code inside the post-frame callback

            // Ensure we are using a valid context for navigation
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ManageQuestionsPage(),
              ),
            );

            // Show the snack bar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Question added successfully')),
            );
          }
        },
      ),
    ),
  );
}
