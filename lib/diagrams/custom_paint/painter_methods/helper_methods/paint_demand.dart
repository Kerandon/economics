import 'dart:ui';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import '../axis/label_align.dart';
import '../../../models/diagram_painter_config.dart';

void paintDemand(
  DiagramPainterConfig c,
  Canvas canvas, {
  String? label,
  bool extend = false,
}) {
  final start = extend ? const Offset(0.10, 0.10) : const Offset(0.20, 0.20);
  final end = extend ? const Offset(0.90, 0.90) : const Offset(0.80, 0.80);

  paintDiagramLines(
    c,
    canvas,
    startPos: start,
    polylineOffsets: [end],
    label2: label ?? DiagramLabel.d.label,
    label2Align: LabelAlign.centerRight,
  );
}
