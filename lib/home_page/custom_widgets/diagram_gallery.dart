import 'package:flutter/material.dart';

import '../../diagrams/models/diagram_widget.dart';

class DiagramGallery extends StatelessWidget {
  final List<DiagramWidget> diagrams;
  final double spacing;

  const DiagramGallery({
    super.key,
    required this.diagrams,
    this.spacing = 24.0, // Increased spacing
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double availableWidth = constraints.maxWidth;

        // We define the size based on a 2-column layout even if there is only 1 diagram.
        // This ensures the "one diagram" view isn't giant.
        final double chartSize = (availableWidth - spacing) / 2;

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
          ), // Extra breathing room
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the diagrams
            crossAxisAlignment: CrossAxisAlignment.start,
            children: diagrams.map((d) {
              return Container(
                width: chartSize,
                padding: const EdgeInsets.symmetric(
                  horizontal: 2.0,
                ), // Extra padding
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          16,
                        ), // Softer corners
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      // Added padding inside the card so the painter doesn't touch the edges
                      padding: const EdgeInsets.all(16.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: CustomPaint(painter: d.basePainterDiagram),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
