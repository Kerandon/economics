import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../diagrams/models/diagram_model.dart';
import '../../../quizzes/quiz_enums/question_part_enum.dart';
import '../../../quizzes/quiz_state/edit_question_state.dart';
import 'diagram_dropdown.dart';

class DiagramBuilder2 extends ConsumerWidget {
  const DiagramBuilder2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    List<DiagramModel> diagramsToShow = [];
    final part = editState.questionPart;
    final answerIndex = part.toIndexEnum();
    if (part == QuestionPart.question) {
      diagramsToShow = DiagramModel.getSelectedDiagrams(size, context,
              selectedDiagrams:
                  editState.currentQuestion.diagrams?.toList() ?? [])
          .toList();
    } else {
      diagramsToShow = DiagramModel.getSelectedDiagrams(size, context,
              selectedDiagrams:
                  editState.currentQuestion.answers?[answerIndex].diagrams ??
                      [])
          .toList();
    }

    return Wrap(
      children: [
        ...List.generate(
          diagramsToShow.length,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: size.width / 4,
              height: size.width / 4,
              child: Column(
                children: [
                  SizedBox(
                    width: size.width / 5,
                    height: size.width / 5,
                    child: CustomPaint(
                      painter: diagramsToShow[index].painter,
                    ),
                  ),
                  DiagramDropdown(index),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
