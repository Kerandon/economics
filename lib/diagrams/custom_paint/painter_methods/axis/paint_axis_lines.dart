import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/paint_grid_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:flutter/material.dart';
import '../../i_diagram_canvas.dart';

import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';
import 'axis_enum.dart';

import 'dart:math';

void paintAxisLines(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  Color? color,
  double strokeWidth = kAxisWidth,
  double? xMaxValue,
  double? yMaxValue,
  int? xDivisions,
  int? yDivisions,
  GridLineStyle gridLineStyle = GridLineStyle.full,
  int decimalPlaces = 0,
  AxisStyle axisStyle = AxisStyle.arrows,
}) {
  final widthAndHeight = config.painterSize.width;
  final indent = widthAndHeight * kAxisIndent;

  final indentXLeft = indent;
  final indentXRight = widthAndHeight * (1 - kAxisIndent);
  final indentYTop = indent * kTopAxisIndent;
  final indentYBottom = widthAndHeight - (indent * kBottomAxisIndent);

  final axisColor = color ?? config.colorScheme.onSurface;
  final axisWidth = kCurveWidth * config.averageRatio;

  // Axis Endpoints
  final bottomLeft = Offset(indentXLeft, indentYBottom);
  final bottomRight = Offset(indentXRight, indentYBottom);
  final topLeft = Offset(indentXLeft, indentYTop);
  final topRight = Offset(indentXRight, indentYTop);

  if (axisStyle == AxisStyle.arrows) {
    // 1. Draw Lines
    canvas.drawLine(bottomLeft, topLeft, axisColor, axisWidth);
    canvas.drawLine(bottomLeft, bottomRight, axisColor, axisWidth);

    // 2. Draw Arrows
    // Y-Axis Arrow
    paintArrowHead(
      config,
      canvas,
      color: axisColor,
      positionOfArrow: topLeft,
      rotationAngle: 0.0,
      isCentered: false,
    );

    // X-Axis Arrow
    paintArrowHead(
      config,
      canvas,
      color: axisColor,
      positionOfArrow: bottomRight,
      rotationAngle: pi / 2,
      isCentered: false,
    );
  } else {
    // ⬛ Lorenz-style box
    canvas.drawLine(bottomLeft, bottomRight, axisColor, axisWidth);
    canvas.drawLine(bottomRight, topRight, axisColor, axisWidth);
    canvas.drawLine(topRight, topLeft, axisColor, axisWidth);
    canvas.drawLine(topLeft, bottomLeft, axisColor, axisWidth);
  }

  // ✅ RESTORED: This was missing in the previous snippet
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
