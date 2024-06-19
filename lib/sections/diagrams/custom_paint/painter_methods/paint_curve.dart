import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/diagram_enums/custom_align.dart';
import 'package:flutter/material.dart';
import '../painter_constants.dart';

void paintCurve(
  Size size,
  Canvas canvas,
  Offset p1,
  Offset p2, {
  Color color = Colors.white,
  double strokeWidth = kCurveWidth,
  String? label1,
  CustomAlign label1Align = CustomAlign.center,
  CustomAlign label2Align = CustomAlign.center,
  String? label2,
  bool makeDashed = false,
}) {
  final width = size.width;
  final height = size.height;

  final paint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round;

  if (makeDashed) {
    paintDashedLine(
        size: size,
        canvas: canvas,
        p1: Offset(p1.dx, p1.dy),
        p2: Offset(p2.dx, p2.dy),
        color: color);
  } else {
    canvas.drawLine(Offset(p1.dx * width, p1.dy * height),
        Offset(p2.dx * width, p2.dy * height), paint);
  }

  if (label1 != null) {
    paintText(size, canvas, label1, Offset(p1.dx, p1.dy), align: label1Align);
  }
  if (label2 != null) {
    paintText(size, canvas, label2, Offset(p2.dx, p2.dy), align: label2Align);
  }
}
