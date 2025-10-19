import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../painter_methods/axis/label_align.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_arrow_helper.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../painter_methods/shortcut_methods/paint_demand.dart';

class Demand extends BaseDiagramPainter2 {
  Demand(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    if (diagramBundleEnum == DiagramBundleEnum.microDemandExtension ||
        diagramBundleEnum == DiagramBundleEnum.microDemandContraction) {
      paintMarketCurve(c, canvas, type: MarketCurveType.demand);
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
      if (diagramBundleEnum == DiagramBundleEnum.microDemandExtension) {
        paintArrowHelper(c, canvas, origin: Offset(0.55, 0.45), angle: pi / 4);
      }
      if (diagramBundleEnum == DiagramBundleEnum.microDemandContraction) {
        paintArrowHelper(
          c,
          canvas,
          origin: Offset(0.55, 0.45),
          angle: pi * 3.25,
        );
      }
    }
    if (diagramBundleEnum == DiagramBundleEnum.microDemandIncrease) {
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.p.label,
        xAxisLabel: DiagramLabel.q.label,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.demand,
        label: DiagramLabel.d1.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q1.label,
        hideYLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.70,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q2.label,
      );

      paintDiagramLines(
        c,
        canvas,
        startPos: Offset(0.30, 0.10),
        polylineOffsets: [Offset(0.90, 0.70)],
        label2: DiagramLabel.d2.label,
        label2Align: LabelAlign.centerRight,
      );

      paintArrowHelper(c, canvas, origin: Offset(0.48, 0.40), angle: pi * 2);
    }

    if (diagramBundleEnum == DiagramBundleEnum.microDemandDecrease) {
      paintAxis(
        c,
        canvas,
        yAxisLabel: DiagramLabel.p.label,
        xAxisLabel: DiagramLabel.q.label,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.demand,
        label: DiagramLabel.d2.label,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.demand,
        label: DiagramLabel.d1.label,
        horizontalShift: 0.20,
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
        xLabel: DiagramLabel.q1.label,
      );

      paintArrowHelper(c, canvas, origin: Offset(0.51, 0.40), angle: pi / 1);
    }
  }
}
