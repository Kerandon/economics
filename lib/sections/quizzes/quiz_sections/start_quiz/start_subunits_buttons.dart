import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:economics_app/sections/quizzes/quiz_sections/questions/quiz_models/question_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/start_quiz_state.dart';
import 'package:economics_app/sections/settings/manage_questions/custom_dropdown_heading.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/utils/models/unit_model.dart';
import '../../custom_widgets/custom_dropdown_tile.dart';
import '../../methods/get_pref.dart';

class StartSubunitsButton extends ConsumerWidget {
  const StartSubunitsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final startState = ref.watch(startQuizProvider);
    QuestionModel? c = getPref(startState).question;

    List<UnitModel> allSubunits = [];
    if (c?.units?.isNotEmpty ?? false) {
      allSubunits = c?.syllabus?.units
              .where((u) => c.units!.contains(u))
              .expand((e) => e.subunits.toList())
              .toList() ??
          [];
    }

    final selectedUnits = c?.subunits?.isNotEmpty == true
        ? c!.subunits!.map((unit) => unit.name).join(', ')
        : 'Select subunits';

    return SizedBox(
      width: size.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<UnitModel>(
          customButton: CustomDropdownHeading(selectedUnits),
          isExpanded: true,
          onChanged: (_) {},
          items: [
            if (allSubunits.isNotEmpty)
              ...allSubunits.map(
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
    this.subunit, {
    super.key,
  });

  final UnitModel subunit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startState = ref.watch(startQuizProvider);
    final startNotifier = ref.read(startQuizProvider.notifier);
    final p = getPref(startState);
    final c = p.question;
    final isSelected = c?.subunits?.contains(subunit) ?? false;
    return InkWell(
      onTap: () {
        List<UnitModel> subunits = c?.subunits?.toList() ?? [];

// Toggle the unit selection
        if (subunits.contains(subunit)) {
          subunits.remove(subunit);
        } else {
          subunits.add(subunit);
        }

        ///Update the question state

        startNotifier.updateUserPrefs(
          p.copyWith(
            question: c!.copyWith(
              subunits: subunits.toList(),
            ),
          ),
        );
      },
      child: CustomDropdownTile(
        leading: subunit.index,
        text: subunit.name ?? '',
        isSelected: isSelected,
      ),
    );
  }
}
