import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quiz_state/edit_question_state.dart';

class NumberOfQuestionsButtons extends ConsumerWidget {
  const NumberOfQuestionsButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final theme = Theme.of(context);

    return ListTile(
      title: const Text('Number of questions'),
      trailing: Wrap(
        alignment: WrapAlignment.center,
        spacing: size.width * kWrapSpacing,
        children: kNumberOfQuestions.map((e) {
          final isSelected = e == editState.numberOfQuestions;
          String text = e == -1 ? 'All' : e.toString();
          final onSurfaceColor =
              isSelected ? Colors.white : theme.colorScheme.onSurface;
          return ChoiceChip(
            selectedColor: theme.colorScheme.primary,
            checkmarkColor: onSurfaceColor,
            label: Text(
              text,
              style: theme.textTheme.titleSmall?.copyWith(
                color: onSurfaceColor,
              ),
            ),
            selected: isSelected,
            onSelected: (_) => editNotifier.setNumberOfQuestions(e),
          );
        }).toList(),
      ),
    );
  }
}
