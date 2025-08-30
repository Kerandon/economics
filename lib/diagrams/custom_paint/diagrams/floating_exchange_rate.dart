import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../enums/diagram_subtype.dart';
import '../painter_methods/axis/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_model.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_diagram_lines.dart';

class FloatingExchangeRate extends BaseDiagramPainter {
  FloatingExchangeRate({
    required DiagramPainterConfig config,
    required DiagramModel model,
  }) : super(config, model);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    String yAxisLabel = DiagramLabel.euroPerDollar.label;
    String xAxisLabel = DiagramLabel.quantityOfUSD.label;
    String equilibriumLabel = DiagramLabel.eR.label;
    String demandCurveLabel = DiagramLabel.demandForUSD.label;
    String supplyCurveLabel = DiagramLabel.supplyOfUSD.label;

    if (model.subtype != DiagramSubtype.equilibrium) {
      yAxisLabel = DiagramLabel.euroUSD.label;
      xAxisLabel = DiagramLabel.qUSD.label;
      equilibriumLabel = DiagramLabel.eR1.label;
      demandCurveLabel = DiagramLabel.d1.label;
      supplyCurveLabel = DiagramLabel.s1.label;
    }

    paintAxis(
      c,
      canvas,
      yAxisLabel: yAxisLabel,
      // yLabelIsVertical: false,
      xAxisLabel: xAxisLabel,
    );

    /// Appreciation - Demand Increase
    if (model.subtype == DiagramSubtype.appreciationIncreaseInDemand) {
      supplyCurveLabel = DiagramLabel.s.label;
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.60,
        yLabel: DiagramLabel.eR2.label,
        hideXLine: true,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.25, 0.05),
        polylineOffsets: [Offset(0.85, 0.65)],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );
    }

    /// Appreciation - Supply Decrease
    if (model.subtype == DiagramSubtype.appreciationDecreaseInSupply) {
      demandCurveLabel = DiagramLabel.d.label;
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.eR2.label,
        hideXLine: true,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.15, 0.65),
        polylineOffsets: [Offset(0.75, 0.05)],
        label2: DiagramLabel.s2.label,
        label2Align: LabelAlign.centerRight,
      );
    }

    /// Depreciation - Demand Decrease
    if (model.subtype == DiagramSubtype.depreciationDecreaseInDemand) {
      supplyCurveLabel = DiagramLabel.s.label;
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.eR2.label,
        hideXLine: true,
      );
      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.30),
        polylineOffsets: [Offset(0.70, 0.90)],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );
    }

    /// Depreciation - Supply increase
    if (model.subtype == DiagramSubtype.depreciationIncreaseInSupply) {
      demandCurveLabel = DiagramLabel.d.label;
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.60,
        yLabel: DiagramLabel.eR2.label,
        hideXLine: true,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.35, 0.85),
        polylineOffsets: [Offset(0.85, 0.35)],
        label2: DiagramLabel.s2.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: equilibriumLabel,
        hideXLine: true,
      );
    }
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      yLabel: equilibriumLabel,
      hideXLine: true,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.85, 0.15),
      polylineOffsets: [Offset(0.15, 0.85)],
      label1: supplyCurveLabel,
      label1Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.15, 0.15),
      polylineOffsets: [Offset(0.85, 0.85)],
      label2: demandCurveLabel,
      label2Align: LabelAlign.centerRight,
    );
  }
}
