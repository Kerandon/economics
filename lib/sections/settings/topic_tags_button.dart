import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/settings/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../quizzes/quiz_enums/topic_tag.dart';
import '../quizzes/quiz_state/edit_question_state.dart';

class TopicTagsButton extends ConsumerWidget {
  const TopicTagsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final editState = ref.watch(editQuestionProvider);

    final f = editState.filterModel;
    final topicText = f.topicTags?.map((e) => e.toText()).join(', ') ?? '';
    final selectedTopics = topicText.isEmpty ? 'Select topics' : topicText;
    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: CustomDropdownHeading(selectedTopics),
          isExpanded: true,
          hint: Text(
            'Select topic',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          value: editState.filterModel.topicTags != null &&
                  editState.filterModel.topicTags!.isNotEmpty
              ? editState.filterModel.topicTags?.first
              : null,
          onChanged: (_) {},
          items: [
            ...TopicTag.values.map(
              (e) => DropdownMenuItem(
                enabled: false,
                value: e,
                child: QuestionTopicDropdownContents(e),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionTopicDropdownContents extends ConsumerWidget {
  const QuestionTopicDropdownContents(
    this.topic, {
    super.key,
  });

  final TopicTag topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final isSelected =
        editState.filterModel.topicTags?.contains(topic) ?? false;

    return InkWell(
      onTap: () {
        // Create a new list from the existing topic tags (if any)
        final updatedTags = editState.filterModel.topicTags?.toList() ?? [];

        // Add or remove the topic based on the current selection
        if (isSelected) {
          updatedTags.remove(topic); // Remove if already selected
        } else {
          updatedTags.add(topic); // Add if not selected
        }

        // Update the filter model with the new list
        editNotifier.updateFilter(
          editState.filterModel.copyWith(topicTags: updatedTags),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                topic.toText(),
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
