import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/configs/constants.dart';
import '../quiz_enums/topic_tag.dart';
import '../quiz_state/edit_question_state.dart';

class TopicTagsButtons extends ConsumerWidget {
  const TopicTagsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: size.width * kWrapSpacing,
      children: TopicTag.values.map((e) {
        bool isSelected = false;
        if (editState.topicTag == e) {
          isSelected = true;
        }
        final onSurfaceColor =
            isSelected ? Colors.white : theme.colorScheme.onSurface;
        return ChoiceChip(
          onSelected: (_) {
            editNotifier.setFlipCardTag(e);
          },
          selectedColor: theme.colorScheme.primary,
          checkmarkColor: onSurfaceColor,
          label: Text(
            e.toText(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isSelected ? Colors.white : theme.colorScheme.onSurface,
            ),
          ),
          selected: isSelected,
        );
      }).toList(),
    );
  }
}
