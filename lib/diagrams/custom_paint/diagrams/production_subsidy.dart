import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../../enums/label_align.dart';
import '../../enums/shade_type.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_diagram_lines.dart';
import '../painter_methods/paint_shading.dart';

class ProductionSubsidy extends BaseDiagramPainter2 {
  ProductionSubsidy(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.price.label,
      xAxisLabel: DiagramLabel.quantity.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.20,
      xLabel: DiagramLabel.q1.label,
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      yLabel: DiagramLabel.pSub.label,
      xAxisEndPos: 0.40,
      xLabel: DiagramLabel.q2.label,
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.10, 0.10),
      polylineOffsets: [Offset(0.90, 0.90)],
      label2: DiagramLabel.dD.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.10, 0.90),
      polylineOffsets: [Offset(0.90, 0.10)],
      label2: DiagramLabel.sD.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.30, 0.90),
      polylineOffsets: [Offset(0.90, 0.30)],
      label2: DiagramLabel.sDSub.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.80),
      polylineOffsets: [Offset(0.90, 0.80)],
      label1: DiagramLabel.pW.label,
      label1Align: LabelAlign.centerLeft,
      label2: DiagramLabel.sW.label,
      label2Align: LabelAlign.centerRight,
    );
    if (diagramBundleEnum == DiagramBundleEnum.globalTariffProducerSurplus) {
      paintShading(canvas, size, ShadeType.welfareLoss, [
        Offset(0.20, 0.80),
        Offset(0.40, 0.80),
        Offset(0.40, 0.60),
      ]);
    }
  }
}
