import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../app/utils/models/unit_model.dart';
import '../../quizzes/custom_widgets/custom_dropdown_tile.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';

class UnitsButton extends ConsumerWidget {
  const UnitsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final c = editState.currentQuestion;

    final List<UnitModel> units = c.syllabuses
        ?.expand((s) => s.units)
        .toList()
        .cast<UnitModel>() ?? [];


    final selectedUnits = c.units?.isNotEmpty == true
        ? c.units!.map((unit) => unit.name).join(', ')
        : 'Select units';
    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<UnitModel>(
          customButton: CustomDropdownHeading(selectedUnits),
          isExpanded: true,
          onChanged: (_) {},
          items: [
            if (units.isNotEmpty)
              ...units.map(
                (e) => DropdownMenuItem(
                  enabled: false,
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
    final isSelected = c.units?.contains(unit) ?? false;
    return InkWell(
      onTap: () {
        List<UnitModel> units = c.units?.toList() ?? [];
        List<UnitModel> subunits = c.subunits?.toList() ?? [];

// Toggle the unit selection
        if (units.contains(unit)) {
          units.remove(unit);

          ///Remove any subunit that belongs to the deselected unit
          subunits.removeWhere((s) => unit.subunits.contains(s));
        } else {
          units.add(unit);
        }

        ///Update the question state
        editNotifier.updateCurrentQuestion(
          c.copyWith(
            units: units.toList(),
            subunits: subunits.toList(),
          ),
        );
      },
      child: CustomDropdownTile(
        leading: unit.index,
        text: unit.name ?? '',
        isSelected: isSelected,
      ),
    );
  }
}
