import 'package:dropdown_button2/dropdown_button2.dart';
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
    final size = MediaQuery.of(context).size;

    List<CustomTag> customTags = CustomTag.values.toList();

    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<CustomTag>(
          hint: Text(
            'Select custom tag',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          isExpanded: true,
          onChanged: (e) {},
          items: [
            ...customTags.map(
              (e) => DropdownMenuItem(
                enabled: false,
                value: e,
                child: CustomTagsDropdown(e),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTagsDropdown extends ConsumerWidget {
  const CustomTagsDropdown(
    this.tag, {
    super.key,
  });

  final CustomTag tag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final isSelected = editState.filterModel.customTags?.contains(tag) ?? false;
    return InkWell(
      onTap: () {
        List<CustomTag> tags = editState.filterModel.customTags?.toList() ?? [];
        isSelected ? tags.remove(tag) : tags.add(tag);
        editNotifier.updateFilter(
          editState.filterModel.copyWith(
            customTags: tags.toList(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                tag.name,
              ),

            ),
            const SizedBox(width: 16),
            if (isSelected) ...[
              const Icon(Icons.check_box_outlined)
            ] else ...[
              const Icon(Icons.check_box_outline_blank),
            ]

          ],
        ),
      ),
    );
  }
}
