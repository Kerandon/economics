import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_entry.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_helper.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_bundle_enum.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_methods/paint_text_2.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';

class TaxesAndSubsidies extends BaseDiagramPainter2 {
  TaxesAndSubsidies(super.config, super.diagramBundleEnum);

  @override
  void paint(Canvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);
    c.painterSize;

    switch (diagramBundleEnum) {
      case DiagramBundleEnum.microIndirectTax:
        _paintIndirectTax(c, canvas, size);
      case DiagramBundleEnum.microIndirectTaxInelasticPED:
        _paintIndirectTaxInelasticDemand(c, canvas, size);
      case DiagramBundleEnum.microIndirectTaxElasticPED:
        _paintIndirectTaxElasticDemand(c, canvas, size);
      case DiagramBundleEnum.microSubsidy:
        _paintSubsidy(c, canvas, size);
      case DiagramBundleEnum.microSubsidyInelasticPED:
        _paintSubsidyInelasticDemand(c, canvas, size);
      case DiagramBundleEnum.microSubsidyElasticPED:
        _paintSubsidyElasticDemand(c, canvas, size);
      default:
    }
  }
}

_paintIndirectTax(DiagramPainterConfig c, Canvas canvas, Size size) {
  paintLegendTable(
    canvas,
    c,
    headers: ['', DiagramLabel.freeMarket.label, 'Indirect Tax'],
    data: [
      [(DiagramLabel.consumerSurplus.label), 'A,B,C,D', '-B,-C,-D'],
      [(DiagramLabel.producerSurplus.label), 'E,F,G,H,I', '-E,-F,-G'],
      [
        (DiagramLabel.governmentBudget.label),
        '-',
        '+B,+C,+D,+E,+F,+G',
      ],
      [(DiagramLabel.socialWelfare.label), 'A,B,C,D,E,F,G,H,I', '-D,-G'],
    ],
  );
  paintShading(canvas, size, ShadeType.welfareLoss, [
    Offset(0.425, 0.43),
    Offset(0.55, 0.55),
    Offset(0.425, 0.68),
  ]);

  paintArrowHelper(
    c,
    canvas,
    origin: Offset(0.60, 0.38),
    angle: -pi / 2,
    length: 0.18,
  );
  paintText2(c, canvas, DiagramLabel.tax.label, Offset(0.66, 0.32));
  paintText2(c, canvas, DiagramLabel.a.label, Offset(0.15, 0.30));
  paintText2(c, canvas, DiagramLabel.b.label, Offset(0.15, 0.48));
  paintText2(c, canvas, DiagramLabel.c.label, Offset(0.38, 0.52));
  paintText2(c, canvas, DiagramLabel.d.label, Offset(0.46, 0.51));
  paintText2(c, canvas, DiagramLabel.e.label, Offset(0.15, 0.62));
  paintText2(c, canvas, DiagramLabel.f.label, Offset(0.38, 0.62));
  paintText2(c, canvas, DiagramLabel.g.label, Offset(0.46, 0.59));
  paintText2(c, canvas, DiagramLabel.h.label, Offset(0.05, 0.74));
  paintText2(c, canvas, DiagramLabel.i.label, Offset(0.25, 0.74));

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.price$.label,
    xAxisLabel: DiagramLabel.quantityUnits.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: DiagramLabel.dEqualsMB.label,
    lengthAdjustment: -kExtendBy15,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    horizontalShift: -kExtendBy10,
    verticalShift: -kExtendBy5,
    lengthAdjustment: -kExtendBy20,
    label: DiagramLabel.sTax.label,
    color: Colors.red,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: DiagramLabel.sEqualsMC.label,
    verticalShift: 0.10,
    lengthAdjustment: -kExtendBy15,
  );
  paintText2(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    Offset(0.75, 0.55),
    pointerLine: Offset(0.50, 0.55),
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.55,
    xAxisEndPos: 0.55,
    yLabel: DiagramLabel.pe.label,
    xLabel: DiagramLabel.qe.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.425,
    xAxisEndPos: 0.425,
    yLabel: DiagramLabel.pc.label,
    xLabel: DiagramLabel.qTax.label,
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.675,
    xAxisEndPos: 0.425,
    yLabel: DiagramLabel.pp.label,
    hideXLine: true,
    showDotAtIntersection: true,
  );
}

