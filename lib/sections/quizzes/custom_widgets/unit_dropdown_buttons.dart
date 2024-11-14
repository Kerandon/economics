import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../app/utils/mixins/unit_mixin.dart';
import '../quiz_state/edit_question_state.dart';

class UnitDropdownButtons extends ConsumerStatefulWidget {
  const UnitDropdownButtons({super.key});

  @override
  ConsumerState<UnitDropdownButtons> createState() =>
      _UnitDropdownButtonsState();
}

class _UnitDropdownButtonsState extends ConsumerState<UnitDropdownButtons> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    return Column(
      children: [
        if (editState.course.units.isNotEmpty) ...[
          SizedBox(
            width: size.width,
            child: DropdownButton<UnitMixin>(
              underline: buildUnderline(context),
              isExpanded: true,
              menuMaxHeight: size.height * 0.20,
              onChanged: (e) {
                editNotifier.setUnit(e as UnitMixin);
                if (e.subunits.isNotEmpty) {
                  editNotifier.setSubunit(e.subunits.first);
                }
              },
              value: editState.unit,
              items: editState.course.units.map((e) {
                int numberOfUnits =
                    editState.allQuestions.where((q) => q.unit == e).length;

                return DropdownMenuItem(
                  value: e,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${e.index}  ${e.name}  ($numberOfUnits)',
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          if (editState.unit.subunits.isNotEmpty) ...[
            SizedBox(
              width: size.width, // Set width of the DropdownButton
              child: DropdownButton<UnitMixin>(
                underline: buildUnderline(context),
                isExpanded: true,
                // Expands each item to match the button width
                onChanged: (e) {
                  editNotifier.setSubunit(e!);
                },
                value: editState.subunit,
                items: editState.unit.subunits.map((e) {
                  editState.unit.subunits;
                  int numberOfSubunits = 0;
                  for (var q in editState.allQuestions) {
                    if (q.subunit == e) {
                      numberOfSubunits++;
                    }
                  }
                  return DropdownMenuItem(
                    value: e,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${editState.unit.index}.${e.index}  ${e.name}  ($numberOfSubunits)',
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ],
    );
  }

  Container buildUnderline(BuildContext context) {
    return Container(
      height: 1,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
