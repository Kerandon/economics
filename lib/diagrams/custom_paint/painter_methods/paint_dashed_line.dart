import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintDashedLine(
    DiagramPainterConfig config,
    Canvas canvas, {
      required Offset p1,
      required Offset p2,
      Iterable<double>? pattern,
      double strokeWidth = kDashedLineWidth,
      Color? color,
    }) {
  final c = color ?? config.colorScheme.onSurface;
  strokeWidth *= config.averageRatio / 2;
  final width = config.painterSize.width;
  final height = config.painterSize.height;

  p1 = Offset(p1.dx * width, (p1.dy * height));
  p2 = Offset(p2.dx * width, (p2.dy * height));

  pattern ??= [4, 5]; // Default pattern if not provided
  assert(pattern.length.isEven);
  final distance = (p2 - p1).distance;
  final normalizedPattern = pattern.map((width) => width / distance).toList();
  final points = <Offset>[];

  final paint = Paint()
    ..color = c
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