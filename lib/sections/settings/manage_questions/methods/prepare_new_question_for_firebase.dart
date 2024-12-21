import 'package:economics_app/app/enums/firebase_status.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';

import 'package:economics_app/sections/settings/manage_questions/methods/send_new_question_to_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/building_helper.dart';
import '../../../quizzes/quiz_enums/flip_card_tag.dart';
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
  final questionType = editState.questionType;
  final fields = formKey.currentState!.fields;
  final question = fields[kQuestion]?.value;
  List<AnswerModel> answers = [];
  String? explanation;
  FlipCardTag? flipCardTag;
  bool? isHL;
  final course = editState.course;
  final unit = editState.unit;
  final subunit = editState.subunit;
  answers.add(
    AnswerModel(fields[kCorrectAnswer]?.value, isCorrect: true),
  );
  if (questionType == QuestionType.multi) {
    answers.add(
      AnswerModel(fields[kIncorrectAnswer1]?.value),
    );
    answers.add(
      AnswerModel(fields[kIncorrectAnswer2]?.value),
    );
    answers.add(
      AnswerModel(fields[kIncorrectAnswer3]?.value),
    );
    explanation = fields[kExplanation]?.value;
  }
  if (editState.questionType == QuestionType.flip) {
    flipCardTag = editState.flipCardTag;
    if (course.name == 'IB Economics') {
      isHL = editState.isHL;
    }
  }

  List<DiagramModel>? diagrams;
  if (editState.selectedDiagrams.isNotEmpty) {
    diagrams = editState.selectedDiagrams.toList();
  }

  final q = QuestionModel(
    questionType: questionType,
    course: course,
    unit: unit,
    subunit: subunit,
    question: question,
    diagrams: diagrams,
    answers: answers,
    explanation: explanation,
    flipCardTag: flipCardTag,
    isHL: isHL,
    customTags: editState.customTags,
  );

  final future = sendNewQuestionToFirebase(question: q);
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => BuilderHelper(
        future: future,
        onComplete: (value) {
          // Check if the widget is still mounted before navigating
          if (context.mounted) {
            // Wrap the navigation code inside the post-frame callback
            String text = 'Question added successfully';
            if (value == FirebaseStatus.error) {
              text = kErrorMessage;
            }
            // Ensure we are using a valid context for navigation
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const ManageQuestionsPage(),
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(text)),
            );
            // Show the snack bar
          }
        },
      ),
    ),
  );
}
