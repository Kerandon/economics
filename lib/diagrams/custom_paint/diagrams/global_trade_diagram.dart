import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_legend_table.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_title.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';

import '../../enums/diagram_enum.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class GlobalTradeDiagram extends BaseDiagramPainter {
  GlobalTradeDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // Draw Base Axes
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
    );
    if (diagram != DiagramEnum.globalWorldPriceHigher &&
        diagram != DiagramEnum.globalWorldPriceLower) {
      _paintDomesticDemandAndSupply(c, canvas);
    }

    // Draw Specific Diagram Logic
    switch (diagram) {
      case DiagramEnum.globalWorldPriceHigher:
      case DiagramEnum.globalWorldPriceLower:
        _paintWorldPrice(c, canvas, diagram);
        break;
      case DiagramEnum.globalDomesticExporter:
      case DiagramEnum.globalDomesticImporter:
        _paintDomesticNetExporterImporter(c, canvas, diagram);
        break;
      case DiagramEnum.globalTariff:
        _paintTariff(c, canvas, diagram);
        break;
      // --- NEW CASES ---
      case DiagramEnum.globalImportQuota:
        _paintImportQuota(c, canvas);
        break;
      case DiagramEnum.globalProductionSubsidy:
        _paintProductionSubsidy(c, canvas);
        break;
      case DiagramEnum.globalExportSubsidy:
        _paintExportSubsidy(c, canvas);
        break;
      default:
        break;
    }
  }
}

void _paintWorldPrice(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
  DiagramEnum diagram,
) {
  paintTitle(c, canvas, 'World Market');

  if (diagram == DiagramEnum.globalWorldPriceHigher) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demandWorld,
      horizontalShift: 0.10,
      verticalShift: -0.10,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supplyWorld,
      horizontalShift: 0,
      verticalShift: -0.10,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 1.5,
      hideXLine: true,
      yLabel: DiagramLabel.pW.label,
    );
  }
  if (diagram == DiagramEnum.globalWorldPriceLower) {
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demandWorld,
      horizontalShift: -0.05,
      verticalShift: 0.25,
      lengthAdjustment: -0.30,
      angle: -0.30,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supplyWorld,
      horizontalShift: 0.00,
      verticalShift: 0.22,
      lengthAdjustment: -0.30,
      angle: 0.20,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.75,
      xAxisEndPos: 1.5,
      hideXLine: true,
      yLabel: DiagramLabel.pW.label,
    );
  }
}

void _paintDomesticNetExporterImporter(c, canvas, diagram) {
  paintTitle(c, canvas, 'Domestic Market');
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.pD.label,
    xLabel: DiagramLabel.qD.label,
    showDotAtIntersection: true,
  );
  if (diagram == DiagramEnum.globalDomesticImporter) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.75,
      xAxisEndPos: 0.75,
      showDotAtIntersection: true,
      xLabel: DiagramLabel.q2.label,
      yLabel: DiagramLabel.pW.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.75,
      xAxisEndPos: 0.25,
      showDotAtIntersection: true,
      xLabel: DiagramLabel.q1.label,
      hideYLine: true,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.75),
      polylineOffsets: [Offset(0.90, 0.75)],
      color: Colors.red,
      label2: DiagramLabel.sW.label,
      label2Align: LabelAlign.centerRight,
    );
    paintText(c, canvas, DiagramLabel.a.label, Offset(0.15, 0.35));
    paintText(c, canvas, DiagramLabel.b.label, Offset(0.15, 0.65));
    paintText(c, canvas, DiagramLabel.c.label, Offset(0.45, 0.65));
    paintText(c, canvas, DiagramLabel.d.label, Offset(0.55, 0.65));
    paintText(c, canvas, DiagramLabel.e.label, Offset(0.15, 0.78));
    paintLegendTable(
      canvas,
      c,
      headers: ['', 'Autarky', 'Free Trade'],
      data: [
        ['Consumer Surplus', '+a', '+(a,b,c,d)'],
        ['Producer Surplus', '+(b,e)', '+e'],
        ['Social Welfare', '+(a,b,e)', '+(a,b,c,d,e)'],
      ],
    );
  }
  if (diagram == DiagramEnum.globalDomesticExporter) {
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.65,
      showDotAtIntersection: true,
      xLabel: DiagramLabel.q2.label,
      yLabel: DiagramLabel.pW.label,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.35,
      showDotAtIntersection: true,
      xLabel: DiagramLabel.q1.label,
      hideYLine: true,
    );
    paintDiagramLines(
      c,
      canvas,
      startPos: Offset(0, 0.35),
      polylineOffsets: [Offset(1, 0.35)],
      color: Colors.red,
    );
    paintText(c, canvas, DiagramLabel.a.label, Offset(0.15, 0.25));
    paintText(c, canvas, DiagramLabel.b.label, Offset(0.15, 0.42));
    paintText(c, canvas, DiagramLabel.c.label, Offset(0.38, 0.42));
    paintText(c, canvas, DiagramLabel.d.label, Offset(0.50, 0.42));
    paintText(c, canvas, DiagramLabel.e.label, Offset(0.15, 0.55));
    paintText(c, canvas, DiagramLabel.f.label, Offset(0.38, 0.55));
    paintLegendTable(
      canvas,
      c,
      headers: ['', 'Autarky', 'Free Trade'],
      data: [
        ['Consumer Surplus', '+(a,b,c)', '+a'],
        ['Producer Surplus', '+(e,f)', '+(b,c,d,e,f)'],
        ['Social Welfare', '+(a,b,e,f)', '+(a,b,c,d,e,f)'],
      ],
    );
  }
}

