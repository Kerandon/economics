import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../enums/column_width.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class UnitButtons extends ConsumerWidget {
  const UnitButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Row(
      children: [
        Expanded(
          flex: CustomColumnWidth.one.getAddDiagramButtonsWidth(),
          child: Text('Unit'),
        ),
        Expanded(
          flex: CustomColumnWidth.two.getAddDiagramButtonsWidth(),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: size.width * kWrapSpacing,
            children: [
              if (editState.currentQuestion.course?.units.isNotEmpty ??
                  false) ...[
                ...editState.currentQuestion.course!.units.map(
                  (e) {
                    bool isSelected = false;
                    if (editState.currentQuestion.unit == e) {
                      isSelected = true;
                    }
                    final onSurfaceColor =
                        isSelected ? Colors.white : theme.colorScheme.onSurface;
                    return ChoiceChip(
                      checkmarkColor: onSurfaceColor,
                      selectedColor: theme.colorScheme.primary,
                      onSelected: (_) {
                        editNotifier.updateCurrentQuestion(
                          editState.currentQuestion.copyWith(
                            unit: e,
                            subunit: e.subunits.first,
                          ),
                        );
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
