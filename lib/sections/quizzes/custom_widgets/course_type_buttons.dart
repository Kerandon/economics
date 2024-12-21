import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../quiz_state/edit_question_state.dart';

class CourseTypeButtons extends ConsumerWidget {
  const CourseTypeButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final theme = Theme.of(context);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: size.width * kWrapSpacing,
      children: editState.courses.map((e) {
        final isSelected = e == editState.course;
        final onSurfaceColor =
            isSelected ? Colors.white : theme.colorScheme.onSurface;

        return ChoiceChip(
          checkmarkColor: onSurfaceColor,
          selected: isSelected,
          selectedColor: theme.colorScheme.primary,
          label: Text(
            e.name,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: onSurfaceColor,
            ),
          ),
          onSelected: (_) => editNotifier.setCourse(e),
        );
      }).toList(),
    );
  }
}
