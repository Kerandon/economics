import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_curve.dart';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import '../painter_constants.dart';

void paintKeynesianCurve(Size size, Canvas canvas,
    {double totalWidth = 0.80,
    Color color = Colors.white,
    String label = 'AS'}) {
  final width = size.width;
  final height = size.height;

  final paint = Paint()
    ..color = color
    ..strokeWidth = kCurveWidth
    ..style = PaintingStyle.stroke;

  const horizontalCurveHeight = 0.65;
  final totalCurveWidth = totalWidth;
  final horizontalCurveWidth = totalCurveWidth - 0.12;

  /// Curves
  final startPosHorizontalCurve =
      Offset(width * 0.20, height * horizontalCurveHeight);
  final endPosHorizontalCurve =
      Offset(width * horizontalCurveWidth, height * horizontalCurveHeight);
  final startPosVerticalCurve = Offset(width * totalCurveWidth, height * 0.45);
  final endPosVerticalCurve = Offset(width * totalCurveWidth, height * 0.15);

  paintCurve(size, canvas, startPosHorizontalCurve, endPosHorizontalCurve,
      color: color);

  paintCurve(size, canvas, startPosVerticalCurve, endPosVerticalCurve,
      color: color);

  final path = Path()
    ..moveTo(endPosHorizontalCurve.dx, endPosHorizontalCurve.dy)
    ..quadraticBezierTo(
        startPosVerticalCurve.dx,
        startPosVerticalCurve.dy + (height * 0.18),
        startPosVerticalCurve.dx,
        startPosVerticalCurve.dy);
  canvas.save();
  canvas.drawPath(path, paint);
  canvas.restore();

  /// Add label
  if (label != "") {
    paintText(
        size,
        canvas,
        label,
        Offset(endPosVerticalCurve.dx,
            endPosVerticalCurve.dy - kCurveLabelAdjustment));
  }
}
