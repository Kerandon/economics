import 'dart:math';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../enums/label_align.dart';
import '../../enums/shade_type.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_shading.dart';

class ImportQuota extends BaseDiagramPainter {
  ImportQuota({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.price.label,
      xAxisLabel: DiagramLabel.q.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.21,
      hideYLine: true,
      xLabel: DiagramLabel.q1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.80,
      hideYLine: true,
      xLabel: DiagramLabel.q2.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.65,
      xAxisEndPos: 0.35,
      hideYLine: true,
      xLabel: DiagramLabel.q3.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.65,
      xAxisEndPos: 0.65,
      hideYLine: true,
      xLabel: DiagramLabel.q4.label,
    );
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.10, 0.10),
      polylineOffsets: [Offset(0.90, 0.90)],

      label2: DiagramLabel.dD.label,
      label2Align: LabelAlign.centerRight,
    );
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.10, 0.90),
      polylineOffsets: [Offset(0.90, 0.10)],
      label2: DiagramLabel.sD.label,
      label2Align: LabelAlign.centerRight,
    );
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.50, 0.80),
      polylineOffsets: [Offset(0.90, 0.40)],
      label2: DiagramLabel.sDQ.label,
      label2Align: LabelAlign.centerRight,
    );
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.80),
      polylineOffsets: [Offset(0.90, 0.80)],
      label1: DiagramLabel.pW.label,
      label1Align: LabelAlign.centerLeft,
      label2: DiagramLabel.sW.label,
      label2Align: LabelAlign.centerRight,
    );
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.65),
      polylineOffsets: [Offset(0.90, 0.65)],
      label1: DiagramLabel.pWQ.label,
      label1Align: LabelAlign.centerLeft,
      label2: DiagramLabel.sWQuota.label,
      label2Align: LabelAlign.centerRight,
    );
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0.62, 0.45),
      polylineOffsets: [Offset(0.72, 0.45)],
      arrowOnEnd: true,
      arrowOnEndAngle: pi / 2,
    );
    if (model.subtype == DiagramSubtype.socialWelfare) {
      paintShading(canvas, size, ShadeType.consumerSurplus, [
        Offset(0.0, 0.0), // q1 at pWT
        Offset(0.65, 0.65), // q2 at pWT
        Offset(0.0, 0.65), // approximate top of demand curve (midpoint)
      ]);
      paintShading(canvas, size, ShadeType.producerSurplus, [
        Offset(0.0, 0.65), // extend left bottom
        Offset(0.35, 0.65), // q1 at pWT
        Offset(0, 1.0), // q1 at supply curve (base)
      ]);
      paintShading(canvas, size, ShadeType.welfareLoss, [
        Offset(0.20, 0.80),
        Offset(0.80, 0.80),
        Offset(0.65, 0.65),
        Offset(0.35, 0.65),
      ]);
    }
  }
}
