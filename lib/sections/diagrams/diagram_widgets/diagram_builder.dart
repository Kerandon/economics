
import 'package:economics_app/sections/diagrams/utils/mixins.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../quizzes/quiz_state/edit_question_state.dart';
import '../data/all_diagrams.dart';

class DiagramBuilder extends ConsumerWidget {
  const DiagramBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final editState = ref.watch(editQuestionProvider);
    final allDiagrams = AllDiagrams(
      size: size,
      surfaceColor: Theme.of(context).colorScheme.surface,
      onSurfaceColor: Theme.of(context).colorScheme.onSurface,
      primaryColor: Theme.of(context).colorScheme.primary,
    ).getAllDiagrams();

    List<CustomPainter> selectedPainterDiagrams = [];

    for (var p in allDiagrams) {
      for (var d in editState.diagramsSelected.entries) {
        final n = p as NameMixin;
        if (n.name == d.value.name) {
          selectedPainterDiagrams.add(p);
        }
      }
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: selectedPainterDiagrams.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
        editState.diagramsSelected.length == 1 ? 1 : 2,
      ),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: CustomPaint(
          painter: selectedPainterDiagrams[index],
        ),
      ),
    );
  }
}


