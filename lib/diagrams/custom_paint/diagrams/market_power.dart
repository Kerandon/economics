import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/label_align.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
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

class MarketPower extends BaseDiagramPainter3 {
  MarketPower(super.config, super.diagram);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.microPerfectCompetitionMarketLongRun ||
          DiagramEnum.microPerfectCompetitionMarketAbnormalProfit ||
          DiagramEnum.microPerfectCompetitionMarketLoss:
        return _perfectCompMarket(c, canvas, size, diagram);
      case DiagramEnum.microPerfectCompetitionFirmLongRun ||
          DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment ||
          DiagramEnum.microPerfectCompetitionFirmLoss ||
          DiagramEnum.microPerfectCompetitionShutdownPoint ||
          DiagramEnum
              .microPerfectCompetitionNormalProfitRevenueCostsCalculation ||
          DiagramEnum
              .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation ||
          DiagramEnum.microPerfectCompetitionShutdownLossCalculation:
        return _perfectCompFirm(c, canvas, size, diagram);
      default:
    }
  }
}

void _perfectCompMarket(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum diagram,
) {
  paintTitle(c, canvas, DiagramLabel.market.label);

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.priceCostsRevenue.label,
    xAxisLabel: DiagramLabel.quantity.label,
  );

  if (diagram == DiagramEnum.microPerfectCompetitionMarketLongRun) {
    paintMarketCurve(c, canvas, type: MarketCurveType.demand);
    paintMarketCurve(c, canvas, type: MarketCurveType.supply);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 1.1,
      yLabel: DiagramLabel.pm.label,
      hideXLine: true,
    );
    paintDot(c, canvas, pos: Offset(0.50, 0.50));
  }
  if (diagram == DiagramEnum.microPerfectCompetitionMarketAbnormalProfit) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      verticalShift: -0.10,
      horizontalShift: -0.00,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      label: DiagramLabel.s1.label,
      verticalShift: -0.10,
      horizontalShift: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      label: DiagramLabel.s2.label,
      verticalShift: -0.05,
      horizontalShift: 0.15,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 1.3,
      yLabel: DiagramLabel.pm1.label,
      hideXLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 1.3,
      yLabel: DiagramLabel.pm2.label,
      hideXLine: true,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(-0.12, 0.41),
      angle: pi / 2,
      length: 0.10,
    );
    paintLineSegment(c, canvas, origin: Offset(0.68, 0.25), length: 0.18);
    paintDot(c, canvas, pos: Offset(0.45, 0.35));
    paintDot(c, canvas, pos: Offset(0.60, 0.50));
  }
  if (diagram == DiagramEnum.microPerfectCompetitionMarketLoss) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      verticalShift: 0.0,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      label: DiagramLabel.s2.label,
      verticalShift: 0.00,
      horizontalShift: 0.0,
      lengthAdjustment: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      label: DiagramLabel.s1.label,
      verticalShift: 0.10,
      horizontalShift: 0.20,
      lengthAdjustment: -0.10,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 1.3,
      yLabel: DiagramLabel.pm2.label,
      hideXLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.65,
      xAxisEndPos: 1.3,
      yLabel: DiagramLabel.pm1.label,
      hideXLine: true,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(-0.12, 0.58),
      angle: -pi / 2,
      length: 0.10,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.809, 0.35),
      length: 0.18,
      angle: pi / 1.0,
    );
    paintDot(c, canvas, pos: Offset(0.50, 0.50));
    paintDot(c, canvas, pos: Offset(0.65, 0.65));
  }
}

