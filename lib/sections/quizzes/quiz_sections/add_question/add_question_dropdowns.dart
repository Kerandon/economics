import 'package:economics_app/app/configs/constants.dart';
import 'package:economics_app/app/custom_widgets/gap.dart';
import 'package:economics_app/sections/quizzes/quiz_state/add_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/utils/models/unit.dart';

class AddQuestionDropdowns extends ConsumerWidget {
  const AddQuestionDropdowns({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final maxWidth = size.width - (size.width * (kPageIndentHorizontal * 2));

    final addQuestionState = ref.watch(addQuestionProvider);
    final addQuestionNotifier = ref.read(addQuestionProvider.notifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownMenu(
          width: maxWidth,
          initialSelection: addQuestionState.unit,
          dropdownMenuEntries: addQuestionState.course.units.map(
            (u) {
              return DropdownMenuEntry(
                style: ButtonStyle(
                  textStyle: WidgetStateProperty.all(
                      const TextStyle(color: Colors.white, fontSize: 20)),
                ),
                value: u,
                label: '${u.index}  ${u.name}',
                labelWidget: SizedBox(
                  width: size.width,
                  child: Text(
                    '${u.index}  ${u.name}',
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
              addQuestionNotifier
                ..setUnit(u)
                ..setSubunit(u.subunits.isNotEmpty
                    ? u.subunits.first
                    : Unit(name: "", index: ""));
            }
          },
        ),
        const Gap(),
        if (addQuestionState.unit.subunits.isNotEmpty) ...[
          DropdownMenu(
            width: maxWidth,
            initialSelection: addQuestionState.subunit,
            dropdownMenuEntries: addQuestionState.unit.subunits.map(
              (s) {
                return DropdownMenuEntry(
                  value: s,
                  label: '${addQuestionState.unit.index}.${s.index}  ${s.name}',
                  labelWidget: Text(
                      '${addQuestionState.unit.index}.${s.index}  ${s.name}'),
                );
              },
            ).toList(),
            onSelected: (s) {
              addQuestionNotifier.setSubunit(s!);
            },
          ),
        ],
      ],
    );
  }
}
