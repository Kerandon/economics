import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/diagram_model.dart';

class DiagramBuilder extends ConsumerWidget {
  const DiagramBuilder({
    this.selectedDiagrams,
    this.doubleCrossAxis = true,
    this.canScroll = true,
    super.key,
  });

  final List<DiagramModel>? selectedDiagrams;
  final bool doubleCrossAxis;
  final bool canScroll;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    List<DiagramModel> diagramsToDisplay = [];

    diagramsToDisplay = selectedDiagrams?.toList() ??
        DiagramModel.getDiagrams(size, context).toList();

    return GridView.builder(
      physics: canScroll ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: diagramsToDisplay.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: doubleCrossAxis
            ? diagramsToDisplay.length == 1
                ? 1
                : 2
            : 1,
      ),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomPaint(
          painter: diagramsToDisplay[index].painter,
        ),
      ),
    );
  }
}
