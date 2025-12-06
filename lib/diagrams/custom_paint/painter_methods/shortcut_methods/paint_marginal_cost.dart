import 'dart:ui';

import '../../../enums/diagram_labels.dart';
import '../../../models/custom_bezier.dart';
import '../../../models/diagram_painter_config.dart';
import '../axis/label_align.dart';
import '../diagram_lines/paint_diagram_lines.dart';

paintMarginalCost(DiagramPainterConfig c, Canvas canvas) {
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.05, 0.80),
    bezierPoints: [
      CustomBezier(control: Offset(0.10, 1.25), endPoint: Offset(0.70, 0.10)),
    ],
    label2: DiagramLabel.mc.label,
    label2Align: LabelAlign.centerTop,
  );
}
