import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import '../painter_constants.dart';

void paintCurve(Size size, Canvas canvas, Offset startPos, Offset endPos,
    {Color color = Colors.white,
    double strokeWidth = kCurveWidth,
    String? label,
    double adjustLabelX = kCurveLabelAdjustment,
    double adjustLabelY = kCurveLabelAdjustment}) {
  final paint = Paint()
    ..color = color
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round;

  canvas.drawLine(startPos, endPos, paint);
  if (label != null) {
    paintText(size, canvas, label,
        Offset(endPos.dx + adjustLabelX, endPos.dy + adjustLabelY));
  }

}
