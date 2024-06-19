import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../painter_constants.dart';

void paintDashedLine({
  required Size size,
  required Canvas canvas,
  required Offset p1,
  required Offset p2,
  Iterable<double>? pattern,
  Color color = Colors.white,
  double strokeWidth = kDashedLineWidth,
}) {
  p1 = p1 * size.width;
  p2 = p2 * size.height;
  pattern ??= [4, 5]; // Default pattern if not provided
  assert(pattern.length.isEven);
  final distance = (p2 - p1).distance;
  final normalizedPattern = pattern.map((width) => width / distance).toList();
  final points = <Offset>[];

  final paint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth;

  double t = 0;
  int i = 0;
  while (t < 1) {
    points.add(Offset.lerp(p1, p2, t)!);
    t += normalizedPattern[i++]; // dashWidth
    points.add(Offset.lerp(p1, p2, t.clamp(0, 1))!);
    t += normalizedPattern[i++]; // dashSpace
    i %= normalizedPattern.length;
  }
  canvas.drawPoints(ui.PointMode.lines, points, paint);
}
