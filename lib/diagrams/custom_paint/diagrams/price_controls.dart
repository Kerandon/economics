import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/label_align.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_legend_table.dart';
import '../painter_methods/paint_line_segment.dart';

class PriceControls extends BaseDiagramPainter2 {
  PriceControls(super.config, super.bundle);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (bundle) {
      case DiagramBundleEnum.microPriceCeiling:
        _paintPriceCeiling(c, canvas, size);
      case DiagramBundleEnum.microPriceFloor:
        _paintPriceFloor(c, canvas, size);
      case DiagramBundleEnum.microNationalMinimumWage || DiagramBundleEnum.microNationalMinimumWageWelfare:
        _paintNMW(c, canvas, size, bundle);
      case DiagramBundleEnum.microNationalMinimumWageInelasticDemandAndSupply:
        _paintNMWInelasticDemand(c, canvas, size);
      case DiagramBundleEnum.microAgriculturalPriceFloor:
        _paintAgriculturalPriceFloor(c, canvas, size);
      default:
    }
  }
}

void _paintPriceCeiling(DiagramPainterConfig c, Canvas canvas, Size size) {
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.50, 1.1),
    angle: 0,
    labelAlign: LabelAlign.centerBottom,
    length: 0.5,
    label: DiagramLabel.shortageQdMinusQs.label,
    endStyle: LineEndStyle.arrowRightAngles,
  );
  paintLegendTable(
    canvas,
    c,
    headers: ['', DiagramLabel.freeMarket.label, (DiagramLabel.priceCeiling.label)
    ],
    data: [
      [(DiagramLabel.consumerSurplus.label), '+(A,B)', '+(A,C)'],
      [(DiagramLabel.producerSurplus.label), '+(C,D,E)', '+E'],
      [(DiagramLabel.socialWelfare.label), '+(A,B,C,D,E)', '+(A,C,E) -(B,D)'],
    ],
  );
  paintShading(canvas, size, ShadeType.welfareLoss, [
    Offset(0.25, 0.75),
    Offset(0.25, 0.25),
    Offset(0.5, 0.50),
  ]);

  paintText2(c, canvas, DiagramLabel.a.label, Offset(0.12, 0.40));
  paintText2(c, canvas, DiagramLabel.b.label, Offset(0.33, 0.40));
  paintText2(c, canvas, DiagramLabel.c.label, Offset(0.12, 0.60));
  paintText2(c, canvas, DiagramLabel.d.label, Offset(0.33, 0.60));
  paintText2(c, canvas, DiagramLabel.e.label, Offset(0.12, 0.82));

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.price.label,
    xAxisLabel: DiagramLabel.quantity.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,

    label: DiagramLabel.dEqualsMB.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,

    label: DiagramLabel.sEqualsMC.label,
  );
  paintDiagramLines(
    c,
    canvas,
    color: Colors.red,
    label1: DiagramLabel.pc.label,
    label1Align: LabelAlign.centerLeft,
    startPos: Offset(0.0, 0.75),
    polylineOffsets: [Offset(1.0, 0.75)],
  );
  paintText2(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    Offset(0.75, 0.50),
    pointerLine: Offset(0.40, 0.50),
  );  paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.25,
      xAxisEndPos: 0.25,
      hideYLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.75,
    xAxisEndPos: 0.25,
    xLabel: DiagramLabel.qSStar.label,

    hideYLine: true,
    addDotAtIntersection: true
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.75,
    xAxisEndPos: 0.75,
    xLabel: DiagramLabel.qD.label,
    addDotAtIntersection: true,
    hideYLine: true
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.pe.label,
    xLabel: DiagramLabel.qe.label,

  );
}

