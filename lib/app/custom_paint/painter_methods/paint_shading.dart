import 'package:economics_app/app/custom_paint/paint_enums/shade_type.dart';
import 'package:flutter/material.dart';

import '../../models/position.dart';

void paintShading(
    Canvas canvas, Size size, ShadeType shade, Pos p1, Pos p2, Pos p3,
    {Pos? p4}) {
  final width = size.width;
  final height = size.height;
  final paint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.orange.withOpacity(0.50);

  final path = Path()
    ..moveTo(p1.x * width, p1.y * height)
    ..lineTo(p2.x * width, p2.y * height)
    ..lineTo(p3.x * width, p3.y * height);
  if (p4 != null) {
    path.lineTo(p4.x, p4.y);
  }
  path.close();

  canvas.drawPath(path, paint);
}
