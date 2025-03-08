import 'package:economics_app/sections/diagrams/enums/diagram_subtype.dart';
import 'package:economics_app/sections/diagrams/enums/diagram_type.dart';
import 'package:economics_app/sections/diagrams/models/diagram_model.dart';
import 'package:economics_app/sections/quizzes/quiz_enums/question_part_enum.dart';
import 'package:economics_app/sections/quizzes/quiz_state/edit_question_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DiagramDropdown extends ConsumerStatefulWidget {
  const DiagramDropdown(this.index, {super.key});

  final int index;

  @override
  ConsumerState<DiagramDropdown> createState() => _DiagramDropdownState();
}

class _DiagramDropdownState extends ConsumerState<DiagramDropdown> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final editNotifier = ref.read(editQuestionProvider.notifier);
    final part = editState.questionPart;

    final q = ref.watch(editQuestionProvider.select((s) => s.currentQuestion));

    List<DiagramModel> allDiagrams = DiagramModel.getAllDiagrams(size, context);

    return allDiagrams.isNotEmpty
        ? DropdownMenu(
            width: size.width,
            requestFocusOnTap: false,
            onSelected: (e) {
              if (e == null) return;

              List<DiagramModel> selectedDiagrams = [];

              if (part == QuestionPart.question) {
                selectedDiagrams = q.diagrams?.toList() ?? [];
              } else {
                selectedDiagrams =
                    q.answers?[part.toIndexEnum()].diagrams?.toList() ?? [];
              }

              // Ensure the selectedDiagrams list is large enough
              if (widget.index < selectedDiagrams.length) {
                selectedDiagrams[widget.index] = e;
              } else {
                selectedDiagrams.add(e);
              }

              if (part == QuestionPart.question) {
                editNotifier.updateCurrentQuestion(
                  q.copyWith(diagrams: selectedDiagrams),
                );
              } else {
                // Clone the answers list to modify
                final updatedAnswers = q.answers?.toList() ?? [];

                // Update the diagrams for the selected answer
                updatedAnswers[part.toIndexEnum()] =
                    updatedAnswers[part.toIndexEnum()]
                        .copyWith(diagrams: selectedDiagrams);

                editNotifier.updateCurrentQuestion(
                  q.copyWith(answers: updatedAnswers.toList()),
                );
              }
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
