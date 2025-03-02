import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/app/utils/models/unit_model.dart';
import 'package:economics_app/sections/settings/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../quizzes/quiz_state/edit_question_state.dart';

class UnitButton extends ConsumerWidget {
  const UnitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<UnitModel>(
          customButton: CustomDropdownHeading(c.unit?.name ?? 'Select unit'),
          value: editState.currentQuestion.unit,
          onChanged: (unit) {
            editNotifier.updateCurrentQuestion(
              editState.currentQuestion.copyWith(
                unit: unit,
                subunit: unit?.subunits.first,
              ),
            );
          },
          items: editState.currentQuestion.course!.units
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
