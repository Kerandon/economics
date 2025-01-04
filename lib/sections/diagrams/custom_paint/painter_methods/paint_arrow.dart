import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';

import '../painter_constants.dart';

void paintArrow(
  DiagramPainterConfig config,
  Canvas canvas, {
  required Offset positionOfArrow,
  double size = kArrowSize,
  double rotationAngle = 0.0,
}) {
  final path = Path();
  final paint = Paint()..color = config.colorScheme.onSurface;

  final arrowWidth = size * config.averageRatio;
  final arrowHeight = size * config.averageRatio;

  // Save the canvas state before applying transformations
  canvas.save();

  // Move the canvas' origin to the position of the arrow
  canvas.translate(positionOfArrow.dx, positionOfArrow.dy);

  // Apply rotation
  canvas.rotate(rotationAngle);

  // Define the arrow path relative to the new origin
  path
    ..moveTo(0, -arrowHeight)
    ..lineTo(arrowWidth, 0)
    ..lineTo(-arrowWidth, 0)
    ..close();

  // Draw the path at the rotated position
  canvas.drawPath(path, paint);

  // Restore the canvas state to prevent affecting other drawings
  canvas.restore();
}
