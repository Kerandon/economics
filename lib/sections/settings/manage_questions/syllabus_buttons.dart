import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/app/enums/syllabus_enum.dart';
import 'package:economics_app/app/utils/models/syllabus_model.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/syllabus_data/courses_data.dart';
import '../../../app/utils/models/unit_model.dart';
import '../../quizzes/custom_widgets/custom_dropdown_tile.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import 'custom_dropdown_heading.dart';

class SyllabusesButtons extends ConsumerWidget {
  const SyllabusesButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;

    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<SyllabusModel>(
          customButton: CustomDropdownHeading(c.syllabuses?.isNotEmpty == true
              ? c.syllabuses!
                  .map((e) => e.syllabus?.toText() ?? 'Unknown')
                  .join(', ')
              : 'Select syllabus'),
          onChanged: (e) {
            List<UnitModel> units = c.units?.toList() ?? [];
            List<UnitModel> subunits = c.subunits?.toList() ?? [];

            // ✅ Get the new course's available units, defaulting to an empty list if null
            final newCourseUnits = e?.units ?? [];

            // ✅ Remove any units that do not belong to the new course
            units.removeWhere((u) => !newCourseUnits.contains(u));

            // ✅ Remove any subunits that belong to removed units
            subunits.removeWhere(
                (s) => !units.expand((u) => u.subunits).contains(s));

            // ✅ Update the question state
            editNotifier.updateCurrentQuestion(
              c.copyWith(
                syllabuses: e != null ? [e] : [],
                units: units,
                subunits: subunits,
              ),
            );
          },
          items: [
            ...allSyllabuses.map(
              (e) => DropdownMenuItem(
                value: e,
                child: CustomDropdownContents(e),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDropdownContents extends ConsumerWidget {
  const CustomDropdownContents(this.syllabus, {super.key});

  final SyllabusModel syllabus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    final isSelected = c.syllabuses?.contains(syllabus) ?? false;
    return InkWell(
      onTap: () {
        List<SyllabusModel> syllabuses = c.syllabuses?.toList() ?? [];

// Toggle the unit selection
        if (syllabuses.contains(syllabus)) {
          syllabuses.remove(syllabus);
        } else {
          syllabuses.add(syllabus);
        }
        List<UnitModel> units = c.units?.toList() ?? [];
        List<UnitModel> subunits = c.subunits?.toList() ?? [];

        final List<UnitModel> newCourseUnits = syllabuses
            .expand((e) => e.units)
            .toList();

        // ✅ Remove any units that do not belong to the new course
        units.removeWhere((u) => !newCourseUnits.contains(u));

        // ✅ Remove any subunits that belong to removed units
        subunits
            .removeWhere((s) => !units.expand((u) => u.subunits).contains(s));

        ///Update the question state
        editNotifier.updateCurrentQuestion(
          c.copyWith(
            syllabuses: syllabuses.toList(),
            units: units.toList(),
            subunits: subunits.toList(),
          ),
        );
      },
      child: CustomDropdownTile(
        text: syllabus.syllabus?.toText() ?? '',
        isSelected: isSelected,
      ),
    );
  }
}
