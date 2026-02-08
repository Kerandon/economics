import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';

import '../../models/base_painter_painter.dart';
import '../i_diagram_canvas.dart';
import '../painter_methods/paint_text.dart';

class PPCDiagram extends BaseDiagramPainter {
  PPCDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.wineBottles.label,
      xAxisLabel: DiagramLabel.cheeseKG.label,
    );
  }
}
