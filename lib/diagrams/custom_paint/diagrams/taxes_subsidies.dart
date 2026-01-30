import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_entry.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_labels.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_methods/paint_text_2.dart';
import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';

class TaxesSubsidies extends BaseDiagramPainter3 {
  TaxesSubsidies(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,

      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
    );

    switch (diagram) {
      case DiagramEnum.microIndirectTax:
        _paintIndirectTax(c, canvas, size);
      case DiagramEnum.microIndirectTaxInelasticPED:
        _paintIndirectTaxInelasticDemand(c, canvas);
      case DiagramEnum.microIndirectTaxElasticPED:
        _paintIndirectTaxElasticDemand(c, canvas);
      case DiagramEnum.microSubsidy:
        _paintSubsidy(c, canvas);
      case DiagramEnum.microSubsidyInelasticPED:
        _paintSubsidyInelasticDemand(c, canvas);
      case DiagramEnum.microSubsidyElasticPED:
        _paintSubsidyElasticDemand(c, canvas);
      default:
    }
  }

  // --- INDIRECT TAX METHODS ---

  void _paintIndirectTax(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    Size size,
  ) {
    // Tax Vertical Bracket
    paintLineSegment(
      c,
      canvas,

      origin: const Offset(0.60, 0.39),
      angle: -pi / 2,
      length: 0.18,
    );
    paintText2(c, canvas, DiagramLabel.tax.label, const Offset(0.66, 0.32));

    // Surplus Area Labels
    final labels = {
      DiagramLabel.a: const Offset(0.15, 0.30),
      DiagramLabel.b: const Offset(0.15, 0.48),
      DiagramLabel.c: const Offset(0.38, 0.52),
      DiagramLabel.d: const Offset(0.46, 0.51),
      DiagramLabel.e: const Offset(0.15, 0.62),
      DiagramLabel.f: const Offset(0.38, 0.62),
      DiagramLabel.g: const Offset(0.46, 0.59),
      DiagramLabel.h: const Offset(0.05, 0.74),
      DiagramLabel.i: const Offset(0.25, 0.74),
    };
    labels.forEach(
      (label, offset) => paintText2(c, canvas, label.label, offset),
    );

    // Curves
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
      horizontalShift: -kExtendBy10,
      verticalShift: -kExtendBy5,
      label: DiagramLabel.sTax.label,
      color: Colors.red,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      label: DiagramLabel.sEqualsMC.label,
      verticalShift: 0.10,
    );

    // Equilibrium Intersections
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.55,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
      showDotAtIntersection: true,
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
    paintLegendTable(
      canvas,
      c,

      headers: ['', 'No Tax', 'Tax'],
      data: [
        ['Consumer', '+(a,b,c,d)', '+a'],
        ['Producer', '+(e,f,g,h,i)', '+h'],
        ['Government', '-', '+(b,c,e,f)'],
        ['Welfare loss', '-', '-(d,g)'],
      ],
    );
  }

  void _paintIndirectTaxInelasticDemand(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintShading(c, canvas, ShadeType.consumerIncidence, [
      const Offset(0, 0.40),
      const Offset(0.46, 0.40),
      const Offset(0.46, 0.58),
      const Offset(0.0, 0.58),
    ], striped: true);
    paintShading(c, canvas, ShadeType.producerIncidence, [
      const Offset(0, 0.58),
      const Offset(0.46, 0.58),
      const Offset(0.46, 0.64),
      const Offset(0.0, 0.64),
    ], striped: true);

    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.demand,
      lengthAdjustment: -kExtendBy10,
      angle: 0.40,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      horizontalShift: -kExtendBy10,
      verticalShift: -kExtendBy5,
      label: DiagramLabel.sTax.label,
      color: Colors.red,
      angle: 0.10,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      verticalShift: 0.10,
      angle: 0.10,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.58,
      xAxisEndPos: 0.53,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.40,
      xAxisEndPos: 0.46,
      yLabel: DiagramLabel.pc.label,
      xLabel: '${DiagramLabel.qTax.label}  ',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.64,
      xAxisEndPos: 0.46,
      yLabel: DiagramLabel.pp.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.consumerBurden.label,
      Offset(0.20, 0.30),
      pointerLine: Offset(0.20, 0.50),
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.producerBurden.label,
      Offset(0.80, 0.60),
      pointerLine: Offset(0.40, 0.60),
    );
  }

  // --- SUBSIDY METHODS ---

  void _paintSubsidy(DiagramPainterConfig c, IDiagramCanvas canvas) {
    // Labels A-H
    paintText2(c, canvas, DiagramLabel.a.label, const Offset(0.10, 0.22));
    paintText2(c, canvas, DiagramLabel.b.label, const Offset(0.10, 0.36));
    paintText2(c, canvas, DiagramLabel.c.label, const Offset(0.42, 0.36));
    paintText2(
      c,
      canvas,
      DiagramLabel.d.label.toLowerCase(),
      const Offset(0.10, 0.49),
    );
    paintText2(c, canvas, DiagramLabel.e.label, const Offset(0.39, 0.51));
    paintText2(c, canvas, DiagramLabel.f.label, const Offset(0.46, 0.51));
    paintText2(c, canvas, DiagramLabel.g.label, const Offset(0.50, 0.42));
    paintText2(c, canvas, DiagramLabel.h.label, const Offset(0.10, 0.62));
    paintLineSegment(
      c,
      canvas,

      origin: const Offset(0.70, 0.26),
      angle: pi / 2,
      length: 0.18,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.subsidy.label,
      const Offset(0.795, 0.165),
    );

    paintMarketCurve(c, canvas, type: MarketCurveType.demand);
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      horizontalShift: kExtendBy5,
      verticalShift: kExtendBy5,
      label: DiagramLabel.sSub.label,
      color: Colors.red,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      horizontalShift: -kExtendBy5,
      verticalShift: -kExtendBy10,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.55,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.pc.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.425,
      xAxisEndPos: 0.425,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
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
    paintLegendTable(
      canvas,
      c,

      headers: ['', 'No Subsidy', 'Subsidy'],
      data: [
        ['Consumer', '+(a,b)', '+(a,b,d,e,f)'],
        ['Producer', '+(d,h)', '+(b,c,d,h)'],
        ['Government', '-', '-(b,c,e,f,g)'],
        ['Welfare loss', '-', '-g'],
      ],
    );
  }

  void _paintSubsidyInelasticDemand(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintShading(c, canvas, ShadeType.producerGain, [
      const Offset(0, 0.325),
      const Offset(0.52, 0.325),
      const Offset(0.52, 0.38),
      const Offset(0.0, 0.38),
    ], striped: true);
    paintShading(c, canvas, ShadeType.consumerGain, [
      const Offset(0, 0.38),
      const Offset(0.52, 0.38),
      const Offset(0.52, 0.575),
      const Offset(0.0, 0.575),
    ], striped: true);

    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.demand,
      angle: 0.50,
      lengthAdjustment: -kExtendBy20,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      horizontalShift: kExtendBy5,
      verticalShift: kExtendBy5,
      color: Colors.red,
      label: DiagramLabel.sSub.label,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      horizontalShift: -0.05,
      verticalShift: -0.10,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.575,
      xAxisEndPos: 0.52,
      yLabel: DiagramLabel.pc.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.325,
      xAxisEndPos: 0.52,
      yLabel: DiagramLabel.pp.label,
      xLabel: ' ${DiagramLabel.qSub.label}',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.38,
      xAxisEndPos: 0.52,
      hideYLine: true,
      hideXLine: true,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.38,
      xAxisEndPos: 0.465,
      hideXLine: true,
      hideYLine: true,
      showDotAtIntersection: true,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.consumerGain.label,
      Offset(0.20, 0.20),

      pointerLine: Offset(0.20, 0.35),
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.producerGain.label,
      Offset(0.75, 0.60),

      pointerLine: Offset(0.40, 0.50),
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.38,
      xAxisEndPos: 0.52,
      hideXLine: true,
      yLabel: DiagramLabel.pE.label,
    );
  }

  // ✅ ADDED: Elastic Tax Variant
  void _paintIndirectTaxElasticDemand(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintShading(c, canvas, ShadeType.consumerIncidence, [
      const Offset(0, 0.47),
      const Offset(0.39, 0.47),
      const Offset(0.39, 0.53),
      const Offset(0.0, 0.53),
    ], striped: true);
    paintShading(c, canvas, ShadeType.producerIncidence, [
      const Offset(0, 0.53),
      const Offset(0.39, 0.53),
      const Offset(0.39, 0.71),
      const Offset(0.0, 0.71),
    ], striped: true);

    paintLegend(canvas, config: c, [
      LegendEntry.fromShade(ShadeType.consumerBurden),
      LegendEntry.fromShade(ShadeType.producerBurden),
    ]);

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
      label: DiagramLabel.sTax.label,
      color: Colors.red,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      verticalShift: 0.10,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.53,
      xAxisEndPos: 0.58,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.47,
      xAxisEndPos: 0.39,
      yLabel: DiagramLabel.pc.label,
      xLabel: DiagramLabel.qTax.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.71,
      xAxisEndPos: 0.39,
      yLabel: DiagramLabel.pp.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
  }

  // ✅ ADDED: Elastic Subsidy Variant
  void _paintSubsidyElasticDemand(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
  ) {
    paintShading(c, canvas, ShadeType.producerGain, [
      const Offset(0, 0.27),
      const Offset(0.58, 0.27),
      const Offset(0.58, 0.465),
      const Offset(0.0, 0.465),
    ], striped: true);
    paintShading(c, canvas, ShadeType.consumerGain, [
      const Offset(0, 0.465),
      const Offset(0.58, 0.465),
      const Offset(0.58, 0.52),
      const Offset(0.0, 0.52),
    ], striped: true);

    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.demand,
      angle: -0.50,
      lengthAdjustment: -kExtendBy20,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      horizontalShift: kExtendBy5,
      verticalShift: kExtendBy5,
      color: Colors.red,
      label: DiagramLabel.sSub.label,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      label: DiagramLabel.s.label,
      horizontalShift: -kExtendBy5,
      verticalShift: -kExtendBy10,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.52,
      xAxisEndPos: 0.58,
      yLabel: DiagramLabel.pc.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.27,
      xAxisEndPos: 0.58,
      yLabel: DiagramLabel.pp.label,
      xLabel: ' ${DiagramLabel.qSub.label}',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.46,
      xAxisEndPos: 0.58,
      yLabel: DiagramLabel.pE.label,
      hideXLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.465,
      xAxisEndPos: 0.385,
      hideXLine: true,
      hideYLine: true,
      showDotAtIntersection: true,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.consumerGain.label,
      Offset(0.30, 0.20),

      pointerLine: Offset(0.30, 0.30),
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.producerGain.label,
      Offset(0.60, 0.70),

      pointerLine: Offset(0.40, 0.50),
    );
  }
}
