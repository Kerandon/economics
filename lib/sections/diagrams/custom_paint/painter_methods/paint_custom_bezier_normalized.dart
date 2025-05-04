import 'dart:math';

import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_arrow_head.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/models/size_adjuster.dart';
import 'package:flutter/material.dart';
import '../../enums/label_align.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_painter_config.dart';

void paintCustomBezierNormalized(
    DiagramPainterConfig config,
    Canvas canvas, {
      required Offset startPos,
      required List<CustomBezier> points,
      Color? color,
      double strokeWidth = kCurveWidth,
      SizeAdjustor sizeAdjustor = const SizeAdjustor(),
      String? label1,
      String? label2,
      LabelAlign label1Align = LabelAlign.center,
      LabelAlign label2Align = LabelAlign.center,
      bool arrowOnStart = false,
      bool arrowOnEnd = false,
      double arrowOnStartAngle = 0,
      double arrowOnEndAngle = 0,
      bool circleAtEnd = false,
      bool circleAtStart = false,
      double circleRadius = 10,
    }) {
  final width = config.painterSize.width;
  final height = config.painterSize.height;
  final mainColor = color ?? config.colorScheme.primary;
  final normalize = 1 - (kAxisIndent * 1.5);

  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = mainColor
    ..strokeWidth = strokeWidth * config.averageRatio;

  final path = Path();

  final startX = startPos.dx * width * normalize + (kAxisIndent * width);
  final startY = startPos.dy * height * normalize + (kAxisIndent * (height / 2));

  final endX = points.last.endPoint.dx * width * normalize + (kAxisIndent * width);
  final endY = points.last.endPoint.dy * height * normalize + (kAxisIndent * (height / 2));


  path.moveTo(startX, startY);

  for (int i = 0; i < points.length; i++) {
    final controlX = points[i].control.dx * width * normalize + (kAxisIndent * width);
    final controlY = points[i].control.dy * height * normalize + (kAxisIndent * (height / 2));
    final eX = points[i].endPoint.dx * width * normalize + (kAxisIndent * width);
    final eY = points[i].endPoint.dy * height * normalize + (kAxisIndent * (height / 2));
    path.quadraticBezierTo(controlX, controlY, eX, eY);
  }

  canvas.drawPath(path, paint);

  // Labels
  if (label1 != null) {
    paintText(
      config,
      canvas,
      label1,
      Offset(
        startPos.dx * normalize + kAxisIndent,
        startPos.dy * normalize + kAxisIndent/2),

      labelAlign: label1Align,
    );
  }

  if (label2 != null) {
    paintText(
      config,
      canvas,
      label2,
      Offset(
        (points.last.endPoint.dx * normalize + kAxisIndent),
        (points.last.endPoint.dy * normalize + kAxisIndent/2),
      ),
      labelAlign: label2Align,
    );
  }

  // Arrows
  if (arrowOnStart) {




    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: Offset(startX, startY),
      rotationAngle: arrowOnStartAngle,
    );
  }

  if (arrowOnEnd) {
    final last = points.last;
    final endX = last.endPoint.dx * width * normalize + (kAxisIndent * width);
    final endY = last.endPoint.dy * height * normalize + (kAxisIndent * (height / 2));
    final autoEndAngle = atan2(endX, endY);

    paintArrowHead(
      config,
      canvas,
      color: mainColor,
      positionOfArrow: Offset(endX, endY),
      rotationAngle: arrowOnEndAngle != 0 ? arrowOnEndAngle : autoEndAngle,
    );
  }
  final r = circleRadius * config.averageRatio;

  if(circleAtStart){
    canvas.drawCircle(
        Offset(startX, startY), r,
        paint..style = PaintingStyle.fill);
  }if(circleAtEnd){
    canvas.drawCircle(
        Offset(endX, endY), r,
        paint..style = PaintingStyle.fill);
  }
}
