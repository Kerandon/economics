import 'package:economics_app/sections/settings/add_question/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_enums/question_key.dart';
import '../../quizzes/quiz_enums/question_part_enum.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class QuestionButton extends ConsumerWidget {
  const QuestionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CustomTextField(
                label: 'Question',
                name: QuestionKey.question.name,
                onChanged: (value) {
                  editNotifier
                    ..updateCurrentQuestion(
                      c.copyWith(question: value),
                    )
                    ..setQuestionPartSelected(QuestionPart.question);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
