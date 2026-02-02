import 'package:flutter/material.dart';
import 'base_painter_painter.dart';

class DiagramWidget {
  final List<BaseDiagramPainter> basePainterDiagrams;

  /// You can pass any number of painters; they will each become a CustomPaint widget.
  DiagramWidget(this.basePainterDiagrams);

  /// Returns a list of Widgets for each diagram
  List<Widget> get widget => basePainterDiagrams
      .map(
        (basePainterDiagram) => ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 500,
            minHeight: 500,
            maxWidth: 500,
            maxHeight: 500,
          ),
          child: CustomPaint(painter: basePainterDiagram),
        ),
      )
      .toList();
}
