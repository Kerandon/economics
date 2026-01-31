import 'package:flutter/material.dart';

import '../enums/diagram_enum.dart';
import 'base_painter_painter.dart';
import 'package:flutter/material.dart';

// class DiagramWidget {
//   final BaseDiagramPainter3 basePainterDiagram;
//
//   DiagramWidget(this.basePainterDiagram);
//
//   Widget get widget => SizedBox(
//     width: 500,
//     height: 500,
//     child: CustomPaint(painter: basePainterDiagram),
//   );
// }

class DiagramWidgetNEW {
  final List<BaseDiagramPainter3> basePainterDiagrams;

  /// You can pass any number of painters; they will each become a CustomPaint widget.
  DiagramWidgetNEW(this.basePainterDiagrams);

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
