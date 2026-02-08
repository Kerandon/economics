import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment_MAKEREDUNDANT.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_description.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class ADASDiagram extends BaseDiagramPainter {
  ADASDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceLevel.label,
      xAxisLabel: DiagramLabel.realGDP.label,
    );
    switch (diagram) {
      case DiagramEnum.macroADASClassicalFullEmployment:
      case DiagramEnum.macroADASClassicalDeflationaryGap:
      case DiagramEnum.macroADASClassicalInflationaryGap:
      case DiagramEnum.macroADASClassicalInflationaryGapAdjustment:
      case DiagramEnum.macroADASClassicalDeflationaryGapAdjustment:
      case DiagramEnum.macroADASClassicalLongTermGrowth:
      case DiagramEnum.macroADASCostPushInflation:
        _paintClassicalADAS(c, canvas, diagram);
      case DiagramEnum.macroADASKeynesianFullEmployment:
      case DiagramEnum.macroADASKeynesianInflationaryGap:
      case DiagramEnum.macroADASKeynesianDeflationaryGap:
      case DiagramEnum.macroADASKeynesianExpansionaryPolicy:
      case DiagramEnum.macroADASKeynesianContractionaryPolicy:
      case DiagramEnum.macroADASKeynesianMultiplier:
        _paintKeynesianADAS(c, canvas, diagram);
      default:
    }
  }
}

void _paintClassicalADAS(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  paintMarketCurve(c, canvas, type: MarketCurveType.lras);
  if (diagram == DiagramEnum.macroADASClassicalFullEmployment) {
    paintMarketCurve(c, canvas, type: MarketCurveType.ad);
    paintMarketCurve(c, canvas, type: MarketCurveType.sras);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL.label,
      hideXLine: true,
    );
  }
  if (diagram == DiagramEnum.macroADASClassicalDeflationaryGap) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: -0.10,
      verticalShift: 0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras,
      horizontalShift: -0.10,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.55,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL.label,
      xLabel: DiagramLabel.pLe.label,
    );
    if (diagram == DiagramEnum.macroADASClassicalDeflationaryGapAdjustment) {}
  }
  if (diagram == DiagramEnum.macroADASClassicalInflationaryGap) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: 0.15,
      verticalShift: 0,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras,
      horizontalShift: 0.10,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.475,
      xAxisEndPos: 0.625,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL.label,
      xLabel: DiagramLabel.pLe.label,
    );
  }
}

void _paintKeynesianADAS(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  if (diagram == DiagramEnum.macroADASKeynesianFullEmployment) {
    paintMarketCurve(c, canvas, type: MarketCurveType.ad);
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.74,
      xAxisEndPos: 0.74,
      yLabel: DiagramLabel.pLf.label,
      xLabel: DiagramLabel.yF.label,
      showDotAtIntersection: true,
    );
  }
  if (diagram == DiagramEnum.macroADASKeynesianDeflationaryGap) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: -0.20,
      verticalShift: 0.10,

      lengthAdjustment: -0.15,
      angle: 0.15,
    );
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.pLe.label,
      xLabel: DiagramLabel.yE.label,
      showDotAtIntersection: true,
    );
  }
  if (diagram == DiagramEnum.macroADASKeynesianExpansionaryPolicy) {
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      label: DiagramLabel.aD1.label,
      horizontalShift: -0.20,
      lengthAdjustment: 0,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      label: DiagramLabel.aD2.label,
      horizontalShift: 0.12,

      lengthAdjustment: 0,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.795,
      xAxisEndPos: 0.44,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL1.label,
      xLabel: DiagramLabel.y1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.745,
      xAxisEndPos: 0.73,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL2.label,
      xLabel: DiagramLabel.y2.label,
    );
    paintLineSegment(c, canvas, origin: Offset(0.42, 0.50), length: 0.20);
  }
  if (diagram == DiagramEnum.macroADASKeynesianContractionaryPolicy) {
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      label: DiagramLabel.aD1.label,
      horizontalShift: 0.26,
      lengthAdjustment: 0,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      label: DiagramLabel.aD2.label,
      horizontalShift: 0.06,

      lengthAdjustment: 0,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.62,
      xAxisEndPos: 0.80,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL1.label,
      xLabel: DiagramLabel.y1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.77,
      xAxisEndPos: 0.69,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL2.label,
      xLabel: DiagramLabel.y2.label,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.64, 0.50),
      length: 0.12,
      angle: pi,
    );
  }
  if (diagram == DiagramEnum.macroADASKeynesianInflationaryGap) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: 0.20,
      verticalShift: -0.02,

      lengthAdjustment: -0.15,
      angle: 0.15,
    );
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.62,
      xAxisEndPos: 0.80,
      yLabel: DiagramLabel.plInF.label,
      xLabel: DiagramLabel.yInf.label,
      showDotAtIntersection: true,
    );
  }
  if (diagram == DiagramEnum.macroADASKeynesianMultiplier) {
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      label: DiagramLabel.aD1.label,
      horizontalShift: -0.25,
      lengthAdjustment: 0,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      label: DiagramLabel.aD2.label,
      horizontalShift: -0.10,

      lengthAdjustment: 0,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      label: DiagramLabel.aD3.label,
      horizontalShift: 0.08,

      lengthAdjustment: 0,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.795,
      xAxisEndPos: 0.39,
      showDotAtIntersection: true,
      hideYLine: true,
      xLabel: DiagramLabel.y1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.795,
      xAxisEndPos: 0.54,
      showDotAtIntersection: true,
      hideYLine: true,
      xLabel: DiagramLabel.y2.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.76,
      xAxisEndPos: 0.70,
      showDotAtIntersection: true,
      hideYLine: true,
      xLabel: DiagramLabel.y3.label,
    );
    paintLineSegment(c, canvas, origin: Offset(0.29, 0.50), length: 0.08);
    paintLineSegment(c, canvas, origin: Offset(0.46, 0.50), length: 0.12);
    paintText(c, canvas, '\$10m', Offset(0.27, 0.45));

    paintText(c, canvas, '\$15m', Offset(0.420, 0.45));
    paintDescription(c, canvas, '''
    Initial Government Spending \$10m. MPC = 0.60. 1/(1-MPC) = 2.5. 2.5 X \$10m = \$25m total spending (autonomous spending = \$10m, induced spending = \$15)
    ''');
  }
}
