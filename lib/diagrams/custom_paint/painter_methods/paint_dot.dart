import 'package:flutter/material.dart';
import 'axis/label_align.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintDot(
  DiagramPainterConfig config,
  Canvas canvas, {
  required Offset pos,
  double radius = kDotRadius,
  Color? color,
}) {
  color = color ?? config.colorScheme.onSurface;
  final size = config.painterSize;
  final width = config.painterSize.width;
  final height = config.painterSize.height;
  final normalize = 1 - (kAxisIndent * 2);
  final r = radius * config.averageRatio * 0.60;
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.fill;
  canvas.drawCircle(
    Offset(
      ((pos.dx * size.width) * normalize) + (width * (kAxisIndent * 1.5)),
      (pos.dy * size.height) * normalize + (height * (kAxisIndent / 2)),
    ),
    r,
    paint,
  );

}
