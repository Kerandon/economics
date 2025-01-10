import 'package:economics_app/sections/diagrams/models/diagram_painter_config.dart';
import 'package:flutter/material.dart';

import '../painter_constants.dart';

void paintDot(
  DiagramPainterConfig config,
  Canvas canvas, {
  required Offset pos,
  double radius = kDotRadius,
  Color color = Colors.white,
}) {
  final size = config.sizeRatio;
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;
  canvas.drawCircle(
      Offset(pos.dx * size.width, pos.dy * size.height), radius, paint);
}
