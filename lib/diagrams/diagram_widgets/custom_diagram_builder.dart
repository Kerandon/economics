import 'package:flutter/material.dart';

import '../models/diagram_model.dart';

class CustomDiagramBuilder extends StatelessWidget {
  const CustomDiagramBuilder(
      {super.key, required this.diagrams, this.dimensions = 0.20, this.showDescription = false,});

  final List<DiagramModel>? diagrams;
  final double dimensions;
  final bool showDescription;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dim = size.width * dimensions;
    final diagramsToShow = [];

    return Wrap(
      children: [
        if (diagramsToShow.isNotEmpty)
          ...diagramsToShow.map(
            (e) => Row(
              children: [
                if(e.painter != null && e.painter is CustomPainter)...[SizedBox(
                  width: dim,
                  height: dim,
                  child: CustomPaint(
                    painter:  e.painter
                  ),
                ),
              if(showDescription)...[  Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(e.description ?? ""),
                  ),
                ),],
              ],],
            ),
          ),
        ],

    );
  }
}
