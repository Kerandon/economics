import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/column_width.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class HLButton extends ConsumerWidget {
  const HLButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Row(
      children: [
        Expanded(
          flex: CustomColumnWidth.one.getAddDiagramButtonsWidth(),
          child: AutoSizeText('HL'),
        ),
        Expanded(
          flex: CustomColumnWidth.two.getAddDiagramButtonsWidth(),
          child: CheckboxListTile(
            value: editState.currentQuestion.hl ?? false,
            onChanged: (value) {
              editNotifier.updateCurrentQuestion(
                editState.currentQuestion.copyWith(hl: value),
              );
            },
          ),
        ),
      ],
    );
  }
}