_paintIndirectTaxInelasticDemand(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
) {
  paintArrowHelper(
    c,
    canvas,
    origin: Offset(0.60, 0.41),
    angle: -pi / 2,
    length: 0.18,
  );
  paintText2(c, canvas, '\$3\nTax', Offset(0.66, 0.32));
  paintShading(canvas, size, ShadeType.consumerIncidence, [
    Offset(0, 0.40),
    Offset(0.46, 0.40),
    Offset(0.46, 0.58),
    Offset(0.0, 0.58),
  ], striped: true);
  paintShading(canvas, size, ShadeType.producerIncidence, [
    Offset(0, 0.58),
    Offset(0.46, 0.58),
    Offset(0.46, 0.64),
    Offset(0.0, 0.64),
  ], striped: true);
  paintLegend(canvas, size, [
    LegendEntry.fromShade(ShadeType.consumerIncidence),

    LegendEntry.fromShade(ShadeType.producerIncidence),
  ]);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.58,
    xAxisEndPos: 0.525,
    yLabel: '5.5',
    xLabel: '120',
  );

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.price$.label,
    xAxisLabel: DiagramLabel.quantityUnits.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    lengthAdjustment: -kExtendBy20,
    angle: 0.40,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    horizontalShift: -kExtendBy10,
    verticalShift: -kExtendBy5,
    lengthAdjustment: -kExtendBy20,
    label: DiagramLabel.sTax.label,
    color: Colors.red,
    angle: 0.10,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    verticalShift: 0.10,
    lengthAdjustment: -kExtendBy15,
    angle: 0.10,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.40,
    xAxisEndPos: 0.46,
    yLabel: '8',
    xLabel: '110    ',
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.64,
    xAxisEndPos: 0.46,
    yLabel: '5',
    hideXLine: true,
    showDotAtIntersection: true,
  );
}

_paintIndirectTaxElasticDemand(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
) {
  paintArrowHelper(
    c,
    canvas,
    origin: Offset(0.60, 0.38),
    angle: -pi / 2,
    length: 0.18,
  );
  paintText2(c, canvas, '\$3\nTax', Offset(0.66, 0.32));
  paintShading(canvas, size, ShadeType.consumerIncidence, [
    Offset(0, 0.47),
    Offset(0.39, 0.47),
    Offset(0.39, 0.53),
    Offset(0.0, 0.53),
  ], striped: true);
  paintShading(canvas, size, ShadeType.producerIncidence, [
    Offset(0, 0.53),
    Offset(0.39, 0.53),
    Offset(0.39, 0.71),
    Offset(0.0, 0.71),
  ], striped: true);
  paintLegend(canvas, size, [
    LegendEntry.fromShade(ShadeType.consumerIncidence),
    LegendEntry.fromShade(ShadeType.producerIncidence),
  ]);

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.price$.label,
    xAxisLabel: DiagramLabel.quantityUnits.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    lengthAdjustment: -kExtendBy15,
    angle: -0.50,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    horizontalShift: -kExtendBy10,
    verticalShift: -kExtendBy5,
    lengthAdjustment: -kExtendBy20,
    label: DiagramLabel.sTax.label,
    color: Colors.red,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    verticalShift: 0.10,
    lengthAdjustment: -kExtendBy15,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.53,
    xAxisEndPos: 0.58,
    yLabel: '5.5',
    xLabel: '120',
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.47,
    xAxisEndPos: 0.39,
    yLabel: '6',
    xLabel: '80',
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.71,
    xAxisEndPos: 0.38,
    yLabel: '3',
    hideXLine: true,showDotAtIntersection: true,
  );
}

void _paintSubsidy(DiagramPainterConfig c, Canvas canvas, Size size) {
  paintShading(canvas, size, ShadeType.welfareLoss, [
    Offset(0.55, 0.3),
    Offset(0.55, 0.55),
    Offset(0.42, 0.43),
  ]);

  paintText2(c, canvas, DiagramLabel.a.label, Offset(0.10, 0.22));
  paintText2(c, canvas, DiagramLabel.b.label, Offset(0.10, 0.36));
  paintText2(c, canvas, DiagramLabel.c.label, Offset(0.42, 0.34));
  paintText2(c, canvas, DiagramLabel.d.label, Offset(0.10, 0.48));
  paintText2(c, canvas, DiagramLabel.e.label, Offset(0.40, 0.50));
  paintText2(c, canvas, DiagramLabel.f.label, Offset(0.50, 0.42));
  paintText2(c, canvas, DiagramLabel.g.label, Offset(0.46, 0.50));
  paintText2(c, canvas, DiagramLabel.h.label, Offset(0.10, 0.62));
  paintArrowHelper(
    c,
    canvas,
    origin: Offset(0.70, 0.26),
    angle: pi / 2,
    length: 0.18,
  );
  paintText2(c, canvas, 'Subsidy', Offset(0.80, 0.170));
  paintLegendTable(
    canvas,
    c,
    headers: ['', DiagramLabel.freeMarket.label, 'Subsidy'],
    data: [
      [(DiagramLabel.consumerSurplus.label), 'A,B', '+D,+E,+G'],
      [(DiagramLabel.producerSurplus.label), 'D,H', '+B,+C'],
      [(DiagramLabel.governmentBudget.label), '-', '-B,-C,-D,-E,-F,-G'],
      [
        (DiagramLabel.socialWelfare.label),
        'A,B,D,H',
        '-F',
      ],
    ],
  );

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.price$.label,
    xAxisLabel: DiagramLabel.quantityUnits.label,
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
    horizontalShift: kExtendBy5,
    verticalShift: kExtendBy5,
    lengthAdjustment: -kExtendBy10,
    label: DiagramLabel.sSub.label,
    color: Colors.red,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: DiagramLabel.sEqualsMC.label,
    horizontalShift: -kExtendBy5,
    verticalShift: -kExtendBy10,
    lengthAdjustment: -kExtendBy10,
  );  paintText2(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    Offset(0.85, 0.45),
    pointerLine: Offset(0.53, 0.45),
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.55,
    xAxisEndPos: 0.55,
    yLabel: DiagramLabel.pc.label,
    hideXLine: true,showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.425,
    xAxisEndPos: 0.425,
    yLabel: DiagramLabel.pe.label,
    xLabel: DiagramLabel.qe.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.55,
    yLabel: DiagramLabel.pp.label,
    xLabel: DiagramLabel.qSub.label,
    showDotAtIntersection: true,
  );
}

