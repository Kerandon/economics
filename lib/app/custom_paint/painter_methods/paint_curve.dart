import 'package:flutter/material.dart';

void paintCurve(Size size, Canvas canvas, Offset startPos, Offset endPos,
    {Color color = Colors.white, double strokeWidth = 0.008}) {
  final paint = Paint()
    ..color = color
    ..strokeWidth = size.width * strokeWidth
    ..strokeCap = StrokeCap.round;

  canvas.drawLine(startPos, endPos, paint);
}
