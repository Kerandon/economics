import 'dart:ui';

import '../../../enums/diagram_labels.dart';
import '../../../models/custom_bezier.dart';
import '../../../models/diagram_painter_config.dart';
import '../../i_diagram_canvas.dart';
import '../../painter_constants.dart';

import '../diagram_lines/paint_diagram_lines.dart';

void paintMarginalCost(
  DiagramPainterConfig c,
  Canvas? canvas, {
  IDiagramCanvas? iCanvas, // 👈 Added Bridge
}) {
  paintDiagramLines(
    c,
    canvas,
    iCanvas: iCanvas, // 👈 Pass the bridge through
    startPos: const Offset(0.03, 0.80),
    bezierPoints: [
      CustomBezier(
        control: const Offset(0.12, 1.26),
        endPoint: const Offset(0.68, 0.10),
      ),
    ],
    label2: DiagramLabel.mc.label,
    label2Align: LabelAlign.centerTop,
  );
}
