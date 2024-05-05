import 'package:economics_app/app/custom_paint/painter_constants.dart';
import 'package:flutter/material.dart';

void paintAxisLines(Size size, Canvas canvas, {Color color = Colors.white, double strokeWidth = kAxisStrokeWidth}) {
  final double width = size.width;
  final double height = size.height;

  final axisPaint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth;

  canvas
    ..drawLine(Offset(width * kAxisIndent, height * kAxisIndent),
        Offset(width * kAxisIndent, height * (1 - kAxisIndent)), axisPaint)
    ..drawLine(Offset(width * kAxisIndent, height * (1 - kAxisIndent)),
        Offset(width * (1 - kAxisIndent), height * (1 - kAxisIndent)), axisPaint);
}
