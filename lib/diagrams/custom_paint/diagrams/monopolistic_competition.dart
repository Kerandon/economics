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
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class MonopolisticCompetitionDiagram extends BaseDiagramPainter {
  MonopolisticCompetitionDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.microMonopolisticCompetitionLongRun:
      case DiagramEnum.microMonopolisticCompetitionAbnormalProfit:
      case DiagramEnum.microMonopolisticCompetitionEconomicLoss:
      case DiagramEnum.microMonopolisticCompetitionAbnormalProfitShift:
      case DiagramEnum.microMonopolisticCompetitionLossShift:
        return _paintMonopolisticCompetition(c, canvas, diagram);
      default:
    }
  }

  void _paintMonopolisticCompetition(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum diagram,
  ) {
    paintAxis(
      c,
      canvas,

      yAxisLabel: DiagramLabel.priceRevenueCosts.label,
      xAxisLabel: DiagramLabel.quantity.label,
    );

    paintMarginalCost(c, canvas);

    paintDiagramLines(
      c,
      canvas,

      startPos: Offset(0.05, 0.20),
      bezierPoints: [
        CustomBezier(control: Offset(0.38, 0.92), endPoint: Offset(0.90, 0.20)),
      ],
      label2: DiagramLabel.atc.label,
      label2Align: LabelAlign.centerTop,
    );

    if (diagram == DiagramEnum.microMonopolisticCompetitionLongRun ||
        diagram ==
            DiagramEnum.microMonopolisticCompetitionAbnormalProfitShift ||
        diagram == DiagramEnum.microMonopolisticCompetitionLossShift) {
      if (diagram ==
          DiagramEnum.microMonopolisticCompetitionAbnormalProfitShift) {
        paintText(
          c,
          canvas,

          'D/AR + MR left\n(and more elastic)\n'
          'until P=ATC',
          Offset(0.85, 0.60),
          type: DiagramTextType.label,
        );
        paintLineSegment(
          c,
          canvas,

          origin: Offset(0.95, 0.75),
          strokeWidth: kCurveWidth * 2,
          angle: pi,
          color: Colors.red,
        );
        paintLineSegment(
          c,
          canvas,

          origin: Offset(0.50, 0.75),
          strokeWidth: kCurveWidth * 2,
          angle: pi,
          color: Colors.red,
        );
      }

      if (diagram == DiagramEnum.microMonopolisticCompetitionLossShift) {
        paintText(
          c,
          canvas,

          'D and MR shift right\n(plus more inelastic)\nuntil P tangent to ATC',
          Offset(0.85, 0.60),
        );
        paintLineSegment(
          c,
          canvas,

          origin: Offset(0.60, 0.75),
          strokeWidth: kCurveWidth * 2,
          color: Colors.red,
        );
        paintLineSegment(
          c,
          canvas,

          origin: Offset(0.20, 0.85),
          strokeWidth: kCurveWidth * 2,
          color: Colors.red,
        );
      }

      paintDiagramLines(
        c,
        canvas,

        startPos: Offset(0.02, 0.40),
        polylineOffsets: [Offset(0.90, 0.80)],
        label2: DiagramLabel.dEqualsAR.label,
      );
      paintDiagramLines(
        c,
        canvas,

        startPos: Offset(0.02, 0.40),
        polylineOffsets: [Offset(0.65, 1.1)],
        label2: DiagramLabel.mr.label,
      );
      paintDot(c, canvas, Offset(0.325, 0.74));

      paintDot(c, canvas, Offset(0.425, 0.585));
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.54,
        xAxisEndPos: 0.325,
        showDotAtIntersection: true,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.qProfitMax.label,
      );
    }
    if (diagram == DiagramEnum.microMonopolisticCompetitionAbnormalProfit) {
      paintText(
        c,
        canvas,

        DiagramLabel.abnormalProfit.label,
        Offset(0.30, 0.15),
        pointerLine: Offset(0.30, 0.51),
      );
      paintShading(c, canvas, ShadeType.abnormalProfit, [
        Offset(0, 0.49),
        Offset(0.375, 0.49),
        Offset(0.375, 0.555),
        Offset(0, 0.555),
      ]);
      paintDiagramLines(
        c,
        canvas,

        startPos: Offset(0.02, 0.25),
        polylineOffsets: [Offset(0.90, 0.85)],
        label2: DiagramLabel.dEqualsAR.label,
      );
      paintDiagramLines(
        c,
        canvas,

        startPos: Offset(0.02, 0.25),
        polylineOffsets: [Offset(0.75, 1.1)],
        label2: DiagramLabel.mr.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.49,
        xAxisEndPos: 0.375,
        showDotAtIntersection: true,
        yLabel: DiagramLabel.p.label,
        xLabel: DiagramLabel.qProfitMax.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.555,
        xAxisEndPos: 0.375,
        showDotAtIntersection: true,
        yLabel: DiagramLabel.c.label,
        xLabel: DiagramLabel.qProfitMax.label,
      );
      paintDot(c, canvas, Offset(0.375, 0.665));
    }
    if (diagram == DiagramEnum.microMonopolisticCompetitionEconomicLoss) {
      paintText(
        c,
        canvas,

        DiagramLabel.loss.label,
        Offset(0.30, 0.40),
        pointerLine: Offset(0.25, 0.55),
      );
      paintShading(c, canvas, ShadeType.loss, [
        Offset(0, 0.515),
        Offset(0.285, 0.515),
        Offset(0.285, 0.59),
        Offset(0, 0.59),
      ]);
      paintDiagramLines(
        c,
        canvas,

        startPos: Offset(0.02, 0.50),
        polylineOffsets: [Offset(0.90, 0.80)],
        label2: DiagramLabel.dEqualsAR.label,
      );
      paintDiagramLines(
        c,
        canvas,

        startPos: Offset(0.02, 0.50),
        polylineOffsets: [Offset(0.55, 1.1)],
        label2: DiagramLabel.mr.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.59,
        xAxisEndPos: 0.285,
        showDotAtIntersection: true,
        yLabel: DiagramLabel.p.label,
        hideXLine: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.515,
        xAxisEndPos: 0.285,
        showDotAtIntersection: true,
        yLabel: DiagramLabel.c.label,
        xLabel: DiagramLabel.qProfitMax.label,
      );
      paintDot(c, canvas, Offset(0.285, 0.80));
    }
  }
}
