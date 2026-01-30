import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';
import '../../enums/diagram_enum.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class Externalities extends BaseDiagramPainter3 {
  Externalities(super.config, super.diagram);

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
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
    );

    switch (diagram) {
      case DiagramEnum.microNegativeProductionExternality ||
          DiagramEnum.microCommonPoolResources ||
          DiagramEnum.microNegativeProductionExternalityPigouvianTax ||
          DiagramEnum.microNegativeProductionExternalityRegulations:
        _paintNegativeProduction(c, canvas, size, diagram, iCanvas: iCanvas);
      case DiagramEnum.microCarbonTax:
        _paintCarbonTax(c, canvas, size, iCanvas: iCanvas);
      case DiagramEnum.microTradablePollutionPermits:
        _paintTradablePermits(c, canvas, size, iCanvas: iCanvas);
      case DiagramEnum.microNegativeConsumptionExternality ||
          DiagramEnum.microNegativeConsumptionExternalityWelfare ||
          DiagramEnum.microNegativeConsumptionExternalityPigouvianTax ||
          DiagramEnum.microNegativeConsumptionExternalityPublicAwareness:
        _paintNegativeConsumption(c, canvas, size, diagram, iCanvas: iCanvas);
      case DiagramEnum.microPositiveProductionExternality ||
          DiagramEnum.microPositiveProductionExternalityWelfare ||
          DiagramEnum.microPositiveProductionExternalitySubsidy ||
          DiagramEnum.microPositiveProductionExternalityDirectProvision:
        _paintPositiveProduction(c, canvas, size, diagram, iCanvas: iCanvas);
      case DiagramEnum.microPositiveConsumptionExternality ||
          DiagramEnum.microPositiveConsumptionExternalityWelfare ||
          DiagramEnum.microPositiveConsumptionExternalitySubsidy ||
          DiagramEnum.microPositiveConsumptionExternalityAdvertising ||
          DiagramEnum.microPositiveConsumptionExternalityDirectProvision:
        _paintPositiveConsumption(c, canvas, size, diagram, iCanvas: iCanvas);
      default:
    }
  }

  @override
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
    Canvas? canvas,
    Size size,
    DiagramEnum bundle, {
    IDiagramCanvas? iCanvas,
  }) {
    String supplyLabel = DiagramLabel.msc.label;

    paintText2(
      c,
      canvas,
      DiagramLabel.externalCost.label,
      Offset(0.80, 0.50),
      pointerLine: Offset(0.60, 0.35),
    );
    paintLineSegment(
      c,
      canvas,
      iCanvas: iCanvas,
      origin: Offset(0.60, 0.35),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
    );

    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.30, 0.46),
      Offset(0.44, 0.59),
      Offset(0.44, 0.36),
    ]);
    paintText2(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.35, 0.30),
      pointerLine: Offset(0.40, 0.45),
    );
    if (bundle == DiagramEnum.microNegativeProductionExternalityPigouvianTax) {
      paintShading(
        canvas,
        size,
        ShadeType.governmentRevenue,
        [
          const Offset(0, 0.47),
          const Offset(0.31, 0.47),
          const Offset(0.31, 0.675),
          const Offset(0, 0.675),
        ],
        striped: true,
        iCanvas: iCanvas,
      );
      supplyLabel = DiagramLabel.mscEqualsMPCPlusTax.label;
    }

    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.2),
      polylineOffsets: [const Offset(0.8, 0.9)],
      label2: DiagramLabel.dEqualsMPBMSB.label,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.9),
      polylineOffsets: [const Offset(0.8, 0.3)],
      label2: DiagramLabel.mpc.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.68),
      polylineOffsets: [const Offset(0.8, 0.11)],
      label2: supplyLabel,
      label2Align: LabelAlign.centerRight,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.465,
      xAxisEndPos: 0.305,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.58,
      xAxisEndPos: 0.43,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
      showDotAtIntersection: true,
    );
  }

  void _paintCarbonTax(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.2),
      polylineOffsets: [const Offset(0.8, 0.9)],
      label2: DiagramLabel.dEqualsMPBMSB.label,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.95),
      polylineOffsets: [const Offset(0.8, 0.35)],
      label2: DiagramLabel.mpc.label,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.65),
      polylineOffsets: [const Offset(0.8, 0.05)],
      label2: 'MSC1',
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.605,
      xAxisEndPos: 0.465,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintText2(
      c,
      canvas,
      'Initial Carbon Tax',
      const Offset(0.35, 0.2),
      pointerLine: const Offset(0.55, 0.4),
      iCanvas: iCanvas,
    );
  }

  void _paintTradablePermits(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.5,
      xAxisEndPos: 0.5,
      yLabel: DiagramLabel.p.label,
      xLabel: DiagramLabel.q.label,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0.5, 1.0),
      polylineOffsets: [const Offset(0.5, 0.15)],
      label2: DiagramLabel.supplyOfPermits.label,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.demand,
      label: DiagramLabel.demandForPermits.label,
    );
  }

  void _paintNegativeConsumption(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size,
    DiagramEnum bundle, {
    IDiagramCanvas? iCanvas,
  }) {
    paintText2(
      c,
      canvas,
      DiagramLabel.externalCost.label,
      Offset(0.85, 0.60),
      pointerLine: Offset(0.65, 0.75),
    );
    paintLineSegment(
      c,
      canvas,
      iCanvas: iCanvas,
      origin: Offset(0.65, 0.73),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
      length: 0.12,
    );

    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.32, 0.615),
      Offset(0.465, 0.72),
      Offset(0.465, 0.50),
    ]);
    paintText2(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.45, 0.35),
      pointerLine: Offset(0.42, 0.60),
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.2),
      polylineOffsets: [const Offset(0.85, 0.75)],
      label2: DiagramLabel.dEqualsMPB.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.4),
      polylineOffsets: [const Offset(0.75, 0.9)],
      label2: DiagramLabel.msb.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.85),
      polylineOffsets: [const Offset(0.8, 0.25)],
      label2: DiagramLabel.sEqualsMPCMSC.label,
      label2Align: LabelAlign.centerRight,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.5,
      xAxisEndPos: 0.465,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.61,
      xAxisEndPos: 0.325,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      showDotAtIntersection: true,
    );
  }

  void _paintPositiveProduction(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size,
    DiagramEnum bundle, {
    IDiagramCanvas? iCanvas,
  }) {
    paintText2(
      c,
      canvas,
      DiagramLabel.externalBenefit.label,
      Offset(0.80, 0.50),
      pointerLine: Offset(0.60, 0.35),
    );
    paintLineSegment(
      c,
      canvas,
      iCanvas: iCanvas,
      origin: Offset(0.60, 0.36),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
      length: 0.14,
    );

    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.33, 0.46),
      Offset(0.33, 0.70),
      Offset(0.46, 0.60),
    ]);
    paintText2(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.35, 0.30),
      pointerLine: Offset(0.35, 0.55),
    );
    String mSCLabel =
        (bundle == DiagramEnum.microPositiveProductionExternalitySubsidy)
        ? DiagramLabel.mscEqualsMPCPlusSubsidy.label
        : DiagramLabel.msc.label;

    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.demand,
      label: DiagramLabel.dEqualsMPBMSB.label,
      horizontalShift: -0.14,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      label: DiagramLabel.sEqualsMPC.label,
      horizontalShift: -0.11,
      verticalShift: -0.08,
      angle: 0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      label: mSCLabel,
      horizontalShift: -0.11,
      verticalShift: 0.15,
      angle: 0.10,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.595,
      xAxisEndPos: 0.46,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.47,
      xAxisEndPos: 0.33,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
      showDotAtIntersection: true,
    );
  }

  void _paintPositiveConsumption(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size,
    DiagramEnum bundle, {
    IDiagramCanvas? iCanvas,
  }) {
    paintText2(
      c,
      canvas,
      DiagramLabel.externalBenefit.label,
      Offset(0.85, 0.60),
      pointerLine: Offset(0.60, 0.70),
    );
    paintLineSegment(
      c,
      canvas,
      iCanvas: iCanvas,
      origin: Offset(0.60, 0.69),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
      length: 0.12,
    );

    paintShading(canvas, size, ShadeType.welfareLoss, [
      Offset(0.285, 0.39),
      Offset(0.285, 0.59),
      Offset(0.45, 0.49),
    ]);
    paintText2(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.35, 0.30),
      pointerLine: Offset(0.35, 0.48),
    );

    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.2),
      polylineOffsets: [const Offset(0.85, 0.75)],
      label2: DiagramLabel.msb.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.4),
      polylineOffsets: [const Offset(0.75, 0.9)],
      label2: DiagramLabel.dEqualsMPB.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.75),
      polylineOffsets: [const Offset(0.8, 0.3)],
      label2: DiagramLabel.sEqualsMPCMSC.label,
      label2Align: LabelAlign.centerRight,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.59,
      xAxisEndPos: 0.285,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.495,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      showDotAtIntersection: true,
    );
  }
}
