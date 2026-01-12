import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/grid_line_style.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../models/diagram_painter_config.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import '../painter_methods/shortcut_methods/paint_market_curve.dart';

class DemandDiagram extends BaseDiagramPainter3 {
  DemandDiagram(super.config, super.diagram);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    switch (diagram) {
      case DiagramEnum.microDemandApples:
        _paintDemandApples(c, canvas, size, diagram);
      case DiagramEnum.microDemandIncrease || DiagramEnum.microDemandDecrease:
        _paintIncreaseDecreaseDemand(c, canvas, size, diagram);
      case DiagramEnum.microDemandExtension ||
          DiagramEnum.microDemandContraction ||
          DiagramEnum.microDemandQuantityChangeDueToSupply:
        _paintExtensionContractionDemand(c, canvas, size, diagram);
      default:
    }
  }
}

void _paintDemandApples(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum diagram,
) {
  paintTitle(c, canvas, 'Sarah\'s Demand for Apples');
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
    labelPad: 0.11,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.09),
    polylineOffsets: [Offset(0.84, 1)],
  );
}

_paintIncreaseDecreaseDemand(c, canvas, size, diagram) {
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.p.label,
    xAxisLabel: DiagramLabel.q.label,
  );
  String title = 'Increase in Demand';
  String demand1Label = DiagramLabel.d1.label;
  String demand2Label = DiagramLabel.d2.label;
  String qLabel1 = DiagramLabel.q1.label;
  String qLabel2 = DiagramLabel.q2.label;
  double arrowAngle = 0;

  if (diagram == DiagramEnum.microDemandDecrease) {
    title = 'Decrease in Demand';
    demand1Label = DiagramLabel.d2.label;
    demand2Label = DiagramLabel.d1.label;
    qLabel1 = DiagramLabel.q2.label;
    qLabel2 = DiagramLabel.q1.label;
    arrowAngle = pi;
  }
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.40, 0.40),
    angle: arrowAngle,
    length: 0.18,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    horizontalShift: -0.15,
    lengthAdjustment: -0.10,
    label: demand1Label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    horizontalShift: 0.15,
    lengthAdjustment: -0.10,
    label: demand2Label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.65,
    showDotAtIntersection: true,
    yLabel: DiagramLabel.p.label,
    xLabel: qLabel2,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.35,
    showDotAtIntersection: true,
    hideYLine: true,
    xLabel: qLabel1,
  );
  paintTitle(c, canvas, title);
}

_paintExtensionContractionDemand(c, canvas, size, diagram) {
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.p.label,
    xAxisLabel: DiagramLabel.q.label,
  );
  String title = 'Extension in Demand';
  String p1Label = DiagramLabel.p1.label;
  String p2Label = DiagramLabel.p2.label;
  String q1Label = DiagramLabel.q1.label;
  String q2Label = DiagramLabel.q2.label;
  double angle = pi / 4.1;

  paintMarketCurve(c, canvas, type: MarketCurveType.demand);
  if (diagram == DiagramEnum.microDemandContraction) {
    title = 'Contraction in Demand';
    angle = pi / -1.33;
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.52, 0.45),
      angle: angle,
      length: 0.25,
    );
  } else {
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.50, 0.43),
      angle: angle,
      length: 0.25,
    );
  }

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.35,
    xAxisEndPos: 0.35,
    yLabel: p1Label,
    xLabel: q1Label,
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.60,
    xAxisEndPos: 0.60,
    yLabel: p2Label,
    xLabel: q2Label,
    showDotAtIntersection: true,
  );
  if (diagram == DiagramEnum.microDemandQuantityChangeDueToSupply) {
    title = 'Extension in Demand Due to Increase in Supply';
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
  paintTitle(c, canvas, title);
}
