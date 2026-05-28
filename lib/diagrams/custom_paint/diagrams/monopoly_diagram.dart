import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
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

class MonopolyDiagram extends BaseDiagramPainter {
  MonopolyDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
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
      case DiagramEnum.microMonopolyIncomeRedistribution:
        return _paintMonopolyIncomeRedistribution(c, canvas);
      default:
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
          Offset(0.25, 0.05),
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
          Offset(0.60, 0.85),
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
      demandLabel = DiagramLabel.dEqualsAR.label;
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
      label2Align: LabelAlign.right,
    );
    paintDiagramLines(
      c,
      canvas,

      startPos: Offset(0.03, 0.15),
      polylineOffsets: [Offset(0.75, 0.92)],
      label2: DiagramLabel.dEqualsAR.label,
      label2Align: LabelAlign.right,
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
        label2Align: LabelAlign.right,
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

  void _paintMonopolyIncomeRedistribution(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintAxis(c, canvas, axisType: AxisType.priceRevenueCosts);
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.32,
      xAxisEndPos: 0.30,
      yLabel: 'P(P>MC)',
      xLabel: 'Q\n(mc=mr)',
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.47,
      xAxisEndPos: 0.45,
      yLabel: 'P(P=MC)',
      hideXLine: true,
    );
    paintMarketCurve(c, canvas, type: MarketCurveType.dArMonopoly);
    paintMarketCurve(c, canvas, type: MarketCurveType.mrMonopoly);
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0.05, 0.90),
      polylineOffsets: [Offset(0.80, 0.10)],
      label2: DiagramLabel.mc.label,
      label2Align: LabelAlign.centerTop,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.a.label,
      Offset(0.07, 0.25),
      type: DiagramTextType.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.b.label,
      Offset(0.19, 0.25),
      type: DiagramTextType.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.c.label,
      Offset(0.07, 0.40),
      type: DiagramTextType.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.d.label,
      Offset(0.24, 0.40),
      type: DiagramTextType.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.e.label,
      Offset(0.34, 0.42),
      type: DiagramTextType.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.f.label,
      Offset(0.07, 0.52),
      type: DiagramTextType.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.g.label,
      Offset(0.28, 0.52),
      type: DiagramTextType.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.h.label,
      Offset(0.34, 0.52),
      type: DiagramTextType.label,
    );
  }
}
