import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';

import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class PPCDiagram extends BaseDiagramPainter {
  PPCDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.globalPPCReallocation:
      case DiagramEnum.globalPPCCapitalInvestment:
      case DiagramEnum.globalPPCUnsustainableUseOfNaturalResources:
      case DiagramEnum.globalPPCEconomicGrowth:
        _paintPPCGlobal(c, canvas, diagram);
      default:
    }
  }
}

void _paintPPCGlobal(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  if (diagram == DiagramEnum.globalPPCReallocation) {
    paintAxis(
      c,
      canvas,
      yAxisLabel: 'Military\nGoods',
      xAxisLabel: 'Merit\nGoods',
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.20),
      bezierPoints: [
        CustomBezier(control: Offset(0.70, 0.30), endPoint: Offset(0.80, 1.0)),
      ],
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.495,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.q1.label,
      xLabel: DiagramLabel.q1.label,
      rightYLabel: 'X',
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.665,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.q2.label,
      xLabel: DiagramLabel.q2.label,

      rightYLabel: 'Y',
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.64, 0.48),
      angle: pi * 0.30,
      length: 0.10,
    );
  }
  if (diagram == DiagramEnum.globalPPCEconomicGrowth) {
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.consumerGoods.label,
      xAxisLabel: DiagramLabel.capitalGoods.label,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.35),
      bezierPoints: [
        CustomBezier(control: Offset(0.50, 0.45), endPoint: Offset(0.65, 1.0)),
      ],
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.15),
      bezierPoints: [
        CustomBezier(control: Offset(0.70, 0.30), endPoint: Offset(0.85, 1.0)),
      ],
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.45,
      showDotAtIntersection: true,
      rightYLabel: 'X',
      yLabel: DiagramLabel.q1.label,
      xLabel: DiagramLabel.q1.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.62,
      showDotAtIntersection: true,
      rightYLabel: 'Y',
      yLabel: DiagramLabel.q2.label,
      xLabel: DiagramLabel.q2.label,
    );
  }
  if (diagram == DiagramEnum.globalPPCUnsustainableUseOfNaturalResources) {
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.consumerGoods.label,
      xAxisLabel: DiagramLabel.capitalGoods.label,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.35),
      bezierPoints: [
        CustomBezier(control: Offset(0.50, 0.45), endPoint: Offset(0.65, 1.0)),
      ],
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.15),
      bezierPoints: [
        CustomBezier(control: Offset(0.70, 0.30), endPoint: Offset(0.85, 1.0)),
      ],
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.70,
      xAxisEndPos: 0.40,
      showDotAtIntersection: true,
      rightYLabel: 'Y',
      hideYLine: true,
      hideXLine: true,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.82,
      xAxisEndPos: 0.18,
      showDotAtIntersection: true,
      rightYLabel: 'X',
      hideYLine: true,
      hideXLine: true,
    );
    paintLineSegment(c, canvas, origin: Offset(0.60, 0.60), angle: pi * 0.80);
    paintLineSegment(c, canvas, origin: Offset(0.32, 0.76), angle: pi * -0.20);
  }
  if (diagram == DiagramEnum.globalPPCCapitalInvestment) {
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.consumerGoods.label,
      xAxisLabel: DiagramLabel.capitalGoods.label,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.50),
      bezierPoints: [
        CustomBezier(control: Offset(0.40, 0.60), endPoint: Offset(0.50, 1.0)),
      ],
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.30),
      bezierPoints: [
        CustomBezier(control: Offset(0.55, 0.50), endPoint: Offset(0.70, 1.0)),
      ],
      curveStyle: CurveStyle.dashed,
      color: Colors.grey,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.15),
      bezierPoints: [
        CustomBezier(control: Offset(0.75, 0.40), endPoint: Offset(0.85, 1.0)),
      ],
      color: Colors.red,
    );
  }
}
