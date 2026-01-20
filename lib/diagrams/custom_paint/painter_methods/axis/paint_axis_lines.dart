import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/paint_grid_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:flutter/material.dart';
import '../../i_diagram_canvas.dart';

import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';

void paintAxisLines(
  DiagramPainterConfig config,
  Canvas? canvas, {
  IDiagramCanvas? iCanvas, // The PDF/Universal bridge
  Color? color,
  double strokeWidth = kAxisWidth,
  double? xMaxValue,
  double? yMaxValue,
  int? xDivisions,
  int? yDivisions,
  GridLineStyle gridLineStyle = GridLineStyle.full,
  int decimalPlaces = 0,
}) {
  // 1. Math remains the same for both
  final widthAndHeight = config.painterSize.width;
  final indent = widthAndHeight * kAxisIndent;
  final indentXLeft = indent;
  final indentYTop = indent * kTopAxisIndent;
  final indentYBottom = widthAndHeight - (indent * kBottomAxisIndent);
  final indentXRight = widthAndHeight * (1 - (kAxisIndent));

  final startYOffset = Offset(indentXLeft, indentYTop);
  final endYOffset = Offset(indentXLeft, indentYBottom);
  final startXOffset = Offset(indentXLeft, indentYBottom);
  final endXOffset = Offset(indentXRight, indentYBottom);

  // 2. Conditional Painting
  if (iCanvas != null) {
    // PDF Path: Use the vector interface
    final axisColor = color ?? config.colorScheme.onSurface;
    final axisWidth = kCurveWidth * config.averageRatio;

    iCanvas.drawLine(startYOffset, endYOffset, axisColor, axisWidth);
    iCanvas.drawLine(startXOffset, endXOffset, axisColor, axisWidth);
  } else if (canvas != null) {
    // 👈 Change 'else' to 'else if (canvas != null)'
    // Standard Flutter Path: Use the old logic
    final axisPaint = Paint()
      ..color = config.colorScheme.onSurface
      ..strokeWidth = kCurveWidth * config.averageRatio;

    // Use a single dot after the null check or keep it safe:
    canvas.drawLine(startYOffset, endYOffset, axisPaint);
    canvas.drawLine(startXOffset, endXOffset, axisPaint);
  }

  // 3. Pass iCanvas down to sub-methods (They will need the same iCanvas param)
  paintArrowHead(
    config,
    canvas,
    iCanvas: iCanvas,
    positionOfArrow: startYOffset,
  );
  paintArrowHead(
    config,
    canvas,
    iCanvas: iCanvas,
    positionOfArrow: endXOffset,
    rotationAngle: pi / 2,
  );

  if (gridLineStyle != GridLineStyle.none) {
    paintGridLines(
      config,
      canvas,
      iCanvas: iCanvas,
      xMaxValue: xMaxValue,
      yMaxValue: yMaxValue,
      xDivisions: xDivisions,
      yDivisions: yDivisions,
      gridLineStyle: gridLineStyle,
      decimalPlaces: decimalPlaces,
    );
  }
}
