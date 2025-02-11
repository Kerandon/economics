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
    List<DiagramModel> diagramsToDisplay = [];

    return GridView.builder(
      physics: canScroll ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: diagramsToDisplay.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
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
