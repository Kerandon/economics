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
      Color? mainColor,
      double strokeWidth = kCurveWidth,
      SizeAdjustor sizeAdjustor = const SizeAdjustor(),
      String? label1,
      String? label2,
      LabelAlign label1Align = LabelAlign.center,
      LabelAlign label2Align = LabelAlign.center,
      bool drawArrowOnStart = false,
      bool drawArrowOnEnd = false,
      double arrowOnStartAngle = 0,
      double arrowOnEndAngle = 0,
    }) {
  final width = config.painterSize.width;
  final height = config.painterSize.height;
  final color = mainColor ?? config.colorScheme.primary;
  final normalize = 1 - (kAxisIndent * 1.5);
  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = color
    ..strokeWidth = strokeWidth * config.averageRatio;
  final path = Path();
  path.moveTo(startPos.dx * width * normalize + (kAxisIndent * width), startPos.dy * height * normalize + (kAxisIndent * (height / 2)));
  for (int i = 0; i < points.length; i++) {
    path.quadraticBezierTo(
      points[i].control.dx * width * normalize + (kAxisIndent * width),
      points[i].control.dy * height * normalize + (kAxisIndent * (height / 2)),
      points[i].endPoint.dx * width * normalize + (kAxisIndent * width),
      points[i].endPoint.dy * height * normalize + (kAxisIndent * (height / 2)),
    );
  }

  canvas.drawPath(path, paint);
  if (label1 != null) {
    paintText(
        config,
        canvas,
        label1,
        Offset(points[points.length - 1].endPoint.dx,
            points[points.length - 1].endPoint.dy),
        labelAlign: label1Align);
  }
  if (label2 != null) {
    paintText(config, canvas, label2, Offset(startPos.dx, startPos.dy),
        labelAlign: label2Align);
  }
  if (drawArrowOnStart) {
    paintArrowHead(
      config,
      canvas,
      color: color,
      positionOfArrow: Offset(startPos.dx * width, startPos.dy * height),
      rotationAngle: arrowOnStartAngle,
    );
  }
  if (drawArrowOnEnd) {
    paintArrowHead(
      config,
      canvas,
      color: color,
      positionOfArrow: Offset(
          points.last.endPoint.dx * width, points.last.endPoint.dy * height),
      rotationAngle: arrowOnEndAngle,
    );
  }
}
