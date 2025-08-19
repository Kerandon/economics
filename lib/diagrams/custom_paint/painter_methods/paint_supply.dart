import 'dart:ui';

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_custom_lines.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';

import '../../enums/label_align.dart';
import '../../models/diagram_painter_config.dart';

void paintSupply(
    DiagramPainterConfig c,
    Canvas canvas, {
      String? label,
      bool extend = false,
    }) {
  final start = extend ? const Offset(0.10, 0.90) : const Offset(0.20, 0.80);
  final end   = extend ? const Offset(0.90, 0.10) : const Offset(0.80, 0.20);

  paintCustomDiagramLines(
    c,
    canvas,
    startPos: start,
    polylineOffsets: [end],
    label2: label ?? DiagramLabel.s.label,
    label2Align: LabelAlign.centerRight,
  );
}
