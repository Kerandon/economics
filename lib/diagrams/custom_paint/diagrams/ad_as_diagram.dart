import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
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
      case DiagramEnum.macroClassicalFullEmployment:
      case DiagramEnum.macroClassicalDeflationaryGap:
      case DiagramEnum.macroClassicalInflationaryGap:
      case DiagramEnum.macroClassicalInflationaryGapAdjustment:
      case DiagramEnum.macroClassicalDeflationaryGapAdjustment:
      case DiagramEnum.macroClassicalLongTermGrowth:
      case DiagramEnum.macroClassicalDemandPullInflation:
      case DiagramEnum.macroCostPushInflation:
        _paintClassicalADAS(c, canvas, diagram);
      case DiagramEnum.macroADASKeynesianFullEmployment:
      case DiagramEnum.macroKeynesianInflationaryGap:
      case DiagramEnum.macroKeynesianDeflationaryGap:
      case DiagramEnum.macroKeynesianExpansionaryPolicy:
      case DiagramEnum.macroKeynesianContractionaryPolicy:
      case DiagramEnum.macroKeynesianMultiplier:
      case DiagramEnum.macroKeynesianLongTermGrowth:
        case DiagramEnum.macroKeynesianDemandPullInflation:
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
  if (diagram == DiagramEnum.macroClassicalFullEmployment) {
    _paintLRAS(c, canvas);
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
  if (diagram == DiagramEnum.macroClassicalDeflationaryGap) {
    _paintLRAS(c, canvas);

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: -0.10,
      lengthAdjustment: -0.10,
      verticalShift: 0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras,
      lengthAdjustment: -0.10,
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
    if (diagram == DiagramEnum.macroClassicalInflationaryGapAdjustment) {
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.ad,
        horizontalShift: 0,
        lengthAdjustment: 0,
        verticalShift: -0.10,
        label: DiagramLabel.aD1.label,
      );

      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.ad,
        horizontalShift: -0.15,
        lengthAdjustment: -0.10,
        verticalShift: 0.05,
        label: DiagramLabel.aD2.label,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.sras,
        lengthAdjustment: -0.00,
        horizontalShift: -0.10,
        label: DiagramLabel.sRAS1.label,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.sras,
        lengthAdjustment: 0.10,
        horizontalShift: 0.10,
        verticalShift: 0.10,
        label: DiagramLabel.sRAS2.label,
        color: Colors.red,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.50,
        showDotAtIntersection: true,
        yLabel: DiagramLabel.pL1.label,
        hideXLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.55,
        xAxisEndPos: 0.35,
        showDotAtIntersection: true,
        yLabel: DiagramLabel.pL2.label,
        xLabel: DiagramLabel.y2.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.70,
        xAxisEndPos: 0.50,
        showDotAtIntersection: true,
        yLabel: DiagramLabel.pL3.label,
        hideXLine: true,
      );
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.28, 0.32),
        length: 0.15,

        angle: pi,
        label: '1',
      );
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.25, 0.78),
        length: 0.15,
        label: '2',
      );
    }
  }
  if (diagram == DiagramEnum.macroClassicalInflationaryGap) {
    _paintLRAS(c, canvas);
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: 0.15,
      verticalShift: 0.0,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras,
      horizontalShift: 0.15,
      verticalShift: 0.05,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.525,
      xAxisEndPos: 0.675,
      yLabel: DiagramLabel.pL.label,
      xLabel: DiagramLabel.pLe.label,
      showDotAtIntersection: true,
    );
  }
  if (diagram == DiagramEnum.macroClassicalDeflationaryGapAdjustment) {
    _paintLRAS(c, canvas);
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: 0,
      lengthAdjustment: 0,
      verticalShift: -0.10,
      label: DiagramLabel.aD1.label,
    );

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: -0.15,
      lengthAdjustment: -0.10,
      verticalShift: 0.05,
      label: DiagramLabel.aD2.label,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras,
      lengthAdjustment: -0.00,
      horizontalShift: -0.10,
      label: DiagramLabel.sRAS1.label,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras,
      lengthAdjustment: 0.10,
      horizontalShift: 0.10,
      verticalShift: 0.10,
      label: DiagramLabel.sRAS2.label,
      color: Colors.red,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.50,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL1.label,
      hideXLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.55,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL2.label,
      xLabel: DiagramLabel.y2.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 0.50,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL3.label,
      hideXLine: true,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.28, 0.32),
      length: 0.15,

      angle: pi,
      label: '1',
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.25, 0.78),
      length: 0.15,
      label: '2',
    );
  }
  if (diagram == DiagramEnum.macroClassicalInflationaryGapAdjustment) {
    _paintLRAS(c, canvas);
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: -0.10,
      lengthAdjustment: 0,
      verticalShift: 0.10,
      label: DiagramLabel.aD1.label,
    );

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: 0.100,
      verticalShift: 0.00,
      label: DiagramLabel.aD2.label,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras,
      lengthAdjustment: -0.00,
      horizontalShift: -0.10,
      label: DiagramLabel.sRAS2.label,
      color: Colors.red,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras,
      lengthAdjustment: 0.10,
      horizontalShift: 0.10,
      verticalShift: 0.10,
      label: DiagramLabel.sRAS1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 0.50,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL1.label,
      hideXLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.55,
      xAxisEndPos: 0.65,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL2.label,
      xLabel: DiagramLabel.y2.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.50,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.pL3.label,
      hideXLine: true,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.74, 0.32),
      length: 0.15,

      angle: pi,
      label: '2',
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.26, 0.78),
      length: 0.15,
      label: '1',
    );
    paintDescription(
      c,
      canvas,
      '1. AD increases causes real GDP > potential GDP. 2. Rising resource prices and inflation expectations cause SRAS to decrease, until real GDP = potential GDP in the long-run at a higher price level.',
    );
  }
  if (diagram == DiagramEnum.macroClassicalLongTermGrowth) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.lras,
      horizontalShift: -0.15,
      label: DiagramLabel.lRAS1.label,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.lras,
      horizontalShift: 0.15,
      label: DiagramLabel.lRAS2.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 1,
      xAxisEndPos: 0.65,
      additionalXPositions: [0.35],
      additionalXLabels: [DiagramLabel.y1.label],
      xLabel: DiagramLabel.y2.label,
      hideYLine: true,
      hideXLine: true,
    );
    paintLineSegment(c, canvas, origin: Offset(0.49, 0.50), length: 0.15);
  }
  if (diagram == DiagramEnum.macroCostPushInflation) {
 paintDiagramDashedLines(c,
     canvas,
     yAxisStartPos: 0.60, xAxisEndPos: 0.60,
   yLabel: DiagramLabel.pL1.label,
   xLabel: DiagramLabel.y1.label,
 );
 paintDiagramDashedLines(c,
   canvas,
   yAxisStartPos: 0.425, xAxisEndPos: 0.425,
   yLabel: DiagramLabel.pL2.label,
   xLabel: DiagramLabel.y2.label,
 );

 paintMarketCurve(c, canvas, type: MarketCurveType.ad,lengthAdjustment: 0.10);
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sras1,
      horizontalShift: 0.15,
      verticalShift: 0.05
    );
 paintMarketCurve(
   c,
   canvas,
   type: MarketCurveType.sras2,
   horizontalShift: -0.10,
   verticalShift: -0.05
 );
 paintLineSegment(c, canvas, origin: Offset(0.70,0.32),angle: pi,
 length: 0.15,
 );
 paintDescription(c, canvas, 'Higher resource prices such as wages, higher business tax rates, weaker exchange rates (imported inflation) and negative supply-shocks cause SRAS to decrease, resulting in a higher PL and lower real GDP. Serious/prolonged falls is Stagflation.');
  }
  if (diagram == DiagramEnum.macroClassicalDemandPullInflation) {
    paintDiagramDashedLines(c,
        canvas,
  xAxisEndPos: 0.425,
      yAxisStartPos: 0.66,
        yLabel: DiagramLabel.pL1.label,
      xLabel: DiagramLabel.y1.label,

    );
    paintDiagramDashedLines(c,
      canvas,
      xAxisEndPos: 0.545,
      yAxisStartPos: 0.55,
      yLabel: DiagramLabel.pL2.label,
      xLabel: DiagramLabel.y2.label,

    );
    paintDiagramDashedLines(c,
      canvas,
      xAxisEndPos: 0.675,
      yAxisStartPos: 0.425,
      yLabel: DiagramLabel.pL3.label,
      xLabel: DiagramLabel.y3.label,

    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad1,
      horizontalShift: -0.15,
      verticalShift: 0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad2,
      verticalShift: 0,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad3,
      horizontalShift: 0.15,
      verticalShift: -0.10,
    );
    paintMarketCurve(c, canvas, type: MarketCurveType.sras,
    horizontalShift: 0.05,
    verticalShift: 0.05,lengthAdjustment: 0.10,
    );
    paintDescription(c, canvas, 'In the classical/new-monetarist model, real GDP and the price level is determined when AD=SRAS. As SRAS is upward sloping any increases in AD result in a higher PL (and thus inflation).');
  }
}

