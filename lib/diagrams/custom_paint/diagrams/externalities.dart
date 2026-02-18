import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
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
    String supplyLabel = DiagramLabel.msc.label;

    paintText(
      c,
      canvas,
      DiagramLabel.externalCost.label,
      Offset(0.80, 0.50),
      pointerLine: Offset(0.60, 0.35),
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.60, 0.35),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
    );

    paintShading(c, canvas, ShadeType.welfareLoss, [
      Offset(0.30, 0.46),
      Offset(0.44, 0.59),
      Offset(0.44, 0.36),
    ]);
    paintText(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.35, 0.30),
      pointerLine: Offset(0.40, 0.45),
    );
    if (bundle == DiagramEnum.microNegativeProductionExternalityPigouvianTax) {
      paintShading(c, canvas, ShadeType.governmentRevenue, [
        const Offset(0, 0.47),
        const Offset(0.31, 0.47),
        const Offset(0.31, 0.675),
        const Offset(0, 0.675),
      ], striped: true);
      supplyLabel = DiagramLabel.mscEqualsMPCPlusTax.label;
    }

    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0, 0.2),
      polylineOffsets: [const Offset(0.8, 0.9)],
      label2: DiagramLabel.dEqualsMPBMSB.label,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0, 0.9),
      polylineOffsets: [const Offset(0.8, 0.3)],
      label2: DiagramLabel.mpc.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0, 0.68),
      polylineOffsets: [const Offset(0.8, 0.11)],
      label2: supplyLabel,
      label2Align: LabelAlign.centerRight,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.465,
      xAxisEndPos: 0.305,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.58,
      xAxisEndPos: 0.43,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
      showDotAtIntersection: true,
    );
  }

  void _paintCarbonTax(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0, 0.2),
      polylineOffsets: [const Offset(0.8, 0.9)],
      label2: DiagramLabel.dEqualsMPBMSB.label,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0, 0.95),
      polylineOffsets: [const Offset(0.8, 0.35)],
      label2: DiagramLabel.mpc.label,
    );
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 0.65),
      polylineOffsets: [const Offset(0.8, 0.05)],
      label2: 'MSC1',
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.605,
      xAxisEndPos: 0.465,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintText(
      c,
      canvas,
      'Initial Carbon Tax',
      const Offset(0.35, 0.2),
      pointerLine: const Offset(0.55, 0.4),
    );
  }

  void _paintTradablePermits(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.5,
      xAxisEndPos: 0.5,
      yLabel: DiagramLabel.p.label,
      xLabel: DiagramLabel.q.label,
    );
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.5, 1.0),
      polylineOffsets: [const Offset(0.5, 0.15)],
      label2: DiagramLabel.supplyOfPermits.label,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.demand,
      label: DiagramLabel.demandForPermits.label,
    );
  }

  void _paintNegativeConsumption(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum bundle,
  ) {
    paintText(
      c,
      canvas,
      DiagramLabel.externalCost.label,
      Offset(0.85, 0.60),
      pointerLine: Offset(0.65, 0.75),
    );
    paintLineSegment(
      c,
      canvas,

      origin: Offset(0.65, 0.73),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
      length: 0.12,
    );

    paintShading(c, canvas, ShadeType.welfareLoss, [
      Offset(0.32, 0.615),
      Offset(0.465, 0.72),
      Offset(0.465, 0.50),
    ]);
    paintText(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.45, 0.35),
      pointerLine: Offset(0.42, 0.60),
    );
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 0.2),
      polylineOffsets: [const Offset(0.85, 0.75)],
      label2: DiagramLabel.dEqualsMPB.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 0.4),
      polylineOffsets: [const Offset(0.75, 0.9)],
      label2: DiagramLabel.msb.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 0.85),
      polylineOffsets: [const Offset(0.8, 0.25)],
      label2: DiagramLabel.sEqualsMPCMSC.label,
      label2Align: LabelAlign.centerRight,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.5,
      xAxisEndPos: 0.465,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.61,
      xAxisEndPos: 0.325,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      showDotAtIntersection: true,
    );
  }

  void _paintPositiveProduction(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum bundle,
  ) {
    paintText(
      c,
      canvas,
      DiagramLabel.externalBenefit.label,
      Offset(0.80, 0.50),
      pointerLine: Offset(0.60, 0.35),
    );
    paintLineSegment(
      c,
      canvas,
      origin: Offset(0.60, 0.36),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
      length: 0.14,
    );

    paintShading(c, canvas, ShadeType.welfareLoss, [
      Offset(0.33, 0.46),
      Offset(0.33, 0.70),
      Offset(0.46, 0.60),
    ]);
    paintText(
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

      type: MarketCurveType.demand,
      label: DiagramLabel.dEqualsMPBMSB.label,
      horizontalShift: -0.14,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      label: DiagramLabel.sEqualsMPC.label,
      horizontalShift: -0.11,
      verticalShift: -0.08,
      angle: 0.10,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      label: mSCLabel,
      horizontalShift: -0.11,
      verticalShift: 0.15,
      angle: 0.10,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.595,
      xAxisEndPos: 0.46,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.47,
      xAxisEndPos: 0.33,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
      showDotAtIntersection: true,
    );
  }

  void _paintPositiveConsumption(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum bundle,
  ) {
    paintText(
      c,
      canvas,
      DiagramLabel.externalBenefit.label,
      Offset(0.85, 0.60),
      pointerLine: Offset(0.60, 0.70),
    );
    paintLineSegment(
      c,
      canvas,

      origin: Offset(0.60, 0.69),
      angle: pi / 2,
      endStyle: LineEndStyle.arrowBothEnds,
      length: 0.12,
    );

    paintShading(c, canvas, ShadeType.welfareLoss, [
      Offset(0.285, 0.39),
      Offset(0.285, 0.59),
      Offset(0.45, 0.49),
    ]);

    paintText(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      Offset(0.35, 0.30),
      pointerLine: Offset(0.35, 0.48),
    );

    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 0.2),
      polylineOffsets: [const Offset(0.85, 0.75)],
      label2: DiagramLabel.msb.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 0.4),
      polylineOffsets: [const Offset(0.75, 0.9)],
      label2: DiagramLabel.dEqualsMPB.label,
      label2Align: LabelAlign.centerRight,
    );
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 0.75),
      polylineOffsets: [const Offset(0.8, 0.3)],
      label2: DiagramLabel.sEqualsMPCMSC.label,
      label2Align: LabelAlign.centerRight,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.59,
      xAxisEndPos: 0.285,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.495,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
      showDotAtIntersection: true,
    );
  }
}
