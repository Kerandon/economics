import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_constants.dart';

import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/paint_axis.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_diagram_dash_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
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

class CompetitiveMarket extends BaseDiagramPainter {
  CompetitiveMarket(super.config, super.diagram);

  @override
  void drawDiagram(
    IDiagramCanvas canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    final c = config.copyWith(painterSize: size);

    // Delegate to specific painters based on the diagram category
    switch (diagram) {
      // 1. Standard Market Analysis
      case DiagramEnum.microMarketEquilibrium:
      case DiagramEnum.microShortage:
      case DiagramEnum.microSurplus:
        _paintStandardMarket(c, canvas);
        break;

      // 2. Price Mechanism (Demand Shifts)
      case DiagramEnum.microDemandIncreasePriceMechanism:
      case DiagramEnum.microDemandDecreasePriceMechanism:
      case DiagramEnum.microPriceRationing:
        _paintPriceMechanism(c, canvas);
        break;

      // 3. Marginal Analysis (Step Curves)
      case DiagramEnum.microMarginalBenefit:
      case DiagramEnum.microMarginalCostSteps:
        _paintMarginalSteps(c, canvas);
        break;

      // 4. Welfare Analysis (CS, PS, Allocative Efficiency)
      case DiagramEnum.microConsumerSurplus:
      case DiagramEnum.microProducerSurplus:
      case DiagramEnum.microAllocativeEfficiency:
        _paintWelfareAnalysis(c, canvas);
        break;

      default:
        paintAxis(c, canvas);
        break;
    }
  }

