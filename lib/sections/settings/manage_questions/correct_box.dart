
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_state/edit_question_state.dart';

class CorrectBox extends ConsumerWidget {
  const CorrectBox({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    final isSelected =
        editState.currentQuestion.answers?[index].isCorrect ?? false;
    return ChoiceChip(
      selectedColor: theme.colorScheme.primary,
      label: Text(
        isSelected ? 'Correct' : 'Incorrect',
        style: theme.textTheme.bodyMedium?.copyWith(
            color: isSelected ? Colors.white : theme.colorScheme.onSurface),
      ),
      checkmarkColor: isSelected ? Colors.white : theme.colorScheme.onSurface,
      selected: isSelected,
      onSelected: (value) {
        final a = editState.currentQuestion.answers?.toList() ?? [];

        for (int i = 0; i < a.length; i++) {
          a[i] = a[i].copyWith(isCorrect: i == index ? value : false);
        }

        editNotifier.updateCurrentQuestion(
          editState.currentQuestion.copyWith(
            answers: a,
          ),
        );
      },
    );
  }
}
