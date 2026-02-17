import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/custom_paint/shade/paint_shading.dart';
import 'package:economics_app/diagrams/custom_paint/shade/shade_type.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/legend/legend_display.dart';
import '../painter_methods/paint_legend_table.dart';
import '../painter_methods/paint_line_segment_MAKEREDUNDANT.dart';

class PriceControls extends BaseDiagramPainter {
  PriceControls(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.microPriceCeiling:
        _paintPriceCeiling(c, canvas, size);
      case DiagramEnum.microPriceFloor:
        _paintPriceFloor(c, canvas, size);
      case DiagramEnum.microMinimumWage:
      case DiagramEnum.microMinimumWageWelfare:
        _paintMinWage(c, canvas, size, diagram);
      case DiagramEnum.microNationalMinimumWageInelasticDemandAndSupply:
        _paintNMWInelasticDemand(c, canvas, size);
      case DiagramEnum.microAgriculturalPriceFloor:
        _paintAgriculturalPriceFloor(c, canvas, size);
      default:
    }
  }

  LegendDisplay get legendDisplay {
    // These diagrams use the A, B, C letters in a table
    if (diagram == DiagramEnum.microPriceCeiling ||
        diagram == DiagramEnum.microPriceFloor ||
        diagram == DiagramEnum.microMinimumWageWelfare ||
        diagram == DiagramEnum.microAgriculturalPriceFloor) {
      return LegendDisplay.letters;
    }
    // Simple NMW and Inelastic variants use standard shading
    return LegendDisplay.shading;
  }
}

// --- SUB-METHODS UPDATED WITH BRIDGE ---

void _paintPriceCeiling(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Size size,
) {
  paintLegendTable(
    canvas,
    c,
    headers: ['', 'Before', 'After'],
    data: [
      ['CS', '+(A,B)', '+(A,C)'],
      ['PS', '+(C,D)', '+E'],
      ['Welfare', '+(A,B,C,D,E)', '+(A,C,E)'],
      ['DWL', '-', '-(B,D)'],
    ],
  );
  paintLineSegment(
    c,
    canvas,

    origin: const Offset(0.50, 1.1),
    angle: 0,
    labelAlign: LabelAlign.centerBottom,
    length: 0.5,
    label: DiagramLabel.shortage.label,
    endStyle: LineEndStyle.arrowRightAngles,
  );

  // paintShading(canvas, size, ShadeType.welfareLoss, [
  //   const Offset(0.25, 0.75),
  //   const Offset(0.25, 0.25),
  //   const Offset(0.5, 0.50),
  // ], );
  final labels = {
    DiagramLabel.a: const Offset(0.11, 0.41),
    DiagramLabel.b: const Offset(0.31, 0.41),
    DiagramLabel.c: const Offset(0.11, 0.59),
    DiagramLabel.d: const Offset(0.31, 0.59),
    DiagramLabel.e: const Offset(0.11, 0.80),
  };
  labels.forEach((label, offset) => paintText(c, canvas, label.label, offset));

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
    lengthAdjustment: 0.15,
  );
  paintMarketCurve(
    c,
    canvas,

    type: MarketCurveType.supply,
    label: DiagramLabel.sEqualsMC.label,
    lengthAdjustment: 0.15,
  );

  paintDiagramLines(
    c,
    canvas,

    color: Colors.red,
    label1: DiagramLabel.pc.label,
    label1Align: LabelAlign.centerLeft,
    startPos: const Offset(0.0, 0.75),
    polylineOffsets: [const Offset(1.0, 0.75)],
  );

  // paintText2(
  //   c,
  //   canvas,
  //   DiagramLabel.welfareLoss.label,
  //   const Offset(0.75, 0.50),
  //   pointerLine: const Offset(0.45, 0.50),
  //   ,
  // );

  paintDiagramDashedLines(
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
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: 0.75,
    xAxisEndPos: 0.75,
    xLabel: DiagramLabel.qD.label,
    showDotAtIntersection: true,
    hideYLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.pE.label,
    xLabel: DiagramLabel.qE.label,
  );
}

void _paintPriceFloor(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Size size,
) {
  paintShading(c, canvas, ShadeType.welfareLoss, [
    const Offset(0.25, 0.75),
    const Offset(0.25, 0.25),
    const Offset(0.5, 0.50),
  ]);

  paintLineSegment(
    c,
    canvas,

    origin: const Offset(0.50, 0.20),
    angle: 0,
    labelAlign: LabelAlign.centerTop,
    length: 0.5,
    label: DiagramLabel.surplus.label,
    endStyle: LineEndStyle.arrowRightAngles,
  );

  final labels = {
    DiagramLabel.a: const Offset(0.12, 0.18),
    DiagramLabel.b: const Offset(0.12, 0.38),
    DiagramLabel.c: const Offset(0.32, 0.42),
    DiagramLabel.d: const Offset(0.12, 0.62),
    DiagramLabel.e: const Offset(0.32, 0.60),
  };
  labels.forEach((label, offset) => paintText(c, canvas, label.label, offset));

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
    startPos: const Offset(0.0, 0.25),
    polylineOffsets: [const Offset(1.0, 0.25)],
  );

  paintText(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    const Offset(0.70, 0.50),
    pointerLine: const Offset(0.40, 0.50),
  );

  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: 0.25,
    xAxisEndPos: 0.25,
    xLabel: DiagramLabel.qDStar.label,
    hideYLine: true,
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.25,
    xAxisEndPos: 0.75,
    xLabel: DiagramLabel.qS.label,
    showDotAtIntersection: true,
    hideYLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.pE.label,
    xLabel: DiagramLabel.qE.label,
  );
}

