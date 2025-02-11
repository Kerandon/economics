import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/constants.dart';
import '../quiz_enums/quiz_filter.dart';
import '../quiz_state/edit_question_state.dart';

class QuizFilterButtons extends ConsumerWidget {
  const QuizFilterButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: size.width * kWrapSpacing,
          children: QuizFilter.values.map(
            (e) {
              String text = e.toText();

              if (e == QuizFilter.all) {
                int numberOfQuestionsInCourse = 0;
                for (var q in editState.allQuestions) {
                  if (q.topicTag == editState.topicTag &&
                      q.course == editState.course) {
                    numberOfQuestionsInCourse++;
                  }
                }
                text = '${e.toText()}  ($numberOfQuestionsInCourse)';
              }

              final isSelected = e == editState.quizFilter;
              final onSurfaceColor =
                  isSelected ? Colors.white : theme.colorScheme.onSurface;

              return ChoiceChip(
                checkmarkColor: onSurfaceColor,
                selected: isSelected,
                selectedColor: theme.colorScheme.primary,
                label: Text(
                  text,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: onSurfaceColor,
                  ),
                ),
                onSelected: (_) => editNotifier.setQuizFilter(e),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
