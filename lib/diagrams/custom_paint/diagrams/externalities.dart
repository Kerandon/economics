import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_description.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_enum.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_methods/axis/paint_axis_labels.dart';

class Externalities extends BaseDiagramPainter {
  Externalities(super.config, super.diagram);

  // Note: No need to override 'paint' anymore, the base class handles it!

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // paintAxis now only needs the unified canvas
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
    );

    switch (diagram) {
      case DiagramEnum.microNegativeProductionExternality ||
          DiagramEnum.microCommonPoolResources ||
          DiagramEnum.microNegativeProductionExternalityPigouvianTax ||
          DiagramEnum.microNegativeProductionExternalityRegulations:
        _paintNegativeProduction(c, canvas, diagram);
      case DiagramEnum.microCarbonTax:
        _paintCarbonTax(c, canvas);
      case DiagramEnum.microTradablePollutionPermits:
        _paintTradablePermits(c, canvas);
      case DiagramEnum.microNegativeConsumptionExternality ||
          DiagramEnum.microNegativeConsumptionExternalityWelfare ||
          DiagramEnum.microNegativeConsumptionExternalityPigouvianTax ||
          DiagramEnum.microNegativeConsumptionExternalityPublicAwareness:
        _paintNegativeConsumption(c, canvas, diagram);
      case DiagramEnum.microPositiveProductionExternality ||
          DiagramEnum.microPositiveProductionExternalityWelfare ||
          DiagramEnum.microPositiveProductionExternalitySubsidy ||
          DiagramEnum.microPositiveProductionExternalityDirectProvision:
        _paintPositiveProduction(c, canvas, diagram);
      case DiagramEnum.microPositiveConsumptionExternality ||
          DiagramEnum.microPositiveConsumptionExternalityWelfare ||
          DiagramEnum.microPositiveConsumptionExternalitySubsidy ||
          DiagramEnum.microPositiveConsumptionExternalityAdvertising ||
          DiagramEnum.microPositiveConsumptionExternalityDirectProvision:
        _paintPositiveConsumption(c, canvas, diagram);
      default:
    }
  }

  LegendDisplay get legendDisplay {
    final welfareDiagrams = [
      DiagramEnum.microNegativeProductionExternalityWelfare,
      DiagramEnum.microNegativeConsumptionExternalityWelfare,
      DiagramEnum.microPositiveProductionExternalityWelfare,
      DiagramEnum.microPositiveConsumptionExternalityWelfare,
    ];
    return welfareDiagrams.contains(diagram)
        ? LegendDisplay.letters
        : LegendDisplay.shading;
  }

  // --- PRIVATE METHODS ---

  void _paintNegativeProduction(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum bundle,
  ) {
    final length = -0.10;

    paintTitle(c, canvas, 'Factory Production Emitting Air Pollution');

    paintShading(c, canvas, ShadeType.welfareLoss, [
      Offset(0.42, 0.42),
      Offset(0.555, 0.56),
      Offset(0.555, 0.30),
    ]);

    if (bundle == DiagramEnum.microNegativeProductionExternalityPigouvianTax) {
      paintShading(c, canvas, ShadeType.governmentRevenue, [
        const Offset(0, 0.47),
        const Offset(0.31, 0.47),
        const Offset(0.31, 0.675),
        const Offset(0, 0.675),
      ], striped: true);
    }

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.dEqualsMPBMSB,
      lengthAdjustment: length,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sEqualsMPC,
      horizontalShift: 0.05,
      verticalShift: 0.05,
      lengthAdjustment: length,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.msc,
      horizontalShift: -0.05,
      verticalShift: -0.10,
      lengthAdjustment: length,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.42,
      xAxisEndPos: 0.425,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.555,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.externalCost.label,
      Offset(0.98, 0.30),
      pointerLine: Offset(0.70, 0.30),
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.70, 0.28),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
      length: 0.15,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.50, 0.18),
      pointerLine: Offset(0.50, 0.40),
    );
    paintDescription(c, canvas, 'Free market: MSC > MPC. Qopt < Qm');
  }

  void _paintCarbonTax(DiagramPainterConfig c, IDiagramCanvas canvas) {
    final length = -0.15;
    paintTitle(c, canvas, 'Carbon Tax - Two Step Process');
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.dEqualsMPBMSB,
      lengthAdjustment: length,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.mscEqualsMpcTax1,
      horizontalShift: -0.12,
      verticalShift: -0.08,
      lengthAdjustment: length,
    );

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.mscEqualsMpcTax2,
      horizontalShift: 0.0,
      verticalShift: 0.0,
      lengthAdjustment: length,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.mpc,
      horizontalShift: 0.12,
      verticalShift: 0.08,
      lengthAdjustment: length,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.40,
      xAxisEndPos: 0.40,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.605,
      xAxisEndPos: 0.605,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.65, 0.36),
      angle: pi / -2,
      length: 0.32,
      label: '1',
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.75, 0.36),
      angle: pi / -2,
      length: 0.14,
      label: '2',
    );
    paintDescription(
      c,
      canvas,
      '1. initial carbon tax, 2. carbon tax reduces as firms substitute to clean energy sources resulting in a reduction of CO2 emissions.',
    );
  }

  void _paintTradablePermits(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintTitle(c, canvas, 'Secondary Market for Pollution Permits');
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.40,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.p.label,
      xLabel: DiagramLabel.q1.label,
      additionalXLabels: [DiagramLabel.q2.label],
      additionalXPositions: [0.35],
    );

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.perfectlyInelasticSupply,

      label: DiagramLabel.s1.label,
      horizontalShift: 0.05,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.perfectlyInelasticSupply,

      label: DiagramLabel.s2.label,
      color: Colors.red,
      horizontalShift: -0.15,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.d1,
      horizontalShift: 0.10,
      verticalShift: -0.05,
      lengthAdjustment: -0.05,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.d2,
      horizontalShift: -0.0,
      verticalShift: 0.05,
      color: Colors.red,
      lengthAdjustment: -0.05,
    );
    paintDescription(
      c,
      canvas,
      'The supply of permits is perfectly inelastic as the quantity is set by the government..',
    );
    paintLineSegment(c, canvas, origin: Offset(0.46, 0.80), angle: pi);
    paintLineSegment(c, canvas, origin: Offset(0.75, 0.69), angle: pi);
  }

  void _paintNegativeConsumption(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum bundle,
  ) {
    final length = -0.10;
    paintShading(c, canvas, ShadeType.welfareLoss, [
      Offset(0.42, 0.58),
      Offset(0.55, 0.71),
      Offset(0.55, 0.46),
    ]);
    paintText(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.80, 0.55),
      pointerLine: Offset(0.52, 0.55),
    );

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sEqualsMPCMSC,
      lengthAdjustment: length,
    );
    paintTitle(c, canvas, 'Sugary Drinks Market');
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.dEqualsMPB,
      lengthAdjustment: length,
      horizontalShift: 0.05,
      verticalShift: -0.05,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.msb,
      horizontalShift: -0.10,
      verticalShift: 0.05,
      lengthAdjustment: length,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.45,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.58,
      xAxisEndPos: 0.42,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.externalCost.label,
      Offset(0.98, 0.70),
      pointerLine: Offset(0.70, 0.70),
    );
    paintLineSegment(
      c,
      canvas,

      origin: Offset(0.70, 0.73),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
      length: 0.18,
    );
    paintDescription(c, canvas, 'Free market: MSB < MPB. Qopt < Qm');
  }

  void _paintPositiveProduction(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum bundle,
  ) {
    paintTitle(c, canvas, 'Vaccination Research & Development');
    final length = -0.10;

    paintShading(c, canvas, ShadeType.welfareLoss, [
      Offset(0.37, 0.42),
      Offset(0.37, 0.69),
      Offset(0.50, 0.55),
    ]);
    paintText(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.70, 0.55),
      pointerLine: Offset(0.42, 0.55),
    );

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.dEqualsMPBMSB,
      horizontalShift: -0.05,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sEqualsMPC,
      horizontalShift: -0.10,
      verticalShift: -0.10,
      lengthAdjustment: length,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.msc,
      horizontalShift: 0,
      verticalShift: 0.05,
      lengthAdjustment: length,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.55,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.43,
      xAxisEndPos: 0.37,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.externalBenefit.label,
      Offset(0.98, 0.28),
      pointerLine: Offset(0.65, 0.28),
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.65, 0.28),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
      length: 0.16,
    );
    paintDescription(c, canvas, 'Free market: MSC < MPC. Qopt > Qm');
  }

  void _paintPositiveConsumption(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum bundle,
  ) {
    paintTitle(c, canvas, 'Gym Memberships');
    final length = -0.10;

    paintShading(c, canvas, ShadeType.welfareLoss, [
      Offset(0.42, 0.32),
      Offset(0.42, 0.59),
      Offset(0.55, 0.45),
    ]);

    paintText(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.75, 0.45),
      pointerLine: Offset(0.50, 0.45),
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.sEqualsMPCMSC,
      lengthAdjustment: length,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.msb,
      lengthAdjustment: length,
      verticalShift: -0.05,
      horizontalShift: 0.05,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.dEqualsMPB,
      verticalShift: 0.05,
      horizontalShift: -0.10,
      lengthAdjustment: length,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.58,
      xAxisEndPos: 0.425,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.45,
      xAxisEndPos: 0.55,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
    paintText(
      c,
      canvas,
      DiagramLabel.externalBenefit.label,
      Offset(1.0, 0.70),
      pointerLine: Offset(0.70, 0.70),
    );
    paintLineSegment(
      c,
      canvas,

      origin: Offset(0.70, 0.72),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
      length: 0.16,
    );
    paintDescription(c, canvas, 'Free market: MSB > MPB. Qopt > Qm');
  }
}
