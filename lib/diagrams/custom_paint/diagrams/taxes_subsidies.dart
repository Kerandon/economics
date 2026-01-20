import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';
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
  void paint(Canvas canvas, Size size) {
    drawDiagram(canvas, size);
  }

  @override
  void drawDiagram(Canvas? canvas, Size size, {IDiagramCanvas? iCanvas}) {
    final c = config.copyWith(painterSize: size);

    paintAxis(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisLabel: DiagramLabel.price.label,
      xAxisLabel: DiagramLabel.quantity.label,
    );

    switch (diagram) {
      case DiagramEnum.microIndirectTax:
        _paintIndirectTax(c, canvas, size, iCanvas: iCanvas);
      case DiagramEnum.microIndirectTaxInelasticPED:
        _paintIndirectTaxInelasticDemand(c, canvas, size, iCanvas: iCanvas);
      case DiagramEnum.microIndirectTaxElasticPED:
        _paintIndirectTaxElasticDemand(c, canvas, size, iCanvas: iCanvas);
      case DiagramEnum.microSubsidy:
        _paintSubsidy(c, canvas, size, iCanvas: iCanvas);
      case DiagramEnum.microSubsidyInelasticPED:
        _paintSubsidyInelasticDemand(c, canvas, size, iCanvas: iCanvas);
      case DiagramEnum.microSubsidyElasticPED:
        _paintSubsidyElasticDemand(c, canvas, size, iCanvas: iCanvas);
      default:
    }
  }

  // --- INDIRECT TAX METHODS ---

  void _paintIndirectTax(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    // Shading for Deadweight Loss
    paintShading(canvas, size, ShadeType.welfareLoss, [
      const Offset(0.425, 0.43),
      const Offset(0.55, 0.55),
      const Offset(0.425, 0.68),
    ], iCanvas: iCanvas);

    // Tax Vertical Bracket
    paintLineSegment(
      c,
      canvas,
      iCanvas: iCanvas,
      origin: const Offset(0.60, 0.39),
      angle: -pi / 2,
      length: 0.18,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.tax.label,
      const Offset(0.66, 0.32),
      iCanvas: iCanvas,
    );

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
      (label, offset) =>
          paintText2(c, canvas, label.label, offset, iCanvas: iCanvas),
    );

    // Curves
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.demand,
      label: DiagramLabel.dEqualsMB.label,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      horizontalShift: -kExtendBy10,
      verticalShift: -kExtendBy5,
      label: DiagramLabel.sTax.label,
      color: Colors.red,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      label: DiagramLabel.sEqualsMC.label,
      verticalShift: 0.10,
    );

    paintText2(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      const Offset(0.75, 0.55),
      pointerLine: const Offset(0.50, 0.55),
      iCanvas: iCanvas,
    );

    // Equilibrium Intersections
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.55,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.425,
      xAxisEndPos: 0.425,
      yLabel: DiagramLabel.pc.label,
      xLabel: DiagramLabel.qTax.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.675,
      xAxisEndPos: 0.425,
      yLabel: DiagramLabel.pp.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
  }

  void _paintIndirectTaxInelasticDemand(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    paintShading(
      canvas,
      size,
      ShadeType.consumerIncidence,
      [
        const Offset(0, 0.40),
        const Offset(0.46, 0.40),
        const Offset(0.46, 0.58),
        const Offset(0.0, 0.58),
      ],
      striped: true,
      iCanvas: iCanvas,
    );
    paintShading(
      canvas,
      size,
      ShadeType.producerIncidence,
      [
        const Offset(0, 0.58),
        const Offset(0.46, 0.58),
        const Offset(0.46, 0.64),
        const Offset(0.0, 0.64),
      ],
      striped: true,
      iCanvas: iCanvas,
    );

    paintLegend(canvas, size, config: c, iCanvas: iCanvas, [
      LegendEntry.fromShade(ShadeType.consumerBurden),
      LegendEntry.fromShade(ShadeType.producerBurden),
    ]);

    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.demand,
      lengthAdjustment: -kExtendBy10,
      angle: 0.40,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
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
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      verticalShift: 0.10,
      angle: 0.10,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.58,
      xAxisEndPos: 0.525,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.46,
      yLabel: DiagramLabel.pc.label,
      xLabel: '${DiagramLabel.qTax.label}  ',
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.64,
      xAxisEndPos: 0.46,
      yLabel: DiagramLabel.pp.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
  }

  // --- SUBSIDY METHODS ---

  void _paintSubsidy(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    paintShading(canvas, size, ShadeType.welfareLoss, [
      const Offset(0.55, 0.3),
      const Offset(0.55, 0.55),
      const Offset(0.42, 0.43),
    ], iCanvas: iCanvas);

    // Labels A-H
    paintText2(
      c,
      canvas,
      DiagramLabel.a.label,
      const Offset(0.10, 0.22),
      iCanvas: iCanvas,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.f.label,
      const Offset(0.50, 0.42),
      iCanvas: iCanvas,
    );

    paintLineSegment(
      c,
      canvas,
      iCanvas: iCanvas,
      origin: const Offset(0.70, 0.26),
      angle: pi / 2,
      length: 0.18,
    );
    paintText2(
      c,
      canvas,
      DiagramLabel.subsidy.label,
      const Offset(0.795, 0.165),
      iCanvas: iCanvas,
    );

    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.demand,
      label: DiagramLabel.dEqualsMB.label,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      horizontalShift: kExtendBy5,
      verticalShift: kExtendBy5,
      label: DiagramLabel.sSub.label,
      color: Colors.red,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      label: DiagramLabel.sEqualsMC.label,
      horizontalShift: -kExtendBy5,
      verticalShift: -kExtendBy10,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.55,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.pc.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.425,
      xAxisEndPos: 0.425,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.30,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.pp.label,
      xLabel: DiagramLabel.qSub.label,
      showDotAtIntersection: true,
    );
  }

  void _paintSubsidyInelasticDemand(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    paintShading(
      canvas,
      size,
      ShadeType.producerGain,
      [
        const Offset(0, 0.325),
        const Offset(0.52, 0.325),
        const Offset(0.52, 0.38),
        const Offset(0.0, 0.38),
      ],
      striped: true,
      iCanvas: iCanvas,
    );
    paintShading(
      canvas,
      size,
      ShadeType.consumerGain,
      [
        const Offset(0, 0.38),
        const Offset(0.52, 0.38),
        const Offset(0.52, 0.575),
        const Offset(0.0, 0.575),
      ],
      striped: true,
      iCanvas: iCanvas,
    );

    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.demand,
      angle: 0.50,
      lengthAdjustment: -kExtendBy20,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      horizontalShift: kExtendBy5,
      verticalShift: kExtendBy5,
      color: Colors.red,
      label: DiagramLabel.sSub.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.575,
      xAxisEndPos: 0.52,
      yLabel: DiagramLabel.pc.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.325,
      xAxisEndPos: 0.52,
      yLabel: DiagramLabel.pp.label,
      xLabel: ' ${DiagramLabel.qSub.label}',
      showDotAtIntersection: true,
    );

    paintLegend(canvas, size, config: c, iCanvas: iCanvas, [
      LegendEntry.fromShade(ShadeType.consumerIncidence),
      LegendEntry.fromShade(ShadeType.producerIncidence),
    ]);
  }

  // ✅ ADDED: Elastic Tax Variant
  void _paintIndirectTaxElasticDemand(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    paintShading(
      canvas,
      size,
      ShadeType.consumerIncidence,
      [
        const Offset(0, 0.47),
        const Offset(0.39, 0.47),
        const Offset(0.39, 0.53),
        const Offset(0.0, 0.53),
      ],
      striped: true,
      iCanvas: iCanvas,
    );
    paintShading(
      canvas,
      size,
      ShadeType.producerIncidence,
      [
        const Offset(0, 0.53),
        const Offset(0.39, 0.53),
        const Offset(0.39, 0.71),
        const Offset(0.0, 0.71),
      ],
      striped: true,
      iCanvas: iCanvas,
    );

    paintLegend(canvas, size, config: c, iCanvas: iCanvas, [
      LegendEntry.fromShade(ShadeType.consumerBurden),
      LegendEntry.fromShade(ShadeType.producerBurden),
    ]);

    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.demand,
      lengthAdjustment: -kExtendBy15,
      angle: -0.50,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      horizontalShift: -kExtendBy10,
      verticalShift: -kExtendBy5,
      label: DiagramLabel.sTax.label,
      color: Colors.red,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      verticalShift: 0.10,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.53,
      xAxisEndPos: 0.58,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.47,
      xAxisEndPos: 0.39,
      yLabel: DiagramLabel.pc.label,
      xLabel: DiagramLabel.qTax.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
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
    Canvas? canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    paintShading(
      canvas,
      size,
      ShadeType.producerGain,
      [
        const Offset(0, 0.27),
        const Offset(0.58, 0.27),
        const Offset(0.58, 0.465),
        const Offset(0.0, 0.465),
      ],
      striped: true,
      iCanvas: iCanvas,
    );
    paintShading(
      canvas,
      size,
      ShadeType.consumerGain,
      [
        const Offset(0, 0.465),
        const Offset(0.58, 0.465),
        const Offset(0.58, 0.52),
        const Offset(0.0, 0.52),
      ],
      striped: true,
      iCanvas: iCanvas,
    );

    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.demand,
      angle: -0.50,
      lengthAdjustment: -kExtendBy20,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      horizontalShift: kExtendBy5,
      verticalShift: kExtendBy5,
      color: Colors.red,
      label: DiagramLabel.sSub.label,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      label: DiagramLabel.s.label,
      horizontalShift: -kExtendBy5,
      verticalShift: -kExtendBy10,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.52,
      xAxisEndPos: 0.58,
      yLabel: DiagramLabel.pc.label,
      hideXLine: true,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.27,
      xAxisEndPos: 0.58,
      yLabel: DiagramLabel.pp.label,
      xLabel: ' ${DiagramLabel.qSub.label}',
      showDotAtIntersection: true,
    );

    paintLegend(canvas, size, config: c, iCanvas: iCanvas, [
      LegendEntry.fromShade(ShadeType.consumerIncidence),
      LegendEntry.fromShade(ShadeType.producerIncidence),
    ]);
  }

  LegendDisplay get legendDisplay {
    // Logic to determine display mode based on specific diagram
    if (diagram == DiagramEnum.microIndirectTax ||
        diagram == DiagramEnum.microSubsidy) {
      return LegendDisplay.letters;
    }
    return LegendDisplay.shading;
  }
}
