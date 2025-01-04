import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_arrow.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import '../../enums/curve_align.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintCurve(
  DiagramPainterConfig config,
  Canvas canvas,
  Offset p1,
  Offset p2, {
  Color? color,
  double strokeWidth = kCurveWidth,
  String? label1,
  String? label2,
  CurveAlign label1Align = CurveAlign.center,
  CurveAlign label2Align = CurveAlign.center,
  bool makeDashed = false,
  bool drawArrowAtStart = false,
  bool drawArrowAtEnd = false,
}) {
  final width = config.painterSize.width;
  final height = config.painterSize.height;

  final paint = Paint()
    ..color = color ?? config.colorScheme.primary
    ..strokeWidth = strokeWidth * config.averageRatio
    ..strokeCap = StrokeCap.round;

  if (makeDashed) {
    paintDashedLine(
      config,
      canvas,
      p1: Offset(p1.dx, p1.dy),
      p2: Offset(p2.dx, p2.dy),
    );
  } else {
    canvas.drawLine(Offset(p1.dx * width, p1.dy * height),
        Offset(p2.dx * width, p2.dy * height), paint);
  }

  if (label1 != null) {
    paintText(
      config,
      canvas,
      label1,
      Offset(p1.dx, p1.dy),
      curveAlign: label1Align,
    );
  }
  if (label2 != null) {
    paintText(config, canvas, label2, Offset(p2.dx, p2.dy),
        curveAlign: label2Align);
  }
  double angle = atan2(p2.dy - p1.dy, p2.dx - p1.dx) - (pi / 2);
  if (drawArrowAtStart) {
    /// work out the angle of the curve, (assume points upwards, and subtracts
    /// half pi to make a base point of zero)

    paintArrow(config, canvas,
        positionOfArrow: Offset(p1.dx * width, p1.dy * height),
        rotationAngle: angle);
  }
  if (drawArrowAtEnd) {
    paintArrow(config, canvas,
        positionOfArrow: Offset(p2.dx * width, p2.dy * height),
        rotationAngle: angle + pi);
  }
}
