import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
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
import '../painter_methods/shortcut_methods/paint_market_curve.dart';

class Demand extends BaseDiagramPainter2 {
  Demand(super.config, super.bundle);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.price.label,
      xAxisLabel: DiagramLabel.quantity.label,
    );
    if (bundle == DiagramBundleEnum.microDemandExtension ||
        bundle == DiagramBundleEnum.microDemandContraction) {
      paintMarketCurve(c, canvas, type: MarketCurveType.demand);

      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.40,
        yLabel: DiagramLabel.p1.label,
        xLabel: DiagramLabel.q1.label,
        addDotAtIntersection: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.60,
        yLabel: DiagramLabel.p2.label,
        xLabel: DiagramLabel.q2.label,
        addDotAtIntersection: true,
      );
      if (bundle == DiagramBundleEnum.microDemandExtension) {
        paintLineSegment(
          c,
          canvas,
          origin: Offset(0.52, 0.46),
          angle: pi / 4,
          length: 0.20,
        );
      }
      if (bundle == DiagramBundleEnum.microDemandContraction) {
        paintLineSegment(
          c,
          canvas,
          origin: Offset(0.53, 0.47),
          angle: pi * 3.25,
          length: 0.20,
        );
      }
    }
    if (bundle == DiagramBundleEnum.microDemandIncrease) {
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.demand,
        label: DiagramLabel.d1.label,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.demand,
        label: DiagramLabel.d2.label,
        horizontalShift: 0.10,
        verticalShift: -0.10,
        lengthAdjustment: -0.05,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q1.label,
        hideYLine: true,
        addDotAtIntersection: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.70,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q2.label,
        addDotAtIntersection: true,
      );

      paintLineSegment(c, canvas, origin: Offset(0.49, 0.40), angle: pi * 2);
    }

    if (bundle == DiagramBundleEnum.microDemandDecrease) {
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
        horizontalShift: 0.10,
        lengthAdjustment: -0.10,
        verticalShift: -0.10,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q2.label,
        hideYLine: true,
        addDotAtIntersection: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.70,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.q1.label,
        addDotAtIntersection: true,
      );

      paintLineSegment(c, canvas, origin: Offset(0.51, 0.40), angle: pi / 1);
    }
  }
}
