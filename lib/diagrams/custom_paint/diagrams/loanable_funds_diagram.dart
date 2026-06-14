import 'dart:math';

import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/shortcut_methods/paint_market_curve.dart';
import 'package:economics_app/diagrams/enums/diagram_enum.dart';
import 'package:economics_app/diagrams/enums/diagram_labels.dart';
import 'package:flutter/material.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';

class LoanableFundsDiagram extends BaseDiagramPainter {
  LoanableFundsDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    switch (diagram) {
      case DiagramEnum.macroLoanableFundsDemandIncrease:
        _paintIncrease(c, canvas);
        break;
      case DiagramEnum.macroLoanableFundsSupplyDecrease:
        _paintDecrease(c, canvas);
      case DiagramEnum.macroLoanableFundsFisherEffect:
        _paintFisherEffect(c, canvas);
      default:
        // Fallback or empty
        break;
    }
  }
}

// 1. STANDARD MONEY MARKET (Equilibrium)
void _paintIncrease(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintAxis(axisType: AxisType.loanableFunds, c, canvas);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.55,
    xAxisEndPos: 0.45,
    yLabel: DiagramLabel.i1.label,
    hideXLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.40,
    xAxisEndPos: 0.60,
    yLabel: DiagramLabel.i2.label,
    hideXLine: true,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.loanableFundsDemand1,
    horizontalShift: -0.05,
    verticalShift: 0.05,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.loanableFundsDemand2,
    horizontalShift: 0.10,
    verticalShift: -0.10,
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.loanableFundsSupply);
  // Draw Curves
}

void _paintDecrease(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintAxis(axisType: AxisType.loanableFunds, c, canvas);
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.55,
    xAxisEndPos: 0.55,
    yLabel: DiagramLabel.i1.label,
    hideXLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.40,
    xAxisEndPos: 0.40,
    yLabel: DiagramLabel.i2.label,
    hideXLine: true,
  );
  paintMarketCurve(c, canvas, type: MarketCurveType.loanableFundsDemand);
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.loanableFundsSupply1,
    horizontalShift: 0.05,
    verticalShift: 0.05,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.loanableFundsSupply2,
    horizontalShift: -0.10,
    verticalShift: -0.10,
  );
  // Draw Curves
}

void _paintFisherEffect(DiagramPainterConfig c, IDiagramCanvas canvas) {
  paintAxis(
    axisType: AxisType.loanableFunds,
    c,
    canvas,
    yAxisLabel: DiagramLabel.nominalInterestRate.label,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.60,
    xAxisEndPos: 0.50,
    yLabel: '3%',
    hideXLine: true,
  );
  paintDiagramDashedLines(
    c,
    canvas,
    yAxisStartPos: 0.30,
    xAxisEndPos: 0.50,
    yLabel: '5%',
    hideXLine: true,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.loanableFundsDemand1,
    horizontalShift: -0.05,
    verticalShift: 0.05,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.loanableFundsDemand2,
    horizontalShift: 0.10,
    verticalShift: -0.10,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.loanableFundsSupply1,
    horizontalShift: 0.05,
    verticalShift: 0.05,
  );
  paintMarketCurve(
    c,
    canvas,
    type: MarketCurveType.loanableFundsSupply2,
    horizontalShift: -0.10,
    verticalShift: -0.10,
  );
  paintLineSegment(c, canvas, origin: Offset(0.72, 0.70));
  paintLineSegment(c, canvas, origin: Offset(0.70, 0.25), angle: pi);
}
