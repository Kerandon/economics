import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
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
      case DiagramEnum.macroADASCostPushInflation:
        _paintClassicalADAS(c, canvas, diagram);
        break;
      case DiagramEnum.macroADASKeynesianFullEmployment:
      case DiagramEnum.macroKeynesianInflationaryGap:
      case DiagramEnum.macroKeynesianDeflationaryGap:
      case DiagramEnum.macroKeynesianExpansionaryPolicy:
      case DiagramEnum.macroKeynesianContractionaryPolicy:
      case DiagramEnum.macroKeynesianMultiplier:
      case DiagramEnum.macroKeynesianLongTermGrowth:
      case DiagramEnum.macroKeynesianDemandPullInflation:
        _paintKeynesianADAS(c, canvas, diagram);
        break;
      default:
        break;
    }
  }
}

void _paintClassicalADAS(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  switch (diagram) {
    case DiagramEnum.macroClassicalFullEmployment:
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
      break;

    case DiagramEnum.macroClassicalDeflationaryGap:
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
      break;

    case DiagramEnum.macroClassicalInflationaryGap:
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
      break;

    case DiagramEnum.macroClassicalDeflationaryGapAdjustment:
      _paintLRAS(c, canvas);
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.ad1,
        horizontalShift: 0,
        lengthAdjustment: 0,
        verticalShift: -0.10,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.ad2,
        horizontalShift: -0.15,
        lengthAdjustment: -0.10,
        verticalShift: 0.05,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.sras1,
        lengthAdjustment: -0.00,
        horizontalShift: -0.10,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.sras2,
        lengthAdjustment: 0.10,
        horizontalShift: 0.10,
        verticalShift: 0.10,
        color: Colors.red,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.40,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.pL1.label,
        hideXLine: true,
        rightYLabel: 'A',
        additionalYLabels: [DiagramLabel.pL3.label],
        additionalYPositions: [0.70],
        additionalRightYLabels: ['C'],
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.55,
        xAxisEndPos: 0.35,
        yLabel: DiagramLabel.pL2.label,
        xLabel: DiagramLabel.yDef.label,
        rightYLabel: 'B',
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
      paintDescription(c, canvas, kDescClassicalDeflationaryAdj);
      break;

    case DiagramEnum.macroClassicalInflationaryGapAdjustment:
      _paintLRAS(c, canvas);
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.ad1,
        horizontalShift: -0.10,
        lengthAdjustment: 0,
        verticalShift: 0.10,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.ad2,
        horizontalShift: 0.100,
        verticalShift: 0.00,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.sras2,
        lengthAdjustment: -0.00,
        horizontalShift: -0.10,
        color: Colors.red,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.sras1,
        lengthAdjustment: 0.10,
        horizontalShift: 0.10,
        verticalShift: 0.10,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.70,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.pL1.label,
        rightYLabel: 'A',
        hideXLine: true,
        additionalYPositions: [0.40],
        additionalYLabels: [DiagramLabel.pL3.label],
        additionalRightYLabels: ['C'],
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.55,
        xAxisEndPos: 0.65,
        yLabel: DiagramLabel.pL2.label,
        xLabel: DiagramLabel.yInf.label,
        rightYLabel: 'B',
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
      paintDescription(c, canvas, kDescClassicalInflationaryAdj);
      break;

    case DiagramEnum.macroClassicalLongTermGrowth:
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.lras1,
        horizontalShift: -0.15,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.lras2,
        horizontalShift: 0.15,
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
      break;

    case DiagramEnum.macroADASCostPushInflation:
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.60,
        xAxisEndPos: 0.60,
        yLabel: DiagramLabel.pL1.label,
        xLabel: DiagramLabel.y1.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.425,
        xAxisEndPos: 0.425,
        yLabel: DiagramLabel.pL2.label,
        xLabel: DiagramLabel.y2.label,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.ad,
        lengthAdjustment: 0.10,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.sras1,
        horizontalShift: 0.15,
        verticalShift: 0.05,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.sras2,
        horizontalShift: -0.10,
        verticalShift: -0.05,
      );
      paintLineSegment(
        c,
        canvas,
        origin: Offset(0.70, 0.32),
        angle: pi,
        length: 0.15,
      );
      paintDescription(c, canvas, kDescCostPushInflation);
      break;

    case DiagramEnum.macroClassicalDemandPullInflation:
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.425,
        yAxisStartPos: 0.66,
        yLabel: DiagramLabel.pL1.label,
        xLabel: DiagramLabel.y1.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        xAxisEndPos: 0.545,
        yAxisStartPos: 0.55,
        yLabel: DiagramLabel.pL2.label,
        xLabel: DiagramLabel.y2.label,
      );
      paintDiagramDashedLines(
        c,
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
      paintMarketCurve(c, canvas, type: MarketCurveType.ad2, verticalShift: 0);
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.ad3,
        horizontalShift: 0.15,
        verticalShift: -0.10,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.sras,
        horizontalShift: 0.05,
        verticalShift: 0.05,
        lengthAdjustment: 0.10,
      );
      paintDescription(c, canvas, kDescClassicalDemandPull);
      break;

    default:
      break;
  }
}

