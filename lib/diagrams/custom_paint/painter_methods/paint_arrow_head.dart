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
  bool isCentered = true, // Set to true to rotate around the middle
}) {
  final double size = arrowSize * config.averageRatio;
  final double height = size * 2.0;

  // Calculate vertical offsets relative to the pivot (positionOfArrow)
  // If centered: tip is at -height/2, base is at +height/2
  // If at end of line: tip is at 0, base is at +height
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
