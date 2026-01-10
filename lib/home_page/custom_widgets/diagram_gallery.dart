import 'package:flutter/material.dart';

import '../../diagrams/models/diagram_widget.dart';

class DiagramGallery extends StatelessWidget {
  final List<DiagramWidget> diagrams;
  final double spacing;

  const DiagramGallery({
    super.key,
    required this.diagrams,
    this.spacing = 8.0, // ⬇️ Tight spacing for more compact look
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // 📏 Calculate the standard half-width
        final double halfWidth = (constraints.maxWidth - spacing) / 2;

        // 📉 Apply the 25% reduction to the box width
        final double itemWidth = halfWidth * 0.65;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            // 🔄 Use Wrap instead of GridView to allow custom sizing
            alignment: WrapAlignment.center, // Centers the smaller boxes
            spacing: spacing,
            runSpacing: spacing,
            children: diagrams.map((d) {
              return Container(
                width: itemWidth, // ⬅️ The new smaller width
                height: itemWidth, // ⬅️ Keep it square
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 500,
                    height: 500,
                    child: CustomPaint(painter: d.basePainterDiagram),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