void _paintLRAS(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintMarketCurve(c, canvas, type: MarketCurveType.lras);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    hideXLine: true,
    hideYLine: true,
    xLabel: DiagramLabel.yP.label,
  );
}

void _paintKeynesianADAS(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  switch (diagram) {
    case DiagramEnum.macroADASKeynesianFullEmployment:
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
        yLabel: DiagramLabel.pP.label,
        xLabel: DiagramLabel.yP.label,
        showDotAtIntersection: true,
      );
      break;

    case DiagramEnum.macroKeynesianDeflationaryGap:
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
      break;

    case DiagramEnum.macroKeynesianExpansionaryPolicy:
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
      break;

    case DiagramEnum.macroKeynesianContractionaryPolicy:
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
      break;

    case DiagramEnum.macroKeynesianInflationaryGap:
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
      break;

    case DiagramEnum.macroKeynesianMultiplier:
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
      paintDescription(c, canvas, kDescKeynesianMultiplier);
      break;

    case DiagramEnum.macroKeynesianLongTermGrowth:
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
      break;

    case DiagramEnum.macroKeynesianDemandPullInflation:
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
        additionalXPositions: [0.35],
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
      paintDescription(c, canvas, kDescKeynesianDemandPull);
      break;

    default:
      break;
  }
}

// --- Description Constants ---

const kDescCostPushInflation =
    'Higher wages and business tax rates, weaker exchange rates (imported inflation) and negative supply-shocks cause SRAS to decrease, resulting in a higher PL and lower real GDP. Serious/prolonged falls is Stagflation.';

const kDescClassicalDeflationaryAdj =
    'A: real GDP = potential GDP. B: AD falls, real GDP < potential GDP, unemployment rises and price level falls. C: Idle resources & low inflationary expectations, wages / resource prices fall (SRAS1 to SRAS2), real GDP returns to potential GDP at lower PL.';

const kDescClassicalInflationaryAdj =
    'A: real GDP = potential GDP (full employment). B: AD increases, real GDP > potential GDP, higher price level and low unemployment. C: Fall in real wages / rising competition for scarce resources, SRAS1 -> SRAS2, actual real GDP = potential GDP in the long-run at a higher price level.';

const kDescClassicalDemandPull =
    'In the classical/new-monetarist model, real GDP and the price level is determined when AD=SRAS. As SRAS is upward sloping any increases in AD result in a higher PL (and thus inflation).';

const kDescKeynesianMultiplier =
    'Initial Government Spending \$10m. MPC = 0.60. 1/(1-MPC) = 2.5. 2.5 X \$10m = \$25m total spending (autonomous spending = \$10m, induced spending = \$15)';

const kDescKeynesianDemandPull =
    'In the Keynesian model, during a recessionary gap increases in AD do not lead to a higher PL. Demand-pull inflation occurs when AD increases once the economy has reached its potential output and LRAS is vertical.';
