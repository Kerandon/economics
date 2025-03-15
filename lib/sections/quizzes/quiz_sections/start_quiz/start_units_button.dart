import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/quizzes/methods/get_pref.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/utils/models/unit_model.dart';
import '../../custom_widgets/custom_dropdown_tile.dart';

class StartUnitsButton extends ConsumerWidget {
  const StartUnitsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final startState = ref.watch(startQuizProvider);
    final pref = getPref(startState);

    final units = pref.question?.syllabus?.units ?? [];

    final selectedUnits = pref.question?.units?.isNotEmpty == true
        ? pref.question?.units?.map((unit) => unit.name).join(', ')
        : 'Select units';

    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<UnitModel>(
          customButton: CustomDropdownHeading(selectedUnits ?? 'Select units'),
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
    final startState = ref.watch(startQuizProvider);
    final startNotifier = ref.read(startQuizProvider.notifier);
    final pref = getPref(startState);
    final isSelected = pref.question?.units?.contains(unit) ?? false;
    return InkWell(
      onTap: () {
        List<UnitModel> units = pref.question?.units?.toList() ?? [];
        List<UnitModel> subunits = pref.question?.subunits?.toList() ?? [];

// Toggle the unit selection
        if (units.contains(unit)) {
          units.remove(unit);

          ///Remove any subunit that belongs to the deselected unit
          subunits.removeWhere((s) => unit.subunits.contains(s));
        } else {
          units.add(unit);
        }

        startNotifier.updateUserPref(
          pref.copyWith(
            question: pref.question?.copyWith(
              units: units.toList(),
              subunits: subunits.toList(),
            ),
          ),
        );

        ///Update the question state
      },
      child: CustomDropdownTile(
        leading: unit.index,
        text: unit.name ?? '',
        isSelected: isSelected,
      ),
    );
  }
}
