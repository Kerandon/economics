import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';

import '../quiz_enums/question_type.dart';

class QuizTypeButtons extends ConsumerWidget {
  const QuizTypeButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: size.width * kWrapSpacing,
      children: QuestionType.values.map((e) {
        final isSelected = e == editState.questionType;
        final theme = Theme.of(context);
        final onSurfaceColor =
            isSelected ? Colors.white : theme.colorScheme.onSurface;
        return ChoiceChip(
          selectedColor: theme.colorScheme.primary,
          checkmarkColor: onSurfaceColor,
          label: Text(
            e.name,
            style: theme.textTheme.titleSmall?.copyWith(
              color: isSelected ? Colors.white : theme.colorScheme.onSurface,
            ),
          ),
          selected: isSelected,
          onSelected: (_) => editNotifier.setQuestionType(e),
        );
      }).toList(),
    );
  }
}
