import 'package:flutter/material.dart';

import '../../diagrams/models/diagram_widget.dart';
import 'package:flutter/material.dart';
import '../models/slide_content.dart';
class DiagramGallery extends StatelessWidget {
  final List<DiagramWidget> diagrams;
  final double spacing;

  const DiagramGallery({
    super.key,
    required this.diagrams,
    this.spacing = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double halfWidth = (constraints.maxWidth - spacing) / 2;
        final double itemWidth = halfWidth * 0.95;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: spacing,
            runSpacing: spacing,
            children: diagrams.map((d) {
              return Container(
                width: itemWidth,
                height: itemWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: d.buildWidget(size: 500),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
