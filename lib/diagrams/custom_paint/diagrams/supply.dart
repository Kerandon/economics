import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_entry.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_shape.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment_MAKEREDUNDANT.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/diagrams/models/custom_bezier.dart';
import '../../enums/diagram_enum.dart';
import '../../enums/diagram_labels.dart';
import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

import '../../models/base_painter_painter.dart';
import '../painter_methods/axis/paint_axis.dart';
import '../painter_methods/paint_diagram_dash_lines.dart';
import '../painter_methods/diagram_lines/paint_diagram_lines.dart';
import 'package:flutter/material.dart';
import '../painter_methods/shortcut_methods/paint_market_curve.dart';

class SupplyDiagram extends BaseDiagramPainter {
  SupplyDiagram(super.config, super.diagram);

  @override
  void drawDiagram(IDiagramCanvas canvas, Size size) {
    final c = config.copyWith(painterSize: size);

    // 1. Determine Labels & Paint Axis
    final labels = _getAxisLabels();
    paintAxis(c, canvas, yAxisLabel: labels.y, xAxisLabel: labels.x);

    // 2. Route to Specific Painters
    switch (diagram) {
      case DiagramEnum.microSupplyExtension:
      case DiagramEnum.microSupplyContraction:
        _paintSupplyMovement(c, canvas);
        break;
      case DiagramEnum.microSupplyIncrease:
      case DiagramEnum.microSupplyDecrease:
        _paintSupplyShift(c, canvas);
        break;
      case DiagramEnum.microTotalAndMarginalProduct:
        _paintTotalMarginalProduct(c, canvas);
        break;
      case DiagramEnum.microMarginalProduct:
        _paintMarginalProduct(c, canvas);
        break;
      case DiagramEnum.microMarginalCost:
      case DiagramEnum.microMarginalCostSupplyCurve:
        _paintMarginalCost(c, canvas);
        break;
      default:
        break;
    }
  }

  // --- HELPER: AXIS LABELS ---

  ({String y, String x}) _getAxisLabels() {
    switch (diagram) {
      case DiagramEnum.microMarginalProduct:
      case DiagramEnum.microTotalAndMarginalProduct:
        return (y: DiagramLabel.product.label, x: DiagramLabel.input.label);
      case DiagramEnum.microMarginalCost:
      case DiagramEnum.microMarginalCostSupplyCurve:
        return (y: DiagramLabel.costs.label, x: DiagramLabel.quantity.label);
      default:
        return (y: DiagramLabel.p.label, x: DiagramLabel.q.label);
    }
  }

  // --- SUB-PAINTERS ---

  void _paintSupplyMovement(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintMarketCurve(c, canvas, type: MarketCurveType.supply);

    // Dashed Lines (P2, Q2)
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.40,
      xAxisEndPos: 0.60,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
    );

    // Dashed Lines (P1, Q1)
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.60,
      xAxisEndPos: 0.40,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
    );

    // Directional Arrow
    final isExtension = diagram == DiagramEnum.microSupplyExtension;
    paintLineSegment(
      c,
      canvas,
      origin: isExtension ? const Offset(0.42, 0.51) : const Offset(0.44, 0.48),
      angle: isExtension ? -pi / 4 : pi / 1.35,
      length: 0.15,
    );
  }

  void _paintSupplyShift(DiagramPainterConfig c, IDiagramCanvas canvas) {
    final bool isIncrease = diagram == DiagramEnum.microSupplyIncrease;
    final double shift = isIncrease ? 0.15 : -0.15;

    // S1
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.s1,
      horizontalShift: -shift,
      lengthAdjustment: -0.15,
    );

    // S2
    paintMarketCurve(
      c,
      canvas,
      type: MarketCurveType.s2,
      horizontalShift: shift,
      lengthAdjustment: -0.15,
    );

    // Dashed Lines (P -> Q1/Q2)
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.35,
      yLabel: DiagramLabel.p.label,
      xLabel: isIncrease ? DiagramLabel.q1.label : DiagramLabel.q2.label,
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0.50,
      xAxisEndPos: 0.65,
      yLabel: DiagramLabel.p.label,
      xLabel: isIncrease ? DiagramLabel.q2.label : DiagramLabel.q1.label,
    );

    // Arrow
    paintLineSegment(
      c,
      canvas,
      origin: Offset(isIncrease ? 0.58 : 0.61, 0.40),
      angle: isIncrease ? 0 : pi,
    );
  }

  void _paintTotalMarginalProduct(DiagramPainterConfig c, IDiagramCanvas canvas) {
    // Total Product (TP)
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0, 1.0),
      label2: DiagramLabel.totalProduct.label,
      label2Align: LabelAlign.centerRight,
      bezierPoints: [
        CustomBezier(
          endPoint: const Offset(0.79, 0.15),
          control: const Offset(0.25, 0.15),
        ),
        CustomBezier(
          endPoint: const Offset(0.89, 0.22),
          control: const Offset(0.86, 0.18),
        ),
      ],
    );

    // Marginal Product (MP)
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0.02, 0.98),
      color: Colors.deepOrange,
      label2: DiagramLabel.marginalProduct.label,
      bezierPoints: [
        CustomBezier(
          endPoint: const Offset(0.90, 1.14),
          control: const Offset(0.25, 0.20),
        ),
      ],
    );

    // Vertical dashed dividers
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0,
      xAxisEndPos: 0.32,
      hideYLine: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,
      yAxisStartPos: 0,
      xAxisEndPos: 0.80,
      hideYLine: true,
    );

    // Text Labels
    const yPos = 0.10;
    paintText(
      c,
      canvas,
      'Increasing\nReturns',
      const Offset(0.15, yPos),
      fontSize: kFontSmall,
    );
    paintText(
      c,
      canvas,
      'Diminishing\nReturns',
      const Offset(0.52, yPos),
      fontSize: kFontSmall,
    );
    paintText(
      c,
      canvas,
      'Negative\nReturns',
      const Offset(0.90, yPos),
      fontSize: kFontSmall,
    );
  }

  void _paintMarginalProduct(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0.05, 0.95),
      label2: DiagramLabel.marginalProduct.label,
      label2Align: LabelAlign.centerBottom,
      bezierPoints: [
        CustomBezier(
          endPoint: const Offset(0.75, 0.50),
          control: const Offset(0.37, -0.43),
        ),
      ],
    );

    paintText(
      c,
      canvas,
      DiagramLabel.diminishingReturnsSetIn.label,
      const Offset(0.45, 0.05),
      pointerLine: const Offset(0.45, 0.125),
    );
  }

  void _paintMarginalCost(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintDiagramLines(
      c,
      canvas,
      startPos: const Offset(0.05, 0.60),
      label2: DiagramLabel.marginalCost.label,
      label2Align: LabelAlign.centerTop,
      bezierPoints: [
        CustomBezier(
          endPoint: const Offset(0.90, 0.10),
          control: const Offset(0.50, 1.3),
        ),
      ],
    );

    paintText(
      c,
      canvas,
      DiagramLabel.diminishingReturnsSetIn.label,
      const Offset(0.38, 0.95),
      pointerLine: const Offset(0.38, 0.855),
    );
  }
}