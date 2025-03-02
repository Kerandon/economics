import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quizzes/quiz_state/edit_question_state.dart';
import 'custom_dropdown_heading.dart';

class SubunitButton extends ConsumerWidget {
  const SubunitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    return DropdownButton2(
      customButton: CustomDropdownHeading(c.subunit?.name ?? 'Select subunit'),
      value: editState.currentQuestion.subunit,
      onChanged: (e) {
        editNotifier.updateCurrentQuestion(
            editState.currentQuestion.copyWith(subunit: e));
      },
      items: [
        if (editState.currentQuestion.unit != null)
          ...editState.currentQuestion.unit!.subunits.map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e.name ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
      ],
    );
  }
}