void _paintTariff(c, canvas, diagram) {
  paintAxis(
    c,
    canvas,
    yAxisLabel: DiagramLabel.p.label,
    xAxisLabel: DiagramLabel.q.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.75,
    xAxisEndPos: 0.90,
    hideXLine: true,
    yLabel: DiagramLabel.pW.label,
    rightYLabel: DiagramLabel.sW.label,
    additionalXPositions: [0.25, 0.75],
    additionalXLabels: [DiagramLabel.q1.label, DiagramLabel.q4.label],
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.60,
    xAxisEndPos: 0.90,
    hideXLine: true,
    yLabel: DiagramLabel.pWT.label,
    rightYLabel: DiagramLabel.sWT.label,
    additionalXPositions: [0.40, 0.60],
    additionalXLabels: [DiagramLabel.q2.label, DiagramLabel.q3.label],
  );
  paintDiagramLines(
    c,
    canvas,
    startPos: Offset(0, 0.60),
    polylineOffsets: [Offset(0.90, 0.60)],
    color: Colors.red,
  );
  paintText(c, canvas, DiagramLabel.a.label, Offset(0.15, 0.55));
  paintText(c, canvas, DiagramLabel.b.label, Offset(0.50, 0.55));
  paintText(c, canvas, DiagramLabel.c.label, Offset(0.15, 0.675));
  paintText(c, canvas, DiagramLabel.d.label, Offset(0.33, 0.71));
  paintText(c, canvas, DiagramLabel.e.label, Offset(0.50, 0.675));
  paintText(c, canvas, DiagramLabel.f.label, Offset(0.65, 0.71));
  paintText(c, canvas, DiagramLabel.g.label, Offset(0.15, 0.78));

  paintLegendTable(
    canvas,
    c,
    headers: ['', DiagramLabel.autarky.label, DiagramLabel.tariff.label],
    data: [
      [DiagramLabel.consumerSurplus.label, '+(a,b,c,d,e,f)', '+(a,b)'],
      [DiagramLabel.producerSurplus.label, '+g', '+(g,c)'],
      [DiagramLabel.governmentBudget.label, '-', '+e'],
      [
        DiagramLabel.socialWelfare.label,
        '+(a,b,c,d,e,f,g)',
        '+(a,b,c,e,g) -(d,f)',
      ],
    ],
  );
  paintLineSegment(c, canvas, origin: Offset(0.80, 0.68), angle: pi * 1.5);
}

