import 'package:economics_app/sections/diagrams/models/size_adjuster.dart';
import 'package:flutter/material.dart';

void paintArrow(
  Canvas canvas,
  Color color, {
  required Offset positionOfArrow,
  SizeAdjustor sizeAdjustor = const SizeAdjustor(),
  double size = 10,
  double rotationAngle = 0.0,
}) {
  final path = Path();
  final paint = Paint()..color = color;

  size *= sizeAdjustor.width;

  final arrowWidth = size;
  final arrowHeight = size;

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
