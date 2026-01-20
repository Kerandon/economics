import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintArrowHead(
  DiagramPainterConfig config,
  Canvas? canvas, { // 👈 Changed to nullable Canvas?
  IDiagramCanvas? iCanvas,
  required Offset positionOfArrow,
  Color? color,
  double size = kArrowSize,
  double rotationAngle = 0.0,
}) {
  final arrowWidth = size * config.averageRatio;
  final arrowHeight = size * config.averageRatio;
  final effectiveColor = color ?? config.colorScheme.onSurface;

  if (iCanvas != null) {
    // 1. PDF/Universal Path Logic (Calculated coordinates)
    Offset p1 = Offset(0, -arrowHeight);
    Offset p2 = Offset(arrowWidth, 0);
    Offset p3 = Offset(-arrowWidth, 0);

    Offset rotate(Offset p) {
      double x = p.dx * cos(rotationAngle) - p.dy * sin(rotationAngle);
      double y = p.dx * sin(rotationAngle) + p.dy * cos(rotationAngle);
      return Offset(x + positionOfArrow.dx, y + positionOfArrow.dy);
    }

    iCanvas.drawPath(
      [rotate(p1), rotate(p2), rotate(p3)],
      effectiveColor,
      fill: true,
    );
  } else if (canvas != null) {
    // 2. Legacy Flutter Path Logic (Canvas Transformations)
    final path = Path();
    final paint = Paint()..color = effectiveColor;

    canvas.save();
    canvas.translate(positionOfArrow.dx, positionOfArrow.dy);
    canvas.rotate(rotationAngle);

    path
      ..moveTo(0, -arrowHeight)
      ..lineTo(arrowWidth, 0)
      ..lineTo(-arrowWidth, 0)
      ..close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }
}
