import 'package:economics_app/app/custom_paint/paint_enums/custom_align.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
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
  final paint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round;

  if (makeDashed) {
    paintDashedLine(canvas: canvas, p1: p1, p2: p2, color: color);
  } else {
    canvas.drawLine(p1, p2, paint);
  }

  if (label1 != null) {
    paintText(size, canvas, label1, Offset(p1.dx, p1.dy), align: label1Align);
  }
  if (label2 != null) {
    paintText(size, canvas, label2, Offset(p2.dx, p2.dy), align: label2Align);
  }
}
