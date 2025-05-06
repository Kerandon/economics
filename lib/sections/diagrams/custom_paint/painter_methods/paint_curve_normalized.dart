import 'dart:math';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_dashed_line.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/diagram_painter_config.dart';
import '../painter_constants.dart';

void paintCurveNormalized(
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
      bool circleAtEnd = false,
      bool circleAtStart = false,
      double circleRadius = 10,
}) {
  final width = config.painterSize.width;
  final height = config.painterSize.height;
  final normalize = 1 - (kAxisIndent * 1.5);
  final paint = Paint()
    ..color = color ?? config.colorScheme.primary
    ..strokeWidth = strokeWidth * config.averageRatio
    ..strokeCap = StrokeCap.round;

  final p1Norm = Offset(
    p1.dx * normalize + (kAxisIndent),
    p1.dy * normalize + (kAxisIndent / 2),
  );
  final p2Norm = Offset(
    p2.dx * normalize + (kAxisIndent),
    p2.dy * normalize + (kAxisIndent / 2),
  );

  if (makeDashed) {
    paintDashedLine(
      config,
      canvas,
      p1: Offset(p1Norm.dx, p1Norm.dy),
      p2: Offset(p2Norm.dx, p2Norm.dy),
    );
  } else {
    canvas.drawLine(Offset(p1Norm.dx * width, p1Norm.dy * height),
        Offset(p2Norm.dx * width, p2Norm.dy * height), paint);
  }

  if (label1 != null) {
    paintText(
      config,
      canvas,
      label1,
      Offset(p1Norm.dx, p1Norm.dy),
      labelAlign: label1Align,
    );
  }
  if (label2 != null) {
    paintText(config, canvas, label2, Offset(p2Norm.dx, p2Norm.dy),
        labelAlign: label2Align);
  }
  double angle = atan2(p2Norm.dy - p1Norm.dy, p2Norm.dx - p1Norm.dx) - (pi / 2);
  if (arrowAtStart) {
    /// work out the angle of the curve, (assume points upwards, and subtracts
    /// half pi to make a base point of zero)

    paintArrowHead(config, canvas,
        positionOfArrow: Offset(p1Norm.dx * width, p1Norm.dy * height),
        rotationAngle: angle,
        color: paint.color);
  }
  if (arrowAtEnd) {

    final paint = Paint()
      ..color = color!
      ..style = PaintingStyle.fill;

    paintArrowHead(config, canvas,
        positionOfArrow: Offset(p2Norm.dx * width, p2Norm.dy * height),
        rotationAngle: angle + pi,
        color: paint.color);
  }
  final r = circleRadius * config.averageRatio;
  if(circleAtStart){
    canvas.drawCircle(
        Offset(p1Norm.dx * width, p1Norm.dy * height),
        r,
        paint);
  }if(circleAtEnd){
    canvas.drawCircle(
        Offset(
          p2Norm.dx * width, p2Norm.dy * height,
        ),
        r,
        paint);
  }
}