void _paintImportQuota(DiagramPainterConfig c, IDiagramCanvas canvas) {
  // Draw Curves

  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supplyDomestic,
    horizontalShift: 0.20,
    lengthAdjustment: -0.375,
    label: DiagramLabel.sDQ.label,
    color: Colors.red,
  );
  // 1. Free Trade (World Price) - Low Price
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.75,
    // Low Price
    yLabel: DiagramLabel.pW.label,
    rightYLabel: DiagramLabel.sW.label,
    xAxisEndPos: 0.90,
    // Draws line across
    hideXLine: true,
    // We will draw specific drops manually
    additionalXPositions: [0.25, 0.75],
    // Q1 and Q4
    additionalXLabels: [DiagramLabel.q1.label, DiagramLabel.q4.label],
  );

  // 2. Quota Price (Higher than World, Lower than Autarky)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.60,
    // Quota Price
    yLabel: DiagramLabel.pQ.label,
    // P_quota
    rightYLabel: DiagramLabel.sWQ.label,
    xAxisEndPos: 0.90,
    hideXLine: true,
    additionalXPositions: [0.40, 0.60],
    // Q2 and Q3
    additionalXLabels: [DiagramLabel.q2.label, DiagramLabel.q3.label],
  );

  // Labels for Areas
  // A: Producer Gain (Left Trapezoid)
  paintText(c, canvas, DiagramLabel.a.label, Offset(0.15, 0.55));
  paintText(c, canvas, DiagramLabel.b.label, Offset(0.50, 0.55));
  paintText(c, canvas, DiagramLabel.c.label, Offset(0.15, 0.675));
  paintText(c, canvas, DiagramLabel.d.label, Offset(0.35, 0.70));
  paintText(c, canvas, DiagramLabel.e.label, Offset(0.45, 0.675));
  paintText(c, canvas, DiagramLabel.f.label, Offset(0.55, 0.70));
  paintText(c, canvas, DiagramLabel.g.label, Offset(0.65, 0.70));
  paintText(c, canvas, DiagramLabel.h.label, Offset(0.15, 0.80));

  paintLegendTable(
    canvas,
    c,
    headers: ['', DiagramLabel.autarky.label, DiagramLabel.quota.label],
    data: [
      [DiagramLabel.consumerSurplus.label, '+(a,b,c,d,e,f,g)', '+(a,b)'],
      [DiagramLabel.producerSurplus.label, '+h', '+(c,h)'],
      ['Quota Licence Holder', '-', '+(e,f)'],
      [
        DiagramLabel.socialWelfare.label,
        '+(a,b,c,d,e,f,g,h)',
        '+(a,b,c,h) -(d,e,f,g)',
      ],
    ],
  );
  paintLineSegment(c, canvas, origin: Offset(0.76, 0.35));
}

void _paintProductionSubsidy(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supplyDomestic,
    verticalShift: 0.10,
    horizontalShift: 0.10,
    lengthAdjustment: -0.20,
    label: DiagramLabel.sDSub.label,
    color: Colors.red,
  );
  // 1. World Price (Consumer pays this)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.75,
    yLabel: DiagramLabel.pW.label,
    rightYLabel: DiagramLabel.sW.label,
    xAxisEndPos: 0.90,
    // Line goes across
    hideXLine: true,
    additionalXPositions: [0.25, 0.75],
    // Qs1 and Qd
    additionalXLabels: [DiagramLabel.q1.label, DiagramLabel.q3.label],
  );

  // 2. Producer Price (Pw + Subsidy)
  // Shifted point on the Supply Curve
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.55,
    // Higher price received by producers
    yLabel: DiagramLabel.pP.label,
    // Price Producer
    xAxisEndPos: 0.45,
    // Qs2 (Increased Supply)
    xLabel: DiagramLabel.q2.label,
    hideYLine: false,
    makeDashed: true,
  );

  // Visualizing the Subsidy Amount (Vertical line between Qs2 points)
  // Drawing a line from (Qs2, Pw) up to (Qs2, Pp) is helpful but the dashed lines cover it.

  // Labels
  // A: Producer Gain (Trapezoid)
  paintText(c, canvas, DiagramLabel.a.label, Offset(0.15, 0.45));
  // B: DWL (Production Inefficiency Triangle)
  paintText(c, canvas, DiagramLabel.b.label, Offset(0.15, 0.65));
  // C: Consumer Surplus
  paintText(c, canvas, DiagramLabel.c.label, Offset(0.40, 0.675));
  // D: Initial PS
  paintText(c, canvas, DiagramLabel.d.label, Offset(0.50, 0.60));
  paintText(c, canvas, DiagramLabel.e.label, Offset(0.60, 0.675));
  paintText(c, canvas, DiagramLabel.f.label, Offset(0.15, 0.79));
  paintLegendTable(
    canvas,
    c,
    headers: ['', DiagramLabel.autarky.label, DiagramLabel.subsidy.label],
    data: [
      [DiagramLabel.consumerSurplus.label, '+(a,b,c,d,e)', '+(a,b,c,d,e)'],
      [DiagramLabel.producerSurplus.label, '+f', '+(b,f)'],
      [DiagramLabel.governmentBudget.label, '-', '-(b,c)'],
      [DiagramLabel.socialWelfare.label, '+(a,b,c,d,e,f)', '+(a,b,d,e,f),-c'],
    ],
  );
  paintLineSegment(c, canvas, origin: Offset(0.68, 0.40), angle: pi / 2);
}