void _paintPriceFloor(DiagramPainterConfig c, Canvas canvas, Size size){
  paintShading(canvas, size, ShadeType.welfareLoss, [
    Offset(0.25, 0.75),
    Offset(0.25, 0.25),
    Offset(0.5, 0.50),
  ]);
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.50, 0.20),
    angle: 0,
    labelAlign: LabelAlign.centerTop,
    length: 0.5,
    label: DiagramLabel.surplusQsMinusQd.label,
    endStyle: LineEndStyle.arrowRightAngles,
  );

  paintLegendTable(
    canvas,
    c,
    headers: ['', 'Free Market', 'Price Floor'],
    data: [
      [(DiagramLabel.consumerSurplus.label), 'A,B,C', '-B,-C'],
      [(DiagramLabel.producerSurplus.label), 'D,E', '+B,-E'],
      [(DiagramLabel.socialWelfare.label), 'A,B,C,D,E', '-C,-E'],
    ],
  );

  paintText2(c, canvas, DiagramLabel.a.label, Offset(0.12, 0.18));
  paintText2(c, canvas, DiagramLabel.b.label, Offset(0.12, 0.38));
  paintText2(c, canvas, DiagramLabel.c.label, Offset(0.32, 0.42));
  paintText2(c, canvas, DiagramLabel.d.label, Offset(0.12, 0.62));
  paintText2(c, canvas, DiagramLabel.e.label, Offset(0.32, 0.60));

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.price.label,
    xAxisLabel: DiagramLabel.quantity.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,

    label: DiagramLabel.dEqualsMB.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,

    label: DiagramLabel.sEqualsMC.label,
  );
  paintDiagramLines(
    c,
    canvas,
    color: Colors.red,
    label1: DiagramLabel.pf.label,
    label1Align: LabelAlign.centerLeft,
    startPos: Offset(0.0, 0.25),
    polylineOffsets: [Offset(1.0, 0.25)],
  );

  paintText2(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    Offset(0.70, 0.50),
    pointerLine: Offset(0.40, 0.50),
  );

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.25,
    xAxisEndPos: 0.25,
    xLabel: DiagramLabel.qDStar.label,
    hideYLine: true,
    addDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.25,
    xAxisEndPos: 0.75,
    xLabel: DiagramLabel.qS.label,
    addDotAtIntersection: true,
    hideYLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.pe.label,
    xLabel: DiagramLabel.qe.label,
  );
}

void _paintNMW(DiagramPainterConfig c, Canvas canvas, Size size, DiagramBundleEnum bundle) {

  if(bundle == DiagramBundleEnum.microNationalMinimumWageWelfare){
    paintText2(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.85, 0.50),
      pointerLine: Offset(0.40, 0.50),
    );
    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.30, 0.70),
      Offset(0.30, 0.30),
      Offset(0.5, 0.50),
    ]);
    paintLegendTable(
      canvas,
      c,
      headers: ['', 'Free Market', 'NMW'],
      data: [
        ['Consumer Surplus (Firms)', '+(A,B,C)', '+A'],
        ['Producer Surplus (Labor)', '+(D,E)', '+(B,D)'],
        [(DiagramLabel.socialWelfare.label), '+(A,B,C,D,E)', '+(A,B,D) -(C,E)'],
      ],
    );

    paintText2(c, canvas, DiagramLabel.a.label, Offset(0.12, 0.18));
    paintText2(c, canvas, DiagramLabel.b.label, Offset(0.12, 0.38));
    paintText2(c, canvas, DiagramLabel.c.label, Offset(0.35, 0.42));
    paintText2(c, canvas, DiagramLabel.d.label, Offset(0.12, 0.62));
    paintText2(c, canvas, DiagramLabel.e.label, Offset(0.35, 0.57));
  }
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.we.label,
    xLabel: DiagramLabel.qe.label,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.55),
    color: Colors.red,
    bezierPoints: [
      CustomBezier(endPoint: Offset(0.0, 0.60)),
      CustomBezier(endPoint: Offset(0.0, 0.65)),
    ],
  );

  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.50, 0.25),
    endStyle: LineEndStyle.arrowRightAngles,
    label: DiagramLabel.surplusLaborUnemployment.label,
    labelAlign: LabelAlign.centerTop,
    length: 0.40,
  );

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.wageRate.label,
    xAxisLabel: DiagramLabel.quantityOfLabor.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,

    label: DiagramLabel.dL.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,

    label: DiagramLabel.sL.label,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.30),
    polylineOffsets: [Offset(1.0, 0.30)],
    label1: DiagramLabel.nmw.label,
    label1Align: LabelAlign.centerLeft,
    color: Colors.red,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.30,
    hideYLine: true,
    xLabel: DiagramLabel.qDStar.label,
    addDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.70,
    hideYLine: true,
    xLabel: DiagramLabel.qS.label,
    addDotAtIntersection:
      true,
  );

}

