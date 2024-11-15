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
    final courseUnitSubunitAllQuestionsProvider = ref.watch(
      editQuestionProvider.select((state) => (
            state.course,
            state.unit,
            state.subunit,
            state.allQuestions,
          )),
    );
    final editNotifier = ref.read(editQuestionProvider.notifier);

    return Column(
      children: [
        if (courseUnitSubunitAllQuestionsProvider.$1.units.isNotEmpty) ...[
          DropdownMenu<UnitMixin>(
            width: size.width,
            requestFocusOnTap: false,
            initialSelection: courseUnitSubunitAllQuestionsProvider.$2,
            onSelected: (e) {
              editNotifier.setUnit(e as UnitMixin);
              if (e.subunits.isNotEmpty) {
                editNotifier.setSubunit(e.subunits.first);
              }
            },
            dropdownMenuEntries:
                courseUnitSubunitAllQuestionsProvider.$1.units.map((e) {
              int numberOfUnits = courseUnitSubunitAllQuestionsProvider.$4
                  .where((q) => q.unit == e)
                  .length;
              return DropdownMenuEntry(
                value: e,
                label: '${e.index}  ${e.name}  ($numberOfUnits)',
              );
            }).toList(),
          ),
          if (courseUnitSubunitAllQuestionsProvider.$2.subunits.isNotEmpty) ...[
            DropdownMenu<UnitMixin>(
              width: size.width,
              requestFocusOnTap: false,
              initialSelection:
                  courseUnitSubunitAllQuestionsProvider.$2.subunits.first,
              onSelected: (e) {
                editNotifier.setSubunit(e!);
              },
              dropdownMenuEntries:
                  courseUnitSubunitAllQuestionsProvider.$2.subunits.map((e) {
                courseUnitSubunitAllQuestionsProvider.$2.subunits;
                int numberOfSubunits = 0;
                for (var q in courseUnitSubunitAllQuestionsProvider.$4) {
                  if (q.subunit == e) {
                    numberOfSubunits++;
                  }
                }
                return DropdownMenuEntry(
                  value: e,
                  label:
                      '${courseUnitSubunitAllQuestionsProvider.$2.index}.${e.index}  ${e.name}  ($numberOfSubunits)',
                );
              }).toList(),
            ),
          ],
        ],
      ],
    );
  }
}