_paintLRAS(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintMarketCurve(c, canvas, type: MarketCurveType.lras);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    hideXLine: true,
    hideYLine: true,
    xLabel: DiagramLabel.yF.label,
  );
}

void _paintKeynesianADAS(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  if (diagram == DiagramEnum.macroADASKeynesianFullEmployment) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      lengthAdjustment: 0.15,
    );
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.735,
      xAxisEndPos: 0.74,
      yLabel: DiagramLabel.pf.label,
      xLabel: DiagramLabel.yF.label,
      showDotAtIntersection: true,
    );
  }
  if (diagram == DiagramEnum.macroKeynesianDeflationaryGap) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.pLDef.label,
      xLabel: DiagramLabel.yDef.label,
      showDotAtIntersection: true,
    );
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
  }
  if (diagram == DiagramEnum.macroKeynesianExpansionaryPolicy) {
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
  if (diagram == DiagramEnum.macroKeynesianContractionaryPolicy) {
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
  if (diagram == DiagramEnum.macroKeynesianInflationaryGap) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.46,
      xAxisEndPos: 0.80,
      yLabel: DiagramLabel.plInF.label,
      xLabel: DiagramLabel.yInf.label,
      showDotAtIntersection: true,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad,
      horizontalShift: 0.25,
      verticalShift: -0.10,

      lengthAdjustment: 0.10,
      angle: 0.15,
    );
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
  }
  if (diagram == DiagramEnum.macroKeynesianMultiplier) {
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
  if (diagram == DiagramEnum.macroKeynesianLongTermGrowth) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.65,
      xAxisEndPos: 0.55,
      xLabel: DiagramLabel.y1.label,
      additionalXPositions: [0.85],
      additionalXLabels: [DiagramLabel.y2.label],
      hideYLine: true,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.keynesianAS,
      label: DiagramLabel.aS.label,
      horizontalShift: -0.25,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.keynesianAS,
      label: DiagramLabel.aS.label,
      horizontalShift: 0.05,
    );
    paintLineSegment(c, canvas, origin: Offset(0.69, 0.50), length: 0.15);
  }
  if (diagram == DiagramEnum.macroKeynesianLongTermGrowth) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.65,
      xAxisEndPos: 0.55,
      xLabel: DiagramLabel.y1.label,
      additionalXPositions: [0.85],
      additionalXLabels: [DiagramLabel.y2.label],
      hideYLine: true,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.keynesianAS,
      label: DiagramLabel.aS.label,
      horizontalShift: -0.25,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.keynesianAS,
      label: DiagramLabel.aS.label,
      horizontalShift: 0.05,
    );
    paintLineSegment(c, canvas, origin: Offset(0.69, 0.50), length: 0.15);
  }
  if (diagram == DiagramEnum.macroKeynesianDemandPullInflation) {
    final angle = 0.30;
    final length = -0.10;
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.80,
      yLabel: DiagramLabel.pL3.label,
      xLabel: DiagramLabel.y3.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.80,
      xAxisEndPos: 0.60,
      yLabel: 'PL1,2',
      xLabel: DiagramLabel.y2.label,
      additionalXLabels: [DiagramLabel.y1.label],
        additionalXPositions: [0.35]
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad1,
      horizontalShift: -0.25,
      verticalShift: 0.10,

      lengthAdjustment: length,
      angle: angle,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad2,
      horizontalShift: 0.00,
      verticalShift: 0.10,

      lengthAdjustment: length,
      angle: angle,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.ad3,
      horizontalShift: 0.25,
      verticalShift: -0.10,

      lengthAdjustment: length,
      angle: angle,
    );
    paintMarketCurve(c, canvas, type: MarketCurveType.keynesianAS);
    paintDescription(c, canvas, 'In the Keynesian model, during a recessionary gap increases in AD do not lead to a higher PL. Demand-pull inflation occurs when AD increases once the economy has reached its potential output and LRAS is vertical.');
  }
}
