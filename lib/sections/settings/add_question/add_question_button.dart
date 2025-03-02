import 'package:economics_app/sections/settings/add_question/add_question_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/building_helper.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';
import '../../../../app/enums/firebase_status.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import '../methods/send_new_question_to_firebase.dart';

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
        text: 'Add question',
        onPressed: () {
          final q = editState.currentQuestion;
          String? errorMsg;

          if (q.question == null || q.question!.trim().isEmpty) {
            errorMsg = 'Question field is empty';
          } else if (q.answers?.any((e) => e.answer.trim().isEmpty) ?? false) {
            errorMsg = 'Answer field(s) are empty';
          } else if (q.answers?.any((e) => e.isCorrect == true) != true) {
            errorMsg = 'Require at least one correct answer';
          }

          if (errorMsg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMsg)),
            );
            return;
          }

          final future = sendNewQuestionToFirebase(question: q);
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
