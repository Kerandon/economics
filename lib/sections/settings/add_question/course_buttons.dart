import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class CourseButtons extends ConsumerWidget {
  const CourseButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: AutoSizeText('Course'),
        ),
        Expanded(
          flex: 6,
          child: Wrap(
              alignment: WrapAlignment.start,
              spacing: size.width * kWrapSpacing,
              children: editState.courses.map(
                (e) {
                  final course = editState.currentQuestion.course ??
                      editState.courses.first;
                  bool isSelected = false;
                  if (course == e) {
                    isSelected = true;
                  }
                  final onSurfaceColor =
                      isSelected ? Colors.white : theme.colorScheme.onSurface;
                  return ChoiceChip(
                    checkmarkColor: onSurfaceColor,
                    selectedColor: theme.colorScheme.primary,
                    onSelected: (_) {
                      editNotifier.updateCurrentQuestion(
                          editState.currentQuestion.copyWith(course: e));
                    },
                    label: Text(
                      e.course?.name ?? "",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: onSurfaceColor,
                      ),
                    ),
                    selected: isSelected,
                  );
                },
              ).toList()),
        ),
      ],
    );
  }
}
