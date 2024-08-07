import 'package:economics_app/sections/diagrams/custom_paint/painter_constants.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:economics_app/sections/diagrams/models.dart';
import 'package:flutter/material.dart';
import '../../enums/curve_align.dart';

void paintCustomBezier(Size size, Canvas canvas,
    {required Offset startPos,
    required List<CustomBezier> points,
    Color? color,
    String? label1,
    String? label2,
    CurveAlign label1Align = CurveAlign.center,
    CurveAlign label2Align = CurveAlign.center}) {
  final width = size.width;
  final height = size.height;
  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..color = color ?? Colors.white
    ..strokeWidth = kCurveWidth;
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
        size,
        canvas,
        label1,
        Offset(points[points.length - 1].endPoint.dx,
            points[points.length - 1].endPoint.dy),
        customAlign: label1Align);
  }
  if (label2 != null) {
    paintText(size, canvas, label2, Offset(startPos.dx, startPos.dy),
        customAlign: label2Align);
  }
}
