import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/building_helper.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';
import '../../../../app/enums/firebase_status.dart';
import '../../quizzes/quiz_init_page.dart';
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
            // print('question type ${q.questionType}');
            // print('topic ${q.topicTag?.name}');
            // print('course ${q.course}');
            // print('unit is ${q.unit}');
            // print('subunit is ${q.subunit}');
            // print('is Hl ${q.hl}');
            // print('question is ${q.question}');
            // print('diagram is ${q.diagrams?.length}');
            // print('number of answers ${q.answers?.length}');
            // for (var a in q.answers!) {
            //   print(
            //       'answer is ${a.answer} and diagrams is ${a.diagrams?.length}');
            // }
            // print('custom tags ${q.customTags?.length}');

            if (q.question == null || q.question == "") {
              print('question is empty');
            } else if (q.answers?.any((e) => e.answer == "") ?? false) {
              print('answer is empty');
            } else if (q.answers?.any((e) => e.isCorrect == true) != true) {
              print('no correct answer selected');
            } else {
              print('ALL OK!');
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
                            builder: (context) => const QuizInitPage(),
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
          }),
    );
  }
}
