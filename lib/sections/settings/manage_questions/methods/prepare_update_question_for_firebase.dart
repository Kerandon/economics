import 'package:economics_app/app/enums/firebase_status.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/settings/manage_questions/manage_questions_page.dart';
import 'package:economics_app/sections/settings/manage_questions/methods/update_question_in_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/answer_model.dart';
import '../../../quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/building_helper.dart';

void prepareUpdateQuestionForFirebase(
    {required BuildContext context,
    required QuestionModel originalQuestion,
    required GlobalKey<FormBuilderState> formKey,
    required EditQuestionState editState}) {
  final fields = formKey.currentState!.fields;
  final updatedFields = <String, dynamic>{};

  final course = editState.course;
  final unit = editState.unit;
  final subunit = editState.subunit;
  final question = fields[kQuestion]?.value;
  final correctAnswer = fields[kCorrectAnswer]?.value;
  final incorrectAnswer1 = fields[kIncorrectAnswer1]?.value;
  final incorrectAnswer2 = fields[kIncorrectAnswer2]?.value;
  final incorrectAnswer3 = fields[kIncorrectAnswer3]?.value;
  final explanation = fields[kExplanation]?.value;
  final flipCardTag = editState.flipCardTag;
  final isHL = editState.isHL;

  if (course != originalQuestion.course) {
    updatedFields[kCourse] = editState.course.name;
  }

  if (unit != originalQuestion.unit) {
    updatedFields[kUnit] = {unit.index: unit.name};
  }
  if (subunit != originalQuestion.subunit) {
    updatedFields[kSubunit] = {subunit.index: subunit.name};
  }
  if (question != originalQuestion.question) {
    updatedFields[kQuestion] = question;
  }

  final a = originalQuestion.answers!;
  List<AnswerModel> updatedAnswers = [];

  if (editState.questionType == QuestionType.multi) {
    if (correctAnswer != a.elementAt(0).answer ||
        incorrectAnswer1 != a.elementAt(1).answer ||
        incorrectAnswer1 != a.elementAt(2).answer ||
        incorrectAnswer1 != a.elementAt(3).answer) {
      updatedAnswers.add(AnswerModel(correctAnswer, isCorrect: true));
      updatedAnswers.add(AnswerModel(incorrectAnswer1, isCorrect: false));
      updatedAnswers.add(AnswerModel(incorrectAnswer2, isCorrect: false));
      updatedAnswers.add(AnswerModel(incorrectAnswer3, isCorrect: false));
      updatedFields[kAnswers] = updatedAnswers.map((e) => e.toMap()).toList();
    }
  }

  if (editState.questionType == QuestionType.flip) {
    if (a.isNotEmpty) {
      if (correctAnswer != a.elementAt(0).answer) {
        updatedAnswers.add(AnswerModel(correctAnswer, isCorrect: true));
      }
    }
    if (a.isEmpty) {
      updatedAnswers.add(AnswerModel(correctAnswer, isCorrect: true));
    }
  }

  updatedFields[kAnswers] = updatedAnswers.map((e) => e.toMap()).toList();
  if (explanation != originalQuestion.explanation) {
    updatedFields[kExplanation] = explanation;
  }

  if (flipCardTag != originalQuestion.flipCardTag) {
    updatedFields[kFlipCardTag] = flipCardTag.name;
  }

  if (isHL != originalQuestion.isHL) {
    updatedFields[kIsHL] = isHL;
  }

  if (updatedFields.isNotEmpty) {
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BuilderHelper(
            future: updateQuestionInFirebase(
                originalQuestionId: originalQuestion.id!,
                updatedFields: updatedFields),
            onComplete: (value) {
              WidgetsBinding.instance.addPostFrameCallback(
                (t) {
                  if (context.mounted) {
                    String text = 'Question updated successfully';

                    if (value == FirebaseStatus.error) {
                      text = kErrorMessage;
                    }
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ManageQuestionsPage(),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(text),
                      ),
                    );
                  }
                },
              );
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
