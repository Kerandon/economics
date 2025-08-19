import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:flutter/material.dart';

import '../../enums/diagram_labels.dart';
import '../../enums/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/paint_axis.dart';
import '../painter_methods/paint_demand.dart';
import '../painter_methods/paint_diagram_custom_lines.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';

class Demand extends BaseDiagramPainter2 {
  Demand(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    if (diagramBundleEnum == DiagramBundleEnum.microDemandPriceChange) {
      paintDemand(c, canvas);
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.price$.label,
        xAxisLabel: DiagramLabel.quantityOfChocolateBars.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: '\$9',
        xLabel: '8',
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.60,
        yLabel: '\$7',
        xLabel: '10',
      );
    }
    if (diagramBundleEnum == DiagramBundleEnum.microDemandIndividual1) {
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.12, 0.20),
        polylineOffsets: [Offset(0.95, 0.85)],
        label2: DiagramLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 1.3,
        yLabel: '\$9',
        hideXLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        hideYLine: true,
        xLabel: '8',
      );
      paintTitle(c, canvas, 'Bobby');
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.price$.label,
        xAxisLabel: DiagramLabel.quantityOfChocolateBars.label,
      );
    }
    if (diagramBundleEnum == DiagramBundleEnum.microDemandIndividual2) {
      paintTitle(c, canvas, 'Sarah');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 1.3,
        yLabel: '\$9',
        hideXLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.36,
        hideYLine: true,
        xLabel: '5',
      );
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.price$.label,
        xAxisLabel: DiagramLabel.quantityOfChocolateBars.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.20, 0.20),
        polylineOffsets: [Offset(0.55, 0.85)],
        label2: DiagramLabel.d.label,
        label2Align: LabelAlign.centerRight,
      );
    }
    if (diagramBundleEnum == DiagramBundleEnum.microDemandIndividualVsMarket) {
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.20, 0.20),
        polylineOffsets: [Offset(0.85, 0.85)],
        label2: DiagramLabel.dMarket.label,
        label2Align: LabelAlign.centerRight,
      );
      paintTitle(c, canvas, 'Market (Bobby + Sarah)');
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 1.0,
        yLabel: '\$9',
        hideXLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        xLabel: '13',
        hideYLine: true,
      );
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.price$.label,
        xAxisLabel: DiagramLabel.quantityOfChocolateBars.label,
      );
    }
    if (diagramBundleEnum == DiagramBundleEnum.microDemandDeterminants) {
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.p.label,
        xAxisLabel: DiagramLabel.q.label,
      );
      paintDemand(c, canvas);

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.30,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q1.label,
        hideYLine: true,
      );

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q2.label,
        hideYLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.70,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q3.label,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.10, 0.30),
        polylineOffsets: [Offset(0.70, 0.90)],
        label2: DiagramLabel.d3.label,
        label2Align: LabelAlign.centerRight,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.30, 0.10),
        polylineOffsets: [Offset(0.90, 0.70)],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );

      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.36, 0.40),
        polylineOffsets: [Offset(0.28, 0.40)],
        arrowOnEnd: true,
        arrowOnEndAngle: pi * 1.5,
      );
      paintCustomDiagramLines(
        c,
        canvas,
        startPos: Offset(0.46, 0.40),
        polylineOffsets: [Offset(0.54, 0.40)],
        arrowOnEnd: true,
        arrowOnEndAngle: pi * 0.5,
      );
    }
  }
}

