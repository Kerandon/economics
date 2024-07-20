import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';

void paintColorLabel(Canvas canvas, Size size,
    {required Offset pos,
    String? text,
    Color color = Colors.green,
    double radius = 8,
    Offset? lineEndPoint}) {
  final width = size.width;
  final height = size.height;
  if (lineEndPoint != null) {
    paintCurve(size, canvas, pos, lineEndPoint, color: color);
  }
  final paint = Paint()
    ..style = PaintingStyle.fill
    ..color = color;
  canvas.drawCircle(Offset(pos.dx * width, pos.dy * height), radius, paint);
  if (text != null) {
    paintText(size, canvas, text, Offset(pos.dx, pos.dy),
        color: Colors.white, fontSize: 8);
  }
}
