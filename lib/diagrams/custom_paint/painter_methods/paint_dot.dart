import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintDot(
  DiagramPainterConfig config,
  Canvas? canvas, {
  IDiagramCanvas? iCanvas, // 👈 Added Bridge
  required Offset pos,
  double radius = kDotRadius,
  Color? color,
}) {
  final dotColor = color ?? config.colorScheme.onSurface;
  final size = config.painterSize;
  final width = size.width;
  final height = size.height;
  final normalize = 1 - (kAxisIndent * 2);
  final r = radius * config.averageRatio * 0.60;

  // Calculate the absolute pixel position using the same logic for both
  final center = Offset(
    ((pos.dx * size.width) * normalize) + (width * (kAxisIndent)),
    (pos.dy * size.height) * normalize + (height * (kAxisIndent * kTopAxisIndent)),
  );

  if (iCanvas != null) {
    // PDF Bridge: Draws a filled square/circle at the intersection
    iCanvas.drawRect(
      Rect.fromCircle(center: center, radius: r),
      dotColor,
      fill: true,
    );
  } else if (canvas != null) {
    // Standard Flutter painting
    final paint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, r, paint);
  }
}
