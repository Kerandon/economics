import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/custom_chip_button.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';

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
            print('question type ${q.questionType}');
            print('topic ${q.topicTag?.name}');
            print('course ${q.course}');
            print('unit is ${q.unit}');
            print('subunit is ${q.subunit}');
            print('question is ${q.question}');
            print('diagram is ${q.diagrams?.length}');
            print('number of answers ${q.answers?.length}');
            for (var a in q.answers!) {
              print(
                  'answer is ${a.answer} and digrams is ${a.diagrams?.length}');
            }
          }),
    );
  }
}
