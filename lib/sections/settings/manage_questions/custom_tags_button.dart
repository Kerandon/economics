import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_enums/custom_tag.dart';

class CustomTagsButton extends ConsumerWidget {
  const CustomTagsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final c = editState.currentQuestion;
    List<CustomTag> customTags = CustomTag.values.toList();
    String tags = (c.customTags?.map((e) => e.toText()).join(', ') ?? '').isEmpty
        ? 'Select custom tags'
        : c.customTags!.map((e) => e.toText()).join(', ');


    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<CustomTag>(
          customButton: CustomDropdownHeading(tags),
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
    final isSelected = editState.currentQuestion.customTags?.contains(tag) ?? false;
    return InkWell(
      onTap: () {
        List<CustomTag> tags = editState.currentQuestion.customTags?.toList() ?? [];
        isSelected ? tags.remove(tag) : tags.add(tag);
        editNotifier
          .updateCurrentQuestion(
            editState.currentQuestion.copyWith(
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
                tag.toText(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
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
