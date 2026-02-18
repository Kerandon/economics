import 'dart:math';
import 'dart:ui';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_description.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';

import '../../enums/diagram_enum.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class PhillipsCurveDiagram extends BaseDiagramPainter {
  PhillipsCurveDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(c, canvas, axisType: AxisType.phillipsCurve);
    switch (diagram) {
      case DiagramEnum.macroSRPCAndLRPC:
        _paintSRPC(c, canvas);
      case DiagramEnum.macroPhillipsCurveStagflation:
        _paintStagflation(c, canvas);
      case DiagramEnum.macroSRPCInflationaryGapAdjustment:
        _paintSRPCInflationaryGapAdjustment(c, canvas);
      case DiagramEnum.macroSRPCDeflationaryGapAdjustment:
        _paintSRPCDeflationaryGapAdjustment(c, canvas);
      case DiagramEnum.macroLRPCFallInNRU:
        _paintLRPCFallInNRU(c, canvas);
      default:
    }
  }
}

void _paintSRPC(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.60,
    xAxisEndPos: 0.29,
    yLabel: DiagramLabel.pi1.label,
    xLabel: DiagramLabel.u1.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.77,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.pi2.label,
    xLabel: 'U2=NRU',
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.90,
    xAxisEndPos: 0.78,
    yLabel: DiagramLabel.pi3.label,
    xLabel: DiagramLabel.u3.label,
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.srpc);
  paintMarketCurve(c, canvas, type: MarketCurveType.lrpc);
  paintDescription(
    c,
    canvas,
    'SRPC shows the trade-off between the inflation rate and unemployment rate in the short-run: π1/U1 Inflationary gap; π3/U3 deflationary gap. In the long-run: LRPC=LRAS=NRU - unemployment rate / real GDP is independent of inflation rate.',
  );
}

void _paintStagflation(DiagramPainterConfig c, IDiagramCanvas canvas) {
  final length = -0.25;
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.80,
    xAxisEndPos: 0.51,
    yLabel: DiagramLabel.pi1.label,
    xLabel: DiagramLabel.u1.label,
    rightYLabel: 'A',
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.61,
    xAxisEndPos: 0.60,
    yLabel: DiagramLabel.pi2.label,
    xLabel: DiagramLabel.u2.label,
    rightYLabel: 'B',
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.srpc1,
    horizontalShift: -0.05,
    verticalShift: 0.05,
    lengthAdjustment: length,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.srpc2,
    horizontalShift: 0.10,
    verticalShift: -0.10,
    lengthAdjustment: length,
  );
  paintLineSegment(c, canvas, origin: Offset(0.28, 0.45), angle: pi * -0.22);
  paintDescription(
    c,
    canvas,
    'Negative supply shocks (e.g., political instability causing global oil supply-chain disruptions) shifts SRPC outwards (higher inflation + higher unemployment)',
  );
}

void _paintSRPCInflationaryGapAdjustment(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  final length = -0.15;
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.83,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.pi1.label,
    additionalYLabels: [DiagramLabel.pi3.label],
    additionalYPositions: [0.525],
    xLabel: DiagramLabel.nRU.label,
    rightYLabel: 'A',
    additionalRightYLabels: ['C'],
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.645,
    xAxisEndPos: 0.25,
    yLabel: DiagramLabel.pi1.label,
    xLabel: DiagramLabel.uInf.label,
    rightYLabel: 'B',
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.lrpc);
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.srpc2,
    horizontalShift: 0.10,
    verticalShift: -0.14,
    lengthAdjustment: length,
    color: Colors.red,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.srpc1,
    horizontalShift: -0.05,
    verticalShift: 0.08,
    lengthAdjustment: length,
  );
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.68, 0.78),

    angle: pi * -0.22,
    length: 0.15,
  );
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.22, 0.38),

    angle: pi * -0.22,
    length: 0.15,
  );
  paintDescription(
    c,
    canvas,
    'A: Actual unemployment = NRU. B: Increase in AD - higher inflation; unemployment < NRU. C: Real wages fall workers demand higher nominal wages / resource prices bid up due to competition (SRPC1 ->  SRPC2). C: Actual Employment again = NRU but at higher inflation rate.',
  );
}

void _paintSRPCDeflationaryGapAdjustment(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  final length = -0.15;
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.83,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.pi1.label,
    additionalYLabels: [DiagramLabel.pi3.label],
    additionalYPositions: [0.525],
    xLabel: DiagramLabel.nRU.label,
    rightYLabel: 'A',
    additionalRightYLabels: ['C'],
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.645,
    xAxisEndPos: 0.25,
    yLabel: DiagramLabel.pi1.label,
    xLabel: DiagramLabel.uInf.label,
    rightYLabel: 'B',
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.lrpc);
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.srpc2,
    horizontalShift: 0.10,
    verticalShift: -0.14,
    lengthAdjustment: length,
    color: Colors.red,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.srpc1,
    horizontalShift: -0.05,
    verticalShift: 0.08,
    lengthAdjustment: length,
  );
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.68, 0.78),

    angle: pi * -0.22,
    length: 0.15,
  );
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.22, 0.38),

    angle: pi * -0.22,
    length: 0.15,
  );
  paintDescription(
    c,
    canvas,
    'A: Actual unemployment = NRU. B: Increase in AD - higher inflation; unemployment < NRU. C: Real wages fall workers demand higher nominal wages / resource prices bid up due to competition (SRPC1 ->  SRPC2). C: Actual Employment again = NRU but at higher inflation rate.',
  );
}

void _paintLRPCFallInNRU(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 1,
    xAxisEndPos: 0.35,
    xLabel: DiagramLabel.nRU2.label,
    additionalXLabels: [DiagramLabel.nRU1.label],
    additionalXPositions: [0.65],
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.lrpc2,
    horizontalShift: 0.15,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.lrpc1,
    horizontalShift: -0.15,
  );
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.50, 0.50),
    angle: pi,
    length: 0.15,
  );
  paintDescription(
    c,
    canvas,
    'A leftward shift of the LRPC reflects a fall in the natural rate of unemployment (NRU) due to structural labour market improvements such as greater labour market flexibility, improved job matching, and higher human capital through education and skills training.',
  );
}
