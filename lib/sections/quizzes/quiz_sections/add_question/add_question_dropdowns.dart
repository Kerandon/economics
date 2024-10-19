import 'package:economics_app/app/custom_widgets/gap.dart';
import 'package:economics_app/sections/quizzes/quiz_state/add_question_state.dart';
import 'package:economics_app/sections/quizzes/quiz_state/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/utils/models/unit.dart';
import '../custom_widgets/dropdown_content.dart';

class AddQuestionDropdowns extends ConsumerWidget {
  const AddQuestionDropdowns({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width * 0.90;

    final addQuestionState = ref.watch(addQuestionProvider);
    final addQuestionNotifier = ref.read(addQuestionProvider.notifier);
    final quizState = ref.watch(quizProvider);
    return Column(
      children: [
        DropdownButton(
          value: addQuestionState.unit,
          menuWidth: maxWidth,
          items: addQuestionState.course.units.map(
            (e) {
              int i = 0;
              for (var q in quizState.allQuestions) {
                if (e == q.unit) {
                  i++;
                }
              }

              return DropdownMenuItem(
                value: e,
                child: DropdownContent('${e.index}  ${e.name} ($i)'),
              );
            },
          ).toList(),
          onChanged: (u) {
            if (u != null) {
              addQuestionNotifier
                ..setUnit(u)
                ..setSubunit(u.subunits.isNotEmpty
                    ? u.subunits.first
                    : Unit(name: "", index: ""));
            }
          },
        ),
        const Gap(),
        if (addQuestionState.subunit.name != "") ...[
          DropdownButton(
            menuWidth: maxWidth,
            value: addQuestionState.subunit,
            items: addQuestionState.unit.subunits.map(
              (s) {
                int i = 0;
                for (var q in quizState.allQuestions) {
                  if (s == q.subunit) {
                    i++;
                  }
                }

                return DropdownMenuItem(
                  value: s,
                  child: DropdownContent(
                      '${addQuestionState.unit.index}.${s.index}  ${s.name} ($i)'),
                );
              },
            ).toList(),
            onChanged: (s) {
              addQuestionNotifier.setSubunit(s! as Unit);
            },
          ),
        ],
      ],
    );
  }
}
