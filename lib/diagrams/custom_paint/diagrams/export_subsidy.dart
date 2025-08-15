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

class ExportSubsidy extends BaseDiagramPainter {
  ExportSubsidy({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.25,
      xAxisEndPos: 0.25,
      xLabel: DiagramLabel.q1.label,
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.25,
      xAxisEndPos: 0.75,
      xLabel: DiagramLabel.q2.label,
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.35,
      xLabel: DiagramLabel.q3.label,
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.65,
      xLabel: DiagramLabel.q4.label,
      hideYLine: true,
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
      startPos: Offset(0.50, 0.60),
      polylineOffsets: [Offset(0.90, 0.20)],
      label2: DiagramLabel.sDSub.label,
      label2Align: LabelAlign.centerRight,
    );
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.35),
      polylineOffsets: [Offset(0.90, 0.35)],

      label1: DiagramLabel.pW.label,
      label1Align: LabelAlign.centerLeft,
      label2: DiagramLabel.sW.label,
      label2Align: LabelAlign.centerRight,
    );
    paintCustomDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.25),
      polylineOffsets: [Offset(0.90, 0.25)],
      label1: DiagramLabel.pWS.label,
      label1Align: LabelAlign.centerLeft,
      label2: DiagramLabel.sW.label,
      label2Align: LabelAlign.centerRight,
    );
    if (model.subtype == DiagramSubtype.socialWelfare) {
      // Left welfare loss triangle (underconsumption)
      paintShading(canvas, size, ShadeType.welfareLoss, [
        Offset(0.25, 0.25), // q1 at pW
        Offset(0.35, 0.35), // q3 at pW
        Offset(0.25, 0.35), // q3 at pWS
      ]);

      // Right welfare loss triangle (overproduction)
      paintShading(canvas, size, ShadeType.welfareLoss, [
        Offset(0.65, 0.35), // q4 at pWS
        Offset(0.75, 0.35), // q2 at pWS
        Offset(0.75, 0.25), // q4 at pW
      ]);

      paintShading(canvas, size, ShadeType.governmentBurden, [
        Offset(0.25, 0.25),
        Offset(0.75, 0.25),
        Offset(0.65, 0.35),
        Offset(0.35, 0.35),
      ]);
    }
  }
}
