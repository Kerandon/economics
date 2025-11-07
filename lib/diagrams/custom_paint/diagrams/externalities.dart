import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';

import '../../enums/diagram_bundle_enum.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';

class Externalities extends BaseDiagramPainter2 {
  Externalities(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    c.painterSize;
    paintAxis(c, canvas, yAxisLabel: DiagramLabel.price.label,xAxisLabel: DiagramLabel.quantityUnits.label);
    switch (diagramBundleEnum) {
      case DiagramBundleEnum.microNegativeConsumptionExternalityWelfare:
        _paintNegativeConsumptionWelfare(c, canvas, size);
      case DiagramBundleEnum.microNegativeProductionExternalityWelfare:
        _paintNegativeProductionWelfare(c, canvas, size);
      case DiagramBundleEnum.microPositiveConsumptionExternalityWelfare:
        _paintPositiveConsumptionWelfare(c, canvas, size);
      case DiagramBundleEnum.microPositiveProductionExternalityWelfare:
        _paintPositiveProductionWelfare(c, canvas, size);
      default:
    }
  }
}

void _paintNegativeConsumptionWelfare(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
) {


}

void _paintNegativeProductionWelfare(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
) {}

void _paintPositiveConsumptionWelfare(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
) {
  paintLegendTable(canvas, c, headers: ['', DiagramLabel.freeMarket.label, DiagramLabel.sociallyOptimumOutput.label], data: [
    [DiagramLabel.consumerSurplus.label, '+(B,D)', '+(A,B,C)'],
    [DiagramLabel.producerSurplus.label, '+(G)', '+(D,E,F,G)'],
    [DiagramLabel.externalBenefits.label, '+(A,E)', '-'],
    [DiagramLabel.socialWelfare.label, '+(A,B,D,E,G)', '+(A,B,C,D,E,F,G)'],
    [DiagramLabel.welfareLoss.label, '-(C,F)', '-'],
  ]);
  paintShading(canvas, size, ShadeType.welfareLoss, [Offset(0.305,0.37),Offset(0.305, 0.61),Offset(0.46,0.50)]);
  paintText2(c, canvas, DiagramLabel.welfareLoss.label, Offset(0.45,0.30), pointerLine: Offset(0.40,0.50));
  paintText2(c, canvas, DiagramLabel.a.label, Offset(0.10,0.30));
  paintText2(c, canvas, DiagramLabel.b.label, Offset(0.05,0.45));
  paintText2(c, canvas, DiagramLabel.c.label, Offset(0.35,0.45));
  paintText2(c, canvas, DiagramLabel.d.label, Offset(0.10,0.55));
  paintText2(c, canvas, DiagramLabel.e.label, Offset(0.26,0.53));
  paintText2(c, canvas, DiagramLabel.f.label, Offset(0.35,0.54));
  paintText2(c, canvas, DiagramLabel.g.label, Offset(0.10,0.70));
  paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.61, xAxisEndPos: 0.305,
    yLabel: DiagramLabel.pm.label, xLabel: DiagramLabel.qm.label,
    hideXLine: true,
  );
  paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.39, xAxisEndPos: 0.305,
    hideYLine: true,
  );
  paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.495, xAxisEndPos: 0.455,
      yLabel: DiagramLabel.pOpt.label, xLabel: DiagramLabel.qOpt.label
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.demand, label: DiagramLabel.msb.label, horizontalShift: -0.04,
      lengthAdjustment: kExtendBy5, angle: -0.10
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.demand, label: DiagramLabel.dEqualsMPB.label, horizontalShift: -0.15,
      verticalShift: kExtendBy15,
      lengthAdjustment: -kExtendBy20, angle: -0.10
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.supply, label: DiagramLabel.sEqualsMPCMSC.label, angle: 0.12,
      horizontalShift: -0.05);
  paintLineSegment(c, canvas, origin: Offset(0.65,0.775), angle: -pi/2, length: 0.16,endStyle:LineEndStyle.arrowBothEnds);
  paintText2(c, canvas, DiagramLabel.externalBenefits.label, Offset(0.90,0.68),
      pointerLine: Offset(0.65,0.78));



}




void _paintPositiveProductionWelfare(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
) {
  paintLegendTable(canvas, c, headers: ['', DiagramLabel.freeMarket.label, DiagramLabel.sociallyOptimumOutput.label], data: [
    [DiagramLabel.consumerSurplus.label, '+A', '+(A,B,C,D)'],
    [DiagramLabel.producerSurplus.label, '+(B,E)', '+(B,E)'],
    [DiagramLabel.externalBenefits.label, '+(F,C)', '-'],
    [DiagramLabel.socialWelfare.label, '+(A,B,E,F,C)', '+(A,B,C,D,E,F,G)'],
    [DiagramLabel.welfareLoss.label, '-(D,G)', '-'],
  ]);
  paintShading(canvas, size, ShadeType.welfareLoss, [Offset(0.40,0.42),Offset(0.40, 0.635),Offset(0.54,0.53)]);
  paintText2(c, canvas, DiagramLabel.welfareLoss.label, Offset(0.46,0.20), pointerLine: Offset(0.46,0.50));
  paintText2(c, canvas, DiagramLabel.a.label, Offset(0.15,0.32));
  paintText2(c, canvas, DiagramLabel.b.label, Offset(0.15,0.47));
  paintText2(c, canvas, DiagramLabel.c.label, Offset(0.37,0.49));
  paintText2(c, canvas, DiagramLabel.d.label, Offset(0.43,0.49));
  paintText2(c, canvas, DiagramLabel.e.label, Offset(0.08,0.60));
  paintText2(c, canvas, DiagramLabel.f.label, Offset(0.26,0.65));
  paintText2(c, canvas, DiagramLabel.g.label, Offset(0.43,0.56));
  paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.63, xAxisEndPos: 0.40,
   xLabel: DiagramLabel.qm.label,
    hideXLine: true,
    hideYLine: true,
  );
  paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.42, xAxisEndPos: 0.40,
    hideXLine: true, yLabel: DiagramLabel.pm.label,
  );
  paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.42, xAxisEndPos: 0.40,
    hideYLine: true,
  );
  paintDiagramDashedLines(c, canvas, yAxisStartPos: 0.53, xAxisEndPos: 0.535,
      yLabel: DiagramLabel.pOpt.label, xLabel: DiagramLabel.qOpt.label
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.demand, label: DiagramLabel.dEqualsMPBMSB.label, horizontalShift: -0.06,
      verticalShift: -kExtendBy5,
      lengthAdjustment: 0, angle: -0.10
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.supply, label: DiagramLabel.sEqualsMPC.label, angle: 0.12,
      horizontalShift: -0.10, verticalShift: -0.080, lengthAdjustment: -kExtendBy10);
  paintMarketCurve(c, canvas, type: MarketCurveType.supply, label: DiagramLabel.msc.label, angle: 0.12,
      horizontalShift: -0.05, verticalShift: kExtendBy10);
  paintLineSegment(c, canvas, origin: Offset(0.65,0.333), angle: -pi/2, length: 0.16,endStyle:LineEndStyle.arrowBothEnds);
  paintText2(c, canvas, DiagramLabel.externalBenefits.label, Offset(0.90,0.45),
      pointerLine: Offset(0.65,0.33));
}
