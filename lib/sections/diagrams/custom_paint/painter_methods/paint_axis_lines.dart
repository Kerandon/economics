import 'dart:math';
import 'package:economics_app/sections/diagrams/custom_paint/painter_methods/paint_arrow.dart';
import 'package:economics_app/sections/diagrams/models/size_adjuster.dart';
import 'package:flutter/material.dart';
import '../painter_constants.dart';

void paintAxisLines(Size size, Canvas canvas,
    {SizeAdjustor sizeAdjustor = const SizeAdjustor(),
    Color color = Colors.white,
    double strokeWidth = kAxisWidth}) {
  final double width = size.width;
  final double height = size.height;

  final axisPaint = Paint()
    ..color = color
    ..strokeWidth = kCurveWidth * sizeAdjustor.width;

  final startYOffset = Offset(width * kAxisIndent, height * kAxisIndent / 2);
  final endYOffset = Offset(width * kAxisIndent, height * (1 - kAxisIndent));
  final startXOffset = Offset(width * kAxisIndent, height * (1 - kAxisIndent));
  final endXOffset =
      Offset(width * (1 - kAxisIndent / 2), height * (1 - kAxisIndent));
  canvas
    ..drawLine(startYOffset, endYOffset, axisPaint)
    ..drawLine(startXOffset, endXOffset, axisPaint);

  /// Arrow-head

  final path = Path();
  final paint = Paint()..color = Colors.white;

  /// Y Axis Arrow
  paintArrow(canvas, color,
      sizeAdjustor: sizeAdjustor, positionOfArrow: startYOffset);

  /// X Axis Arrow
  paintArrow(canvas, color,
      sizeAdjustor: sizeAdjustor,
      positionOfArrow: endXOffset,
      rotationAngle: pi / 2);

  canvas.save();
  canvas.drawPath(path, paint);
  canvas.restore();
}
