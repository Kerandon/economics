import 'package:economics_app/app/utils/helper_methods/string_extensions.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../diagrams/enums/diagrams_number.dart';

class DiagramDropdown extends ConsumerWidget {
  const DiagramDropdown(this.index, {this.initialValue, super.key});

  final int index;
  final DiagramModel? initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return DropdownMenu(
      trailingIcon: Text(
        (index + 1).toString(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      initialSelection: initialValue ?? editState.selectedDiagrams.first,
      width: size.width,
      requestFocusOnTap: false,
      onSelected: (e) {
        editNotifier.setDiagramsSelected(
          DiagramModel(unit: e!.unit, type: e.type, subtype: e.subtype),
          index,
        );
      },
      dropdownMenuEntries: allDiagrams
          .map(
            (e) => DropdownMenuEntry(
                value: e, label: '${e.type?.name} ${e.subtype?.name}'),
          )
          .toList(),
    );
  }
}

class DiagramsSelection extends ConsumerWidget {
  const DiagramsSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              flex: 2,
              child: ListTile(
                title: Text('Add diagrams'),
              ),
            ),
            DropdownMenu(
              onSelected: (e) {
                editNotifier.setDiagramsNumber(e!);
              },
              initialSelection: editState.diagramsNumber,
              dropdownMenuEntries: DiagramsNumber.values
                  .map(
                    (e) => DropdownMenuEntry(
                      value: e,
                      label: e.name.capitalizeFirstLetter(),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        ...List.generate(
          editState.diagramsNumber.toInt,
          (index) => DiagramDropdown(index),
        )
      ],
    );
  }
}
