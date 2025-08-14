import 'dart:ui';

import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintSolidLine(
  DiagramPainterConfig config,
  Canvas canvas, {
  required Offset p1,
  required Offset p2,
  double strokeWidth = kDashedLineWidth / 2,
  Color? color,
}) {
  final c = color ?? config.colorScheme.onSurface;
  strokeWidth *= config.averageRatio / 2;
  final width = config.painterSize.width;
  final height = config.painterSize.height;

  p1 = Offset(p1.dx * width, (p1.dy * height));
  p2 = Offset(p2.dx * width, (p2.dy * height));

  final paint = Paint()
    ..color = c
    ..strokeWidth = strokeWidth;

  canvas.drawLine(p1, p2, paint);
}
