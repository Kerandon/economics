import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:economics_app/sections/settings/manage_questions/methods/update_question_in_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../app/utils/mixins/course_mixin.dart';
import '../../../../app/utils/mixins/unit_mixin.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/building_helper.dart';

void prepareUpdateQuestionForFirebase({
  required BuildContext context,
  required QuestionModel originalQuestion,
  required GlobalKey<FormBuilderState> formKey,
  required CourseMixin course,
  required UnitMixin unit,
  required UnitMixin subunit,
}) {
  final fields = formKey.currentState!.fields;
  final updatedFields = <String, dynamic>{};

  // Retrieve current values from the form
  final question = fields[kQuestion]?.value;
  final correctAnswer = fields[kCorrectAnswer]?.value;
  final incorrectAnswer1 = fields[kIncorrectAnswer1]?.value;
  final incorrectAnswer2 = fields[kIncorrectAnswer2]?.value;
  final incorrectAnswer3 = fields[kIncorrectAnswer3]?.value;
  final explanation = fields[kExplanation]?.value;

  if (unit != originalQuestion.unit) {
    updatedFields[kUnit] = unit;
  }
  if (subunit != originalQuestion.subunit) {
    updatedFields[kSubunit] = subunit;
  }
  if (question != originalQuestion.question) {
    updatedFields[kQuestion] = question;
  }
  final a = originalQuestion.answers!;
  if (correctAnswer != a.elementAt(0).answer ||
      incorrectAnswer1 != a.elementAt(1).answer ||
      incorrectAnswer1 != a.elementAt(2).answer ||
      incorrectAnswer1 != a.elementAt(3).answer) {
    List<AnswerModel> updatedAnswers = [];
    updatedAnswers.add(AnswerModel(correctAnswer, isCorrect: true));
    updatedAnswers.add(AnswerModel(incorrectAnswer1, isCorrect: false));
    updatedAnswers.add(AnswerModel(incorrectAnswer2, isCorrect: false));
    updatedAnswers.add(AnswerModel(incorrectAnswer3, isCorrect: false));
    updatedFields[kAnswers] = updatedAnswers.map((e) => e.toMap()).toList();

    updatedFields[kAnswers] = updatedAnswers.map((e) => e.toMap()).toList();
  }

  if (explanation != originalQuestion.explanation) {
    updatedFields[kExplanation] = explanation;
  }

  if (updatedFields.isNotEmpty) {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BuilderHelper(
            future: updateQuestionInFirebase(
                originalQuestionId: originalQuestion.id!,
                updatedFields: updatedFields),
            onComplete: () {
              WidgetsBinding.instance.addPostFrameCallback((t) {
                if (context.mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ManageQuestionsPage(),
                    ),
                  );
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Question updated successfully')));
            },
          ),
        ),
      );
    } catch (e) {
      throw Exception('Error: $e');
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'No changes to be saved',
        ),
      ),
    );
  }
}