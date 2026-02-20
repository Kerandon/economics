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
  bool showLabelBackground = true,
}) {
  final size = config.painterSize.width;
  final indent = size * kAxisIndent;

  // Coordinate Calculations
  final double xL = indent;
  final double xR = size * (1 - kAxisIndent);
  final double yT = indent * kTopAxisIndent;
  final double yB = size - (indent * kBottomAxisIndent);

  final axisColor = color ?? config.colorScheme.onSurface;
  final axisWidth = kCurveWidth * config.averageRatio;

  final bottomLeft = Offset(xL, yB);
  final bottomRight = Offset(xR, yB);
  final topLeft = Offset(xL, yT);
  final topRight = Offset(xR, yT);

  // 1. Draw Axis Geometry
  if (axisStyle == AxisStyle.arrows) {
    canvas.drawLine(bottomLeft, topLeft, axisColor, axisWidth);
    canvas.drawLine(bottomLeft, bottomRight, axisColor, axisWidth);

    paintArrowHead(
      config,
      canvas,
      color: axisColor,
      positionOfArrow: topLeft,
      rotationAngle: 0.0,
    );
    paintArrowHead(
      config,
      canvas,
      color: axisColor,
      positionOfArrow: bottomRight,
      rotationAngle: pi / 2,
    );
  } else if (axisStyle == AxisStyle.box) {
    // Standard box for Lorenz curves or 45-degree diagrams
    canvas.drawLine(bottomLeft, bottomRight, axisColor, axisWidth);
    canvas.drawLine(bottomRight, topRight, axisColor, axisWidth);
    canvas.drawLine(topRight, topLeft, axisColor, axisWidth);
    canvas.drawLine(topLeft, bottomLeft, axisColor, axisWidth);
  }

  // 2. Draw Grid/Ticks
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
      showBackground: showLabelBackground, // Passes your new property
    );
  }
}
