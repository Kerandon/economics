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

    // Draw Axes (Nominal Interest Rate vs Quantity of Money)
    paintAxis(
      c,
      canvas,
      yAxisLabel: DiagramLabel.interestRate.label,
      xAxisLabel: DiagramLabel.quantityOfMoney.label,
    );

    switch (diagram) {
      case DiagramEnum.macroMoneyMarket:
        _paintIncrease(c, canvas);
        break;
      default:
        // Fallback or empty
        break;
    }
  }
}

// 1. STANDARD MONEY MARKET (Equilibrium)
void _paintIncrease(DiagramPainterConfig c, IDiagramCanvas canvas) {
  // Draw Curves
}
