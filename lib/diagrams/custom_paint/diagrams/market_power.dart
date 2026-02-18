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

class MarketPower extends BaseDiagramPainter {
  MarketPower(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.microPerfectCompetitionMarketLongRun:
      case DiagramEnum.microPerfectCompetitionMarketAbnormalProfit:
      case DiagramEnum.microPerfectCompetitionMarketLoss:
        return _paintPerfectCompMarket(c, canvas, diagram);
      case DiagramEnum.microPerfectCompetitionFirmLongRun:
      case DiagramEnum.microPerfectCompetitionFirmAbnormalProfitAdjustment:
      case DiagramEnum.microPerfectCompetitionFirmLoss:
      case DiagramEnum.microPerfectCompetitionShutdownPoint:
      case DiagramEnum
          .microPerfectCompetitionNormalProfitRevenueCostsCalculation:
      case DiagramEnum
          .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation:
      case DiagramEnum.microPerfectCompetitionShutdownLossCalculation:
        return _perfectCompFirm(c, canvas, diagram);
      case DiagramEnum.microMonopolyAbnormalProfit:
      case DiagramEnum.microMonopolyAbnormalProfitAndCosts:
      case DiagramEnum.microMonopolyWelfare:
      case DiagramEnum.microMonopolyWelfareAllocativelyEfficient:
        return _paintStandardMonopoly(c, canvas, diagram);
      case DiagramEnum.microMonopolyNatural:
      case DiagramEnum.microMonopolyNaturalUnregulatedWelfare:
      case DiagramEnum.microMonopolyNaturalPricingComparisons:
      case DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare:
      case DiagramEnum.microMonopolyNaturalMarginalCostPricing:
      case DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare:
        return _paintNaturalMonopoly(c, canvas, diagram);
      case DiagramEnum.microOligopolyKinkedDemandCurve:
        return _paintKinkedDemand(c, canvas, diagram);
      case DiagramEnum.microMonopolisticCompetitionLongRun:
      case DiagramEnum.microMonopolisticCompetitionAbnormalProfit:
      case DiagramEnum.microMonopolisticCompetitionLoss:
      case DiagramEnum.microMonopolisticCompetitionAbnormalProfitShift:
      case DiagramEnum.microMonopolisticCompetitionLossShift:
        return _paintMonopolisticCompetition(c, canvas, diagram);
      default:
    }
  }

  void _paintPerfectCompMarket(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,

    DiagramEnum diagram,
  ) {
    paintTitle(c, canvas, DiagramLabel.market.label);

    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.priceRevenueCosts.label,
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
      paintDot(c, canvas, const Offset(0.50, 0.50));
    }

    if (diagram == DiagramEnum.microPerfectCompetitionMarketAbnormalProfit) {
      paintMarketCurve(
        c,
        canvas,

        type: MarketCurveType.demand,
        verticalShift: -0.10,
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

        origin: const Offset(-0.12, 0.41),
        angle: pi / 2,
        length: 0.10,
      );
      paintLineSegment(
        c,
        canvas,

        origin: const Offset(0.68, 0.25),
        length: 0.18,
      );
      paintDot(c, canvas, const Offset(0.45, 0.35));
      paintDot(c, canvas, const Offset(0.60, 0.50));
    }

    if (diagram == DiagramEnum.microPerfectCompetitionMarketLoss) {
      paintMarketCurve(c, canvas, type: MarketCurveType.demand);
      paintMarketCurve(
        c,
        canvas,

        type: MarketCurveType.supply,
        label: DiagramLabel.s2.label,
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

        origin: const Offset(-0.12, 0.58),
        angle: -pi / 2,
        length: 0.10,
      );
      paintLineSegment(
        c,
        canvas,

        origin: const Offset(0.809, 0.35),
        length: 0.18,
        angle: pi,
      );
      paintDot(c, canvas, const Offset(0.50, 0.50));
      paintDot(c, canvas, const Offset(0.65, 0.65));
    }
  }

  void _perfectCompFirm(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum diagram,
  ) {
    String pLabel = DiagramLabel.priceRevenueCosts.label;
    String qLabel = DiagramLabel.quantity.label;
    if (diagram ==
        DiagramEnum
            .microPerfectCompetitionAbnormalProfitRevenueCostsCalculation) {
      pLabel = DiagramLabel.priceCostsRevenueDollar.label;
      qLabel = DiagramLabel.quantityThousands.label;
    }
    paintAxis(c, canvas, yAxisLabel: pLabel, xAxisLabel: qLabel);

    if (diagram ==
        DiagramEnum
            .microPerfectCompetitionNormalProfitRevenueCostsCalculation) {
      paintTitle(c, canvas, 'Normal Profit');
      paintShading(c, canvas, ShadeType.revenueUnchanged, [
        Offset(0, 0.50),
        Offset(0.48, 0.50),
        Offset(0.48, 1),
        Offset(0, 1),
      ]);
      paintText(
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
      paintShading(c, canvas, ShadeType.costs, [
        Offset(0, 0.47),
        Offset(0.565, 0.47),
        Offset(0.565, 1),
        Offset(0, 1),
      ]);
      paintShading(c, canvas, ShadeType.abnormalProfit, [
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

      paintText(
        c,
        canvas,
        DiagramLabel.abnormalProfit.label,
        Offset(0.35, 0.20),
        pointerLine: Offset(0.35, 0.40),
      );
      paintText(
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

      paintShading(c, canvas, ShadeType.abnormalProfit, [
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
      paintText(
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
      paintShading(c, canvas, ShadeType.loss, [
        Offset(0.0, 0.485),
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
      paintText(
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
          CustomBezier(
            control: Offset(0.50, 1.0),
            endPoint: Offset(0.92, 0.15),
          ),
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

      paintText(
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
          CustomBezier(
            control: Offset(0.50, 1.0),
            endPoint: Offset(0.92, 0.15),
          ),
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

  void _paintStandardMonopoly(
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

    if (diagram == DiagramEnum.microMonopolyWelfare ||
        diagram == DiagramEnum.microMonopolyWelfareAllocativelyEfficient) {
      if (diagram == DiagramEnum.microMonopolyWelfare) {
        paintText(
          c,
          canvas,

          DiagramLabel.consumerSurplus.label,
          Offset(0.20, 0.05),
          pointerLine: Offset(0.15, 0.30),
        );
        paintText(
          c,
          canvas,

          DiagramLabel.welfareLoss.label,
          Offset(0.40, 0.25),
          pointerLine: Offset(0.40, 0.50),
        );
        paintText(
          c,
          canvas,

          DiagramLabel.producerSurplus.label,
          Offset(0.55, 0.85),
          pointerLine: Offset(0.20, 0.70),
        );
        paintShading(c, canvas, ShadeType.consumerSurplus, [
          Offset(0, 0.08),
          Offset(0.33, 0.38),
          Offset(0, 0.38),
        ]);
        paintShading(c, canvas, ShadeType.producerSurplus, [
          Offset(0, 0.38),
          Offset(0.33, 0.38),
          Offset(0.33, 0.75),
          CustomBezier(control: Offset(0.03, 1.17), endPoint: Offset(0, 0.60)),
        ]);
        paintShading(c, canvas, ShadeType.welfareLoss, [
          Offset(0.325, 0.38),
          Offset(0.47, 0.51),
          Offset(0.325, 0.75),
        ]);
      }
      if (diagram == DiagramEnum.microMonopolyWelfareAllocativelyEfficient) {
        paintDiagramDashedLines(
          c,
          canvas,

          yAxisStartPos: 0.51,
          xAxisEndPos: 0.47,
          yLabel: DiagramLabel.pMC.label,
          xLabel: DiagramLabel.qMC.label,
        );
        paintText(
          c,
          canvas,

          'Consumer Surplus\nCaptured by\nMonopolist ',
          Offset(0.42, 0.20),
          pointerLine: Offset(0.25, 0.45),
        );
        paintText(
          c,
          canvas,

          'Lost Consumer\nSurplus',
          Offset(0.70, 0.50),
          pointerLine: Offset(0.35, 0.45),
        );
        paintText(
          c,
          canvas,

          DiagramLabel.consumerSurplus.label,
          Offset(0.20, 0.05),
          pointerLine: Offset(0.15, 0.30),
        );
        paintShading(c, canvas, ShadeType.consumerSurplus, [
          Offset(0, 0.08),
          Offset(0.33, 0.38),
          Offset(0, 0.38),
        ]);
        paintShading(c, canvas, ShadeType.lostConsumerSurplus, [
          Offset(0.0, 0.38),
          Offset(0.325, 0.38),
          Offset(0.325, 0.51),
          Offset(0.0, 0.51),
        ]);
        paintShading(c, canvas, ShadeType.loss, [
          Offset(0.325, 0.38),
          Offset(0.48, 0.51),
          Offset(0.325, 0.51),
        ]);
      }
    } else {
      paintDiagramLines(
        c,
        canvas,

        startPos: Offset(0.05, 0.20),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.38, 0.885),
            endPoint: Offset(0.90, 0.20),
          ),
        ],
        label2: DiagramLabel.atc.label,
        label2Align: LabelAlign.centerTop,
      );
    }
    if (diagram == DiagramEnum.microMonopolyAbnormalProfit ||
        diagram == DiagramEnum.microMonopolyAbnormalProfitAndCosts) {
      if (diagram == DiagramEnum.microMonopolyAbnormalProfitAndCosts) {
        paintText(
          c,
          canvas,

          DiagramLabel.costs.label,
          Offset(0.50, 0.80),
          pointerLine: Offset(0.20, 0.80),
        );
        paintShading(c, canvas, ShadeType.costs, [
          Offset(0.0, 0.52),
          Offset(0.325, 0.52),
          Offset(0.325, 1.0),
          Offset(0.0, 1.0),
        ]);
      }
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.52,
        xAxisEndPos: 0.325,
        showDotAtIntersection: true,
        yLabel: DiagramLabel.c.label,
        hideXLine: true,
      );
      paintText(
        c,
        canvas,

        DiagramLabel.abnormalProfit.label,
        Offset(0.38, 0.22),
        pointerLine: Offset(0.25, 0.42),
      );
      paintShading(c, canvas, ShadeType.abnormalProfit, [
        Offset(0.0, 0.38),
        Offset(0.325, 0.38),
        Offset(0.325, 0.52),
        Offset(0.0, 0.52),
      ]);
    }

    paintMarginalCost(c, canvas);

    String demandLabel = DiagramLabel.dEqualsAR.label;
    if (diagram == DiagramEnum.microMonopolyWelfare) {
      demandLabel = DiagramLabel.dEqualsARMB.label;
    }
    paintDiagramLines(
      c,
      canvas,

      startPos: Offset(0.02, 0.10),
      polylineOffsets: [Offset(0.90, 0.90)],
      label2: demandLabel,
    );
    paintDiagramLines(
      c,
      canvas,

      startPos: Offset(0.02, 0.10),
      polylineOffsets: [Offset(0.50, 1.1)],
      label2: DiagramLabel.mr.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.38,
      xAxisEndPos: 0.325,
      showDotAtIntersection: true,
      yLabel: DiagramLabel.p.label,
      xLabel: DiagramLabel.qProfitMax.label,
    );

    paintDot(c, canvas, Offset(0.325, 0.74));

    paintDot(c, canvas, Offset(0.47, 0.51));
  }

  void _paintNaturalMonopoly(
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
    paintDiagramLines(
      c,
      canvas,

      startPos: Offset(0.03, 0.25),
      bezierPoints: [
        CustomBezier(control: Offset(0.20, 0.80), endPoint: Offset(0.90, 0.80)),
      ],
      label2: DiagramLabel.lrac.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,

      startPos: Offset(0.03, 0.15),
      polylineOffsets: [Offset(0.75, 0.92)],
      label2: DiagramLabel.dEqualsAR.label,
      label2Align: LabelAlign.centerRight,
    );
    if (diagram == DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare) {
      paintText(
        c,
        canvas,

        DiagramLabel.consumerSurplus.label,
        Offset(0.60, 0.50),
        pointerLine: Offset(0.30, 0.50),
      );
      paintText(
        c,
        canvas,

        DiagramLabel.welfareLoss.label,
        Offset(0.70, 0.70),
        pointerLine: Offset(0.65, 0.85),
      );
      paintShading(c, canvas, ShadeType.consumerSurplus, [
        Offset(0, 0.12),
        Offset(0.61, 0.77),
        Offset(0, 0.77),
      ]);
      paintShading(c, canvas, ShadeType.welfareLoss, [
        Offset(0.61, 0.77),
        Offset(0.72, 0.89),
        Offset(0.61, 0.89),
      ]);
    }
    if (diagram == DiagramEnum.microMonopolyNaturalUnregulatedWelfare) {
      paintText(
        c,
        canvas,

        DiagramLabel.consumerSurplus.label,
        Offset(0.50, 0.40),
        pointerLine: Offset(0.20, 0.40),
      );
      paintText(
        c,
        canvas,

        DiagramLabel.abnormalProfit.label,
        Offset(0.55, 0.50),
        pointerLine: Offset(0.35, 0.65),
      );
      paintText(
        c,
        canvas,

        DiagramLabel.welfareLoss.label,
        Offset(0.65, 0.60),
        pointerLine: Offset(0.50, 0.70),
      );
      paintShading(c, canvas, ShadeType.consumerSurplus, [
        Offset(0, 0.12),
        Offset(0.43, 0.58),
        Offset(0, 0.58),
      ]);
      paintShading(c, canvas, ShadeType.abnormalProfit, [
        Offset(0.0, 0.58),
        Offset(0.43, 0.58),
        Offset(0.43, 0.71),
        Offset(0.0, 0.71),
      ]);
      paintShading(c, canvas, ShadeType.welfareLoss, [
        Offset(0.43, 0.58),
        Offset(0.72, 0.89),
        Offset(0.43, 0.89),
      ]);
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.58,
        xAxisEndPos: 0.43,
        yLabel: DiagramLabel.pProfitMax.label,
        xLabel: DiagramLabel.qProfitMax.label,
        showDotAtIntersection: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.71,
        xAxisEndPos: 0.43,
        yLabel: DiagramLabel.costs.label,
        hideXLine: true,
        showDotAtIntersection: true,
      );
    }
    if (diagram == DiagramEnum.microMonopolyNaturalMarginalCostPricing) {
      if (diagram == DiagramEnum.microMonopolyNaturalMarginalCostPricing) {
        paintText(
          c,
          canvas,

          DiagramLabel.subsidy.label,
          Offset(0.65, 0.65),
          pointerLine: Offset(0.60, 0.84),
        );
        paintShading(c, canvas, ShadeType.loss, [
          Offset(0, 0.79),
          Offset(0.72, 0.79),
          Offset(0.72, 0.89),
          Offset(0, 0.89),
        ]);

        paintDiagramDashedLines(
          c,
          canvas,

          yAxisStartPos: 0.79,
          xAxisEndPos: 0.72,
          yLabel: DiagramLabel.costs.label,
          showDotAtIntersection: true,
        );
      }
    }
    if (diagram == DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare) {
      paintText(
        c,
        canvas,

        DiagramLabel.consumerSurplus.label,
        Offset(0.50, 0.40),
        pointerLine: Offset(0.35, 0.60),
      );
      paintShading(c, canvas, ShadeType.consumerSurplus, [
        Offset(0, 0.12),
        Offset(0.72, 0.89),
        Offset(0, 0.89),
      ]);
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.89,
        xAxisEndPos: 0.72,
        yLabel: DiagramLabel.pMC.label,
        xLabel: DiagramLabel.qMC.label,
        showDotAtIntersection: true,
      );
    }
    if (diagram == DiagramEnum.microMonopolyNaturalPricingComparisons ||
        diagram == DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare) {
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.77,
        xAxisEndPos: 0.61,
        yLabel: DiagramLabel.pACP.label,
        xLabel: DiagramLabel.qACP.label,
        showDotAtIntersection: true,
      );
    }
    if (diagram == DiagramEnum.microMonopolyNaturalPricingComparisons ||
        diagram == DiagramEnum.microMonopolyNaturalUnregulatedWelfare ||
        diagram == DiagramEnum.microMonopolyNaturalMarginalCostPricing ||
        diagram == DiagramEnum.microMonopolyNaturalAverageCostPricingWelfare ||
        diagram == DiagramEnum.microMonopolyNaturalMarginalCostPricingWelfare) {
      paintDiagramLines(
        c,
        canvas,

        startPos: Offset(0.03, 0.15),
        polylineOffsets: [Offset(0.75, 0.92)],
      );
      paintDiagramLines(
        c,
        canvas,

        startPos: Offset(0.03, 0.70),
        bezierPoints: [
          CustomBezier(
            control: Offset(0.15, 0.93),
            endPoint: Offset(0.90, 0.88),
          ),
        ],
        label2: DiagramLabel.lrmc.label,
        label2Align: LabelAlign.centerRight,
      );
      paintDiagramLines(
        c,
        canvas,

        startPos: Offset(0.03, 0.15),
        polylineOffsets: [Offset(0.55, 1.1)],
        label2: DiagramLabel.mr.label,
      );
    }
    if (diagram == DiagramEnum.microMonopolyNaturalPricingComparisons) {
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.58,
        xAxisEndPos: 0.43,
        yLabel: DiagramLabel.pProfitMax.label,
        xLabel: DiagramLabel.qProfitMax.label,
        showDotAtIntersection: true,
      );
      paintDiagramDashedLines(
        c,
        canvas,

        yAxisStartPos: 0.89,
        xAxisEndPos: 0.72,
        yLabel: DiagramLabel.pMC.label,
        xLabel: DiagramLabel.qMC.label,
        showDotAtIntersection: true,
      );
    }
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

          'D/AR & MR shift left\n(also more elastic)\n'
          'until P=ATC',
          Offset(0.85, 0.60),
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

          'D/AR & MR shift right\n(also more inelastic)\nuntil P=ATC',
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

          origin: Offset(0.20, 0.75),
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
        Offset(0.30, 0.25),
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
    if (diagram == DiagramEnum.microMonopolisticCompetitionLoss) {
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
