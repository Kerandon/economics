import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/configs/constants.dart';
import '../../../../app/utils/mixins/unit_mixin.dart';
import '../quiz_state/edit_question_state.dart';

class UnitDropdownButtons extends ConsumerWidget {
  const UnitDropdownButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    return Column(
      children: [
        if (editState.course.units.isNotEmpty) ...[
          FormBuilderDropdown(
              initialValue: editState.unit,
              onChanged: (e) {
                editNotifier.setUnit(e as UnitMixin);
                if(e.subunits.isNotEmpty) {
                  editNotifier.setSubunit(e.subunits.first);
                }
              },
              name: kUnit,
              items: editState.course.units.map((e) {
                int numberOfUnits = 0;
                for (var q in editState.allQuestions) {
                  if (q.unit == e) {
                    numberOfUnits++;
                  }
                }

                return DropdownMenuItem(
                    value: e,
                    child: Text('${e.index}  ${e.name}  ($numberOfUnits)'));
              }).toList()),
          if (editState.unit.subunits.isNotEmpty) ...[
            FormBuilderDropdown(
              initialValue: editState.subunit,
              onChanged: (e){
                editNotifier.setSubunit(e!);
              },
              name: kSubunit,
              items: editState.unit.subunits.map((e) {


                int numberOfSubunits = 0;
                for (var q in editState.allQuestions) {
                  if (q.subunit == e) {
                    numberOfSubunits++;
                  }
                }

                return DropdownMenuItem(
                    value: e,
                    child: Text(
                      '${editState.unit.index}.${e.index}  ${e.name}  ($numberOfSubunits)',
                    ));
              }).toList(),
            ),
          ],
        ],
      ],
    );
  }
}
