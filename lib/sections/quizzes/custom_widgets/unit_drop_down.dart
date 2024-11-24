import 'package:economics_app/sections/quizzes/quiz_enums/quiz_filter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/utils/mixins/unit_mixin.dart';
import '../quiz_state/edit_question_state.dart';

class UnitDropDown extends ConsumerWidget {
  const UnitDropDown({required this.alwaysShowAllUnits, super.key});

  final bool alwaysShowAllUnits;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);

    bool showUnits = false, showSubunits = false;

    if (editState.course.units.isNotEmpty) {
      if (alwaysShowAllUnits) {
        showUnits = true;
      } else if (editState.quizFilter == QuizFilter.unit ||
          editState.quizFilter == QuizFilter.subunit) {
        showUnits = true;
      } else {
        showUnits = false;
      }
    }

    if (editState.unit.subunits.isNotEmpty) {
      if (alwaysShowAllUnits) {
        showSubunits = true;
      } else if (editState.quizFilter == QuizFilter.subunit) {
        showSubunits = true;
      } else {
        showSubunits = false;
      }
    }

    return Column(
      children: [
        if (showUnits) ...[
          DropdownMenu<UnitMixin>(
            key: UniqueKey(),
            width: size.width,
            requestFocusOnTap: false,
            initialSelection: editState.unit,
            onSelected: (e) {
              editNotifier.setUnit(e as UnitMixin);
              if (e.subunits.isNotEmpty) {
                editNotifier.setSubunit(e.subunits.first);
              }
            },
            dropdownMenuEntries: editState.course.units.map((e) {
              int numberOfUnits = editState.allQuestions
                  .where((q) =>
                      q.questionType == editState.questionType && q.unit == e)
                  .length;
              return DropdownMenuEntry(
                value: e,
                label: '${e.index}  ${e.name}  ($numberOfUnits)',
              );
            }).toList(),
          ),
        ],
        if (showSubunits) ...[
          DropdownMenu<UnitMixin>(
            key: UniqueKey(),
            width: size.width,
            requestFocusOnTap: false,
            initialSelection: editState.subunit.name == ""
                ? editState.unit.subunits.first
                : editState.subunit,
            onSelected: (e) {
              editNotifier.setSubunit(e!);
            },
            dropdownMenuEntries: editState.unit.subunits.map((e) {
              editState.unit.subunits;
              int numberOfSubunits = 0;
              for (var q in editState.allQuestions) {
                if (q.questionType == editState.questionType &&
                    q.subunit == e) {
                  numberOfSubunits++;
                }
              }
              return DropdownMenuEntry(
                value: e,
                label:
                    '${editState.unit.index}.${e.index}  ${e.name}  ($numberOfSubunits)',
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
