import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

import '../painter_constants.dart';

void paintDot(
  Canvas canvas,
  Size size, {
  required Offset pos,
  double radius = kDotRadius,
  Color color = Colors.white,
}) {
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;
  canvas.drawCircle(
      Offset(pos.dx * size.width, pos.dy * size.height), radius, paint);
}
