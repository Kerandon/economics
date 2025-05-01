import 'package:economics_app/sections/quizzes/quiz_enums/question_type.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';
import '../../../app/custom_widgets/building_helper.dart';
import '../../../app/enums/firebase_status.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import '../methods/send_new_question_to_firebase.dart';
import 'add_question_page.dart';

class AddQuestionButton extends ConsumerWidget {
  const AddQuestionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final editState = ref.watch(editQuestionProvider);

    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: size.height * kPageIndentVertical * 2),
      child: CustomChipButton(
        text:
            editState.editExistingQuestion ? 'Update question' : 'Add question',
        onPressed: () {
          final q = editState.currentQuestion;
          List<String> errors = [];

          if (q.question == null || q.question!.trim().isEmpty) {
            errors.add('Question field is empty');
          }
          if (!editState.editExistingQuestion &&
              editState.allQuestions.any((e) =>
                  e.question == q.question && e.syllabus == q.syllabus)) {
            errors.add('Question already exists');
          }
          if (q.questionType == QuestionType.multi) {
            var answerTexts =
                q.answers?.map((a) => a.answer.trim()).toList() ?? [];
            if (answerTexts.toSet().length != answerTexts.length) {
              errors.add('Duplicate answers are not allowed');
            }
            if (q.answers?.any((e) => e.isCorrect == true) != true) {
              errors.add('Require at least one correct answer');
            }
          }

          if (errors.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  errors.join('\n'),
                ),
              ),
            );
            return;
          }

          final future = sendNewQuestionToFirebase(
              question: q, existing: editState.editExistingQuestion);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => BuilderHelper(
                future: future,
                onComplete: (value) {
                  if (context.mounted) {
                    String text = 'Question added successfully';
                    if (value == FirebaseStatus.error) {
                      text = kErrorMessage;
                    }

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const AddQuestionPage(),
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(text)),
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
