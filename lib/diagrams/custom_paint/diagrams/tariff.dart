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

class Tariff extends BaseDiagramPainter {
  Tariff({required DiagramPainterConfig config, required DiagramModel model})
    : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
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
      label1: DiagramLabel.pWT.label,
      label1Align: LabelAlign.centerLeft,
      label2: DiagramLabel.sWTariff.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.20,
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
      startPos: Offset(0.85, 0.76),
      polylineOffsets: [Offset(0.85, 0.70)],
      arrowOnEnd: true,
      arrowOnEndAngle: pi * 2,
    );
    if (model.subtype == DiagramSubtype.socialWelfare) {
      // 1. Consumer Surplus (triangle above pWT, under demand curve)
      paintShading(canvas, size, ShadeType.consumerSurplus, [
        Offset(0.0, 0.0), // q1 at pWT
        Offset(0.65, 0.65), // q2 at pWT
        Offset(0.0, 0.65), // approximate top of demand curve (midpoint)
      ]);

      // 2. Producer Surplus (triangle below pWT, above supply curve)
      paintShading(canvas, size, ShadeType.producerSurplus, [
        Offset(0.0, 0.65), // extend left bottom
        Offset(0.35, 0.65), // q1 at pWT
        Offset(0, 1.0), // q1 at supply curve (base)
      ]);

      // 3. Government Revenue (rectangle between q3 and q4, from pW to pWT)
      paintShading(canvas, size, ShadeType.governmentRevenue, [
        Offset(0.35, 0.80), // q3 at pW
        Offset(0.65, 0.80), // q4 at pW
        Offset(0.65, 0.65), // q4 at pWT
        Offset(0.35, 0.65), // q3 at pWT
      ]);

      // 4. Left deadweight loss triangle (production loss)
      paintShading(canvas, size, ShadeType.welfareLoss, [
        Offset(0.20, 0.80), // q1 at pW
        Offset(0.35, 0.80), // q3 at pW
        Offset(0.35, 0.65), // q3 at pWT
      ]);

      // 5. Right deadweight loss triangle (consumption loss)
      paintShading(canvas, size, ShadeType.welfareLoss, [
        Offset(0.65, 0.80), // q4 at pW
        Offset(0.80, 0.80), // q2 at pW
        Offset(0.65, 0.65), // q4 at pWT
      ]);
    }
  }
}
