import 'package:flutter/material.dart';
import '../../diagram_enums/shade_type.dart';

void paintShading(
    Canvas canvas, Size size, ShadeType shade, Offset p1, Offset p2, Offset p3,
    {Offset? p4}) {
  final width = size.width;
  final height = size.height;
  final paint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.orange.withOpacity(0.50);

  final path = Path()
    ..moveTo(p1.dx * width, p1.dy * height)
    ..lineTo(p2.dx * width, p2.dy * height)
    ..lineTo(p3.dx * width, p3.dy * height);
  if (p4 != null) {
    path.lineTo(p4.dx, p4.dy);
  }
  path.close();

  canvas.drawPath(path, paint);
}
