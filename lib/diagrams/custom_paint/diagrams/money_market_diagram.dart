import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class MoneyMarketDiagram extends BaseDiagramPainter {
  MoneyMarketDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // Draw Axes (Nominal Interest Rate vs Quantity of Money)
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.interestRate.label,
      xAxisLabel: DiagramLabel.quantityOfMoney.label,
    );

    switch (diagram) {
      case DiagramEnum.macroMoneyMarket:
        _paintMoneyMarket(c, canvas);
        break;
      case DiagramEnum.macroMoneyMarketExpansionaryMonetaryPolicy:
        _paintMoneyMarketExpansionary(c, canvas);
        break;
      case DiagramEnum.macroMoneyMarketContractionaryMonetaryPolicy:
        _paintMoneyMarketContractionary(c, canvas);
        break;
      default:
        // Fallback or empty
        break;
    }
  }
}

// 1. STANDARD MONEY MARKET (Equilibrium)
void _paintMoneyMarket(DiagramPainterConfig c, IDiagramCanvas canvas) {
  // Draw Curves
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.moneySupply,
  ); // Defaults to MS
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.moneyDemand,
  ); // Defaults to Md

  // Draw Equilibrium Lines (iE and QE)
  // Assuming intersection is at center (0.5, 0.5)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    yLabel: DiagramLabel.iE.label,
    hideXLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.50,
    xAxisEndPos: 0.50,
    xLabel: DiagramLabel.qE.label,
    hideXLine: true,
    hideYLine: true,
  );
}

// 2. EXPANSIONARY (MS Shifts Right -> Interest Rate Falls)
void _paintMoneyMarketExpansionary(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  // 1. Draw Money Demand (Static)
  paintMarketCurve(c, canvas, type: MarketCurveType.moneyDemand);

  // 2. Draw MS1 (Initial - Left) at X = 0.4
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.moneySupply,
    lrasX: 0.40,
    label: DiagramLabel.mS1.label,
  );

  // 3. Draw MS2 (New - Right) at X = 0.6
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.moneySupply,
    lrasX: 0.60,
    label: DiagramLabel.mS2.label,
  );

  // 5. Draw Equilibrium 1 (High Interest Rate)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.40, // Intersection at 0.4 since Md is diagonal
    xAxisEndPos: 0.40,
    yLabel: DiagramLabel.i1.label,
    xLabel: DiagramLabel.q1.label,
    hideXLine: true,
    showDotAtIntersection: true,
  );

  // 6. Draw Equilibrium 2 (Low Interest Rate)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.60, // Intersection moves "down" visually (higher Y value)
    xAxisEndPos: 0.60,
    yLabel: DiagramLabel.i2.label,
    xLabel: DiagramLabel.q2.label,
    hideXLine: true,
    showDotAtIntersection: true,
  );
  paintLineSegment(c, canvas, origin: Offset(0.50, 0.20));
}

// 3. CONTRACTIONARY (MS Shifts Left -> Interest Rate Rises)
void _paintMoneyMarketContractionary(
  DiagramPainterConfig c,
  IDiagramCanvas canvas,
) {
  // 1. Draw Money Demand (Static)
  paintMarketCurve(c, canvas, type: MarketCurveType.moneyDemand);

  // 2. Draw MS1 (Initial - Right) at X = 0.6
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.moneySupply,
    lrasX: 0.60,
    label: DiagramLabel.mS1.label,
  );

  // 3. Draw MS2 (New - Left) at X = 0.4
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.moneySupply,
    lrasX: 0.40,
    label: DiagramLabel.mS2.label,
  );

  // 5. Draw Equilibrium 1 (Low Interest Rate)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.60, // Initial intersection low on graph
    xAxisEndPos: 0.60,
    yLabel: DiagramLabel.i1.label,
    xLabel: DiagramLabel.q1.label,
    hideXLine: true,
    showDotAtIntersection: true,
  );

  // 6. Draw Equilibrium 2 (High Interest Rate)
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.40, // New intersection high on graph
    xAxisEndPos: 0.40,
    yLabel: DiagramLabel.i2.label,
    xLabel: DiagramLabel.q2.label,
    hideXLine: true,
    showDotAtIntersection: true,
  );
  paintLineSegment(c, canvas, origin: Offset(0.51, 0.20), angle: pi);
}
