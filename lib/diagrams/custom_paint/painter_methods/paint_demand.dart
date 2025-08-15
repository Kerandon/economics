import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_custom_lines.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';

import '../../enums/label_align.dart';
import '../../models/diagram_painter_config.dart';

void paintDemand(DiagramPainterConfig c, Canvas canvas, {String? label}) {
  paintCustomDiagramLines(
    c,
    canvas,
    startPos: Offset(0.20, 0.20),
    polylineOffsets: [Offset(0.80, 0.80)],
    label2: label ?? DiagramLabel.d.label,
    label2Align: LabelAlign.centerRight,
  );
}