void _paintNMWInelasticDemand(DiagramPainterConfig c, Canvas canvas, Size size) {
  paintText2(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    Offset(0.85, 0.50),
    pointerLine: Offset(0.46, 0.50),
  );
    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.44, 0.65),
      Offset(0.44, 0.30),
      Offset(0.5, 0.50),
    ]);

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.we.label,
    xLabel: DiagramLabel.qe.label,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0.0, 0.55),
    color: Colors.red,
    bezierPoints: [
      CustomBezier(endPoint: Offset(0.0, 0.60)),
      CustomBezier(endPoint: Offset(0.0, 0.65)),
    ],
  );

  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.515, 0.22),
    endStyle: LineEndStyle.arrowRightAngles,
    label: 'Surplus Labor',
    labelAlign: LabelAlign.centerTop,
    length: 0.12,
  );

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.wageRate.label,
    xAxisLabel: DiagramLabel.quantityOfLabor.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,

    label: DiagramLabel.dL.label,
    angle: 0.50,
      lengthAdjustment: -kExtendBy15
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,

    label: DiagramLabel.sL.label,
    angle: -0.40,
      lengthAdjustment: -kExtendBy15
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.30),
    polylineOffsets: [Offset(1.0, 0.30)],
    label1: DiagramLabel.nmw.label,
    label1Align: LabelAlign.centerLeft,
    color: Colors.red,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.44,
    hideYLine: true,
    xLabel: '${DiagramLabel.qDStar.label}       ',
    addDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.58,
    hideYLine: true,
    xLabel: DiagramLabel.qS.label,
    addDotAtIntersection:
    true,
  );

}
void _paintAgriculturalPriceFloor(DiagramPainterConfig c, Canvas canvas, Size size) {
  paintText2(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    Offset(0.90, 0.50),
    pointerLine: Offset(0.65, 0.50),
  );
  paintShading(canvas, size, ShadeType.welfareLoss, [
    Offset(0.30, 0.30),
    Offset(0.30, 1.0),
    Offset(0.70, 1.0),
    Offset(0.70, 0.30),
    Offset(0.50,0.50)
  ]);
  paintLegendTable(
    canvas,
    c,
    headers: ['', DiagramLabel.freeMarket.label, DiagramLabel.priceFloorAgri.label],
    data: [
      [(DiagramLabel.consumerSurplus.label), '+(A,B,C)', '+A'],
      [(DiagramLabel.producerSurplus.label), '+(D,E)', '+(B,C,D,E,F)'],
      [(DiagramLabel.governmentBudget.label), '-', '-(C,D,E,F,G,H,I)'],
      [(DiagramLabel.socialWelfare.label), '+(A,B,C,D,E)', '+(A,B,D) -(C,-E,-G,-H,-I)'],
    ],
  );

  paintLineSegment(c, canvas, origin: Offset(0.50,0.24), endStyle: LineEndStyle.arrowRightAngles, length: 0.40,
  label: DiagramLabel.governmentBoughtSurplusQsMinusQd.label, labelAlign: LabelAlign.centerTop
  );
  paintLineSegment(c, canvas, origin: Offset(0.15,1.10), endStyle: LineEndStyle.arrowRightAngles, length: 0.28,
      label: DiagramLabel.freeMarket.label, labelAlign: LabelAlign.centerBottom
  );
  paintLineSegment(c, canvas, origin: Offset(0.50,1.10), endStyle: LineEndStyle.arrowRightAngles, length: 0.40,
      label: DiagramLabel.government.label, labelAlign: LabelAlign.centerBottom
  );
  /// Letters
  paintText2(c, canvas, DiagramLabel.a.label, Offset(0.12, 0.20));
  paintText2(c, canvas, DiagramLabel.b.label, Offset(0.12, 0.40));
  paintText2(c, canvas, DiagramLabel.c.label, Offset(0.35, 0.42));
  paintText2(c, canvas, DiagramLabel.d.label, Offset(0.12, 0.60));
  paintText2(c, canvas, DiagramLabel.e.label, Offset(0.35, 0.58));
  paintText2(c, canvas, DiagramLabel.f.label, Offset(0.50, 0.38));
  paintText2(c, canvas, DiagramLabel.g.label, Offset(0.40, 0.80));
  paintText2(c, canvas, DiagramLabel.h.label, Offset(0.60, 0.80));
  paintText2(c, canvas, DiagramLabel.i.label, Offset(0.60, 0.50));

  ///Diagram Dashed Lines
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.pe.label,
    xLabel: DiagramLabel.qe.label,
  );
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.price$.label,
    xAxisLabel: DiagramLabel.quantity.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,

    label: DiagramLabel.dEqualsMB.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,

    label: DiagramLabel.sEqualsMC.label,
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.30),
    polylineOffsets: [Offset(1.0, 0.30)],
    label1: DiagramLabel.pf.label,
    label1Align: LabelAlign.centerLeft,
    color: Colors.red,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.30,
    hideYLine: true,
    xLabel: DiagramLabel.qD.label,
    addDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.70,
    hideYLine: true,
    xLabel: DiagramLabel.qSStar.label,
    addDotAtIntersection: true,
  );
}
