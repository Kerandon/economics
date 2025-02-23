import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_enums/custom_tag.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class CustomTagsButtons extends ConsumerWidget {
  const CustomTagsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    // Initialize the list of custom tags from the current question state
    List<CustomTag> customTags = editState.currentQuestion.customTags ?? [];

    return PopupMenuButton<CustomTag>(
      itemBuilder: (BuildContext context) {
        return CustomTag.values.map((CustomTag tag) {
          // Check if the current tag is selected
          bool isSelected = customTags.contains(tag);

          return PopupMenuItem<CustomTag>(
            value: tag,
            child: Row(
              children: [
                // Checkbox to indicate selection
                Checkbox(
                  value: isSelected,
                  onChanged: (_) {
                    // Update the list of custom tags
                    List<CustomTag> updatedTags = List.from(customTags);
                    if (isSelected) {
                      updatedTags.remove(tag); // Remove the tag if it's already selected
                    } else {
                      updatedTags.add(tag); // Add the tag if it's not selected
                    }

                    // Update the state with the new list of custom tags
                    editNotifier.updateCurrentQuestion(
                      editState.currentQuestion.copyWith(
                        customTags: updatedTags,
                      ),
                    );

                    // Close the popup menu
                    Navigator.of(context).pop();
                  },
                ),
                // Tag label
                Text(
                  tag.toText(), // Assuming `toText()` converts CustomTag to a displayable string
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          );
        }).toList();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.onSurface.withAlpha(55)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display selected tags or a placeholder
            Text(
              customTags.isNotEmpty
                  ? customTags.map((tag) => tag.toText()).join(', ')
                  : 'Select Tags',
              style: theme.textTheme.bodyMedium,
            ),
            const Icon(Icons.arrow_drop_down), // Dropdown icon
          ],
        ),
      ),
    );
  }
}