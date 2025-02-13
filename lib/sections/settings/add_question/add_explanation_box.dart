import 'package:economics_app/sections/settings/enums/column_width.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_enums/question_key.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import 'custom_text_field.dart';

class AddExplanationBox extends ConsumerWidget {
  const AddExplanationBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Row(
      children: [
        Expanded(
          flex: CustomColumnWidth.two.getAddDiagramButtonsWidth(),
          child: CustomTextField(
            label: QuestionKey.explanation.name,
            name: QuestionKey.explanation.name,
            onChanged: (value) {
              editNotifier.updateCurrentQuestion(
                editState.currentQuestion.copyWith(
                  explanation: value,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