void _perfectCompFirm(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
  DiagramEnum diagram,
) {
  String pLabel = DiagramLabel.priceCostsRevenue.label;
  String qLabel = DiagramLabel.quantity.label;
  if (diagram ==
      DiagramEnum
          .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation) {
    pLabel = DiagramLabel.priceCostsRevenueDollar.label;
    qLabel = DiagramLabel.quantityThousands.label;
  }
  paintAxis(c, canvas, yAxisLabel: pLabel, xAxisLabel: qLabel);

  if (diagram ==
      DiagramEnum.microPerfectCompetitionNormalProfitRevenueCostsCalculation) {
    paintTitle(c, canvas, 'Normal Profit');
    paintShading(canvas, size, ShadeType.revenueUnchanged, [
      Offset(0, 0.50),

      Offset(0.48, 0.50),
      Offset(0.48, 1),
      Offset(0, 1),
    ]);
    paintText2(
      c,
      canvas,
      'TR=TC (zero profit)',
      Offset(0.70, 0.80),
      pointerLine: Offset(0.40, 0.80),
    );
  }
  if (diagram ==
      DiagramEnum
          .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation) {
    paintTitle(c, canvas, 'Abnormal Profit');
    paintShading(canvas, size, ShadeType.costs, [
      Offset(0, 0.47),

      Offset(0.565, 0.47),
      Offset(0.565, 1),
      Offset(0, 1),
    ]);
    paintShading(canvas, size, ShadeType.abnormalProfit, [
      CustomBezier(endPoint: Offset(0.0, 0.35)),
      CustomBezier(endPoint: Offset(0.565, 0.35)),
      CustomBezier(endPoint: Offset(0.565, 0.475)),
      CustomBezier(endPoint: Offset(0.0, 0.475)),
    ]);
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.35),
      polylineOffsets: [Offset(0.80, 0.35)],
      label2: DiagramLabel.dEqualsARMR.label,
      label2Align: LabelAlign.centerRight,
    );

    paintText2(
      c,
      canvas,
      DiagramLabel.abnormalProfit.label,
      Offset(0.35, 0.20),
      pointerLine: Offset(0.35, 0.40),
    );
    paintText2(
      c,
      canvas,
      'Total Cost',
      Offset(0.70, 0.80),
      pointerLine: Offset(0.40, 0.80),
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.565,
      showDotAtIntersection: true,
      yLabel: '\$11',
      hideYLine: true,
      xLabel: '50',
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.47,
      hideXLine: true,
      yLabel: '\$10',
      showDotAtIntersection: true,
      xAxisEndPos: 0.565,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.565, 0.36),
      polylineOffsets: [Offset(0.565, 0.465)],
      color: Colors.red,
      strokeWidth: kCurveWidth,
    );
  }
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.05, 0.10),
    bezierPoints: [
      CustomBezier(control: Offset(0.45, 0.90), endPoint: Offset(0.90, 0.10)),
    ],
    label2: DiagramLabel.atc.label,
    label2Align: LabelAlign.centerTop,
  );
  paintMarginalCost(c, canvas);
  if (diagram == DiagramEnum.microPerfectCompetitionFirmLongRun) {
    paintTitle(c, canvas, DiagramLabel.firm.label);
  }
  if (diagram == DiagramEnum.microPerfectCompetitionFirmLongRun ||
      diagram ==
          DiagramEnum
              .microPerfectCompetitionNormalProfitRevenueCostsCalculation) {
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.50),
      polylineOffsets: [Offset(0.90, 0.50)],
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.50),
      polylineOffsets: [Offset(0.90, 0.50)],
      label2: DiagramLabel.dEqualsARMR.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.48,
      hideYLine: true,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
      showDotAtIntersection: true,
    );
  }
  if (diagram ==
      DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment) {
    paintTitle(c, canvas, DiagramLabel.firm.label);

    paintShading(canvas, size, ShadeType.abnormalProfit, [
      CustomBezier(endPoint: Offset(0.0, 0.35)),
      CustomBezier(endPoint: Offset(0.565, 0.35)),
      CustomBezier(endPoint: Offset(0.565, 0.475)),
      CustomBezier(endPoint: Offset(0.0, 0.475)),
    ]);
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.35),
      polylineOffsets: [Offset(0.90, 0.35)],
      label2: DiagramLabel.dARMR1.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.50),
      polylineOffsets: [Offset(0.90, 0.50)],
      label2: DiagramLabel.dARMR2.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.565,
      hideYLine: true,
      yLabel: DiagramLabel.p1.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.475,
      xAxisEndPos: 0.565,
      hideXLine: true,
      showDotAtIntersection: true,
      xLabel: DiagramLabel.q1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.5,
      xAxisEndPos: 0.475,
      hideYLine: true,

      showDotAtIntersection: true,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.53, 1.08),
      angle: pi,
      length: 0.07,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(-0.08, 0.415),
      angle: pi / 2,
      length: 0.10,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.80, 0.415),
      angle: pi / 2,
      length: 0.10,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.abnormalProfit.label,
      Offset(0.35, 0.25),
      pointerLine: Offset(0.35, 0.43),
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.565, 0.36),
      polylineOffsets: [Offset(0.565, 0.465)],
      color: Colors.red,
      strokeWidth: kCurveWidth * 2,
    );
  }
  if (diagram == DiagramEnum.microPerfectCompetitionFirmLoss) {
    paintTitle(c, canvas, DiagramLabel.firm.label);
    paintShading(canvas, size, ShadeType.loss, [
      CustomBezier(endPoint: Offset(0.0, 0.485)),
      CustomBezier(endPoint: Offset(0.38, 0.485)),
      CustomBezier(endPoint: Offset(0.38, 0.65)),
      CustomBezier(endPoint: Offset(0.0, 0.65)),
    ]);
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.65),
      polylineOffsets: [Offset(0.90, 0.65)],
      label2: DiagramLabel.dARMR1.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.50),
      polylineOffsets: [Offset(0.90, 0.50)],
      label2: DiagramLabel.dARMR2.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.48,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.65,
      xAxisEndPos: 0.38,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.p1.label,
      hideXLine: true,
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.485,
      xAxisEndPos: 0.38,
      showDotAtIntersection: true,
      xLabel: DiagramLabel.q1.label,
    );
    paintLineSegment(c, canvas, origin: Offset(0.42, 1.08), length: 0.07);
    paintLineSegment(
      c,
      canvas,
      origin: Offset(-0.08, 0.58),
      angle: -pi / 2,
      length: 0.10,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.80, 0.58),
      angle: -pi / 2,
      length: 0.10,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.loss.label,
      Offset(0.30, 0.30),
      pointerLine: Offset(0.30, 0.55),
    );
  }
  if (diagram == DiagramEnum.microPerfectCompetitionShutdownPoint) {
    paintTitle(c, canvas, DiagramLabel.firm.label);
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.05, 0.55),
      bezierPoints: [
        CustomBezier(control: Offset(0.50, 1.0), endPoint: Offset(0.92, 0.15)),
      ],
      label2: DiagramLabel.avc.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.50),
      polylineOffsets: [Offset(0.80, 0.50)],
      color: Colors.blueAccent,
      label2: DiagramLabel.breakEvenPoint.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.705),
      polylineOffsets: [Offset(0.80, 0.705)],
      color: Colors.red,
      label2: DiagramLabel.shutdownPoint.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.48,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.p1.label,
      hideXLine: true,
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.705,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.p2.label,
      hideXLine: true,
      hideYLine: true,
    );
  }
  if (diagram == DiagramEnum.microPerfectCompetitionShutdownLossCalculation) {
    paintTitle(c, canvas, 'π when P<AVC');
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.47,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      hideYLine: true,
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.35, 0.47),
      polylineOffsets: [(Offset(0.35, 0.70))],

      color: Colors.red,
    );

    paintText2(
      c,
      canvas,
      'AFC=ATC-AVC',
      Offset(0.40, 0.35),
      pointerLine: Offset(0.35, 0.50),
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.05, 0.55),
      bezierPoints: [
        CustomBezier(control: Offset(0.50, 1.0), endPoint: Offset(0.92, 0.15)),
      ],
      label2: DiagramLabel.avc.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.705,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      hideXLine: true,
      yLabel: '\$5',
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.47,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      hideXLine: true,
      yLabel: '\$9',
      xLabel: '100',
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.0, 0.80),
      polylineOffsets: [Offset(0.50, 0.80)],
      curveStyle: CurveStyle.dashed,
      color: Colors.red,
      label1: DiagramLabel.p.label,
      label1Align: LabelAlign.centerLeft,
      label2: 'P<AVCmin (firm has shut-down)',
      label2Align: LabelAlign.centerRight,
    );
  }
}
