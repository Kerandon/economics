import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/custom_dropdown_tile.dart';
import 'package:economics_app/sections/quizzes/methods/get_pref.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quiz_enums/tag.dart';

class StartTagsButton extends ConsumerWidget {
  const StartTagsButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final startState = ref.watch(startQuizProvider);
    final c = getPref(startState).question;

    String tags = 'Select tags'; // Default value

    if (c?.tags != null && c!.tags!.isNotEmpty) {
      tags = c.tags!.map((e) => e.toText()).join(', ');
    }

    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<Tag>(
          customButton: CustomDropdownHeading(tags),
          isExpanded: true,
          onChanged: (_) {},
          items: [
            ...Tag.values.map(
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
    final startState = ref.watch(startQuizProvider);
    final startNotifier = ref.read(startQuizProvider.notifier);
    final p = getPref(startState);
    final c = p.question;
    final isSelected = c?.tags?.contains(tag) ?? false;
    return InkWell(
        onTap: () {
          List<Tag> tags = c?.tags?.toList() ?? [];
          isSelected ? tags.remove(tag) : tags.add(tag);
          startNotifier.updateUserPref(
            p.copyWith(
              question: c?.copyWith(
                tags: tags.toList(),
              ),
            ),
          );
        },
        child: CustomDropdownTile(
          text: tag.toText(),
          isSelected: isSelected,
        ));
  }
}
