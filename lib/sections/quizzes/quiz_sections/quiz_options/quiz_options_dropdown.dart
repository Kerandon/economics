// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/configs/constants.dart';
import '../../../../app/custom_widgets/gap.dart';
import '../../quiz_state/quiz_state.dart';

class QuizOptionsDropdown extends ConsumerStatefulWidget {
  const QuizOptionsDropdown({super.key});

  @override
  ConsumerState<QuizOptionsDropdown> createState() =>
      _QuizOptionsDropdownState();
}

class _QuizOptionsDropdownState extends ConsumerState<QuizOptionsDropdown> {
  @override
  Widget build(BuildContext context) {
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
          dropdownMenuEntries: quizState.course.units
              .map(
                (e) => DropdownMenuEntry(
                  style: ButtonStyle(
                    textStyle: WidgetStateProperty.all(
                        const TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  value: e,
                  label: e.name ?? "",
                  labelWidget: SizedBox(
                    width: size.width,
                    child: Text(
                      e.name ?? "",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Apply onSurface color
                          ),
                    ),
                  ),
                ),
              )
              .toList(),
          onSelected: (u) {
            quizNotifier
              ..setUnit(u!)
              ..setSubunit(u.subunits.first);
          },
        ),
        const Gap(),
        DropdownMenu(
          width: maxWidth,
          initialSelection: quizState.subunit,
          dropdownMenuEntries: quizState.unit.subunits
              .map(
                (s) => DropdownMenuEntry(
                  value: s,
                  label: s.name ?? "",
                  labelWidget: Text(s.name ?? ""),
                ),
              )
              .toList(),
          onSelected: (u) {
            quizNotifier.setSubunit(u!);
          },
        ),
      ],
    );
  }
}
