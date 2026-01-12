import 'package:flutter/material.dart';

import '../enums/diagram_enum.dart';
import 'base_painter_painter.dart';
class DiagramWidget {
  final BaseDiagramPainter3 basePainterDiagram;
  final GlobalKey repaintKey = GlobalKey(); // ⬅ Add key for capture

  DiagramWidget(this.basePainterDiagram);

  /// Build method for on-screen rendering
  Widget buildWidget({double size = 500}) {
    return RepaintBoundary(
      key: repaintKey,
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: basePainterDiagram,
        ),
      ),
    );
  }
}
