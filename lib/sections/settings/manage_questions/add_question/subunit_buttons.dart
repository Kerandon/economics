import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';

class SubunitButtons extends ConsumerWidget {
  const SubunitButtons({super.key});

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
          child: Text(
            'Subunit',
          ),
        ),
        Expanded(
          flex: 5,
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: size.width * kWrapSpacing,
            children: [
              if (editState.currentQuestion.unit?.subunits.isNotEmpty ??
                  false) ...[
                ...editState.currentQuestion.unit!.subunits.map(
                  (e) {
                    bool isSelected = false;
                    if (editState.currentQuestion.subunit == e) {
                      isSelected = true;
                    }
                    final onSurfaceColor =
                        isSelected ? Colors.white : theme.colorScheme.onSurface;
                    return ChoiceChip(
                      checkmarkColor: onSurfaceColor,
                      selectedColor: theme.colorScheme.primary,
                      onSelected: (_) {
                        editNotifier.updateCurrentQuestion(
                            editState.currentQuestion.copyWith(subunit: e));
                      },
                      label: Text(
                        e.name!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: onSurfaceColor,
                        ),
                      ),
                      selected: isSelected,
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
