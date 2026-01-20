import 'package:flutter/material.dart';

import '../../diagrams/models/diagram_widget.dart';
import 'package:flutter/material.dart';
import '../models/slide_content.dart';
import 'package:flutter/material.dart';

class DiagramGallery extends StatelessWidget {
  final List<DiagramWidget> diagrams;
  final double spacing;

  const DiagramGallery({super.key, required this.diagrams, this.spacing = 1.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double halfWidth = (constraints.maxWidth - spacing) / 2;
        final double itemSize = halfWidth * 0.95;

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: spacing,
          runSpacing: spacing,
          children: diagrams.map((d) {
            return SizedBox(
              width: itemSize,
              height: itemSize,

              // ✅ IMPORTANT: reuse the SAME widget instance
              child: FittedBox(fit: BoxFit.contain, child: d.widget),
            );
          }).toList(),
        );
      },
    );
  }
}
