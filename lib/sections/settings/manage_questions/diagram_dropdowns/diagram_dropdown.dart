import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_type.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DiagramDropdown extends ConsumerWidget {
  const DiagramDropdown(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    final editNotifier = ref.read(editQuestionProvider.notifier);

    List<DiagramModel> allDiagrams = DiagramModel.getDiagrams(size, context);

    return allDiagrams.isNotEmpty
        ? DropdownMenu(
            initialSelection: allDiagrams.first,
            trailingIcon: Text(
              (index + 1).toString(),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            width: size.width,
            requestFocusOnTap: false,
            onSelected: (e) {
              editNotifier.setDiagramsSelected(
                e!,
                // DiagramModel(unit: e!.unit, type: e.type, subtype: e.subtype),
                index,
              );
            },
            dropdownMenuEntries: allDiagrams
                .map(
                  (e) => DropdownMenuEntry(
                      value: e,
                      label: '${e.type?.toText()} - ${e.subtype?.toText()}'),
                )
                .toList(),
          )
        : SizedBox.shrink();
  }
}
