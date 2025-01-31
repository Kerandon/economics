import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/configs/constants.dart';
import '../quiz_enums/flip_card_tag.dart';
import '../quiz_state/edit_question_state.dart';

class FlipCardTagsButtons extends ConsumerWidget {
  const FlipCardTagsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: size.width * kWrapSpacing,
      children: FlipCardTag.values.map((e) {
        bool isSelected = false;
        if (editState.flipCardTag == e) {
          isSelected = true;
        }
        final onSurfaceColor =
            isSelected ? Colors.white : Theme.of(context).colorScheme.onSurface;
        return ChoiceChip(
          onSelected: (_) {
            editNotifier.setFlipCardTag(e);
          },
          selectedColor: Theme.of(context).colorScheme.primary,
          checkmarkColor: onSurfaceColor,
          label: Text(
            e.toText(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface,
                ),
          ),
          selected: isSelected,
        );
      }).toList(),
    );
  }
}
