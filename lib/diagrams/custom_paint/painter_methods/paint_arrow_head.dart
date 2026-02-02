import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintArrowHead(
  DiagramPainterConfig config,
  IDiagramCanvas canvas, {
  required Color color,
  required Offset positionOfArrow,
  required double rotationAngle,
  double arrowSize = 10.0,
  double scale = 1.0, // Added scale to support 1.2x sizing
  bool isCentered = true,
}) {
  final double size = arrowSize * config.averageRatio * scale;
  final double height = size * 2.0;

  // Calculate vertical offsets relative to the pivot
  final double tipOffset = isCentered ? -(height / 2) : 0.0;
  final double baseOffset = isCentered ? (height / 2) : height;

  Offset rotate(double x, double y) {
    return Offset(
      positionOfArrow.dx + (x * cos(rotationAngle) - y * sin(rotationAngle)),
      positionOfArrow.dy + (x * sin(rotationAngle) + y * cos(rotationAngle)),
    );
  }

  final List<Offset> arrowPath = [
    rotate(0, tipOffset), // The sharp tip
    rotate(-size, baseOffset), // Bottom Left
    rotate(size, baseOffset), // Bottom Right
  ];

  canvas.drawPath(arrowPath, color, fill: true);
}
