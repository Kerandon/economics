import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:flutter/material.dart';

import '../../enums/diagram_enum.dart';
import '../../enums/diagram_labels.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_line_segment.dart';

import '../painter_methods/shortcut_methods/paint_market_curve.dart';

class DemandDiagram extends BaseDiagramPainter3 {
  DemandDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    switch (diagram) {
      case DiagramEnum.microDemand:
        _paintDemand(c, canvas, size, diagram);
        break;
      case DiagramEnum.microDemandIncrease:
      case DiagramEnum.microDemandDecrease:
        _paintIncreaseDecreaseDemand(c, canvas, size, diagram);
        break;
      case DiagramEnum.microDemandExtension:
      case DiagramEnum.microDemandContraction:
      case DiagramEnum.microDemandQuantityChangeDueToSupply:
        _paintExtensionContractionDemand(c, canvas, size, diagram);
        break;
      default:
    }
  }
}

// --- UPDATED PRIVATE METHODS ---

void _paintDemand(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Size size,
  DiagramEnum diagram, {
  IDiagramCanvas? iCanvas,
}) {
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.price$.label,
    xAxisLabel: DiagramLabel.quantity.label,
    yDivisions: 11,
    yMaxValue: 11,
    gridLineStyle: GridLineStyle.dashes,
    xDivisions: 6,
    xMaxValue: 6,
    labelPad: 0.08,
  );
  paintDiagramLines(
    c,
    canvas,

    startPos: const Offset(0, 0.09),
    polylineOffsets: [const Offset(0.84, 1)],
  );
}

void _paintIncreaseDecreaseDemand(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Size size,
  DiagramEnum diagram, {
  IDiagramCanvas? iCanvas,
}) {
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.p.label,
    xAxisLabel: DiagramLabel.q.label,
  );

  bool isDecrease = diagram == DiagramEnum.microDemandDecrease;

  if (isDecrease) {
    paintLineSegment(
      c,
      canvas,

      origin: const Offset(0.42, 0.40),
      angle: pi,
      length: 0.15,
    );
  } else {
    paintLineSegment(
      c,
      canvas,

      origin: const Offset(0.38, 0.40),
      angle: 0,
      length: 0.15,
    );
  }

  paintMarketCurve(
    c,
    canvas,

    type: MarketCurveType.demand,
    horizontalShift: -0.15,
    lengthAdjustment: -0.15,
    label: isDecrease ? DiagramLabel.d2.label : DiagramLabel.d1.label,
  );

  paintMarketCurve(
    c,
    canvas,

    type: MarketCurveType.demand,
    horizontalShift: 0.15,
    lengthAdjustment: -0.15,
    label: isDecrease ? DiagramLabel.d1.label : DiagramLabel.d2.label,
  );

  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: 0.50,
    xAxisEndPos: 0.65,
    showDotAtIntersection: true,
    yLabel: DiagramLabel.p.label,
    xLabel: isDecrease ? DiagramLabel.q1.label : DiagramLabel.q2.label,
  );

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.35,
    showDotAtIntersection: true,
    hideYLine: true,
    xLabel: isDecrease ? DiagramLabel.q2.label : DiagramLabel.q1.label,
  );
}

void _paintExtensionContractionDemand(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Size size,
  DiagramEnum diagram, {
  IDiagramCanvas? iCanvas,
}) {
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.p.label,
    xAxisLabel: DiagramLabel.q.label,
  );

  bool isContraction = diagram == DiagramEnum.microDemandContraction;

  double angle = isContraction ? pi / -1.33 : pi / 4.1;

  if (diagram == DiagramEnum.microDemandQuantityChangeDueToSupply) {
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      lengthAdjustment: -0.15,
      label: DiagramLabel.s1.label,
      horizontalShift: -0.15,
      verticalShift: -0.15,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      lengthAdjustment: -0.15,
      label: DiagramLabel.s2.label,
      horizontalShift: 0.10,
      verticalShift: 0.10,
    );
  }
  paintMarketCurve(c, canvas, type: MarketCurveType.demand);
  paintLineSegment(
    c,
    canvas,

    origin: Offset(isContraction ? 0.52 : 0.50, isContraction ? 0.45 : 0.43),
    angle: angle,
    length: 0.25,
  );

  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: 0.35,
    xAxisEndPos: 0.35,
    yLabel: DiagramLabel.p1.label,
    xLabel: DiagramLabel.q1.label,
    showDotAtIntersection: true,
  );

  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: 0.60,
    xAxisEndPos: 0.60,
    yLabel: DiagramLabel.p2.label,
    xLabel: DiagramLabel.q2.label,
    showDotAtIntersection: true,
  );
}
