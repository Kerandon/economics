import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_display.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_entry.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/legend_shape.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/legend/paint_legend.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_dot.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_line_segment.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_text_2.dart';
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

class Supply extends BaseDiagramPainter3 {
  Supply(super.config, super.diagram);

  @override
  void drawDiagram(
    IDiagramCanvas canvas,
    Size size, {
    IDiagramCanvas? iCanvas,
  }) {
    final c = config.copyWith(painterSize: size);

    // 1. Determine Axis Labels
    String yLabel = DiagramLabel.p.label;
    String xLabel = DiagramLabel.q.label;

    if (diagram == DiagramEnum.microMarginalProduct ||
        diagram == DiagramEnum.microTotalAndMarginalProduct) {
      yLabel = DiagramLabel.product.label;
      xLabel = DiagramLabel.input.label;
    } else if (diagram == DiagramEnum.microMarginalCost ||
        diagram == DiagramEnum.microMarginalCostSupplyCurve) {
      yLabel = DiagramLabel.costs.label;
    }

    paintAxis(c, canvas, yAxisLabel: yLabel, xAxisLabel: xLabel);

    // 2. Route Drawing Logic
    switch (diagram) {
      case DiagramEnum.microSupplyExtension:
      case DiagramEnum.microSupplyContraction:
        _paintSupplyMovement(c, canvas);
      case DiagramEnum.microSupplyIncrease:
      case DiagramEnum.microSupplyDecrease:
        _paintSupplyShift(c, canvas);
      case DiagramEnum.microTotalAndMarginalProduct:
        _paintTotalMarginalProduct(c, canvas);
      case DiagramEnum.microMarginalProduct:
        _paintMarginalProduct(c, canvas);
      case DiagramEnum.microMarginalCost:
        _paintMarginalCost(c, canvas);
      default:
    }
  }

  // --- SUB-PAINTERS ---

  void _paintSupplyMovement(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintMarketCurve(c, canvas, type: MarketCurveType.supply);

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.40,
      xAxisEndPos: 0.60,
      yLabel: DiagramLabel.p2.label,
      xLabel: DiagramLabel.q2.label,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.60,
      xAxisEndPos: 0.40,
      yLabel: DiagramLabel.p1.label,
      xLabel: DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );

    if (diagram == DiagramEnum.microSupplyExtension) {
      paintLineSegment(
        c,
        canvas,

        origin: const Offset(0.42, 0.51),
        angle: -pi / 4,
        length: 0.15,
      );
    } else {
      paintLineSegment(
        c,
        canvas,

        origin: const Offset(0.44, 0.48),
        angle: pi / 1.35,
        length: 0.15,
      );
    }
  }

  void _paintSupplyShift(DiagramPainterConfig c, IDiagramCanvas canvas) {
    final bool isIncrease = diagram == DiagramEnum.microSupplyIncrease;
    final double shift = isIncrease ? 0.15 : -0.15;

    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      label: DiagramLabel.s1.label,
      horizontalShift: -shift,
      lengthAdjustment: -0.15,
    );
    paintMarketCurve(
      c,
      canvas,

      type: MarketCurveType.supply,
      label: DiagramLabel.s2.label,
      horizontalShift: shift,
      lengthAdjustment: -0.15,
    );

    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.50,
      xAxisEndPos: 0.35,
      yLabel: DiagramLabel.p.label,
      xLabel: isIncrease ? DiagramLabel.q1.label : DiagramLabel.q2.label,
      hideYLine: true,
      showDotAtIntersection: true,
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.50,
      xAxisEndPos: 0.65,
      yLabel: DiagramLabel.p.label,
      xLabel: isIncrease ? DiagramLabel.q2.label : DiagramLabel.q1.label,
      showDotAtIntersection: true,
    );

    paintLineSegment(
      c,
      canvas,

      origin: Offset(isIncrease ? 0.58 : 0.61, 0.40),
      angle: isIncrease ? 0 : pi,
    );
  }

  void _paintTotalMarginalProduct(
    DiagramPainterConfig c,

    IDiagramCanvas canvas,
  ) {
    // Total Product (TP)
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0, 1.0),
      bezierPoints: [
        CustomBezier(
          endPoint: const Offset(0.73, 0.19),
          control: const Offset(0.21, 0.15),
        ),
        CustomBezier(
          endPoint: const Offset(0.83, 0.23),
          control: const Offset(0.78, 0.19),
        ),
      ],
    );
    // Marginal Product (MP)
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.02, 0.98),
      color: Colors.deepOrange,
      bezierPoints: [
        CustomBezier(
          endPoint: const Offset(0.80, 1.06),
          control: const Offset(0.28, 0.35),
        ),
      ],
    );

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
      xAxisEndPos: 0.76,
      hideYLine: true,
    );

    paintLegend(canvas, config: c, [
      LegendEntry(
        label: DiagramLabel.marginalProduct.label,
        color: Colors.deepOrange,
      ),
      LegendEntry(
        label: DiagramLabel.totalProduct.label,
        color: c.colorScheme.primary,
      ),
    ]);

    final fontSize = kFontSmall;
    const yPos = 0.10;
    paintText2(
      c,
      canvas,
      fontSize: fontSize,
      'Increasing\nReturns',
      const Offset(0.15, yPos),
    );
    paintText2(
      c,
      canvas,
      fontSize: fontSize,
      'Diminishing\nReturns',
      const Offset(0.52, yPos),
    );
    paintText2(
      c,
      canvas,
      fontSize: fontSize,
      'Negative\nReturns',
      const Offset(0.90, yPos),
    );

    for (var p in [
      const Offset(0.32, 0.34),
      const Offset(0.32, 0.685),
      const Offset(0.76, 0.195),
      const Offset(0.76, 1.0),
    ]) {
      paintDot(c, canvas, p);
    }
  }

  void _paintMarginalProduct(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.05, 0.95),
      label2: DiagramLabel.marginalProduct.label,
      label2Align: LabelAlign.center,
      bezierPoints: [
        CustomBezier(
          endPoint: const Offset(0.75, 0.50),
          control: const Offset(0.37, -0.43),
        ),
      ],
    );

    paintText2(
      c,
      canvas,
      DiagramLabel.diminishingReturnsSetIn.label,
      Offset(0.45, 0.05),
      pointerLine: Offset(0.45, 0.125),
    );
  }

  void _paintMarginalCost(DiagramPainterConfig c, IDiagramCanvas canvas) {
    paintDiagramLines(
      c,
      canvas,

      startPos: const Offset(0.05, 0.60),
      label2: DiagramLabel.marginalCost.label,
      label2Align: LabelAlign.center,
      bezierPoints: [
        CustomBezier(
          endPoint: const Offset(0.90, 0.10),
          control: const Offset(0.50, 1.3),
        ),
      ],
    );
    paintDiagramDashedLines(
      c,
      canvas,

      yAxisStartPos: 0.90,
      xAxisEndPos: 0.385,
      hideYLine: true,
      xLabel: 'Diminishing\nReturns\nSets In',
    );
    paintDot(c, canvas, const Offset(0.385, 0.855));
  }

  LegendDisplay get legendDisplay => LegendDisplay.shading;
}
