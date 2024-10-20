import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/custom_widgets/gap.dart';
import '../../../../app/utils/models/unit.dart';
import '../../quiz_state/quiz_state.dart';
import '../custom_widgets/dropdown_content.dart';

class QuizOptionsDropdown extends ConsumerWidget {
  const QuizOptionsDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    return Column(
      children: [
        DropdownButton(
          value: quizState.unit,
          menuWidth: size.width * kDropDownWidth,
          items: quizState.course.units.map(
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
              quizNotifier
                ..setUnit(u)
                ..setSubunit(u.subunits.isNotEmpty
                    ? u.subunits.first
                    : Unit(name: "", index: ""));
            }
          },
        ),
        const Gap(),
        if (quizState.subunit.name != "") ...[
          DropdownButton(
            menuWidth: size.width * kDropDownWidth,
            value: quizState.subunit,
            items: quizState.unit.subunits.map(
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
                      '${quizState.unit.index}.${s.index}  ${s.name} ($i)'),
                );
              },
            ).toList(),
            onChanged: (s) {
              quizNotifier.setSubunit(s! as Unit);
            },
          ),
        ],
      ],
    );
  }
}
