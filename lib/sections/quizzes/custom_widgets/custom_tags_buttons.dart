import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/constants.dart';
import '../quiz_enums/custom_tag.dart';
import '../quiz_state/edit_question_state.dart';

class CustomTagsButtons extends ConsumerWidget {
  const CustomTagsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: kWrapSpacing * size.width,
      children: CustomTag.values.map(
        (e) {
          bool isSelected = false;
          if (editState.customTags.contains(e)) {
            isSelected = true;
          }
          final onSurfaceColor = isSelected
              ? Colors.white
              : Theme.of(context).colorScheme.onSurface;
          return ChoiceChip(
            onSelected: (_) {
              editNotifier.setCustomTags(e);
            },
            checkmarkColor: onSurfaceColor,
            selectedColor: Theme.of(context).colorScheme.primary,
            label: Text(
              e.toText(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: onSurfaceColor,
                  ),
            ),
            selected: isSelected,
          );
        },
      ).toList(),
    );
  }
}
