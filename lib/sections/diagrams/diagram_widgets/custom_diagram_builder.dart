import 'package:flutter/material.dart';

import '../models/diagram_model.dart';

class CustomDiagramBuilder extends StatelessWidget {
  const CustomDiagramBuilder(
      {super.key, required this.diagrams, this.dimensions = 0.20});

  final List<DiagramModel>? diagrams;
  final double dimensions;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagramsToShow = DiagramModel.getSelectedDiagrams(
      size,
      context,
      selectedDiagrams: diagrams?.toList() ?? [],
    ).toList();

    return Wrap(
      children: [
        ...diagramsToShow.map(
          (e) => Padding(
            padding: const EdgeInsets.all(42.0),
            child: SizedBox(
              width: size.width * dimensions,
              height: size.width * dimensions,
              child: CustomPaint(
                painter: e.painter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
