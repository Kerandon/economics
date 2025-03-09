import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/utils/models/unit_model.dart';
import '../../quizzes/custom_widgets/custom_dropdown_tile.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import 'custom_dropdown_heading.dart';

class SubunitsButton extends ConsumerWidget {
  const SubunitsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final c = editState.currentQuestion;
    final units =
        c.units?.expand((e) => e.subunits.map((e) => e)).toList() ?? [];
    final selectedUnits = c.subunits?.isNotEmpty == true
        ? c.subunits!.map((unit) => unit.name).join(', ')
        : 'Select subunits';
    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<UnitModel>(
          customButton: CustomDropdownHeading(selectedUnits),
          isExpanded: true,
          onChanged: (value) {},
          items: [
            ...units.map(
                  (e) {
                return DropdownMenuItem(
                  enabled: false,
                  value: e,
                  child: CustomDropdownContents(e),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDropdownContents extends ConsumerWidget {
  const CustomDropdownContents(
      this.unit, {
        super.key,
      });

  final UnitModel unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final c = editState.currentQuestion;
    final isSelected = c.subunits?.contains(unit) ?? false;
    return InkWell(
        onTap: () {
          List<UnitModel> units = c.subunits?.toList() ?? [];
          units.contains(unit) ? units.remove(unit) : units.add(unit);

          editNotifier.updateCurrentQuestion(
            c.copyWith(
              subunits: units.toList(),
            ),
          );
        },
        child: CustomDropdownTile(
          leading: unit.index,
          text: unit.name ?? '',
          isSelected: isSelected,
        ));
  }
}
