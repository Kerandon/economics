import 'package:flutter/material.dart';

import '../../models/diagram_painter_config.dart';
import '../i_diagram_canvas.dart';
import '../painter_constants.dart';

void paintDot(
  DiagramPainterConfig config,
  IDiagramCanvas iCanvas, // 👈 Unified interface only
  Offset pos, {
  double radius = kDotRadius,
  Color? color,
}) {
  final dotColor = color ?? config.colorScheme.onSurface;
  final size = config.painterSize;
  final width = size.width;
  final height = size.height;

  // Normalization logic consistent with your axis margins
  final normalize = 1 - (kAxisIndent * 2);
  final r = radius * config.averageRatio * 0.60;

  // Calculate the absolute pixel position
  final center = Offset(
    ((pos.dx * width) * normalize) + (width * kAxisIndent),
    ((pos.dy * height) * normalize) + (height * (kAxisIndent * kTopAxisIndent)),
  );

  // 👈 Use the unified drawDot method defined in your interface
  iCanvas.drawDot(center, dotColor, radius: r, fill: true);
}