void _paintSubsidyInelasticDemand(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
) {

  paintShading(canvas, size, ShadeType.producerIncidence, [
    Offset(0, 0.325),
    Offset(0.52, 0.325),
    Offset(0.52, 0.38),
    Offset(0.0, 0.38),
  ], striped: true);
  paintShading(canvas, size, ShadeType.consumerIncidence, [
    Offset(0, 0.38),
    Offset(0.52, 0.38),
    Offset(0.52, 0.575),
    Offset(0.0, 0.575),
  ], striped: true);
  paintArrowHelper(
    c,
    canvas,
    origin: Offset(0.70, 0.26),
    angle: pi / 2,
    length: 0.18,
  );
  paintText2(c, canvas, 'Subsidy', Offset(0.80, 0.170));

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.price$.label,
    xAxisLabel: DiagramLabel.quantityUnits.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    horizontalShift: kExtendBy5,
    verticalShift: kExtendBy5,
    lengthAdjustment: -kExtendBy10,
    label: DiagramLabel.sSub.label,
    color: Colors.red,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: DiagramLabel.s.label,
    horizontalShift: -kExtendBy5,
    verticalShift: -kExtendBy10,
    lengthAdjustment: -kExtendBy10,
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.demand, angle: 0.50, lengthAdjustment: -kExtendBy20);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.575,
    xAxisEndPos: 0.52,
    yLabel: DiagramLabel.pc.label,
    hideXLine: true,showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.38,
    xAxisEndPos: 0.465,
    yLabel: DiagramLabel.pe.label,
    xLabel: '${DiagramLabel.qe.label}   ',hideYLine: true, hideXLine: true
  );

  paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.325,
      xAxisEndPos: 0.465, hideYLine: true
  );


  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.38,
    xAxisEndPos: 0.52, hideXLine: true);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.325,
    xAxisEndPos: 0.52,
    yLabel: DiagramLabel.pp.label,
    xLabel: '      ${DiagramLabel.qSub.label}',
    showDotAtIntersection: true,
  );
  paintLegend(canvas, size, [
    LegendEntry.fromShade(ShadeType.consumerIncidence),
    LegendEntry.fromShade(ShadeType.producerIncidence),

  ]);
}

void _paintSubsidyElasticDemand(
  DiagramPainterConfig c,
  Canvas canvas,
  Size size,
) {
  paintShading(canvas, size, ShadeType.producerIncidence, [
    Offset(0, 0.27),
    Offset(0.58, 0.27),
    Offset(0.58, 0.465),
    Offset(0.0, 0.465),
  ], striped: true);
  paintShading(canvas, size, ShadeType.consumerIncidence, [
    Offset(0, 0.465),
    Offset(0.58, 0.465),
    Offset(0.58, 0.52),
    Offset(0.0, 0.52),
  ], striped: true);
  paintArrowHelper(
    c,
    canvas,
    origin: Offset(0.70, 0.26),
    angle: pi / 2,
    length: 0.18,
  );
  paintText2(c, canvas, 'Subsidy', Offset(0.80, 0.170));

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.price$.label,
    xAxisLabel: DiagramLabel.quantityUnits.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    horizontalShift: kExtendBy5,
    verticalShift: kExtendBy5,
    lengthAdjustment: -kExtendBy10,
    label: DiagramLabel.sSub.label,
    color: Colors.red,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: DiagramLabel.s.label,
    horizontalShift: -kExtendBy5,
    verticalShift: -kExtendBy10,
    lengthAdjustment: -kExtendBy10,
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.demand, angle: -0.50, lengthAdjustment: -kExtendBy20);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.52,
    xAxisEndPos: 0.58,
    yLabel: DiagramLabel.pc.label,
    hideXLine: true,showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.465,
      xAxisEndPos: 0.58,
       hideXLine: true
  );

  paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.465,
      xAxisEndPos: 0.385,
      yLabel: DiagramLabel.pe.label,
      xLabel: DiagramLabel.qe.label,
    hideYLine: true,
  );


  paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.465,
      xAxisEndPos: 0.52, hideXLine: true);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.27,
    xAxisEndPos: 0.58,
    yLabel: DiagramLabel.pp.label,
    xLabel: '      ${DiagramLabel.qSub.label}',
    showDotAtIntersection: true,
  );
  paintLegend(canvas, size, [
    LegendEntry.fromShade(ShadeType.consumerIncidence),
    LegendEntry.fromShade(ShadeType.producerIncidence),

  ]);
}
