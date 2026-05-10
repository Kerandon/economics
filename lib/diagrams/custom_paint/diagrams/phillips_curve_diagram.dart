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
      case DiagramEnum.macroSRPC:
        _paintSRPC(c, canvas);
      case DiagramEnum.macroSRPCLRPC:
        _paintSRPCLRPC(c, canvas);
      case DiagramEnum.macroSRPCCostPushInflation:
        _paintStagflation(c, canvas);
      case DiagramEnum.macroExpectationsAugmentedPhillipsCurveInflationaryGap:
        _paintExpectationsAugmentedPCInflationGap(c, canvas);
      case DiagramEnum.macroExpectationsAugmentedPhillipsCurveDeflationaryGap:
        _paintExpectationsAugmentedPhillipsCurveDeflationaryGap(c, canvas);
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
    xAxisEndPos: 0.24,
    yLabel: '5%',
    xLabel: '4%',
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.75,
    xAxisEndPos: 0.40,
    yLabel: '3%',
    xLabel: '5%',
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.85,
    xAxisEndPos: 0.62,
    yLabel: '1.5%',
    xLabel: '7%',
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.srpc);
}

void _paintSRPCLRPC(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.54,
    xAxisEndPos: 0.24,
    yLabel: '4%',
    xLabel: 'U<NRU',
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.77,
    xAxisEndPos: 0.50,
    yLabel: '2%',
    xLabel: 'U=NRU',
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.90,
    xAxisEndPos: 0.77,
    yLabel: '1%',
    xLabel: 'U>NRU',
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.srpc);
  paintMarketCurve(c, canvas, type: MarketCurveType.lrpc);
}

void _paintStagflation(DiagramPainterConfig c, IDiagramCanvas canvas) {
  final length = -0.25;
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.75,
    xAxisEndPos: 0.38,
    yLabel: '4%',
    xLabel: '5%',
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.60,
    xAxisEndPos: 0.54,
    yLabel: '5%',
    xLabel: '7%',
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
}

void _paintExpectationsAugmentedPCInflationGap(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  final length = -0.15;
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.88,
    xAxisEndPos: 0.50,
    yLabel: '1%',
    additionalYLabels: ['3%'],
    additionalYPositions: [0.57],
    xLabel: DiagramLabel.nRU.label,
    rightYLabel: DiagramLabel.a.label,
    rightYVerticalPivot: LabelPivot.bottom,
    additionalRightYLabels: [DiagramLabel.c.label],
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.73,
    xAxisEndPos: 0.28,
    yLabel: '2%',
    xLabel: 'U<NRU',
    rightYLabel: DiagramLabel.b.label,
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.lrpc);
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.srpc2,
    horizontalShift: 0.10,
    verticalShift: -0.135,
    lengthAdjustment: length,
    color: Colors.red,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.srpc1,
    horizontalShift: -0.05,
    verticalShift: 0.09,
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
}

void _paintExpectationsAugmentedPhillipsCurveDeflationaryGap(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  // final length = -0.15;
  // paintDiagramDashedLines(
  //   c,
  //   canvas,
  //   yAxisStartPos: 0.85,
  //   xAxisEndPos: 0.50,
  //   yLabel: '2%',
  //   additionalYLabels: ['6%'],
  //   additionalYPositions: [0.525],
  //   xLabel: DiagramLabel.nRU.label,
  //   rightYLabel: 'A',
  //   additionalRightYLabels: ['C'],
  // );
  // paintDiagramDashedLines(
  //   c,
  //   canvas,
  //   yAxisStartPos: 0.70,
  //   xAxisEndPos: 0.30,
  //   yLabel: '4%',
  //   xLabel: DiagramLabel.uInf.label,
  //   rightYLabel: 'B',
  // );
  // paintMarketCurve(c, canvas, type: MarketCurveType.lrpc);
  // paintMarketCurve(
  //   c,
  //   canvas,
  //   type: MarketCurveType.srpc2,
  //   horizontalShift: 0.10,
  //   verticalShift: -0.14,
  //   lengthAdjustment: length,
  //   color: Colors.red,
  // );
  // paintMarketCurve(
  //   c,
  //   canvas,
  //   type: MarketCurveType.srpc1,
  //   horizontalShift: -0.05,
  //   verticalShift: 0.08,
  //   lengthAdjustment: length,
  // );
  // paintLineSegment(
  //   c,
  //   canvas,
  //   origin: Offset(0.68, 0.78),
  //
  //   angle: pi * -0.22,
  //   length: 0.15,
  // );
  // paintLineSegment(
  //   c,
  //   canvas,
  //   origin: Offset(0.22, 0.38),
  //
  //   angle: pi * -0.22,
  //   length: 0.15,
  // );
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
    type: MarketCurveType.lrpc1,
    horizontalShift: 0.15,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.lrpc2,
    horizontalShift: -0.15,
  );
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.50, 0.50),
    angle: pi,
    length: 0.15,
  );
}
