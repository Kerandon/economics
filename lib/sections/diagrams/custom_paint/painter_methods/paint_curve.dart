import 'dart:math';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
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
  LabelAlign label1Align = LabelAlign.center,
  LabelAlign label2Align = LabelAlign.center,
  bool makeDashed = false,
  bool arrowAtStart = false,
  bool arrowAtEnd = false,
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
      labelAlign: label1Align,
    );
  }
  if (label2 != null) {
    paintText(config, canvas, label2, Offset(p2.dx, p2.dy),
        labelAlign: label2Align);
  }
  double angle = atan2(p2.dy - p1.dy, p2.dx - p1.dx) - (pi / 2);
  if (arrowAtStart) {
    /// work out the angle of the curve, (assume points upwards, and subtracts
    /// half pi to make a base point of zero)

    paintArrowHead(config, canvas,
        positionOfArrow: Offset(p1.dx * width, p1.dy * height),
        rotationAngle: angle,
        color: color);
  }
  if (arrowAtEnd) {
    paintArrowHead(config, canvas,
        positionOfArrow: Offset(p2.dx * width, p2.dy * height),
        rotationAngle: angle + pi,
        color: paint.color);
  }
}
void paintDashedLine(
    DiagramPainterConfig config,
    Canvas canvas, {
      required Offset p1,
      required Offset p2,
      double dashWidth = 5.0,
      double dashSpace = 3.0,
    }) {
  final paint = Paint()
    ..color = config.colorScheme.onSurface
    ..strokeWidth = 1.5
    ..style = PaintingStyle.stroke;

  final width = config.painterSize.width;
  final height = config.painterSize.height;

  final start = Offset(p1.dx * width, p1.dy * height);
  final end = Offset(p2.dx * width, p2.dy * height);

  final totalLength = (end - start).distance;
  final direction = (end - start) / totalLength;

  double distance = 0.0;
  while (distance < totalLength) {
    final dashStart = start + direction * distance;
    final dashEnd = start + direction * (distance + dashWidth);
    canvas.drawLine(dashStart, dashEnd, paint);
    distance += dashWidth + dashSpace;
  }
}
