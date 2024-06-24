import 'dart:math' as math;

import 'package:flutter/material.dart';

void paintArrowHead(Canvas canvas, Size size, Offset start, Offset end,
    Color color, bool isStart) {
  final width = size.width;
  final height = size.height;

  final arrowHeadSize = width * 0.015;

  final angle = (end - start).direction;
  const arrowAngle = 0.5; // Adjust arrow angle for aesthetics

  final path = Path()
    ..moveTo(start.dx * width, start.dy * height)
    ..lineTo(
      start.dx * width + arrowHeadSize * math.cos(angle - arrowAngle),
      start.dy * height + arrowHeadSize * math.sin(angle - arrowAngle),
    )
    ..lineTo(
      start.dx * width + arrowHeadSize * math.cos(angle + arrowAngle),
      start.dy * height + arrowHeadSize * math.sin(angle + arrowAngle),
    )
    ..close();

  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;

  canvas.drawPath(path, paint);
}
