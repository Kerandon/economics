import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintArrowHead(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  required Offset positionOfArrow,
  Color? color,
  double size = kArrowSize,
  double rotationAngle = 0.0,
}) {
  final arrowWidth = size * config.averageRatio;
  final arrowHeight = size * config.averageRatio;
  final effectiveColor = color ?? config.colorScheme.onSurface;

  // We use the unified interface's transformation methods
  canvas.save();

  // 1. Move to the tip of the axis
  canvas.translate(positionOfArrow.dx, positionOfArrow.dy);

  // 2. Rotate to face the correct direction
  if (rotationAngle != 0) {
    canvas.rotate(rotationAngle);
  }

  // 3. Define the triangle relative to (0,0)
  // These points form a triangle pointing "up" (negative Y in Flutter)
  final points = [
    const Offset(0, 0), // The tip
    Offset(arrowWidth / 2, arrowHeight), // Bottom right
    Offset(-arrowWidth / 2, arrowHeight), // Bottom left
  ];

  // 4. Draw the filled shape
  canvas.drawPath(points, effectiveColor, fill: true);

  canvas.restore();
}
