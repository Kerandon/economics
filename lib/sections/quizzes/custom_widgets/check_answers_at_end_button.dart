import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quiz_state/edit_question_state.dart';

class CheckAnswersAtEndButton extends ConsumerWidget {
  const CheckAnswersAtEndButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return SwitchListTile(
        title: const Text('Check answers at end'),
        value: editState.checkAnswersAtEnd,
        onChanged: (e) {
          editNotifier.setCheckAnswersAtEnd(e);
        });
  }
}
