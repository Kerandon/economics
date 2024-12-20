import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../quizzes/quiz_state/edit_question_state.dart';
import '../utils/methods/get_diagrams_to_display.dart';

class DiagramBuilder extends ConsumerWidget {
  const DiagramBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);

    List<CustomPainter> selectedPainterDiagrams =
        getDiagramsToDisplay(size, context, editState.selectedDiagrams);

    return Builder(builder: (context) {
      return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: selectedPainterDiagrams.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: editState.selectedDiagrams.length == 1 ? 1 : 2,
        ),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: CustomPaint(
            painter: selectedPainterDiagrams[index],
          ),
        ),
      );
    });
  }
}
