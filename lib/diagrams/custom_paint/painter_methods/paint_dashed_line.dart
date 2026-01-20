import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintDashedLine(
  DiagramPainterConfig config,
  Canvas? canvas, {
  IDiagramCanvas? iCanvas, // 👈 Added Bridge
  required Offset p1,
  required Offset p2,
  Iterable<double>? pattern,
  double strokeWidth = kDashedLineWidth,
  Color? color,
}) {
  final c = color ?? config.colorScheme.onSurface;
  final double effectiveStrokeWidth = strokeWidth * (config.averageRatio / 2);

  final width = config.painterSize.width;
  final height = config.painterSize.height;

  // 1. Coordinate Transformation
  // Note: We check if the offsets are already absolute (px) or normalized (0.0-1.0)
  // If they are coming from paintDiagramDashedLines, they are already absolute.
  final Offset start = p1.dx <= 1.0 && p1.dy <= 1.0
      ? Offset(p1.dx * width, p1.dy * height)
      : p1;
  final Offset end = p2.dx <= 1.0 && p2.dy <= 1.0
      ? Offset(p2.dx * width, p2.dy * height)
      : p2;

  // 2. PDF Bridge Logic
  if (iCanvas != null) {
    // Your PDF engine now handles the pattern via drawDashedLine
    iCanvas.drawDashedLine(start, end, c, effectiveStrokeWidth);
    return;
  }

  // 3. Flutter Canvas Logic
  if (canvas != null) {
    final dashPattern = pattern ?? [4, 5];
    final paint = Paint()
      ..color = c
      ..strokeWidth = effectiveStrokeWidth
      ..strokeCap = StrokeCap.round;

    final distance = (end - start).distance;
    if (distance <= 0) return;

    final normalizedPattern = dashPattern.map((w) => w / distance).toList();
    final points = <Offset>[];

    double t = 0;
    int i = 0;
    while (t < 1) {
      points.add(Offset.lerp(start, end, t)!);
      t += normalizedPattern[i++]; // dashWidth
      points.add(Offset.lerp(start, end, t.clamp(0, 1))!);
      t += normalizedPattern[i++]; // dashSpace
      i %= normalizedPattern.length;
    }

    canvas.drawPoints(ui.PointMode.lines, points, paint);
  }
}
