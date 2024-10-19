// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/gap.dart';
import '../../../../app/utils/models/unit.dart';
import '../../quiz_state/quiz_state.dart';

class QuizOptionsDropdown extends ConsumerWidget {
  const QuizOptionsDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width - (size.width * (kPageIndentHorizontal * 2));
    final quizState = ref.watch(quizProvider);
    final quizNotifier = ref.read(quizProvider.notifier);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownMenu(
            width: maxWidth,
            initialSelection: quizState.unit,
            dropdownMenuEntries: quizState.course.units.map(
              (e) {
                int i = 0;
                for (var q in quizState.allQuestions) {
                  if (e == q.unit) {
                    i++;
                  }
                }

                return DropdownMenuEntry(
                  style: ButtonStyle(
                    textStyle: WidgetStateProperty.all(
                        const TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  value: e,
                  label: '${e.index}  ${e.name}  ($i)',
                  labelWidget: SizedBox(
                    width: size.width,
                    child: Text(
                      '${e.index}  ${e.name}  ($i)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Apply onSurface color
                          ),
                    ),
                  ),
                );
              },
            ).toList(),
            onSelected: (u) {
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
            DropdownMenu(
              width: maxWidth,
              initialSelection: quizState.subunit,
              dropdownMenuEntries: quizState.unit.subunits.map(
                (s) {
                  int i = 0;
                  for (var q in quizState.allQuestions) {
                    if (s == q.subunit) {
                      i++;
                    }
                  }

                  return DropdownMenuEntry(
                      value: s,
                      label:
                          '${quizState.unit.index}.${s.index}  ${s.name}  ($i)',
                      labelWidget: Text(
                          '${quizState.unit.index}.${s.index}  ${s.name}  ($i)'));
                },
              ).toList(),
              onSelected: (s) {
                quizNotifier.setSubunit(s! as Unit);
              },
            ),
          ],
        ]);
  }
}
