import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/app/enums/syllabus_enum.dart';

import 'package:economics_app/app/utils/models/unit_model.dart';
import 'package:economics_app/sections/quizzes/custom_widgets/custom_dropdown_tile.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class SyllabusButton extends ConsumerWidget {
  const SyllabusButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;

    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          customButton: CustomDropdownHeading(
              c.syllabus?.syllabus?.toText() ?? 'Select course'),
          onChanged: (e) {
            // ✅ Clone current units and subunits
            List<UnitModel> units = c.units?.toList() ?? [];
            List<UnitModel> subunits = c.subunits?.toList() ?? [];

            // ✅ Get the new course's available units, defaulting to an empty list if null
            final newCourseUnits = e?.units ?? [];

            // ✅ Remove any units that do not belong to the new course
            units.removeWhere((u) => !newCourseUnits.contains(u));

            // ✅ Remove any subunits that belong to removed units
            subunits.removeWhere((s) => !units.expand((u) => u.subunits).contains(s));

            // ✅ Update the question state
            editNotifier.updateCurrentQuestion(
              c.copyWith(
                syllabus: e,
                units: units,
                subunits: subunits,
              ),
            );
          },


          value: c.syllabus,
          items: [
            ...editState.syllabuses.map(
              (e) => DropdownMenuItem(
                value: e,
                child: CustomDropdownTile(text: e.syllabus?.toText()??''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
