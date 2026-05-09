import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_marginal_cost.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/diagrams/enums/diagram_title.dart';
import 'package:economics_app/diagrams/enums/diagram_type.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class OligopolyDiagram extends BaseDiagramPainter {
  OligopolyDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    paintAxis(c, canvas, axisType: AxisType.priceRevenueCosts);

    switch (diagram) {
      case DiagramEnum.microOligopolyCartel:
        _paintCartel(c, canvas);
      case DiagramEnum.microOligopolyKinkedDemandCurve:
        return _paintKinkedDemand(c, canvas, diagram);
      default:
    }
  }
}

void _paintCartel(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintShading(c, canvas, ShadeType.consumerSurplus, [
    Offset(0, 0),
    Offset(0.34, 0.36),
    Offset(0, 0.36),
  ]);
  paintText(
    c,
    canvas,
    DiagramLabel.consumerSurplus.label,
    Offset(0.30, 0.10),
    type: DiagramTextType.label,
    pointerLine: Offset(0.20, 0.30),
  );
  paintShading(c, canvas, ShadeType.abnormalProfit, [
    Offset(0, 0.36),
    Offset(0.34, 0.36),
    Offset(0.34, 0.52),
    Offset(0, 0.52),
  ]);
  paintText(
    c,
    canvas,
    DiagramLabel.abnormalProfit.label,
    Offset(-0.20, 0.45),
    type: DiagramTextType.label,
    pointerLine: Offset(0.05, 0.45),
  );
  paintShading(c, canvas, ShadeType.welfareLoss, [
    Offset(0.34, 0.36),
    Offset(0.48, 0.50),
    Offset(0.34, 0.72),
  ]);
  paintText(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    Offset(0.50, 0.70),
    type: DiagramTextType.label,
    pointerLine: Offset(0.38, 0.58),
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.36,
    xAxisEndPos: 0.34,
    yLabel: DiagramLabel.p.label,
    xLabel: DiagramLabel.qProfitMax.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.52,
    xAxisEndPos: 0.34,
    hideXLine: true,
    yLabel: 'C',
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.dArMrMonopoly);

  paintMarketCurve(c, canvas, type: MarketCurveType.mcAtc);
}

void _paintKinkedDemand(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  paintAxis(
    c,
    canvas,

    yAxisLabel: DiagramLabel.price.label,
    xAxisLabel: DiagramLabel.quantity.label,
  );

  paintText(
    c,
    canvas,

    'Kink',
    Offset(0.70, 0.30),
    pointerLine: Offset(0.55, 0.30),
  );
  paintText(c, canvas, 'Elastic', Offset(0.40, 0.15));
  paintText(c, canvas, 'Inelastic', Offset(0.80, 0.60));
  paintDiagramLines(
    c,
    canvas,

    startPos: Offset(0.10, 0.15),
    polylineOffsets: [Offset(0.55, 0.30), Offset(0.75, 0.90)],
  );
  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: 0.20,
    xAxisEndPos: 0.25,
    showDotAtIntersection: true,
    yLabel: DiagramLabel.p1.label,
    xLabel: DiagramLabel.q1.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: 0.30,
    xAxisEndPos: 0.55,
    showDotAtIntersection: true,
    yLabel: DiagramLabel.pE.label,
    xLabel: DiagramLabel.qE.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: 0.60,
    xAxisEndPos: 0.65,
    showDotAtIntersection: true,
    yLabel: DiagramLabel.p2.label,
    xLabel: DiagramLabel.q2.label,
  );
}
