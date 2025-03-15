import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../methods/get_pref.dart';
import '../../quiz_state/start_quiz_state.dart';
import '../questions/quiz_models/question_model.dart';

class AnswersAtEndButton extends ConsumerWidget {
  const AnswersAtEndButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startState = ref.watch(startQuizProvider);
    final startNotifier = ref.read(startQuizProvider.notifier);
    final p = getPref(startState);
    QuestionModel? c = getPref(startState).question;
    return DropdownButtonHideUnderline(
      child: CheckboxListTile(
          title: AutoSizeText('Show answers at end'),
          value: c?.showAnswersAtEnd == true,
          onChanged: (on) {
            startNotifier.updateUserPref(
              p.copyWith(
                question: c?.copyWith(showAnswersAtEnd: on),
              ),
            );
          }),
    );
  }
}
