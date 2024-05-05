import 'package:economics_app/app/custom_paint/painter_methods/paint_axis_lines.dart';
import 'package:economics_app/app/custom_paint/painter_methods/paint_text.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void paintAxis(
    Size size, Canvas canvas, String verticalLabel, String horizontalLabel,
    {Color color = Colors.white}) {
  final width = size.width;
  final height = size.height;
  paintAxisLines(size, canvas, color: color);
  paintText(size, canvas, 'Real GDP', Offset(width * 0.50, height * 0.96),
      color: color);
  paintText(size, canvas, 'Price Level', Offset(width * 0.04, height * 0.50),
      angle: math.pi / -2, color: color);
}
