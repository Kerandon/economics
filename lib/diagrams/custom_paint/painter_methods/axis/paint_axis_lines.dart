import 'dart:math';
import 'package:economics_app/diagrams/custom_paint/painter_methods/axis/grid_lines/paint_grid_lines.dart';
import 'package:economics_app/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:flutter/material.dart';
import 'grid_lines/grid_line_style.dart';
import '../../../models/diagram_painter_config.dart';
import '../../painter_constants.dart';

void paintAxisLines(
  DiagramPainterConfig config,
  Canvas canvas, {
  Color? color,
  double strokeWidth = kAxisWidth,
  double? xMaxValue,
  double? yMaxValue,
  int? xDivisions,
  int? yDivisions,
  GridLineStyle gridLineStyle = GridLineStyle.full, // New enum property
  int decimalPlaces = 0,
}) {
  // Assertions for consistent axis configs
  assert(
    (xMaxValue == null && xDivisions == null) ||
        (xMaxValue != null && xDivisions != null),
    'If xMaxValue is provided, xDivisions must also be provided (and vice versa).',
  );
  assert(
    (yMaxValue == null && yDivisions == null) ||
        (yMaxValue != null && yDivisions != null),
    'If yMaxValue is provided, yDivisions must also be provided (and vice versa).',
  );

  final widthAndHeight = config.painterSize.width;
  final indent = widthAndHeight * kAxisIndent;

  final axisPaint = Paint()
    ..color = config.colorScheme.onSurface
    ..strokeWidth = kCurveWidth * config.averageRatio;

  final indentXLeft = indent * 1.5;
  final indentYTop = indent * 0.50;
  final indentYBottom = widthAndHeight - (indent * 1.5);
  final indentXRight = widthAndHeight * (1 - (kAxisIndent * 0.50));

  final startYOffset = Offset(indentXLeft, indentYTop);
  final endYOffset = Offset(indentXLeft, indentYBottom);
  final startXOffset = Offset(indentXLeft, indentYBottom);
  final endXOffset = Offset(indentXRight, indentYBottom);

  // Draw the main X and Y axes
  canvas
    ..drawLine(startYOffset, endYOffset, axisPaint)
    ..drawLine(startXOffset, endXOffset, axisPaint);

  // Draw arrow-heads
  paintArrowHead(config, canvas, positionOfArrow: startYOffset);
  paintArrowHead(
    config,
    canvas,
    positionOfArrow: endXOffset,
    rotationAngle: pi / 2,
  );

  // Draw gridlines only if style is not none
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
