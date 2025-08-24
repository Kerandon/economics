import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_custom_bezier.dart';

import 'package:flutter/material.dart';

import '../../enums/diagram_labels.dart';
import '../../enums/label_align.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_painter_config.dart';

void paintKeynesianCurve({
  required DiagramPainterConfig config,
  required Canvas canvas,
}) {
  paintCustomBezier(
    config,
    canvas,
    startPos: Offset(0.20, 0.70),
    points: [
      CustomBezier(control: Offset(0.65, 0.70), endPoint: Offset(0.65, 0.70)),
      CustomBezier(control: Offset(0.80, 0.70), endPoint: Offset(0.80, 0.50)),
      CustomBezier(control: Offset(0.80, 0.20), endPoint: Offset(0.80, 0.20)),
    ],
    label1: DiagramLabel.keynesianAS.label,
    label1Align: LabelAlign.centerTop,
  );
}
