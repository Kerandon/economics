import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/custom_dropdown_tile.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_enums/tag.dart';


class TagsButtons extends ConsumerWidget {
  const TagsButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final c = editState.currentQuestion;
    List<Tag> customTags = Tag.values.toList();
    String tags = (c.tags?.map((e) => e.toText()).join(', ') ?? '').isEmpty
        ? 'Select tags'
        : c.tags!.map((e) => e.toText()).join(', ');


    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<Tag>(
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

  final Tag tag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final isSelected = editState.currentQuestion.tags?.contains(tag) ?? false;
    return InkWell(
        onTap: () {
          List<Tag> tags = editState.currentQuestion.tags?.toList() ?? [];
          isSelected ? tags.remove(tag) : tags.add(tag);
          editNotifier
              .updateCurrentQuestion(
            editState.currentQuestion.copyWith(
              tags: tags.toList(),
            ),
          );
        },
        child: CustomDropdownTile(text: tag.toText(), isSelected: isSelected,)
    );
  }
}