void _paintMinWage(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Size size,
  DiagramEnum bundle,
) {
  if (bundle == DiagramEnum.microMinimumWageWelfare) {
    paintText(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      const Offset(0.85, 0.50),
      pointerLine: const Offset(0.40, 0.50),
    );
    paintShading(c, canvas, ShadeType.welfareLoss, [
      const Offset(0.30, 0.70),
      const Offset(0.30, 0.30),
      const Offset(0.5, 0.50),
    ]);

    final labels = {
      DiagramLabel.a: const Offset(0.12, 0.18),
      DiagramLabel.b: const Offset(0.12, 0.38),
      DiagramLabel.c: const Offset(0.35, 0.42),
      DiagramLabel.d: const Offset(0.12, 0.62),
      DiagramLabel.e: const Offset(0.35, 0.57),
    };
    labels.forEach(
      (label, offset) => paintText(c, canvas, label.label, offset),
    );
  }

  paintDiagramDashedLines(
    c,
    canvas,

    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.wE.label,
    xLabel: DiagramLabel.qE.label,
  );
  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.50, 0.25),
    endStyle: LineEndStyle.arrowRightAngles,
    label: DiagramLabel.surplusLabor.label,
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
    startPos: const Offset(0, 0.30),
    polylineOffsets: [const Offset(1.0, 0.30)],
    label1: DiagramLabel.wMin.label,
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
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.70,
    hideYLine: true,
    xLabel: DiagramLabel.qS.label,
    showDotAtIntersection: true,
  );
}

void _paintNMWInelasticDemand(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Size size,
) {
  paintText(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    const Offset(0.85, 0.50),
    pointerLine: const Offset(0.46, 0.50),
  );
  paintShading(c, canvas, ShadeType.welfareLoss, [
    const Offset(0.44, 0.65),
    const Offset(0.44, 0.30),
    const Offset(0.5, 0.50),
  ]);

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.wE.label,
    xLabel: DiagramLabel.qE.label,
  );
  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.515, 0.22),
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
    lengthAdjustment: -kExtendBy15,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: DiagramLabel.sL.label,
    angle: -0.40,
    lengthAdjustment: -kExtendBy15,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: const Offset(0, 0.30),
    polylineOffsets: [const Offset(1.0, 0.30)],
    label1: DiagramLabel.wMin.label,
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
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.58,
    hideYLine: true,
    xLabel: DiagramLabel.qS.label,
    showDotAtIntersection: true,
  );
}

void _paintAgriculturalPriceFloor(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Size size,
) {
  // paintText2(
  //   c,
  //   canvas,
  //   DiagramLabel.welfareLoss.label,
  //   const Offset(0.90, 0.50),
  //   pointerLine: const Offset(0.65, 0.50),
  //   ,
  // );
  // paintShading(canvas, size, ShadeType.welfareLoss, [
  //   const Offset(0.30, 0.30),
  //   const Offset(0.30, 1.0),
  //   const Offset(0.70, 1.0),
  //   const Offset(0.70, 0.30),
  //   const Offset(0.50, 0.50),
  // ], );

  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.50, 0.24),
    endStyle: LineEndStyle.arrowRightAngles,
    length: 0.40,
    label: DiagramLabel.governmentBoughtSurplus.label,
    labelAlign: LabelAlign.centerTop,
  );
  paintLineSegment(
    c,
    canvas,

    origin: const Offset(0.15, 1.10),
    endStyle: LineEndStyle.arrowRightAngles,
    length: 0.28,
    label: DiagramLabel.freeMarket.label,
    labelAlign: LabelAlign.centerBottom,
  );
  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.50, 1.10),
    endStyle: LineEndStyle.arrowRightAngles,
    length: 0.40,
    label: DiagramLabel.government.label,
    labelAlign: LabelAlign.centerBottom,
  );

  final labels = {
    DiagramLabel.a: const Offset(0.12, 0.20),
    DiagramLabel.b: const Offset(0.12, 0.40),
    DiagramLabel.c: const Offset(0.35, 0.42),
    DiagramLabel.d: const Offset(0.12, 0.60),
    DiagramLabel.e: const Offset(0.35, 0.58),
    DiagramLabel.f: const Offset(0.50, 0.38),
    DiagramLabel.g: const Offset(0.40, 0.80),
    DiagramLabel.h: const Offset(0.60, 0.80),
    DiagramLabel.i: const Offset(0.60, 0.50),
  };
  labels.forEach((label, offset) => paintText(c, canvas, label.label, offset));

  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.p.label,
    xAxisLabel: DiagramLabel.q.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: DiagramLabel.dEqualsMB.label,
    lengthAdjustment: 0.20,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: DiagramLabel.sEqualsMC.label,
    lengthAdjustment: 0.20,
  );

  paintDiagramLines(
    c,
    canvas,
    startPos: const Offset(0, 0.30),
    polylineOffsets: [const Offset(1.0, 0.30)],
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
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.70,
    hideYLine: true,
    xLabel: DiagramLabel.qSStar.label,
    showDotAtIntersection: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.pE.label,
    xLabel: DiagramLabel.qE.label,
    showDotAtIntersection: true,
  );
}