  /// 1. Standard Market: Equilibrium, Shortage, or Surplus
  void _paintStandardMarket(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintAxis(c, canvas);

    // Draw Standard Curves
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      lengthAdjustment: 0.20,
    );
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      lengthAdjustment: 0.20,
    );

    // Draw Equilibrium Lines (center)
    // We always show Pe/Qe unless it's a specific disequilibrium diagram where it might be clutter
    if (diagram == DiagramEnum.microMarketEquilibrium) {
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.50,
        xAxisEndPos: 0.50,
        yLabel: DiagramLabel.pE.label,
        xLabel: DiagramLabel.qE.label,
      );
    }

    // Handle Disequilibrium (Shortage/Surplus)
    if (diagram == DiagramEnum.microShortage) {
      // Price Floor Logic (Below Equilibrium)
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.70,
        xAxisEndPos: 0.70,
        yLabel: DiagramLabel.p1.label,
        xLabel: DiagramLabel.qD.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.70,
        xAxisEndPos: 0.30,
        xLabel: DiagramLabel.qS.label,
      );

      // Curly Brace for Shortage
      paintLineSegment(
        c,
        canvas,
        origin: const Offset(0.50, 0.74), // Between Qs(0.3) and Qd(0.7)
        length: 0.40,
        angle: 0,
        endStyle: LineEndStyle.arrowRightAngles, // <--- New Style
        label: DiagramLabel.shortage.label,
        labelAlign: LabelAlign.centerBottom,
      );
    } else if (diagram == DiagramEnum.microSurplus) {
      // Price Ceiling Logic (Above Equilibrium)
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.30,
        xAxisEndPos: 0.30,
        yLabel: DiagramLabel.p1.label,
        xLabel: DiagramLabel.qD.label,
      );
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.30,
        xAxisEndPos: 0.70,
        xLabel: DiagramLabel.qS.label,
      );

      // Curly Brace for Surplus
      paintLineSegment(
        c,
        canvas,
        origin: const Offset(0.50, 0.26), // Between Qd(0.3) and Qs(0.7)
        length: 0.40,
        angle: 0,
        endStyle: LineEndStyle.arrowRightAngles, // <--- New Style
        label: DiagramLabel.surplus.label,
        labelAlign: LabelAlign.centerTop,
      );
    }
  }

  /// 2. Price Mechanism: Shifts in Demand
  void _paintPriceMechanism(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintAxis(c, canvas);

    final isIncrease =
        diagram == DiagramEnum.microDemandIncreasePriceMechanism ||
        diagram == DiagramEnum.microPriceRationing;

    // Draw Supply (Static)
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.supply,
      lengthAdjustment: -0.15,
    );

    // Draw D1 and D2
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      horizontalShift: -0.15,
      lengthAdjustment: -0.15,
      label: isIncrease ? DiagramLabel.d1.label : DiagramLabel.d2.label,
    );

    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      horizontalShift: 0.15,
      lengthAdjustment: -0.15,
      label: isIncrease ? DiagramLabel.d2.label : DiagramLabel.d1.label,
    );

    if (isIncrease) {
      // --- INCREASE SCENARIO ---
      // 1. Initial Equilibrium (P1, Q1)
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.575,
        xAxisEndPos: 0.425,
        yLabel: DiagramLabel.p1.label,
        xLabel: DiagramLabel.q1.label,
      );

      // 2. New Equilibrium (P2, Q2)
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.425,
        xAxisEndPos: 0.575,
        yLabel: DiagramLabel.p2.label,
        xLabel: DiagramLabel.q2.label,
      );

      // 3. Temporary point at Q3 (Extension of old price to new demand)
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.575,
        xAxisEndPos: 0.725,
        hideYLine: true,
        xLabel: DiagramLabel.q3.label,
      );

      // 4. Shortage Brace
      paintLineSegment(
        c,
        canvas,
        origin: const Offset(0.575, 0.60), // Under the old price line
        length: 0.30,
        endStyle: LineEndStyle.arrowRightAngles,
        label: DiagramLabel.shortage.label,
        labelAlign: LabelAlign.centerBottom,
      );

      // 5. Dynamic Arrows (Extension/Contraction)
      paintLineSegment(
        c,
        canvas,
        origin: const Offset(0.69, 0.48),
        angle: -pi / 1.33, // Extension along Supply
      );
      paintLineSegment(
        c,
        canvas,
        origin: const Offset(0.45, 0.50),
        angle: -pi / 4, // Contraction along Demand
      );
    } else {
      // --- DECREASE SCENARIO ---
      // 1. Initial Equilibrium (P1, Q1)
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.425,
        xAxisEndPos: 0.575,
        yLabel: DiagramLabel.p1.label,
        xLabel: DiagramLabel.q1.label,
      );

      // 2. New Equilibrium (P2, Q2)
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.575,
        xAxisEndPos: 0.425,
        yLabel: DiagramLabel.p2.label,
        xLabel: DiagramLabel.q2.label,
      );

      // 3. Temporary point (Extension of old price to new demand)
      paintDiagramDashedLines(
        c,
        canvas,
        yAxisStartPos: 0.425,
        xAxisEndPos: 0.275,
        hideYLine: true,
        xLabel: DiagramLabel.q3.label,
      );

      // 4. Surplus Brace
      paintLineSegment(
        c,
        canvas,
        origin: const Offset(0.425, 0.40), // Above the old price line
        length: 0.30,
        endStyle: LineEndStyle.arrowRightAngles,
        label: DiagramLabel.surplus.label,
        labelAlign: LabelAlign.centerTop,
      );

      // 5. Dynamic Arrows
      paintLineSegment(
        c,
        canvas,
        origin: const Offset(0.31, 0.50),
        angle: pi * 0.25,
      );
      paintLineSegment(
        c,
        canvas,
        origin: const Offset(0.54, 0.51),
        angle: pi * 0.75,
      );
    }
  }

  /// 3. Marginal Analysis: MB and MC Steps
  void _paintMarginalSteps(DiagramPainterConfig c, IDiagramCanvas canvas) {
    // Custom Grid Axis
    paintAxis(
      c,
      canvas,
      drawGridlines: true,
      gridLineStyle: GridLineStyle.indents,
      yMaxValue: 100,
      xMaxValue: 10,
      xDivisions: 10,
      yDivisions: 10,
    );

    bool isBenefit = diagram == DiagramEnum.microMarginalBenefit;

    // Draw Grid Numbers efficiently
    for (int i = 0; i < 10; i++) {
      double val = isBenefit ? (90.0 - i * 10) : (i * 10.0);
      double pos = 0.05 + i * 0.10;
      paintText(
        c,
        canvas,
        val.toInt().toString(),
        Offset(pos, isBenefit ? pos : (1.0 - pos)),
      );
    }

    // Build Step Path
    List<Offset> steps = [];
    if (isBenefit) {
      for (double i = 0; i <= 0.9; i += 0.1) {
        steps.add(Offset(i, i + 0.1));
        steps.add(Offset(i + 0.1, i + 0.1));
      }
    } else {
      for (double i = 0.0; i <= 0.9; i += 0.1) {
        steps.add(Offset(i, 1.0 - i));
        steps.add(Offset(i + 0.1, 1.0 - i));
      }
    }

    paintDiagramLines(
      c,
      canvas,
      color: isBenefit ? c.colorScheme.primary : Colors.deepOrange,
      startPos: isBenefit ? const Offset(0, 0.10) : const Offset(0, 1.0),
      polylineOffsets: steps,
    );

    // Explanatory Text
    paintText(
      c,
      canvas,
      isBenefit
          ? 'The Law Of Diminishing\nMarginal Utility\nleads to falling MB'
          : 'The Law Of Diminishing\nMarginal Returns\nleads to rising MC',
      Offset(isBenefit ? 0.72 : 0.36, 0.20),
    );
  }

  /// 4. Welfare Analysis: Consumer/Producer Surplus
  void _paintWelfareAnalysis(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintAxis(c, canvas);

    // 1. Draw Curves (MB and MC labels)
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0.0, 0.10),
      polylineOffsets: [const Offset(0.90, 0.90)],
      label2: DiagramLabel.dEqualsMB.label,
      label2Align: LabelAlign.centerRight,
    );

    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0.0, 0.90),
      polylineOffsets: [const Offset(0.90, 0.10)],
      label2: DiagramLabel.sEqualsMC.label,
      label2Align: LabelAlign.centerRight,
    );

    // 2. Shading Logic
    if (diagram == DiagramEnum.microConsumerSurplus ||
        diagram == DiagramEnum.microAllocativeEfficiency) {
      paintShading(c, canvas, ShadeType.consumerSurplus, [
        const Offset(0, 0.10),
        const Offset(0.45, 0.50),
        const Offset(0, 0.50),
      ]);
      paintText(
        c,
        canvas,
        DiagramLabel.consumerSurplus.label,
        const Offset(0.25, 0.10),
        pointerLine: const Offset(0.25, 0.40),
      );
    }

    if (diagram == DiagramEnum.microProducerSurplus ||
        diagram == DiagramEnum.microAllocativeEfficiency) {
      paintShading(c, canvas, ShadeType.producerSurplus, [
        const Offset(0, 0.50),
        const Offset(0.45, 0.50),
        const Offset(0, 0.90),
      ]);
      paintText(
        c,
        canvas,
        DiagramLabel.producerSurplus.label,
        const Offset(0.25, 0.90),
        pointerLine: const Offset(0.25, 0.60),
      );
    }

    // 3. Equilibrium Lines
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.45,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
    );
  }
}