void _paintExportSubsidy(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supplyDomestic,
    verticalShift: -0.05,
    lengthAdjustment: -0.30,
    horizontalShift: 0.20,
    label: DiagramLabel.sDSub.label,
    color: Colors.red,
  );
  // 1. World Price (Baseline)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    yLabel: DiagramLabel.pW.label,
    rightYLabel: DiagramLabel.sW.label,
    xAxisEndPos: 0.90,
    hideXLine: true,
    additionalXPositions: [0.30, 0.70],
    // Q_d1, Q_s1 (Exporting start)
    additionalXLabels: [DiagramLabel.q2.label, DiagramLabel.q3.label],
  );

  // 2. Domestic Price (Pw + Subsidy) - Price Rises
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.15,
    // Higher Price
    yLabel: DiagramLabel.pWS.label,
    xAxisEndPos: 0.85,
    hideXLine: true,
    additionalXPositions: [0.15, 0.85],
    // Q_d2 (falls), Q_s2 (rises)
    additionalXLabels: [DiagramLabel.q1.label, DiagramLabel.q4.label],
  );

  // Labels
  paintText(c, canvas, DiagramLabel.a.label, Offset(0.05, 0.10));
  paintText(c, canvas, DiagramLabel.b.label, Offset(0.05, 0.225));
  paintText(c, canvas, DiagramLabel.c.label, Offset(0.20, 0.25));
  paintText(c, canvas, DiagramLabel.d.label, Offset(0.50, 0.225));
  paintText(c, canvas, DiagramLabel.e.label, Offset(0.80, 0.25));
  paintText(c, canvas, DiagramLabel.f.label, Offset(0.05, 0.45));
  paintText(c, canvas, DiagramLabel.g.label, Offset(0.20, 0.45));
  paintText(c, canvas, DiagramLabel.h.label, Offset(0.35, 0.45));
  paintText(c, canvas, DiagramLabel.i.label, Offset(0.50, 0.375));
  paintLegendTable(
    canvas,
    c,
    headers: ['', DiagramLabel.autarky.label, DiagramLabel.subsidy.label],
    data: [
      [DiagramLabel.consumerSurplus.label, '+(a,b,c)', '+a'],
      [DiagramLabel.producerSurplus.label, '+(f,g,h,i)', '+(b,c,d,f,g,h,i)'],
      [DiagramLabel.governmentBudget.label, '-', '-(c,d,e)'],
      [
        DiagramLabel.socialWelfare.label,
        '+(a,b,c,f,g,h,i)',
        '+(a,b,f,g,h,i), -(c,e)',
      ],
    ],
  );
  paintLineSegment(
    c,
    canvas,
    origin: Offset(0.90, 0.16),
    angle: pi / 2,
    length: 0.08,
  );
}

void _paintDomesticDemandAndSupply(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.demandDomestic,
    lengthAdjustment: 0.10,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.supplyDomestic,
    lengthAdjustment: 0.10,
  );
}
