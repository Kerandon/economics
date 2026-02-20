import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
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
import '../painter_methods/paint_line_segment.dart';

class PriceControls extends BaseDiagramPainter {
  PriceControls(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.microPriceCeiling:
        _paintPriceCeiling(c, canvas);
      case DiagramEnum.microPriceFloor:
        _paintPriceFloor(c, canvas);
      case DiagramEnum.microMinimumWage:
      case DiagramEnum.microMinimumWageWelfare:
        _paintMinWage(c, canvas, diagram);
      case DiagramEnum.microNationalMinimumWageInelasticDemandAndSupply:
        _paintNMWInelasticDemand(c, canvas);
      case DiagramEnum.microAgriculturalPriceFloor:
        _paintAgriculturalPriceFloor(c, canvas);
      default:
        break;
    }
  }

  LegendDisplay get legendDisplay {
    const letterDiagrams = {
      DiagramEnum.microPriceCeiling,
      DiagramEnum.microPriceFloor,
      DiagramEnum.microMinimumWageWelfare,
      DiagramEnum.microAgriculturalPriceFloor,
    };
    return letterDiagrams.contains(diagram)
        ? LegendDisplay.letters
        : LegendDisplay.shading;
  }
}

// --- SUB-METHODS ---

void _paintPriceCeiling(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintTitle(c, canvas, 'Rental Market');

  paintLegendTable(
    canvas,
    c,
    headers: [
      '',
      DiagramLabel.freeMarket.label,
      DiagramLabel.priceCeiling.label,
    ],
    data: [
      [DiagramLabel.cs.label, '+(A,B)', '+(A,C)'],
      [DiagramLabel.ps.label, '+(C,D)', '+E'],
      [DiagramLabel.welfare.label, '+(A,B,C,D,E)', '+(A,C,E),-(B,D)'],
    ],
  );

  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.50, 1.1),
    label: DiagramLabel.shortage.label,
    length: 0.5,
    labelAlign: LabelAlign.centerBottom,
    endStyle: LineEndStyle.arrowRightAngles,
  );

  _paintLabels(c, canvas, {
    DiagramLabel.a: const Offset(0.11, 0.41),
    DiagramLabel.b: const Offset(0.31, 0.41),
    DiagramLabel.c: const Offset(0.11, 0.59),
    DiagramLabel.d: const Offset(0.31, 0.59),
    DiagramLabel.e: const Offset(0.11, 0.80),
  });

  _drawBasicMarket(
    c,
    canvas,
    yLabel: DiagramLabel.price.label,
    xLabel: DiagramLabel.quantity.label,
  );

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.75,
    xAxisEndPos: 0.75,
    xLabel: DiagramLabel.qD.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.25,
    xAxisEndPos: 0.25,
    xLabel: DiagramLabel.qSStar.label,
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

  _drawPriceControlLine(c, canvas, 0.75, DiagramLabel.pc.label);
}

void _paintPriceFloor(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintShading(c, canvas, ShadeType.welfareLoss, [
    const Offset(0.25, 0.75),
    const Offset(0.25, 0.25),
    const Offset(0.5, 0.50),
  ]);

  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.50, 0.20),
    label: DiagramLabel.surplus.label,
    length: 0.5,
    labelAlign: LabelAlign.centerTop,
    endStyle: LineEndStyle.arrowRightAngles,
  );

  _paintLabels(c, canvas, {
    DiagramLabel.a: const Offset(0.12, 0.18),
    DiagramLabel.b: const Offset(0.12, 0.38),
    DiagramLabel.c: const Offset(0.32, 0.42),
    DiagramLabel.d: const Offset(0.12, 0.62),
    DiagramLabel.e: const Offset(0.32, 0.60),
  });

  _drawBasicMarket(c, canvas);

  paintText(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    const Offset(0.70, 0.50),
    pointerLine: const Offset(0.40, 0.50),
  );

  _drawPriceControlLine(c, canvas, 0.25, DiagramLabel.pf.label);

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.25,
    xAxisEndPos: 0.25,
    xLabel: DiagramLabel.qDStar.label,
    hideYLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.25,
    xAxisEndPos: 0.75,
    xLabel: DiagramLabel.qS.label,
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
  DiagramEnum bundle,
) {
  paintTitle(c, canvas, 'Retail Industry');

  if (bundle == DiagramEnum.microMinimumWageWelfare) {
    paintShading(c, canvas, ShadeType.welfareLoss, [
      const Offset(0.30, 0.70),
      const Offset(0.30, 0.30),
      const Offset(0.5, 0.50),
    ]);
    _paintLabels(c, canvas, {
      DiagramLabel.a: const Offset(0.12, 0.18),
      DiagramLabel.b: const Offset(0.12, 0.38),
      DiagramLabel.c: const Offset(0.35, 0.42),
      DiagramLabel.d: const Offset(0.12, 0.62),
      DiagramLabel.e: const Offset(0.35, 0.57),
    });
    paintText(
      c,
      canvas,
      DiagramLabel.welfareLoss.label,
      const Offset(0.85, 0.50),
      pointerLine: const Offset(0.40, 0.50),
    );
  }

  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.50, 0.25),
    label: DiagramLabel.laborSurplus.label,
    length: 0.40,
    labelAlign: LabelAlign.centerTop,
    endStyle: LineEndStyle.arrowRightAngles,
  );

  _drawBasicMarket(
    c,
    canvas,
    yLabel: DiagramLabel.wageRate.label,
    xLabel: DiagramLabel.quantityOfLabor.label,
    dLabel: DiagramLabel.dL,
    sLabel: DiagramLabel.sL,
  );

  _drawPriceControlLine(c, canvas, 0.30, DiagramLabel.wMin.label);

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.wE.label,
    xLabel: DiagramLabel.qE.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.30,
    xLabel: DiagramLabel.qDStar.label,
    hideYLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.70,
    xLabel: DiagramLabel.qS.label,
    hideYLine: true,
  );
}

