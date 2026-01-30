import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/paint_grid_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:flutter/material.dart';
import '../../i_diagram_canvas.dart';

import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';

void paintAxisLines(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, { // Now only takes the unified interface
  Color? color,
  double strokeWidth = kAxisWidth,
  double? xMaxValue,
  double? yMaxValue,
  int? xDivisions,
  int? yDivisions,
  GridLineStyle gridLineStyle = GridLineStyle.full,
  int decimalPlaces = 0,
}) {
  // 1. Math remains identical
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

  // 2. Painting Logic
  // We use the same code for Flutter and PDF now
  final axisColor = color ?? config.colorScheme.onSurface;
  final axisWidth = kCurveWidth * config.averageRatio;

  // Vertical Y-Axis
  canvas.drawLine(startYOffset, endYOffset, axisColor, axisWidth);
  // Horizontal X-Axis
  canvas.drawLine(startXOffset, endXOffset, axisColor, axisWidth);

  // 3. Sub-method calls
  // These must also be updated to accept IDiagramCanvas
  paintArrowHead(config, canvas, positionOfArrow: startYOffset);

  paintArrowHead(
    config,
    canvas,
    positionOfArrow: endXOffset,
    rotationAngle: pi / 2,
  );

  if (gridLineStyle != GridLineStyle.none) {
    paintGridLines(
      config,
      canvas,
      xMaxValue: xMaxValue,
      yMaxValue: yMaxValue,
      xDivisions: xDivisions,
      yDivisions: yDivisions,
      gridLineStyle: gridLineStyle,
      decimalPlaces: decimalPlaces,
    );
  }
}
