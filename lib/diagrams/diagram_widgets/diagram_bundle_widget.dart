
import 'package:flutter/material.dart';

import '../models/diagram_bundle.dart';

class DiagramBundleWidget extends StatelessWidget {
  final DiagramBundle diagramBundle;

  const DiagramBundleWidget({
    super.key,
    required this.diagramBundle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagrams = diagramBundle.diagramModels;

    if (diagrams.isEmpty) {
      return const SizedBox.shrink(); // No diagrams to show
    }

    final maxDimension = size.width < size.height ? size.width : size.height;
    final maxAllowedSize = maxDimension * 0.8;

    if (diagrams.length == 1) {
      final diagramSize = maxAllowedSize.clamp(0, maxAllowedSize).toDouble();

      return Center(
        child: SizedBox(
          width: diagramSize,
          height: diagramSize,
          child: CustomPaint(
            painter: diagrams.first.painter,
            size: Size(diagramSize, diagramSize),
          ),
        ),
      );
    } else {
      // For multiple diagrams, reduce size proportionally and wrap in a Row
      final count = diagrams.length;
      final individualSize =
      (maxAllowedSize / count).clamp(50, maxAllowedSize).toDouble();

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: diagrams.map((diagram) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: individualSize,
                height: individualSize,
                child: CustomPaint(
                  painter: diagram.painter,
                  size: Size(individualSize, individualSize),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }
  }
}
