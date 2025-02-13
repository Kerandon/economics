import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../enums/column_width.dart';
import '../../quizzes/quiz_enums/custom_tag.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class CustomTagsButtons extends ConsumerWidget {
  const CustomTagsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    // Initialize the list of custom tags from the current question state
    List<CustomTag> customTags = editState.currentQuestion.customTags ?? [];

    return Row(
      children: [
        Expanded(
          flex: CustomColumnWidth.one.getAddDiagramButtonsWidth(),
          child: AutoSizeText('Custom Tag'),
        ),
        Expanded(
          flex: CustomColumnWidth.two.getAddDiagramButtonsWidth(),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: size.width * kWrapSpacing,
            children: CustomTag.values.map((e) {
              // Check if the current tag is selected
              bool isSelected = customTags.contains(e);

              final onSurfaceColor =
                  isSelected ? Colors.white : theme.colorScheme.onSurface;

              return ChoiceChip(
                checkmarkColor: onSurfaceColor,
                selectedColor: theme.colorScheme.primary,
                onSelected: (_) {
                  // Update the list of custom tags
                  List<CustomTag> updatedTags = List.from(customTags);
                  if (isSelected) {
                    updatedTags
                        .remove(e); // Remove the tag if it's already selected
                  } else {
                    updatedTags.add(e); // Add the tag if it's not selected
                  }

                  // Update the state with the new list of custom tags
                  editNotifier.updateCurrentQuestion(
                    editState.currentQuestion.copyWith(
                      customTags: updatedTags,
                    ),
                  );
                },
                label: Text(
                  e.toText(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: onSurfaceColor,
                  ),
                ),
                selected: isSelected,
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
