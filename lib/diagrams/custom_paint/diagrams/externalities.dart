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
      yAxisLabel: DiagramLabel.price.label,
      xAxisLabel: DiagramLabel.quantity.label,
    );

    switch (diagram) {
      case DiagramEnum.microNegativeProductionExternality ||
          DiagramEnum.microNegativeProductionExternalityWelfare ||
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
    String arrowLabel = (bundle == DiagramEnum.microCommonPoolResources)
        ? DiagramLabel.externalCostOfOverFishing.label
        : DiagramLabel.externalCost.label;

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
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.68),
      polylineOffsets: [const Offset(0.8, 0.11)],
      label2: supplyLabel,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.47,
      xAxisEndPos: 0.31,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.575,
      xAxisEndPos: 0.43,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
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
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.2),
      polylineOffsets: [const Offset(0.85, 0.75)],
      label2: DiagramLabel.dEqualsMPB.label,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.4),
      polylineOffsets: [const Offset(0.75, 0.9)],
      label2: DiagramLabel.msb.label,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.85),
      polylineOffsets: [const Offset(0.8, 0.25)],
      label2: DiagramLabel.sEqualsMPCMSC.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.5,
      xAxisEndPos: 0.465,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.61,
      xAxisEndPos: 0.325,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
  }

  void _paintPositiveProduction(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size,
    DiagramEnum bundle, {
    IDiagramCanvas? iCanvas,
  }) {
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
      horizontalShift: -0.06,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      label: DiagramLabel.sEqualsMPC.label,
      horizontalShift: -0.1,
      verticalShift: -0.08,
    );
    paintMarketCurve(
      c,
      canvas,
      iCanvas: iCanvas,
      type: MarketCurveType.supply,
      label: mSCLabel,
      horizontalShift: -0.05,
      verticalShift: 0.1,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.53,
      xAxisEndPos: 0.535,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
  }

  void _paintPositiveConsumption(
    DiagramPainterConfig c,
    Canvas? canvas,
    Size size,
    DiagramEnum bundle, {
    IDiagramCanvas? iCanvas,
  }) {
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.2),
      polylineOffsets: [const Offset(0.85, 0.75)],
      label2: DiagramLabel.msb.label,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.4),
      polylineOffsets: [const Offset(0.75, 0.9)],
      label2: DiagramLabel.dEqualsMPB.label,
    );
    paintDiagramLines(
      c,
      canvas,
      iCanvas: iCanvas,
      startPos: const Offset(0, 0.75),
      polylineOffsets: [const Offset(0.8, 0.3)],
      label2: DiagramLabel.sEqualsMPCMSC.label,
    );

    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.59,
      xAxisEndPos: 0.285,
      yLabel: DiagramLabel.pm.label,
      xLabel: DiagramLabel.qm.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      iCanvas: iCanvas,
      yAxisStartPos: 0.495,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.pOpt.label,
      xLabel: DiagramLabel.qOpt.label,
    );
  }
}
