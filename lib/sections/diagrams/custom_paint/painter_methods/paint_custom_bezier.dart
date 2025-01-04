import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/models/size_adjuster.dart';
import 'package:flutter/material.dart';
import '../../enums/curve_align.dart';
import '../../models/custom_bezier.dart';
import '../../models/diagram_painter_config.dart';

void paintCustomBezier(
  DiagramPainterConfig config,
  Canvas canvas,
  Color color, {
  required Offset startPos,
  required List<CustomBezier> points,
  SizeAdjustor sizeAdjustor = const SizeAdjustor(),
  String? label1,
  String? label2,
  CurveAlign label1Align = CurveAlign.center,
  CurveAlign label2Align = CurveAlign.center,
  bool drawArrowOnStart = false,
  bool drawArrowOnEnd = false,
  double arrowOnStartAngle = 0,
  double arrowOnEndAngle = 0,
}) {
  final width = config.appSize.width;
  final height = config.appSize.height;
  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = color
    ..strokeWidth = kCurveWidth * sizeAdjustor.width;
  final path = Path();
  path.moveTo(startPos.dx * width, startPos.dy * height);
  for (int i = 0; i < points.length; i++) {
    path.quadraticBezierTo(
      points[i].control.dx * width,
      points[i].control.dy * height,
      points[i].endPoint.dx * width,
      points[i].endPoint.dy * height,
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
        curveAlign: label1Align);
  }
  if (label2 != null) {
    paintText(config, canvas, label2, Offset(startPos.dx, startPos.dy),
        curveAlign: label2Align);
  }
  if (drawArrowOnStart) {
    // paintArrow(
    //   color,
    //   positionOfArrow: Offset(startPos.dx * width, startPos.dy * height),
    //   rotationAngle: arrowOnStartAngle,
    // );
  }
  if (drawArrowOnEnd) {
    // paintArrow(
    //   canvas,
    //   color,
    //   positionOfArrow: Offset(
    //       points.last.endPoint.dx * width, points.last.endPoint.dy * height),
    //   rotationAngle: arrowOnEndAngle,
    // );
  }
}
