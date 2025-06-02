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
  final bool oneChoiceOnly;

  const SyllabusesButtons({super.key, this.oneChoiceOnly = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final c = editState.currentQuestion;
    final editNotifier = ref.read(editQuestionProvider.notifier);




    if (oneChoiceOnly) {

      final currentList = c.syllabuses ?? [];

      if (currentList.isEmpty) {
        final defaultType = Syllabus.values.first;

            Future.microtask(() {
          editNotifier.updateCurrentQuestion(
            c.copyWith(
              syllabuses: [
                SyllabusModel(syllabus: defaultType, units: []),
              ],
              units: [],
              subunits: [],
            ),
          );
        });
      } else if (currentList.length > 1) {
        final first = currentList.first;
        Future.microtask(() {
          editNotifier.updateCurrentQuestion(
            c.copyWith(
              syllabuses: [first],
              units: [],
              subunits: [],
            ),
          );
        });
      }
    }

   final selectedText = c.syllabuses?.isNotEmpty == true
        ? c.syllabuses!.map((e) => e.syllabus?.toText() ?? 'Unknown').join(', ')
        : 'Select syllabus';

    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<SyllabusModel>(
          customButton: CustomDropdownHeading(selectedText),
          onChanged: (_) {},
          items: [
            ...allSyllabuses.map(
              (e) => DropdownMenuItem(
                value: e,
                child: CustomDropdownContents(e, oneChoiceOnly: oneChoiceOnly),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDropdownContents extends ConsumerWidget {
  final SyllabusModel syllabus;
  final bool oneChoiceOnly;

  const CustomDropdownContents(this.syllabus,
      {super.key, this.oneChoiceOnly = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    final isSelected = c.syllabuses?.contains(syllabus) ?? false;

    return InkWell(
      onTap: () {
        List<SyllabusModel> syllabuses;

        if (oneChoiceOnly) {
          // Always replace with the single selected syllabus
          syllabuses = [syllabus];
          Navigator.maybePop(context);
        } else {
          syllabuses = c.syllabuses?.toList() ?? [];
          if (isSelected) {
            syllabuses.remove(syllabus);
          } else {
            syllabuses.add(syllabus);
          }
        }

        List<UnitModel> units = c.units?.toList() ?? [];
        List<UnitModel> subunits = c.subunits?.toList() ?? [];

        final newCourseUnits = syllabuses.expand((e) => e.units).toList();
        units.removeWhere((u) => !newCourseUnits.contains(u));
        subunits
            .removeWhere((s) => !units.expand((u) => u.subunits).contains(s));

        editNotifier.updateCurrentQuestion(
          c.copyWith(
            syllabuses: syllabuses,
            units: units,
            subunits: subunits,
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