void _paintNMWInelasticDemand(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintShading(c, canvas, ShadeType.welfareLoss, [
    const Offset(0.44, 0.65),
    const Offset(0.44, 0.30),
    const Offset(0.5, 0.50),
  ]);

  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.515, 0.22),
    label: 'Surplus Labor',
    length: 0.12,
    labelAlign: LabelAlign.centerTop,
    endStyle: LineEndStyle.arrowRightAngles,
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

  _drawPriceControlLine(c, canvas, 0.30, DiagramLabel.wMin.label);

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.wE.label,
    xLabel: DiagramLabel.qE.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.44,
    xLabel: '${DiagramLabel.qDStar.label}       ',
    hideYLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.58,
    xLabel: DiagramLabel.qS.label,
    hideYLine: true,
  );

  paintText(
    c,
    canvas,
    DiagramLabel.welfareLoss.label,
    const Offset(0.85, 0.50),
    pointerLine: const Offset(0.46, 0.50),
  );
}

void _paintAgriculturalPriceFloor(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  paintTitle(c, canvas, 'Butter Market');
  paintLegendTable(
    canvas,
    c,
    headers: ['', DiagramLabel.freeMarket.label, DiagramLabel.priceFloor.label],
    data: [
      [DiagramLabel.cs.label, '+(a,b,c)', '+a'],
      [DiagramLabel.ps.label, '+(b,c,d,e)', '+(b,c,d,e,f)'],
      [DiagramLabel.governmentBudget.label, '-', '-(c,e,f,g,h,i)'],
      [DiagramLabel.welfareLoss.label, '-', '-(c,e,g,h,i)'],
    ],
  );

  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.50, 0.26),
    length: 0.40,
    label: DiagramLabel.governmentBoughtSurplus.label,
    labelAlign: LabelAlign.centerTop,
    endStyle: LineEndStyle.arrowRightAngles,
  );
  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.15, 1.10),
    length: 0.28,
    label: DiagramLabel.freeMarket.label,
    labelAlign: LabelAlign.centerBottom,
    endStyle: LineEndStyle.arrowRightAngles,
  );
  paintLineSegment(
    c,
    canvas,
    origin: const Offset(0.50, 1.10),
    length: 0.40,
    label: DiagramLabel.government.label,
    labelAlign: LabelAlign.centerBottom,
    endStyle: LineEndStyle.arrowRightAngles,
  );

  _paintLabels(c, canvas, {
    DiagramLabel.a: const Offset(0.12, 0.20),
    DiagramLabel.b: const Offset(0.12, 0.40),
    DiagramLabel.c: const Offset(0.35, 0.42),
    DiagramLabel.d: const Offset(0.12, 0.60),
    DiagramLabel.e: const Offset(0.35, 0.58),
    DiagramLabel.f: const Offset(0.50, 0.38),
    DiagramLabel.g: const Offset(0.40, 0.80),
    DiagramLabel.h: const Offset(0.60, 0.80),
    DiagramLabel.i: const Offset(0.60, 0.50),
  });

  _drawBasicMarket(
    c,
    canvas,
    yLabel: DiagramLabel.p.label,
    xLabel: DiagramLabel.q.label,
  );
  _drawPriceControlLine(c, canvas, 0.30, DiagramLabel.pf.label);

  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.30,
    xLabel: DiagramLabel.qD.label,
    hideYLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.70,
    xLabel: DiagramLabel.qSStar.label,
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

// --- SHARED HELPERS TO TIDY UP REPETITIVE CALLS ---

void _paintLabels(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  Map<DiagramLabel, Offset> labels,
) {
  labels.forEach((label, offset) => paintText(c, canvas, label.label, offset));
}

void _drawBasicMarket(
  DiagramPainterConfig c,
  IDiagramCanvas canvas, {
  String? yLabel,
  String? xLabel,
  DiagramLabel dLabel = DiagramLabel.dEqualsMB,
  DiagramLabel sLabel = DiagramLabel.sEqualsMC,
}) {
  paintAxis(
    c,
    canvas,
    yAxisLabel: yLabel ?? DiagramLabel.price.label,
    xAxisLabel: xLabel ?? DiagramLabel.quantity.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demand,
    label: dLabel.label,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supply,
    label: sLabel.label,
  );
}

void _drawPriceControlLine(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  double yPos,
  String label,
) {
  paintDiagramLines(
    c,
    canvas,
    color: Colors.red,
    label1: label,
    label1Align: LabelAlign.centerLeft,
    startPos: Offset(0.0, yPos),
    polylineOffsets: [Offset(1.0, yPos)],
  );
}
