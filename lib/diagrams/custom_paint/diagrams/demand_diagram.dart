import 'dart:math';

import 'package:flutter/material.dart';

import '../../enums/diagram_enum.dart';
import '../../enums/diagram_labels.dart';
import '../../models/base_painter_painter.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/paint_line_segment.dart';

import '../painter_methods/shortcut_methods/paint_market_curve.dart';

class DemandDiagram extends BaseDiagramPainter {
  DemandDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // Draw the specific diagram elements
    switch (diagram) {
      case DiagramEnum.microDemand:
        _paintDemand(c, canvas);
        break;
      case DiagramEnum.microDemandIncrease:
      case DiagramEnum.microDemandDecrease:
        _paintIncreaseDecreaseDemand(c, canvas, diagram);
        break;
      case DiagramEnum.microDemandExtension:
      case DiagramEnum.microDemandContraction:
      case DiagramEnum.microDemandQuantityChangeDueToSupply:
        _paintExtensionContractionDemand(c, canvas, diagram);
        break;
      default:
        break;
    }
  }

  // --- PRIVATE METHODS ---

  void _paintDemand(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintAxis(c, canvas);

    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.50,
      yLabel: DiagramLabel.pE.label,
      xLabel: DiagramLabel.qE.label,
    );

    paintMarketCurve(c, canvas, type: MarketCurveType.demand);
  }

  void _paintIncreaseDecreaseDemand(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum diagram,
  ) {
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
    );

    final isDecrease = diagram == DiagramEnum.microDemandDecrease;

    // Draw directional arrow
    paintLineSegment(
      c,
      canvas,
      origin: isDecrease ? const Offset(0.42, 0.40) : const Offset(0.38, 0.40),
      angle: isDecrease ? pi : 0,
      length: 0.15,
    );

    // Initial Curve (D1)
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      horizontalShift: -0.15,
      lengthAdjustment: -0.15,
      label: isDecrease ? DiagramLabel.d2.label : DiagramLabel.d1.label,
    );

    // Shifted Curve (D2)
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.demand,
      horizontalShift: 0.15,
      lengthAdjustment: -0.15,
      label: isDecrease ? DiagramLabel.d1.label : DiagramLabel.d2.label,
    );

    // Dashed lines for Q1
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.65,

      yLabel: DiagramLabel.p.label,
      xLabel: isDecrease ? DiagramLabel.q1.label : DiagramLabel.q2.label,
    );

    // Dashed lines for Q2
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.35,

      hideYLine: true,
      xLabel: isDecrease ? DiagramLabel.q2.label : DiagramLabel.q1.label,
    );
  }

  void _paintExtensionContractionDemand(
    DiagramPainterConfig c,
    IDiagramCanvas canvas,
    DiagramEnum diagram,
  ) {
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.p.label,
      xAxisLabel: DiagramLabel.q.label,
    );

    final isContraction = diagram == DiagramEnum.microDemandContraction;
    final isSupplyChange =
        diagram == DiagramEnum.microDemandQuantityChangeDueToSupply;

    // Calculate arrow angle
    // Standard contraction moves up-left, extension moves down-right
    final double angle = isContraction ? pi / -1.33 : pi / 4.1;

    // Draw Supply curves if the change is driven by Supply
    if (isSupplyChange) {
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.supply,
        lengthAdjustment: -0.15,
        label: DiagramLabel.s1.label,
        horizontalShift: -0.15,
        verticalShift: -0.15,
      );
      paintMarketCurve(
        c,
        canvas,
        type: MarketCurveType.supply,
        lengthAdjustment: -0.15,
        label: DiagramLabel.s2.label,
        horizontalShift: 0.10,
        verticalShift: 0.10,
      );
    }

    paintMarketCurve(c, canvas, type: MarketCurveType.demand);

    // Draw movement arrow along the curve
    paintLineSegment(
      c,
      canvas,
      origin: Offset(isContraction ? 0.52 : 0.50, isContraction ? 0.45 : 0.43),
      angle: angle,
      length: 0.25,
    );

    // P1 Q1
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.35,
      xAxisEndPos: 0.35,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );

    // P2 Q2
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.60,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );
  }
}

// --- CONSTANTS ---
