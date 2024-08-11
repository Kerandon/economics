import 'dart:math';


import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_arrow.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import '../../enums/curve_align.dart';
import '../painter_constants.dart';

void paintCurve(
  Size size,
  Canvas canvas,
  Offset p1,
  Offset p2, {
  Color color = Colors.white,
  double strokeWidth = kCurveWidth,
  String? label1,
  String? label2,
  CurveAlign label1Align = CurveAlign.center,
  CurveAlign label2Align = CurveAlign.center,
  bool makeDashed = false,
  bool drawArrowAtStart = false,
  bool drawArrowAtEnd = false,
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
    paintText(size, canvas, label1, Offset(p1.dx, p1.dy),
        curveAlign: label1Align);
  }
  if (label2 != null) {
    paintText(size, canvas, label2, Offset(p2.dx, p2.dy),
        curveAlign: label2Align);
  }
  double angle = atan2(p2.dy - p1.dy, p2.dx - p1.dx) - (pi / 2);
  if (drawArrowAtStart) {
    /// work out the angle of the curve, (assume points upwards, and subtracts
    /// half pi to make a base point of zero)

    paintArrow(canvas,
        positionOfArrow: Offset(p1.dx * width, p1.dy * height),
        rotationAngle: angle);
  }
  if (drawArrowAtEnd) {
    paintArrow(canvas,
        positionOfArrow: Offset(p2.dx * width, p2.dy * height),
        rotationAngle: angle + pi);
  }
}
